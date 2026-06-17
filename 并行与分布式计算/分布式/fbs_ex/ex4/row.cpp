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

int main(int argc, char* argv[]) {

    int my_rank, comm_sz;
    int namelen;
    char processor_name[MPI_MAX_PROCESSOR_NAME];
    MPI_Init(NULL, NULL);
    MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);
    MPI_Comm_size(MPI_COMM_WORLD, &comm_sz);
    MPI_Get_processor_name(processor_name, &namelen);

    int* A = nullptr, * x = nullptr, m, n, * result = nullptr, my_row;

    if (my_rank == 0) {
        start_time = MPI_Wtime();
        getData(A, x, m, n);
    }
    cout << processor_name << endl;

    MPI_Bcast(&m, 1, MPI_INT, 0, MPI_COMM_WORLD);
    MPI_Bcast(&n, 1, MPI_INT, 0, MPI_COMM_WORLD);

    if (my_rank != 0)
        x = new int[n];
    MPI_Bcast(x, n, MPI_INT, 0, MPI_COMM_WORLD);
    my_row = m / comm_sz;
    int* local_A = new int[my_row * n];
    int* local_result = new int[my_row];
    memset(local_result, 0, my_row * sizeof(int));

    MPI_Scatter(A, my_row * n, MPI_INT, local_A, my_row * n,
        MPI_INT, 0, MPI_COMM_WORLD);
    if (my_rank == 0) {
        free(A);
        result = new int[m];
    }

    # pragma omp parallel for num_threads(2)
    for (int i = 0; i < my_row; i++) {
        for (int j = 0; j < n; j++) {
            local_result[i] += local_A[i * n + j] * x[j];
        }
    }

    MPI_Gather(local_result, my_row, MPI_INT, result, my_row,
        MPI_INT, 0, MPI_COMM_WORLD);

    if (my_rank == 0) {
        end_time = MPI_Wtime();
        cout << "row parallel cost time: " << end_time - start_time << "s" << endl;
        cout << "result[m-1] = " << result[m - 1] << endl;
    }

    MPI_Finalize();
    return 0;
}
