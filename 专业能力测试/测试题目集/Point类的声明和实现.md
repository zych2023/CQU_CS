---
tags:
---
# 题目
定义一个Point类，代表平面上的一个点，其横坐标和纵坐标分别用x和y表示，设计Point类的成员函数，实现并测试这个类。  
主函数中输入两个点的坐标，计算并输出了两点间的距离。请根据主函数实现Point类。

### 裁判测试程序样例：

```c++
#include <iostream>
#include <iomanip>
#include <cmath>
using namespace std;

//你的代码将被嵌在这里

int main()
{
    Point p1, p2;
    double x1, y1, x2, y2;
    cin >> x1 >> y1 >> x2 >> y2;
    p1.setX(x1);
    p1.setY(y1);
    p2.setX(x2);
    p2.setY(y2);
    double x = p1.getX() - p2.getX();
    double y = p1.getY() - p2.getY();
    double len = sqrt(x * x + y * y);
    cout << fixed << setprecision(2) << len << endl;
    return 0;
}
```

### 输入样例：

```in
0 0 3 3
```

### 输出样例：

```out
4.24
```

# 解答
```cpp
class Point {
private:
    double x;  // 横坐标
    double y;  // 纵坐标
public:
    // 设置横坐标
    void setX(double xVal) {
        x = xVal;
    }
    // 设置纵坐标
    void setY(double yVal) {
        y = yVal;
    }
    // 获取横坐标
    double getX() {
        return x;
    }
    // 获取纵坐标
    double getY() {
        return y;
    }
};
```