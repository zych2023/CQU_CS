---
tags:
---
# 题目
定义一个CPU类，包含等级（Rank）、频率（frequency）、电压(voltage)等属性。其中，rank为枚举类型CPU__Rank,定义为enum CPU_Rank{P1=1,P2,P3,P4,P5,P6,P7},frequency为单位是MHz的整型数，voltage为浮点型的电压值。

### 函数接口定义：

```c++
根据题目要求写出类。
```

### 裁判测试程序样例：

```c++

/* 请在这里填写答案 */


int main()
{
    CPU a(P6,3,300); 
    
    cout<<"cpu a's parameter"<<endl;
    a.showinfo(); //显示性能参数

    CPU b; 
    cout<<"cpu b's parameter"<<endl;
    b.showinfo(); //显示性能参数

    CPU c(a); 
    cout<<"cpu c's parameter"<<endl;
    c.showinfo(); //显示性能参数
}

```

### 输入样例：

无

### 输出样例：

```out
create a CPU!
cpu a's parameter
rank:6
frequency:3
voltage:300
create a CPU!
cpu b's parameter
rank:1
frequency:2
voltage:100
copy create a CPU!
cpu c's parameter
rank:6
frequency:3
voltage:300
destruct a CPU!
destruct a CPU!
destruct a CPU!
```

# 解答

```cpp
#include <iostream>
using namespace std;

// 1. 定义CPU等级枚举类型
enum CPU_Rank { P1 = 1, P2, P3, P4, P5, P6, P7 };

// 2. 定义CPU类
class CPU {
private:
    CPU_Rank rank;    // 等级
    int frequency;    // 频率（MHz）
    double voltage;   // 电压
public:
    // 带参数构造函数
    CPU(CPU_Rank r, int f, double v) : rank(r), frequency(f), voltage(v) {
        cout << "create a CPU!" << endl;
    }

    // 默认构造函数
    CPU() : rank(P1), frequency(2), voltage(100.0) {
        cout << "create a CPU!" << endl;
    }

    // 拷贝构造函数
    CPU(const CPU& other) : rank(other.rank), frequency(other.frequency), voltage(other.voltage) {
        cout << "copy create a CPU!" << endl;
    }

    // 析构函数
    ~CPU() {
        cout << "destruct a CPU!" << endl;
    }

    // 显示信息函数
    void showinfo() {
        cout << "rank:" << rank << endl;
        cout << "frequency:" << frequency << endl;
        cout << "voltage:" << voltage << endl;
    }
};
```