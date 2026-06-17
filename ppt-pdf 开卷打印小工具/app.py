#!/usr/bin/env python3
"""
PPT-PDF 缩印 & 合并工具
=======================
功能：PPT缩印(多合一) | PDF缩印(多合一) | PDF合并 | PDF拆分
技术：PowerPoint COM + PyMuPDF(矢量合成，保证清晰)
"""

import os
import re
import threading
import tkinter as tk
from tkinter import ttk, filedialog, messagebox
from pathlib import Path
from datetime import datetime

import fitz  # PyMuPDF


# ─────────────────────────────────────────────
# 常量
# ─────────────────────────────────────────────
GRID_LAYOUTS = [
    ("2×2（4合一）",   2, 2),
    ("2×3（6合一）",   2, 3),
    ("3×3（9合一）",   3, 3),
    ("3×4（12合一）",  3, 4),
    ("4×4（16合一）",  4, 4),
    ("2×4（8合一）",   2, 4),
    ("4×3（12合一）",  4, 3),
]
DEFAULT_LAYOUT_IDX = 2  # 3×3
GAP_PT = 4          # 页间距（磅）
MARGIN_PT = 10      # 页边距（磅）
BG_COLOR = (1, 1, 1)  # 白色背景


# ─────────────────────────────────────────────
# 核心：PDF 多合一矢量合成
# ─────────────────────────────────────────────
def compose_nup(src_path, out_path, rows, cols, gap=GAP_PT, margin=MARGIN_PT):
    """
    将 PDF 多页缩印到一页（矢量合成，零光栅化）。

    使用 show_pdf_page() 保持原始 PDF 的矢量路径、文字、
    嵌入图像的最高质量。等比缩放，不变形，不裁切。
    """
    src = fitz.open(src_path)
    if src.page_count == 0:
        src.close()
        raise ValueError("源文件没有页面")

    # 输出页面尺寸 = 第一页尺寸（保持原比例）
    src_rect = src[0].rect
    pw, ph = src_rect.width, src_rect.height
    out = fitz.open()

    total = src.page_count
    pages_per_sheet = rows * cols
    sheet_count = (total + pages_per_sheet - 1) // pages_per_sheet

    for sheet in range(sheet_count):
        page = out.new_page(width=pw, height=ph)
        # 白色背景
        page.draw_rect(fitz.Rect(0, 0, pw, ph), color=None, fill=BG_COLOR)

        for idx in range(pages_per_sheet):
            page_num = sheet * pages_per_sheet + idx
            if page_num >= total:
                break

            # 计算网格位置（左上角为原点）
            r, c = divmod(idx, cols)
            cell_x = margin + c * ((pw - 2 * margin) / cols) + c * gap / cols
            cell_y = margin + r * ((ph - 2 * margin) / rows) + r * gap / rows
            cell_w = (pw - 2 * margin - (cols - 1) * gap) / cols
            cell_h = (ph - 2 * margin - (rows - 1) * gap) / rows

            # 等比缩放源页，适应单元格
            sw, sh = src_rect.width, src_rect.height
            scale = min(cell_w / sw, cell_h / sh)
            fit_w, fit_h = sw * scale, sh * scale

            # 居中对齐
            x = cell_x + (cell_w - fit_w) / 2
            y = cell_y + (cell_h - fit_h) / 2
            where = fitz.Rect(x, y, x + fit_w, y + fit_h)

            # 矢量插入源页（保持原始质量）
            page.show_pdf_page(where, src, page_num, keep_proportion=False)

    out.save(str(out_path), deflate=True, garbage=4)
    out.close()
    src.close()


# ─────────────────────────────────────────────
# 核心：PPTX → PDF（PowerPoint COM）
# ─────────────────────────────────────────────

def _win_path(path):
    """
    将路径转为 Windows COM 可靠识别的绝对路径。
    对含中文/空格的路径使用 8.3 短路径名，避免 COM 编码问题。
    """
    import win32api
    abs_path = os.path.abspath(str(path))
    if not os.path.exists(abs_path):
        raise FileNotFoundError(f"文件不存在: {abs_path}")
    try:
        return win32api.GetShortPathName(abs_path)
    except Exception:
        # 短路径不可用时，返回绝对路径（正反斜杠已正确）
        return abs_path


