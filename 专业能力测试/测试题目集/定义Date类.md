---
tags:
---
# 题目
本题要求实现一个日期类定义，根据所定义的类可以完成相关的类测试。

### Date类定义：

根据Date被使用的情况，进行Date类定义，要求通过构造函数进行日期初始化，并通过display（）函数进行日期格式显示，显示格式为"月/日/年"

### 测试程序样例：

main( ) 函数定义如下

```c++
int main()
{
 Date d1(3,25,2019);
 Date d2(3,30);
 Date d3(10);
 Date d4;
 d1.display();
 d2.display();
 d3.display();
 d4.display();
 return 0;
 }

/* 请在这里填写答案 */
```

### 输出样例：

在这里给出相应的输出。例如：

```out
3/25/2019
3/30/2019
10/1/2019
1/1/2019
```

# 解答
```cpp
#include <iostream>
using namespace std;

class Date {
private:
    int month;
    int day;
    int year;
public:
    // 带三个参数的构造函数：月、日、年
    Date(int m, int d, int y) : month(m), day(d), year(y) {}
    // 带两个参数的构造函数：月、日，年默认2019
    Date(int m, int d) : month(m), day(d), year(2019) {}
    // 带一个参数的构造函数：月，日默认1，年默认2019
    Date(int m) : month(m), day(1), year(2019) {}
    // 无参构造函数：月默认1，日默认1，年默认2019
    Date() : month(1), day(1), year(2019) {}
    // 显示日期，格式为"月/日/年"
    void display() {
        cout << month << "/" << day << "/" << year << endl;
    }
};

```