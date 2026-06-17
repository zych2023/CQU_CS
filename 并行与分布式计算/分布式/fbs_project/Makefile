# ============================================================
# PageRank 并行算法 - Makefile
# ============================================================
# 用法：
#   make all          - 编译所有目标
#   make serial       - 仅编译串行版本
#   make openmp       - 仅编译 OpenMP 版本
#   make mpi          - 仅编译 MPI 版本
#   make generator    - 仅编译图生成器
#   make run_serial   - 编译并运行串行实验
#   make run_openmp   - 编译并运行 OpenMP 实验
#   make run_mpi      - 编译并运行 MPI 实验（4进程）
#   make clean        - 清理编译产物
#
# 注意：
#   - OpenMP 和 MPI 版本需要相应的编译器和库支持
#   - 在华为云服务器上编译时，需先安装依赖（见 scripts/setup_huawei.sh）
#   - MSYS2 g++ 15.2.0 在 -O1/-O2 下有 ifstream bug，本机请用 make LOCAL=1
# ============================================================

CXX      = g++
MPICXX   = mpic++

# 默认使用 -O2（华为云标准 g++ 无 bug）
# 本机 MSYS2 环境请使用：make LOCAL=1
ifdef LOCAL
  CXXFLAGS  = -std=c++17 -O0 -g -Wall -Wextra
  MPIFLAGS  = -std=c++17 -O0 -g -Wall -Wextra
else
  CXXFLAGS  = -std=c++17 -O2 -Wall -Wextra
  MPIFLAGS  = -std=c++17 -O2 -Wall -Wextra
endif

OMPFLAGS = -fopenmp

# 输出目录
BIN_DIR  = bin
SRC_DIR  = src

# 目标文件
SERIAL    = $(BIN_DIR)/pagerank_serial
OPENMP    = $(BIN_DIR)/pagerank_openmp
MPI       = $(BIN_DIR)/pagerank_mpi
GENERATOR = $(BIN_DIR)/graph_generator

# 默认图规模（可修改）
GRAPH     = data/graph_10K.txt
PROCS     = 4

.PHONY: all clean run_serial run_openmp run_mpi generate

all: generator serial openmp mpi

# ---- 创建输出目录 ----
$(BIN_DIR):
	mkdir -p $(BIN_DIR)

# ---- 编译图生成器 ----
generator: $(GENERATOR)

$(GENERATOR): $(SRC_DIR)/graph_generator.cpp $(SRC_DIR)/utils.h | $(BIN_DIR)
	$(CXX) $(CXXFLAGS) -o $@ $(SRC_DIR)/graph_generator.cpp

# ---- 编译串行版本 ----
serial: $(SERIAL)

$(SERIAL): $(SRC_DIR)/pagerank_serial.cpp $(SRC_DIR)/utils.h | $(BIN_DIR)
	$(CXX) $(CXXFLAGS) -o $@ $(SRC_DIR)/pagerank_serial.cpp

# ---- 编译 OpenMP 版本 ----
openmp: $(OPENMP)

$(OPENMP): $(SRC_DIR)/pagerank_openmp.cpp $(SRC_DIR)/utils.h | $(BIN_DIR)
	$(CXX) $(CXXFLAGS) $(OMPFLAGS) -o $@ $(SRC_DIR)/pagerank_openmp.cpp

# ---- 编译 MPI 版本 ----
mpi: $(MPI)

$(MPI): $(SRC_DIR)/pagerank_mpi.cpp $(SRC_DIR)/utils.h | $(BIN_DIR)
	$(MPICXX) $(MPIFLAGS) -o $@ $(SRC_DIR)/pagerank_mpi.cpp

# ---- 运行实验 ----
generate: generator
	./$(GENERATOR)

run_serial: serial generate
	./$(SERIAL)

run_openmp: openmp generate
	./$(OPENMP) $(GRAPH)

run_mpi: mpi generate
	mpirun -np $(PROCS) ./$(MPI) $(GRAPH)

# ---- 清理 ----
clean:
	rm -rf $(BIN_DIR)/*.exe $(BIN_DIR)/*.o
	rm -rf results/*.txt