def pptx_to_pdf(pptx_path, pdf_path):
    """
    通过 PowerPoint COM 导出矢量 PDF。

    策略：源文件和输出都放在临时目录（纯 ASCII 路径），
    完成后再移到最终位置。彻底避免中文路径导致 COM 错误。
    """
    import win32com.client
    import pythoncom
    import shutil
    import tempfile

    pdf_path = Path(pdf_path)

    # 创建临时目录（纯 ASCII 路径，如 C:\Users\...\AppData\Local\Temp\pptpdf_xxx\）
    tmp_dir = tempfile.mkdtemp(prefix="pptpdf_")
    tmp_src = os.path.join(tmp_dir, "input.pptx")
    tmp_out = os.path.join(tmp_dir, "output.pdf")

    try:
        # 复制源文件到临时目录
        shutil.copy2(str(pptx_path), tmp_src)
    except Exception as e:
        shutil.rmtree(tmp_dir, ignore_errors=True)
        raise RuntimeError(f"无法复制源文件: {e}") from e

    pythoncom.CoInitialize()
    app = None
    ppt = None
    try:
        app = win32com.client.DispatchEx("PowerPoint.Application")
        app.DisplayAlerts = 0  # ppAlertsNone
        ppt = app.Presentations.Open(
            tmp_src,
            ReadOnly=True,
            Untitled=False,
            WithWindow=False,
        )
        # ppSaveAsPDF = 32
        ppt.SaveAs(tmp_out, 32)
        ppt.Close()
        ppt = None

        # 移动到最终位置
        pdf_path.parent.mkdir(parents=True, exist_ok=True)
        shutil.move(tmp_out, str(pdf_path))

    except Exception as e:
        raise RuntimeError(f"PowerPoint 转换失败: {e}") from e
    finally:
        try:
            if ppt:
                ppt.Close()
        except Exception:
            pass
        try:
            if app:
                app.Quit()
        except Exception:
            pass
        pythoncom.CoUninitialize()
        # 清理临时目录
        shutil.rmtree(tmp_dir, ignore_errors=True)


# ─────────────────────────────────────────────
# 核心：PDF 合并
# ─────────────────────────────────────────────
def merge_pdfs(pdf_list, output_path):
    """将多个 PDF 按顺序合并为一个。"""
    result = fitz.open()
    for path in pdf_list:
        src = fitz.open(path)
        result.insert_pdf(src)
        src.close()
    result.save(str(output_path), deflate=True, garbage=4)
    result.close()


# ─────────────────────────────────────────────
# 核心：PDF 拆分
# ─────────────────────────────────────────────
def split_pdf(pdf_path, output_dir, page_ranges=None):
    """
    拆分 PDF。
    page_ranges: [(起始页0-index, 结束页0-index), ...]，None=逐页拆分
    """
    src = fitz.open(pdf_path)
    total = src.page_count
    base = Path(pdf_path).stem
    outputs = []

    if page_ranges is None:
        page_ranges = [(i, i) for i in range(total)]

    for idx, (start, end) in enumerate(page_ranges):
        start = max(0, min(start, total - 1))
        end = max(start, min(end, total - 1))
        out = fitz.open()
        out.insert_pdf(src, from_page=start, to_page=end)
        if len(page_ranges) == 1:
            name = f"{base}_拆分.pdf"
        else:
            name = f"{base}_P{start+1}-{end+1}.pdf"
        out_path = Path(output_dir) / name
        out.save(str(out_path), deflate=True, garbage=4)
        out.close()
        outputs.append(str(out_path))

    src.close()
    return outputs


