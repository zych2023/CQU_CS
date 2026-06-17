#include <algorithm>
#include <cstdlib>
#include <iostream>
#include <thread>
#include <vector>

#include "hpc_helpers.hpp"

namespace {

constexpr int kThreadCount = 8;
constexpr int kBlockRows = 8;

void sequential(const std::vector<int>& A,
				const std::vector<int>& B,
				std::vector<int>& C,
				int n) {
	const size_t total = static_cast<size_t>(n) * static_cast<size_t>(n);
	for (size_t idx = 0; idx < total; ++idx) {
		C[idx] = A[idx] + B[idx];
	}
}

void block_worker(const std::vector<int>& A,
				  const std::vector<int>& B,
				  std::vector<int>& C,
				  int n,
				  int thread_id,
				  int thread_count) {
	const int rows_per_thread = SDIV(n, thread_count);
	const int row_begin = thread_id * rows_per_thread;
	const int row_end = std::min(n, row_begin + rows_per_thread);

	for (int r = row_begin; r < row_end; ++r) {
		const size_t base = static_cast<size_t>(r) * static_cast<size_t>(n);
		for (int c = 0; c < n; ++c) {
			const size_t idx = base + static_cast<size_t>(c);
			C[idx] = A[idx] + B[idx];
		}
	}
}

void block_parallel(const std::vector<int>& A,
					const std::vector<int>& B,
					std::vector<int>& C,
					int n,
					int thread_count = kThreadCount) {
	std::vector<std::thread> workers;
	workers.reserve(thread_count);

	for (int t = 0; t < thread_count; ++t) {
		workers.emplace_back(block_worker, std::cref(A), std::cref(B), std::ref(C), n, t,
							 thread_count);
	}

	for (std::thread& th : workers) {
		th.join();
	}
}

void cyclic_worker(const std::vector<int>& A,
				   const std::vector<int>& B,
				   std::vector<int>& C,
				   int n,
				   int thread_id,
				   int thread_count) {
	for (int r = thread_id; r < n; r += thread_count) {
		const size_t base = static_cast<size_t>(r) * static_cast<size_t>(n);
		for (int c = 0; c < n; ++c) {
			const size_t idx = base + static_cast<size_t>(c);
			C[idx] = A[idx] + B[idx];
		}
	}
}

void cyclic_parallel(const std::vector<int>& A,
					 const std::vector<int>& B,
					 std::vector<int>& C,
					 int n,
					 int thread_count = kThreadCount) {
	std::vector<std::thread> workers;
	workers.reserve(thread_count);

	for (int t = 0; t < thread_count; ++t) {
		workers.emplace_back(cyclic_worker, std::cref(A), std::cref(B), std::ref(C), n, t,
							 thread_count);
	}

	for (std::thread& th : workers) {
		th.join();
	}
}

void block_cyclic_worker(const std::vector<int>& A,
						 const std::vector<int>& B,
						 std::vector<int>& C,
						 int n,
						 int thread_id,
						 int thread_count,
						 int block_rows) {
	const int stride_rows = block_rows * thread_count;
	for (int block_start = thread_id * block_rows; block_start < n; block_start += stride_rows) {
		const int block_end = std::min(n, block_start + block_rows);
		for (int r = block_start; r < block_end; ++r) {
			const size_t base = static_cast<size_t>(r) * static_cast<size_t>(n);
			for (int c = 0; c < n; ++c) {
				const size_t idx = base + static_cast<size_t>(c);
				C[idx] = A[idx] + B[idx];
			}
		}
	}
}

void block_cyclic_parallel(const std::vector<int>& A,
						   const std::vector<int>& B,
						   std::vector<int>& C,
						   int n,
						   int thread_count = kThreadCount,
						   int block_rows = kBlockRows) {
	std::vector<std::thread> workers;
	workers.reserve(thread_count);

	for (int t = 0; t < thread_count; ++t) {
		workers.emplace_back(block_cyclic_worker, std::cref(A), std::cref(B), std::ref(C), n, t,
							 thread_count, block_rows);
	}

	for (std::thread& th : workers) {
		th.join();
	}
}

bool verify_all_three(const std::vector<int>& C) {
	for (int value : C) {
		if (value != 3) {
			return false;
		}
	}
	return true;
}

}  // namespace

int main(int argc, char* argv[]) {
	int n = 10000;
	if (argc > 1) {
		n = std::max(1, std::atoi(argv[1]));
	}

	std::cout << "Matrix size: " << n << " x " << n << "\n";
	std::cout << "Thread count: " << kThreadCount << "\n";
	std::cout << "Block rows (block-cyclic): " << kBlockRows << "\n\n";

	const size_t total = static_cast<size_t>(n) * static_cast<size_t>(n);
	std::vector<int> A(total, 1);
	std::vector<int> B(total, 2);
	std::vector<int> C(total, 0);

	TIMERSTART(sequential);
	sequential(A, B, C, n);
	TIMERSTOP(sequential);
	std::cout << "Result check: " << (verify_all_three(C) ? "PASS" : "FAIL") << "\n\n";

	std::fill(C.begin(), C.end(), 0);
	TIMERSTART(static_block);
	block_parallel(A, B, C, n, kThreadCount);
	TIMERSTOP(static_block);
	std::cout << "Result check: " << (verify_all_three(C) ? "PASS" : "FAIL") << "\n\n";

	std::fill(C.begin(), C.end(), 0);
	TIMERSTART(cyclic);
	cyclic_parallel(A, B, C, n, kThreadCount);
	TIMERSTOP(cyclic);
	std::cout << "Result check: " << (verify_all_three(C) ? "PASS" : "FAIL") << "\n\n";

	std::fill(C.begin(), C.end(), 0);
	TIMERSTART(block_cyclic);
	block_cyclic_parallel(A, B, C, n, kThreadCount, kBlockRows);
	TIMERSTOP(block_cyclic);
	std::cout << "Result check: " << (verify_all_three(C) ? "PASS" : "FAIL") << "\n";

	return 0;
}
