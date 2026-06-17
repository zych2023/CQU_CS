#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#ifndef N
#define N 1200000
#endif
#ifndef REPEAT
#define REPEAT 10
#endif
typedef struct {
    float a;
    float pad[31];
} S;
static inline double now_sec() {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (double)ts.tv_sec + (double)ts.tv_nsec * 1e-9;
}
__attribute__((noinline))
void transform_a_aos(const S* x, float* out) {
    for (int r = 0; r < REPEAT; r++) {
        for (int i = 0; i < N; i++) {
            out[i] = x[i].a * 1.1f + 2.0f;
        }
    }
}
__attribute__((noinline))
void transform_a_soa(const float* a, float* out) {
    for (int r = 0; r < REPEAT; r++) {
        for (int i = 0; i < N; i++) {
            out[i] = a[i] * 1.1f + 2.0f;
        }
    }
}
int main() {
    S* xs = (S*)aligned_alloc(64, sizeof(S) * (size_t)N);
    float* a = (float*)aligned_alloc(64, sizeof(float) * (size_t)N);
    float* out_aos = (float*)aligned_alloc(64, sizeof(float) * (size_t)N);
    float* out_soa = (float*)aligned_alloc(64, sizeof(float) * (size_t)N);
    if (!xs || !a || !out_aos || !out_soa) {
        printf("alloc failed\n");
        return 1;
    }
    for (int i = 0; i < N; i++) {
        xs[i].a = (float)i * 0.001f;
        memset(xs[i].pad, 0, sizeof(xs[i].pad));
        a[i] = xs[i].a;
        out_aos[i] = 0.0f;
        out_soa[i] = 0.0f;
    }
    double st1 = now_sec();
    transform_a_aos(xs, out_aos);
    double ed1 = now_sec();
    double st2 = now_sec();
    transform_a_soa(a, out_soa);
    double ed2 = now_sec();
    double checksum_aos = 0.0, checksum_soa = 0.0;
    for (int i = 0; i < N; i++) {
        checksum_aos += out_aos[i];
        checksum_soa += out_soa[i];
    }
    printf("checksum_aos=%0.3f checksum_soa=%0.3f\n", checksum_aos, checksum_soa);
    printf("time_aos=%f time_soa=%f\n", ed1 - st1, ed2 - st2);
    free(xs); free(a); free(out_aos); free(out_soa);
    return 0;
}
