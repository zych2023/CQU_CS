#!/bin/bash
set -euo pipefail
export AUTOTUNE_DATADIR=/tmp/autotuner_data
rm -rf /tmp/autotuner_data
mkdir -p /tmp/autotuner_data
ITERS=60000
TUNE_ITERS=10
echo '=== [1] generate ==='
clang -Iposix -I. -g -DCOMPILER_FLAGS=\"-O2\" -DITERATIONS=60000 core_list_join.c core_main.c core_matrix.c core_state.c core_util.c posix/core_portme.c -O2 -o coremark -fautotune-generate
echo '=== [2] init ==='
llvm-autotune minimize
echo '=== [3] iterate ==='
for i in 1 2 3 4 5 6 7 8 9 10; do
  clang -Iposix -I. -g -DCOMPILER_FLAGS=\"-O2\" -DITERATIONS=60000 core_list_join.c core_main.c core_matrix.c core_state.c core_util.c posix/core_portme.c -O2 -o coremark -fautotune
  time_cost=$(./coremark 0x0 0x0 0x66 60000 | grep 'Total time' | awk '{print $4}')
  echo "Iteration $i -> time: $time_cost"
  llvm-autotune feedback "$time_cost"
done
echo '=== [4] finalize ==='
llvm-autotune finalize
echo '=== [5] build autotuned and baseline ==='
clang -Iposix -I. -g -DCOMPILER_FLAGS=\"-O2\" -DITERATIONS=60000 core_list_join.c core_main.c core_matrix.c core_state.c core_util.c posix/core_portme.c -O2 -o coremark -fautotune
mv coremark coremark_autotuned
clang -Iposix -I. -g -DCOMPILER_FLAGS=\"-O2\" -DITERATIONS=60000 core_list_join.c core_main.c core_matrix.c core_state.c core_util.c posix/core_portme.c -O2 -o coremark
mv coremark coremark_O2
echo '=== [6] run compare ==='
echo '--- O2 baseline ---'
./coremark_O2 0x0 0x0 0x66 60000 | grep -E 'Total time|Iterations/Sec|CoreMark'
echo '--- autotuned ---'
./coremark_autotuned 0x0 0x0 0x66 60000 | grep -E 'Total time|Iterations/Sec|CoreMark'
echo 'config: /tmp/autotuner_data/config.yaml'
