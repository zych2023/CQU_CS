---
tags:
---
# 题目
一个俱乐部需要保存它的简要信息，包括四项：名称（字符串），成立年份（整数），教练姓名（字符串）和教练胜率（0－100之间的整数）。用键盘输入这些信息后，把它们分两行输出：第一行输出名称和成立年份，第二行输出教练姓名和胜率。

### 裁判测试程序样例：

```c++
#include <iostream>
#include <string>
using namespace std;
class Coach{
    string name;
    int winRate;
public:
    Coach(string n, int wr){
        name=n; winRate=wr;
    }
    void show();
};
class Club{
    string name;
    Coach c;
    int year;
public:
    Club(string n1, int y, string n2, int wr);
    void show();
};
int main(){
    string n1, n2;
    int year, winRate;
    cin>>n1>>year>>n2>>winRate;
    Club c(n1,year, n2, winRate);
    c.show();
    return 0;
}

/* 请在这里填写答案 */
```

### 输入样例：

```in
Guanzhou 2006 Tom 92
```

### 输出样例：

```out
Guanzhou 2006
Tom 92%
```

# 解答

```cpp
// 1. Coach类的show成员函数：输出教练姓名和带%的胜率
void Coach::show() {
	    cout << name << " " << winRate << "%" << endl;
}

// 2. Club类的构造函数：初始化俱乐部名称、成立年份，以及教练对象（Coach）
Club::Club(string n1, int y, string n2, int wr) 
    : name(n1), year(y), c(n2, wr) {  // 初始化列表：先初始化成员对象c，再初始化其他成员
    // 构造函数体无需额外代码，初始化列表已完成所有成员的初始化
}

// 3. Club类的show成员函数：分两行输出俱乐部信息和教练信息
void Club::show() {
    // 第一行：输出俱乐部名称和成立年份
    cout << name << " " << year << endl;
    // 第二行：调用Coach类的show函数输出教练信息
    c.show();
}
```