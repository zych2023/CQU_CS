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
