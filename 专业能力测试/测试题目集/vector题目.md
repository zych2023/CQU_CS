---
tags:
---
# 题目
本题要求实现一个Vector类模板，能实现数据的存储和访问。通过`[]`运算符访问时只能访问已经存在的元素，而通过`add()`方法访问时可以自动扩展内部存储空间。

_注意，这个`Vector`的行为和`std::vector`是不同的_

### 函数接口定义：

```c
template <class T>
class Vector {
...
```

### 裁判测试程序样例：

```c++
#include <iostream>
using namespace std;

/* 请在这里填写答案 */

int main()
{
    Vector<int> vint;
    int n,m;
    cin >> n >> m;
    for ( int i=0; i<n; i++ ) {
        //    add() can inflate the vector automatically
        vint.add(i);    
    }
    //    get_size() returns the number of elements stored in the vector
    cout << vint.get_size() << endl;
    cout << vint[m] << endl;
    //    remove() removes the element at the index which begins from zero
    vint.remove(m);
    cout << vint.add(-1) << endl;
    cout << vint[m] << endl;
    Vector<int> vv = vint;
    cout << vv[vv.get_size()-1] << endl;
    vv.add(m);
    cout << vint.get_size() << endl;
}
```

### 输入样例：

```in
100 50
```

### 输出样例：

```out
100
50
99
51
-1
100
```

# 解答
```cpp
// #include <iostream>
// using namespace std;

template <class T>
class Vector {
private:
    T* data;       // 动态数组存储元素
    int capacity;  // 数组的容量
    int size;      // 当前元素个数

    // 辅助函数：扩展容量
    void expand() {
        int new_capacity = (capacity == 0) ? 1 : capacity * 2;
        T* new_data = new T[new_capacity];
        // 复制现有元素到新数组
        for (int i = 0; i < size; ++i) {
            new_data[i] = data[i];
        }
        delete[] data;  // 释放旧数组内存
        data = new_data;
        capacity = new_capacity;
    }

public:
    // 构造函数
    Vector() : data(nullptr), capacity(0), size(0) {}

    // 复制构造函数
    Vector(const Vector& other) : capacity(other.capacity), size(other.size) {
        data = new T[capacity];
        for (int i = 0; i < size; ++i) {
            data[i] = other.data[i];
        }
    }

    // 赋值运算符
    Vector& operator=(const Vector& other) {
        if (this != &other) {
            delete[] data;  // 释放当前数据
            capacity = other.capacity;
            size = other.size;
            data = new T[capacity];
            for (int i = 0; i < size; ++i) {
                data[i] = other.data[i];
            }
        }
        return *this;
    }

    // 析构函数
    ~Vector() {
        delete[] data;
    }

    // 添加元素，返回添加的索引
    int add(const T& elem) {
        if (size >= capacity) {
            expand();
        }
        data[size] = elem;
        size++;
        return size - 1;
    }

    // 获取当前元素个数
    int get_size() const {
        return size;
    }

    // 访问元素，仅允许访问已存在的元素
    T& operator[](int index) {
        return data[index];
    }

    // 删除指定索引的元素
    void remove(int index) {
        for (int i = index; i < size - 1; ++i) {
            data[i] = data[i + 1];
        }
        size--;
    }
};

```