#include<iostream>
#include<mpi.h>
#include<omp.h>
#include<cstring>

using namespace std;
double start_time, end_time;

void getData(int*& A, int*& x, int& m, int& n) {
    m = 7680, n = 42000;
    cout << "shape: " << m << " * " << n << endl;
    A = new int[m * n];
    x = new int[n];

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (j <= i)
                A[i * n + j] = j + 1;
            else
                A[i * n + j] = 0;
        }
    }
    for (int i = 0; i < n; i++) x[i] = 1;
}

void transpose(int*& A, int*& B, int& m, int& n) {
    B = new int[m * n];
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            B[j*m+i] = A[i * n + j];
        }
    }
    free(A);
}

int main(int argc, char* argv[]) {

    int my_rank, comm_sz;
    int namelen;
    char processor_name[MPI_MAX_PROCESSOR_NAME];
    MPI_Init(NULL, NULL);
    MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);
    MPI_Comm_size(MPI_COMM_WORLD, &comm_sz);
    MPI_Get_processor_name(processor_name, &namelen);

    int* A = nullptr, *B = nullptr, * x = nullptr, m, n, * result = nullptr, my_col;

    if (my_rank == 0) {
        start_time = MPI_Wtime();
        getData(A, x, m, n);
        transpose(A, B,m, n);
    }
    cout << processor_name << endl;

    MPI_Bcast(&m, 1, MPI_INT, 0, MPI_COMM_WORLD);
    MPI_Bcast(&n, 1, MPI_INT, 0, MPI_COMM_WORLD);

    my_col = n / comm_sz;
    int* local_A = new int[my_col * m];
    int* local_x = new int[my_col];
    int* local_result = new int[m];
    memset(local_result, 0, m * sizeof(int));

    MPI_Scatter(B, my_col * m, MPI_INT, local_A, my_col * m,
        MPI_INT, 0, MPI_COMM_WORLD);
    MPI_Scatter(x, my_col, MPI_INT, local_x, my_col,
        MPI_INT, 0, MPI_COMM_WORLD);

    if (my_rank == 0) {
        free(B);
        result = new int[m];
    }

    # pragma omp parallel for num_threads(2)
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < my_col; j++) {
            local_result[i] += local_A[j * m + i] * local_x[j];
        }
    }
    MPI_Reduce(local_result, result, m, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD);

    if (my_rank == 0) {
        end_time = MPI_Wtime();
        cout << "column parallel cost time: " << end_time - start_time << "s"<< endl;
        cout << "result[m-1] = "<<result[m-1] << endl;
    }

    MPI_Finalize();
    return 0;
}

