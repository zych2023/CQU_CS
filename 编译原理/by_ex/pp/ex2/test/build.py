import os, platform, subprocess, shutil, sys

def build_compiler():
    is_windows = platform.system() == "Windows"
    project_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
    bin_dir = os.path.join(project_dir, "bin")
    build_dir = os.path.join(project_dir, "build")

    if os.path.exists(bin_dir):
        shutil.rmtree(bin_dir)
    os.mkdir(bin_dir)

    if os.path.exists(build_dir):
        shutil.rmtree(build_dir)
    os.mkdir(build_dir)
        
    generator = ""
    if is_windows:
        if shutil.which("ninja"):
            generator = "-G \"Ninja\""
        elif shutil.which("mingw32-make") or shutil.which("make"):
            generator = "-G \"MinGW Makefiles\""

    cfg_cmd = "cmake -S \"{}\" -B \"{}\" {}".format(project_dir, build_dir, generator).strip()
    build_cmd = "cmake --build \"{}\"".format(build_dir)
    os.system(cfg_cmd)
    os.system(build_cmd)
        
if __name__ == "__main__":
    build_compiler()