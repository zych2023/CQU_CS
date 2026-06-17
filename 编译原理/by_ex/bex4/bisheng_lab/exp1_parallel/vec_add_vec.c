#include <stdio.h>
#include <stdlib.h>
#include <time.h>
void __attribute__ ((noinline))
f(int N, float *a, float *b, float *out) {
    for (int i = 0; i < N; i++) out[i] = a[i] + b[i];
}
int main() {
    int loop = 1000;
    int len  = 200000;
    float *a = (float*)malloc(sizeof(float) * len);
    float *b = (float*)malloc(sizeof(float) * len);
    float *o = (float*)malloc(sizeof(float) * len);
    for (int i = 0; i < len; i++) { 
        a[i] = (float)rand() /((float)RAND_MAX + 1.0f);
        b[i] = (float)rand() / ((float)RAND_MAX + 1.0f); 
    }
    clock_t st = clock();
    for (int i = 0; i < loop; i++) f(len, a, b, o);
    clock_t ed = clock();
    double t = (double)(ed - st) / CLOCKS_PER_SEC;
    printf("time: %f s\n", t);
    volatile float guard = o[0];
    (void)guard;
    free(a); free(b); free(o);
    return 0;
}
