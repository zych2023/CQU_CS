#include <iostream>
#include <mutex>
#include <string>
#include <thread>

void print_id(const std::string& student_id, bool use_mutex, std::mutex& mtx) {
    for (int i = 0; i < 10; ++i) {
        if (use_mutex) {
            std::lock_guard<std::mutex> lock(mtx);
            std::cout << "学号: " << student_id << " 次数: " << i + 1 << '\n';
        } else {
            std::cout << "学号: " << student_id << " 次数: " << i + 1 << '\n';
        }
    }
}

void print_name(const std::string& name, bool use_mutex, std::mutex& mtx) {
    for (int i = 0; i < 10; ++i) {
        if (use_mutex) {
            std::lock_guard<std::mutex> lock(mtx);
            std::cout << "姓名: " << name << " 次数: " << i + 1 << '\n';
        } else {
            std::cout << "姓名: " << name << " 次数: " << i + 1 << '\n';
        }
    }
}

int main() {
    const std::string student_id = "20260001";
    const std::string name = "张三";

    std::mutex mtx;

    std::cout << "===== 不加锁输出 =====" << '\n';
    {
        std::thread t1(print_id, std::cref(student_id), false, std::ref(mtx));
        std::thread t2(print_name, std::cref(name), false, std::ref(mtx));
        t1.join();
        t2.join();
    }

    std::cout << "\n===== 使用 mutex 加锁输出 =====" << '\n';
    {
        std::thread t1(print_id, std::cref(student_id), true, std::ref(mtx));
        std::thread t2(print_name, std::cref(name), true, std::ref(mtx));
        t1.join();
        t2.join();
    }
    
    return 0;
}
