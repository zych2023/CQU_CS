cmake_minimum_required(VERSION 3.22)
project(compiler)

# compile flags
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_FLAGS   "-g")                     # 调试信息
set(CMAKE_CXX_FLAGS   "-Wall")                  # 开启所有警告
# debug flags
# add_definitions(-DDEBUG_DFA)
# add_definitions(-DDEBUG_SCANNER)
# add_definitions(-DDEBUG_PARSER)

# output settings
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_SOURCE_DIR}/bin)


# include
include_directories(./include)

# third party libs
add_library(jsoncpp_obj OBJECT ./src/third_party/jsoncpp/jsoncpp.cpp)

# --------------------- from lib ---------------------
# link libxx.a
# u should rename libxx-x86-win.a or libxx-x86-linux.a to libxx.a according to ur own platform
link_directories(./lib)
# --------------------- from lib ---------------------

# build library
# every src file directory should be compile into a lib

aux_source_directory(./src/front FRONT_SRC)
add_library(Front_obj OBJECT ${FRONT_SRC})

# 为了 debug 方便，你可以选择通过源文件来构建 IR 测评机，但是请以链接静态库文件的方式去跑分（为了防止你们修改测评机，在OJ上我们会采取此方式）
# --------------------- from src ---------------------
# aux_source_directory(./src/ir IR_SRC)
# add_library(IR ${IR_SRC})
# aux_source_directory(./src/tools TOOLS_SRC)
# add_library(Tools ${TOOLS_SRC})
# --------------------- from src ---------------------


# executable
add_executable(compiler
	main.cpp
	$<TARGET_OBJECTS:Front_obj>
	$<TARGET_OBJECTS:jsoncpp_obj>
)

# link
# every lib should be linked with [compiler]
if (WIN32)
	set(IR_LIB ${PROJECT_SOURCE_DIR}/lib/libIR-x86-win.a)
	set(TOOLS_LIB ${PROJECT_SOURCE_DIR}/lib/libTools-x86-win.a)
else()
	set(IR_LIB ${PROJECT_SOURCE_DIR}/lib/libIR-x86-linux.a)
	set(TOOLS_LIB ${PROJECT_SOURCE_DIR}/lib/libTools-x86-linux.a)
endif()

target_link_libraries(compiler ${TOOLS_LIB} ${IR_LIB})