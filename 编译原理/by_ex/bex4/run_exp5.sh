#!/bin/bash
set -e
cd /home/student/workspace/bisheng_lab/exp5_loopopt_project

cat > loop_fusion_test.c << 'EOF'
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#ifndef N
#define N 6000000
#endif
#ifndef REPEAT
#define REPEAT 3
#endif
static inline double now_sec() {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (double)ts.tv_sec + (double)ts.tv_nsec * 1e-9;
}
int main() {
    float *a = (float*)aligned_alloc(64, (size_t)N * sizeof(float));
    float *b = (float*)aligned_alloc(64, (size_t)N * sizeof(float));
    float *c = (float*)aligned_alloc(64, (size_t)N * sizeof(float));
    float *d = (float*)aligned_alloc(64, (size_t)N * sizeof(float));
    if (!a || !b || !c || !d) { fprintf(stderr, "alloc failed\n"); return 1; }
    for (int i = 0; i < N; i++) { a[i] = (float)i; b[i] = (float)(N - i); }
    double st = now_sec();
#if defined(FUSED)
    for (int r = 0; r < REPEAT; r++) {
        for (int i = 0; i < N; i++) {
            float ai = a[i];
            c[i] = ai + b[i];
            d[i] = ai * 0.5f;
        }
    }
#else
    for (int r = 0; r < REPEAT; r++) {
        for (int i = 0; i < N; i++) c[i] = a[i] + b[i];
        for (int i = 0; i < N; i++) d[i] = a[i] * 0.5f;
    }
#endif
    double ed = now_sec();
    float checksum = 0.0f;
    for (int i = 0; i < N; i++) checksum += c[i] + d[i];
    fprintf(stderr, "Checksum: %f\n", checksum);
#if defined(FUSED)
    printf("mode=fused ");
#else
    printf("mode=unfused ");
#endif
    printf("N=%d REPEAT=%d time=%f\n", N, REPEAT, (ed - st));
    free(a); free(b); free(c); free(d);
    return 0;
}
EOF

echo '=== compile ==='
clang -O0 loop_fusion_test.c -o unfused_O0
clang -O1 loop_fusion_test.c -o unfused_O1
clang -O2 loop_fusion_test.c -o unfused_O2
clang -O2 -DFUSED=1 loop_fusion_test.c -o fused_O2

echo '=== run unfused_O0 x3 ==='
./unfused_O0
./unfused_O0
./unfused_O0

echo '=== run unfused_O1 x3 ==='
./unfused_O1
./unfused_O1
./unfused_O1

echo '=== run unfused_O2 x3 ==='
./unfused_O2
./unfused_O2
./unfused_O2

echo '=== run fused_O2 x3 ==='
./fused_O2
./fused_O2
./fused_O2

echo '=== generate asm ==='
clang -O0 -S loop_fusion_test.c -o unfused_O0.s
clang -O2 -S loop_fusion_test.c -o unfused_O2.s
clang -O2 -DFUSED=1 -S loop_fusion_test.c -o fused_O2.s

echo '=== loop structure evidence ==='
echo '--- unfused loops ---'
grep -n 'Inner Loop Header' unfused_O2.s | head -n 20 || true
echo '--- fused loops ---'
grep -n 'Inner Loop Header' fused_O2.s | head -n 20 || true

echo '=== Autotuner for loop fusion ==='
export AUTOTUNE_DATADIR=/tmp/autotuner_fusion
rm -rf /tmp/autotuner_fusion && mkdir -p /tmp/autotuner_fusion
clang -O2 -o fusion_tuned loop_fusion_test.c -fautotune-generate
llvm-autotune minimize
for i in 1 2 3 4 5; do
  clang -O2 -o fusion_tuned loop_fusion_test.c -fautotune
  t=$(./fusion_tuned | grep 'time=' | awk -F'time=' '{print $2}')
  echo "Iter $i time=$t"
  llvm-autotune feedback "$t"
done
llvm-autotune finalize
clang -O2 -o fusion_tuned loop_fusion_test.c -fautotune
echo '=== compare unfused_O2 vs fusion_tuned x3 ==='
./unfused_O2
./unfused_O2
./unfused_O2
./fusion_tuned
./fusion_tuned
./fusion_tuned
ls -lh /tmp/autotuner_fusion/config.yaml