# ─────────────────────────────────────────────
# 页码范围解析工具
# ─────────────────────────────────────────────
def parse_page_ranges(text, total_pages):
    """
    解析页码范围字符串 → 页码列表（0-indexed）。
    格式: "1-5, 8, 10-15" 或 "1,3,5-8"
    """
    pages = set()
    for part in text.split(","):
        part = part.strip()
        if not part:
            continue
        if "-" in part:
            a, b = part.split("-", 1)
            a, b = int(a.strip()), int(b.strip())
            for p in range(max(1, a), min(total_pages, b) + 1):
                pages.add(p - 1)
        else:
            p = int(part)
            if 1 <= p <= total_pages:
                pages.add(p - 1)
    return sorted(pages)


# ─────────────────────────────────────────────
# GUI 应用
# ─────────────────────────────────────────────
class PPTPDFApp:
    """PPT-PDF 缩印 & 合并工具 主界面。"""

    def __init__(self):
        self.root = tk.Tk()
        self.root.title("PPT-PDF 缩印 & 合并工具")
        self.root.geometry("720x760")
        self.root.minsize(640, 680)
        self.root.configure(bg="#f0f0f0")
        self.is_converting = False
        self._build_ui()

    # ── 界面构建 ──────────────────────────────

    def _build_ui(self):
        """构建完整界面。"""
        # 顶部标题栏
        header = tk.Frame(self.root, bg="#1a5276", height=60)
        header.pack(fill=tk.X)
        header.pack_propagate(False)
        tk.Label(
            header, text="📑  PPT-PDF 缩印 & 合并工具",
            font=("Segoe UI", 16, "bold"), fg="white", bg="#1a5276",
        ).pack(expand=True)

        # 标签页
        notebook = ttk.Notebook(self.root)
        notebook.pack(fill=tk.BOTH, expand=True, padx=8, pady=(8, 4))

        tab_convert = tk.Frame(notebook, bg="white")
        tab_ppt = tk.Frame(notebook, bg="white")
        tab_pdf = tk.Frame(notebook, bg="white")
        tab_merge = tk.Frame(notebook, bg="white")
        notebook.add(tab_convert, text="  🔄  PPT 转 PDF  ")
        notebook.add(tab_ppt, text="  📊  PPT 缩印  ")
        notebook.add(tab_pdf, text="  📄  PDF 缩印  ")
        notebook.add(tab_merge, text="  🔧  PDF 合并/拆分  ")

        self._build_convert_tab(tab_convert)
        self._build_nup_tab(tab_ppt, is_ppt=True)
        self._build_nup_tab(tab_pdf, is_ppt=False)
        self._build_merge_split_tab(tab_merge)

        # 底部状态栏
        status_frame = tk.Frame(self.root, bg="#e8e8e8", height=30)
        status_frame.pack(fill=tk.X, side=tk.BOTTOM)
        status_frame.pack_propagate(False)
        self.status_var = tk.StringVar(value="就绪")
        tk.Label(
            status_frame, textvariable=self.status_var,
            font=("Segoe UI", 9), bg="#e8e8e8", anchor="w", padx=12,
        ).pack(fill=tk.BOTH, expand=True)

    def _build_convert_tab(self, parent):
        """构建 PPT 转 PDF 标签页（纯格式转换，不做缩印）。"""
        container = tk.Frame(parent, bg="white")
        container.pack(fill=tk.BOTH, expand=True, padx=16, pady=12)

        tk.Label(
            container, text="批量将 PPTX 转为 PDF（原样保留，不做缩印）",
            font=("Segoe UI", 10), fg="#555", bg="white", anchor="w",
        ).pack(fill=tk.X, pady=(0, 8))

        # 文件列表
        list_frame = tk.LabelFrame(
            container, text=" PPTX 文件列表 ", font=("Segoe UI", 10),
            bg="white", fg="#333", padx=8, pady=8,
        )
        list_frame.pack(fill=tk.BOTH, expand=True)

        btn_row = tk.Frame(list_frame, bg="white")
        btn_row.pack(fill=tk.X, pady=(0, 6))
        tk.Button(
            btn_row, text="➕ 添加文件", font=("Segoe UI", 9),
            command=lambda: self._add_files(True, self.convert_listbox),
        ).pack(side=tk.LEFT, padx=(0, 6))
        tk.Button(
            btn_row, text="🗑 清空列表", font=("Segoe UI", 9),
            command=lambda: self._clear_list(self.convert_listbox),
        ).pack(side=tk.LEFT)

        list_container = tk.Frame(list_frame, bg="white")
        list_container.pack(fill=tk.BOTH, expand=True)
        scrollbar = tk.Scrollbar(list_container)
        scrollbar.pack(side=tk.RIGHT, fill=tk.Y)
        self.convert_listbox = tk.Listbox(
            list_container, font=("Consolas", 9), height=10,
            yscrollcommand=scrollbar.set, selectmode=tk.EXTENDED,
        )
        self.convert_listbox.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        scrollbar.config(command=self.convert_listbox.yview)

        # 输出目录
        opts = tk.LabelFrame(
            container, text=" 输出选项 ", font=("Segoe UI", 10),
            bg="white", fg="#333", padx=8, pady=8,
        )
        opts.pack(fill=tk.X, pady=(8, 0))

        row = tk.Frame(opts, bg="white")
        row.pack(fill=tk.X, pady=2)
        tk.Label(row, text="输出目录:", font=("Segoe UI", 10), bg="white").pack(side=tk.LEFT)
        self.convert_outdir_var = tk.StringVar(value="（与源文件同目录）")
        tk.Entry(row, textvariable=self.convert_outdir_var, font=("Segoe UI", 9),
                 state="readonly").pack(side=tk.LEFT, fill=tk.X, expand=True, padx=(8, 6))
        tk.Button(
            row, text="浏览...", font=("Segoe UI", 9),
            command=lambda: self._choose_dir(self.convert_outdir_var),
        ).pack(side=tk.RIGHT)

        # 进度条
        self.convert_progress = ttk.Progressbar(container, mode="determinate", length=300)
        self.convert_progress.pack(fill=tk.X, pady=(12, 4))

        # 转换按钮
        tk.Button(
            container, text="▶  开始转换", font=("Segoe UI", 12, "bold"),
            bg="#8e44ad", fg="white", activebackground="#7d3c98",
            activeforeground="white", relief=tk.FLAT, padx=24, pady=6,
            command=self._start_convert,
        ).pack(pady=(4, 0))

    def _start_convert(self):
        """开始批量 PPTX 转 PDF（后台线程）。"""
        if self.is_converting:
            messagebox.showwarning("提示", "正在转换中，请等待完成。")
            return

        files = list(self.convert_listbox.get(0, tk.END))
        if not files:
            messagebox.showwarning("提示", "请先添加 PPTX 文件！")
            return

        outdir = self._get_outdir(self.convert_outdir_var, files[0])
        progress = self.convert_progress

        self.is_converting = True
        progress["value"] = 0
        progress["maximum"] = len(files)

        def worker():
            ok, fail = 0, 0
            for i, fpath in enumerate(files):
                fname = Path(fpath).name
                self.root.after(0, self._set_status, f"[{i+1}/{len(files)}] 正在转换: {fname}")
                self.root.after(0, lambda v=i+1: progress.configure(value=v))
                try:
                    base = Path(fpath).stem
                    out_path = Path(outdir) / f"{base}.pdf"
                    pptx_to_pdf(fpath, out_path)
                    ok += 1
                except Exception as e:
                    fail += 1
                    print(f"[ERROR] {fname}: {e}")

            self.is_converting = False
            msg = f"完成！成功 {ok} 个" + (f"，失败 {fail} 个" if fail else "")
            self.root.after(0, self._set_status, msg)
            self.root.after(0, lambda: progress.configure(value=progress["maximum"]))
            self.root.after(100, lambda: messagebox.showinfo("完成", msg))

        threading.Thread(target=worker, daemon=True).start()

    def _build_nup_tab(self, parent, is_ppt=False):
        """构建缩印标签页（PPT 或 PDF 通用）。"""
        container = tk.Frame(parent, bg="white")
        container.pack(fill=tk.BOTH, expand=True, padx=16, pady=12)

        # 说明
        ext = "PPTX" if is_ppt else "PDF"
        tk.Label(
            container, text=f"选择 {ext} 文件 → 选择布局 → 一键生成缩印 PDF",
            font=("Segoe UI", 10), fg="#555", bg="white", anchor="w",
        ).pack(fill=tk.X, pady=(0, 8))

        # 文件列表
        list_frame = tk.LabelFrame(
            container, text=f" {ext} 文件列表 ", font=("Segoe UI", 10),
            bg="white", fg="#333", padx=8, pady=8,
        )
        list_frame.pack(fill=tk.BOTH, expand=True)

        btn_row = tk.Frame(list_frame, bg="white")
        btn_row.pack(fill=tk.X, pady=(0, 6))
        tk.Button(
            btn_row, text="➕ 添加文件", font=("Segoe UI", 9),
            command=lambda: self._add_files(is_ppt),
        ).pack(side=tk.LEFT, padx=(0, 6))
        tk.Button(
            btn_row, text="🗑 清空列表", font=("Segoe UI", 9),
            command=lambda: self._clear_list(listbox),
        ).pack(side=tk.LEFT)

        list_container = tk.Frame(list_frame, bg="white")
        list_container.pack(fill=tk.BOTH, expand=True)
        scrollbar = tk.Scrollbar(list_container)
        scrollbar.pack(side=tk.RIGHT, fill=tk.Y)
        listbox = tk.Listbox(
            list_container, font=("Consolas", 9), height=8,
            yscrollcommand=scrollbar.set, selectmode=tk.EXTENDED,
        )
        listbox.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        scrollbar.config(command=listbox.yview)

        if is_ppt:
            self.ppt_listbox = listbox
        else:
            self.pdf_nup_listbox = listbox

        # 选项区
        opts = tk.LabelFrame(
            container, text=" 输出选项 ", font=("Segoe UI", 10),
            bg="white", fg="#333", padx=8, pady=8,
        )
        opts.pack(fill=tk.X, pady=(8, 0))

        # 布局选择
        row1 = tk.Frame(opts, bg="white")
        row1.pack(fill=tk.X, pady=2)
        tk.Label(row1, text="布局:", font=("Segoe UI", 10), bg="white").pack(side=tk.LEFT)
        layout_var = tk.StringVar(value=GRID_LAYOUTS[DEFAULT_LAYOUT_IDX][0])
        ttk.Combobox(
            row1, textvariable=layout_var, state="readonly", width=22,
            values=[l[0] for l in GRID_LAYOUTS],
        ).pack(side=tk.LEFT, padx=(8, 0))
        if is_ppt:
            self.ppt_layout_var = layout_var
        else:
            self.pdf_layout_var = layout_var

        # 输出目录
        row2 = tk.Frame(opts, bg="white")
        row2.pack(fill=tk.X, pady=(6, 2))
        tk.Label(row2, text="输出:", font=("Segoe UI", 10), bg="white").pack(side=tk.LEFT)
        out_var = tk.StringVar(value="（与源文件同目录）")
        tk.Entry(row2, textvariable=out_var, font=("Segoe UI", 9), state="readonly").pack(
            side=tk.LEFT, fill=tk.X, expand=True, padx=(8, 6),
        )
        tk.Button(
            row2, text="浏览...", font=("Segoe UI", 9),
            command=lambda: self._choose_dir(out_var),
        ).pack(side=tk.RIGHT)
        if is_ppt:
            self.ppt_outdir_var = out_var
        else:
            self.pdf_outdir_var = out_var

        # 进度条
        progress = ttk.Progressbar(container, mode="determinate", length=300)
        progress.pack(fill=tk.X, pady=(12, 4))
        if is_ppt:
            self.ppt_progress = progress
        else:
            self.pdf_progress = progress

        # 转换按钮
        tk.Button(
            container, text="▶  开始缩印", font=("Segoe UI", 12, "bold"),
            bg="#27ae60", fg="white", activebackground="#219a52",
            activeforeground="white", relief=tk.FLAT, padx=24, pady=6,
            command=lambda: self._start_nup(is_ppt),
        ).pack(pady=(4, 0))

    def _build_merge_split_tab(self, parent):
        """构建合并/拆分标签页。"""
        container = tk.Frame(parent, bg="white")
        container.pack(fill=tk.BOTH, expand=True, padx=16, pady=12)

        # ── 合并区 ──
        merge_frame = tk.LabelFrame(
            container, text=" 📎 PDF 合并 ", font=("Segoe UI", 10, "bold"),
            bg="white", fg="#333", padx=8, pady=8,
        )
        merge_frame.pack(fill=tk.BOTH, expand=True)

        btn_row = tk.Frame(merge_frame, bg="white")
        btn_row.pack(fill=tk.X, pady=(0, 6))
        tk.Button(
            btn_row, text="➕ 添加", font=("Segoe UI", 9),
            command=self._add_merge_files,
        ).pack(side=tk.LEFT, padx=(0, 4))
        tk.Button(
            btn_row, text="⬆ 上移", font=("Segoe UI", 9),
            command=lambda: self._move_merge(-1),
        ).pack(side=tk.LEFT, padx=(0, 4))
        tk.Button(
            btn_row, text="⬇ 下移", font=("Segoe UI", 9),
            command=lambda: self._move_merge(1),
        ).pack(side=tk.LEFT, padx=(0, 4))
        tk.Button(
            btn_row, text="🗑 清空", font=("Segoe UI", 9),
            command=lambda: self._clear_list(self.merge_listbox),
        ).pack(side=tk.LEFT)

        list_container = tk.Frame(merge_frame, bg="white")
        list_container.pack(fill=tk.BOTH, expand=True)
        scrollbar = tk.Scrollbar(list_container)
        scrollbar.pack(side=tk.RIGHT, fill=tk.Y)
        self.merge_listbox = tk.Listbox(
            list_container, font=("Consolas", 9), height=5,
            yscrollcommand=scrollbar.set,
        )
        self.merge_listbox.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        scrollbar.config(command=self.merge_listbox.yview)

        tk.Button(
            merge_frame, text="▶  合并为一个 PDF", font=("Segoe UI", 11, "bold"),
            bg="#2980b9", fg="white", activebackground="#2472a4",
            activeforeground="white", relief=tk.FLAT, padx=16, pady=4,
            command=self._do_merge,
        ).pack(pady=(8, 0))

        # ── 拆分区 ──
        split_frame = tk.LabelFrame(
            container, text=" ✂️ PDF 拆分 ", font=("Segoe UI", 10, "bold"),
            bg="white", fg="#333", padx=8, pady=8,
        )
        split_frame.pack(fill=tk.X, pady=(12, 0))

        row1 = tk.Frame(split_frame, bg="white")
        row1.pack(fill=tk.X, pady=(0, 6))
        tk.Button(
            row1, text="选择 PDF 文件", font=("Segoe UI", 9),
            command=self._choose_split_file,
        ).pack(side=tk.LEFT)
        self.split_file_var = tk.StringVar(value="（未选择）")
        tk.Label(
            row1, textvariable=self.split_file_var,
            font=("Segoe UI", 9), fg="#555", bg="white",
        ).pack(side=tk.LEFT, padx=(8, 0), fill=tk.X, expand=True)

        row2 = tk.Frame(split_frame, bg="white")
        row2.pack(fill=tk.X, pady=(0, 6))
        tk.Label(row2, text="页码范围:", font=("Segoe UI", 10), bg="white").pack(side=tk.LEFT)
        self.split_range_var = tk.StringVar(value="")
        tk.Entry(
            row2, textvariable=self.split_range_var,
            font=("Segoe UI", 10), width=30,
        ).pack(side=tk.LEFT, padx=(8, 0))
        tk.Label(
            row2, text="留空=逐页拆分  |  格式: 1-5, 8, 10-15",
            font=("Segoe UI", 8), fg="#999", bg="white",
        ).pack(side=tk.LEFT, padx=(8, 0))

        btn_row2 = tk.Frame(split_frame, bg="white")
        btn_row2.pack(fill=tk.X)
        tk.Button(
            btn_row2, text="✂  开始拆分", font=("Segoe UI", 11, "bold"),
            bg="#e67e22", fg="white", activebackground="#d35400",
            activeforeground="white", relief=tk.FLAT, padx=16, pady=4,
            command=self._do_split,
        ).pack(pady=(4, 0))

    # ── 工具方法 ──────────────────────────────

    def _add_files(self, is_ppt, listbox=None):
        """添加文件到列表。listbox 为 None 时按 is_ppt 自动选择。"""
        if listbox is None:
            listbox = self.ppt_listbox if is_ppt else self.pdf_nup_listbox
        ext = "*.pptx" if is_ppt else "*.pdf"
        ftypes = [("PPTX 文件", "*.pptx")] if is_ppt else [("PDF 文件", "*.pdf")]
        ftypes.append(("所有文件", "*.*"))
        files = filedialog.askopenfilenames(filetypes=ftypes)
        existing = set(listbox.get(0, tk.END))
        for f in files:
            if f not in existing:
                listbox.insert(tk.END, f)

    def _add_merge_files(self):
        """添加合并文件。"""
        files = filedialog.askopenfilenames(filetypes=[("PDF 文件", "*.pdf")])
        existing = set(self.merge_listbox.get(0, tk.END))
        for f in files:
            if f not in existing:
                self.merge_listbox.insert(tk.END, f)

    def _clear_list(self, listbox):
        """清空列表。"""
        listbox.delete(0, tk.END)

    def _move_merge(self, direction):
        """上下移动合并列表中的文件。"""
        lb = self.merge_listbox
        sel = lb.curselection()
        if not sel:
            return
        idx = sel[0]
        new_idx = idx + direction
        if 0 <= new_idx < lb.size():
            item = lb.get(idx)
            lb.delete(idx)
            lb.insert(new_idx, item)
            lb.selection_set(new_idx)

    def _choose_dir(self, var):
        """选择输出目录。"""
        d = filedialog.askdirectory()
        if d:
            var.set(d)

    def _choose_split_file(self):
        """选择拆分文件。"""
        f = filedialog.askopenfilename(filetypes=[("PDF 文件", "*.pdf")])
        if f:
            self.split_file_var.set(f)
            # 显示总页数
            try:
                doc = fitz.open(f)
                total = doc.page_count
                doc.close()
                self.split_range_var.set("")
                self._set_status(f"已选择: {Path(f).name}（共 {total} 页）")
            except Exception as e:
                messagebox.showerror("错误", f"无法打开 PDF: {e}")

    def _set_status(self, text):
        """更新状态栏。"""
        self.status_var.set(text)
        self.root.update_idletasks()

    def _get_layout(self, layout_var):
        """根据布局名称获取 (rows, cols)。"""
        name = layout_var.get()
        for lname, rows, cols in GRID_LAYOUTS:
            if lname == name:
                return rows, cols
        return 3, 3  # 默认

    def _get_outdir(self, outdir_var, source_path=None):
        """获取输出目录。"""
        val = outdir_var.get()
        if val and val != "（与源文件同目录）":
            return val
        if source_path:
            return str(Path(source_path).parent)
        return str(Path.home() / "Desktop")

    # ── 缩印操作 ──────────────────────────────

    def _start_nup(self, is_ppt):
        """开始缩印转换（后台线程）。"""
        if self.is_converting:
            messagebox.showwarning("提示", "正在转换中，请等待完成。")
            return

        listbox = self.ppt_listbox if is_ppt else self.pdf_nup_listbox
        layout_var = self.ppt_layout_var if is_ppt else self.pdf_layout_var
        outdir_var = self.ppt_outdir_var if is_ppt else self.pdf_outdir_var
        progress = self.ppt_progress if is_ppt else self.pdf_progress

        files = list(listbox.get(0, tk.END))
        if not files:
            messagebox.showwarning("提示", "请先添加文件！")
            return

        rows, cols = self._get_layout(layout_var)
        outdir = self._get_outdir(outdir_var, files[0] if files else None)

        self.is_converting = True
        progress["value"] = 0
        progress["maximum"] = len(files)

        def worker():
            ok, fail = 0, 0
            for i, fpath in enumerate(files):
                fname = Path(fpath).name
                self.root.after(0, self._set_status, f"[{i+1}/{len(files)}] 正在处理: {fname}")
                self.root.after(0, lambda v=i+1: progress.configure(value=v))

                try:
                    base = Path(fpath).stem
                    # 布局标签用于文件名
                    layout_tag = f"{rows}x{cols}"
                    suffix = f"_缩印{layout_tag}"
                    out_name = f"{base}{suffix}.pdf"
                    out_path = Path(outdir) / out_name

                    if is_ppt:
                        # PPT → 先导出 PDF，再缩印
                        tmp_pdf = Path(outdir) / f"{base}_tmp_export.pdf"
                        pptx_to_pdf(fpath, tmp_pdf)
                        compose_nup(tmp_pdf, out_path, rows, cols)
                        try:
                            tmp_pdf.unlink()
                        except Exception:
                            pass
                    else:
                        compose_nup(fpath, out_path, rows, cols)

                    ok += 1
                except Exception as e:
                    fail += 1
                    print(f"[ERROR] {fname}: {e}")

            self.is_converting = False
            msg = f"完成！成功 {ok} 个" + (f"，失败 {fail} 个" if fail else "")
            self.root.after(0, self._set_status, msg)
            self.root.after(0, lambda: progress.configure(value=progress["maximum"]))
            self.root.after(100, lambda: messagebox.showinfo("完成", msg))

        threading.Thread(target=worker, daemon=True).start()

    # ── 合并操作 ──────────────────────────────

    def _do_merge(self):
        """合并多个 PDF。"""
        files = list(self.merge_listbox.get(0, tk.END))
        if len(files) < 2:
            messagebox.showwarning("提示", "请至少添加 2 个 PDF 文件！")
            return

        out = filedialog.asksaveasfilename(
            defaultextension=".pdf",
            initialfile=f"合并_{datetime.now():%Y%m%d_%H%M%S}.pdf",
            filetypes=[("PDF 文件", "*.pdf")],
        )
        if not out:
            return

        self._set_status("正在合并...")
        try:
            merge_pdfs(files, out)
            total_pages = 0
            for f in files:
                doc = fitz.open(f)
                total_pages += doc.page_count
                doc.close()
            msg = f"合并完成！共 {len(files)} 个文件，{total_pages} 页"
            self._set_status(msg)
            messagebox.showinfo("完成", f"{msg}\n保存至: {out}")
        except Exception as e:
            messagebox.showerror("合并失败", str(e))
            self._set_status("合并失败")

    # ── 拆分操作 ──────────────────────────────

    def _do_split(self):
        """拆分 PDF。"""
        pdf_path = self.split_file_var.get()
        if not pdf_path or pdf_path == "（未选择）":
            messagebox.showwarning("提示", "请先选择 PDF 文件！")
            return

        out_dir = filedialog.askdirectory(title="选择输出目录")
        if not out_dir:
            return

        try:
            doc = fitz.open(pdf_path)
            total = doc.page_count
            doc.close()

            range_text = self.split_range_var.get().strip()
            if range_text:
                pages = parse_page_ranges(range_text, total)
                if not pages:
                    messagebox.showwarning("提示", "页码范围无效！")
                    return
                # 将连续页码合并为范围
                ranges = []
                start = pages[0]
                end = pages[0]
                for p in pages[1:]:
                    if p == end + 1:
                        end = p
                    else:
                        ranges.append((start, end))
                        start = end = p
                ranges.append((start, end))
            else:
                ranges = None  # 逐页拆分

            self._set_status("正在拆分...")
            outputs = split_pdf(pdf_path, out_dir, ranges)
            msg = f"拆分完成！生成 {len(outputs)} 个文件"
            self._set_status(msg)
            messagebox.showinfo("完成", f"{msg}\n保存至: {out_dir}")
        except Exception as e:
            messagebox.showerror("拆分失败", str(e))
            self._set_status("拆分失败")

    # ── 启动 ──────────────────────────────────

    def run(self):
        """启动应用。"""
        self.root.mainloop()


# ─────────────────────────────────────────────
# 入口
# ─────────────────────────────────────────────
if __name__ == "__main__":
    app = PPTPDFApp()
    app.run()
