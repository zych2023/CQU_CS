import os, platform, subprocess, shutil, sys
import re

def score_compiler(arg1):
    record = {}

    is_windows = platform.system() == "Windows"
    has_diff = shutil.which("diff") is not None

    assert(len(sys.argv) == 2)

    oftype = ""
    step = "-" + arg1
    if step == "-s0":
        oftype = "tk"
    elif step == "-s1":
        oftype = "json"
    elif step == "-s2":
        oftype = "out"
    else:
        print("illegal input")
        exit()

    output_base = "./output/"
    ref_base = "./ref/" + arg1 + "/"

    score = 0
    total = 58      # FIXME 改成读取测试用例数而不是写死

    hex_float_re = re.compile(r"0x[0-9a-fA-F]+(?:\.[0-9a-fA-F]*)?p[+-]?\d+")

    def normalize_hex_float_token(tok):
        t = tok.lower()
        mantissa, exp = t.split("p", 1)
        if "." in mantissa:
            intp, frac = mantissa.split(".", 1)
            frac = frac.rstrip("0")
            if frac:
                mantissa = intp + "." + frac
            else:
                mantissa = intp
        return mantissa + "p" + exp

    def normalize_lines(lines, ignore_whitespace, ignore_blank_lines):
        out = []
        for line in lines:
            if ignore_blank_lines and line.strip() == "":
                continue
            if ignore_whitespace:
                line = " ".join(line.split())
            line = hex_float_re.sub(lambda m: normalize_hex_float_token(m.group(0)), line)
            out.append(line)
        return out

    def files_equal(path_a, path_b, ignore_whitespace, ignore_blank_lines):
        try:
            with open(path_a, "r", encoding="utf-8", errors="ignore") as fa:
                with open(path_b, "r", encoding="utf-8", errors="ignore") as fb:
                    a_lines = normalize_lines(fa.readlines(), ignore_whitespace, ignore_blank_lines)
                    b_lines = normalize_lines(fb.readlines(), ignore_whitespace, ignore_blank_lines)
                    return a_lines == b_lines
        except OSError:
            return False

    if step == "-s0":
        for i in ["basic", "function"]:
            output_dir = output_base + i + '/'
            ref_dir = ref_base + i + '/'
            if os.path.exists(output_dir):
                files = os.listdir(output_dir)
                for file in files:
                    if not (file[-3:] == ".tk"):
                        continue
                    if has_diff:
                        cmd = ' '.join(["diff", ref_dir + file, output_dir + file, '-w'])
                        if is_windows:
                            cmd = cmd.replace('/','\\')
                        cp = subprocess.run(cmd, shell=True, stderr=subprocess.DEVNULL, stdout=subprocess.PIPE)
                        ok = (cp.returncode == 0)
                    else:
                        ok = files_equal(ref_dir + file, output_dir + file, True, False)

                    if not ok:
                        record[file] = {"retval": 1, "err_detail": "diff test failed"}
                    else:
                        score += 1
                        record[file] = {"retval": 0}
                    print(file, record[file])
        print("score:",score,"/",total)
    elif step == "-s1":
        for i in ["basic", "function"]:
            output_dir = output_base + i + '/'
            ref_dir = ref_base + i + '/'
            if os.path.exists(output_dir):
                files = os.listdir(output_dir)
                for file in files:
                    if not (file[-5:] == ".json"):
                        continue
                    if has_diff:
                        cmd = ' '.join(["diff", ref_dir + file, output_dir + file, '-w'])
                        if is_windows:
                            cmd = cmd.replace('/','\\')
                        cp = subprocess.run(cmd, shell=True, stderr=subprocess.DEVNULL, stdout=subprocess.PIPE)
                        ok = (cp.returncode == 0)
                    else:
                        ok = files_equal(ref_dir + file, output_dir + file, True, False)

                    if not ok:
                        record[file] = {"retval": 1, "err_detail": "diff test failed"}
                    else:
                        score += 1
                        record[file] = {"retval": 0}
                    print(file, record[file])
        print("score:",score,"/",total)
    elif step == "-s2":
        for i in ["basic", "function"]:
            output_dir = output_base + i + '/'
            ref_dir = ref_base + i + '/'
            if os.path.exists(output_dir):
                files = os.listdir(output_dir)
                for file in files:
                    if not (file[-4:] == ".out"):
                        continue
                    if has_diff:
                        cmd = ' '.join(["diff", ref_dir + file, output_dir + file, '-wB'])
                        if is_windows:
                            cmd = cmd.replace('/','\\')
                        cp = subprocess.run(cmd, shell=True, stderr=subprocess.PIPE, stdout=subprocess.DEVNULL)
                        ok = (cp.returncode == 0)
                    else:
                        ok = files_equal(ref_dir + file, output_dir + file, True, True)

                    if not ok:
                        record[file] = {"retval": 1, "err_detail": "diff test failed"}
                    else:
                        score += 1
                        record[file] = {"retval": 0}
                    print(file, record[file])
        print("score:",score,"/",total)
    else:
        print("TODO")
        # exit()
        
    return int(score/total * 100)


if __name__ == "__main__":
    assert(len(sys.argv) == 2)
    score_compiler(sys.argv[1])