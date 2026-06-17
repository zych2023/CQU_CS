---
tags:
---
# 题目

一个学生类，有三个私有成员：名字name、课程学分指针score、课程成绩指针grade。定义一个友元函数，求全班同学的平均绩点。单门课程的学分绩点=学分*绩点=学分*(成绩/10-5) ; 全班同学的平均绩点是 所有同学的全部课程的学分绩点之和/所有同学学分数之和。单个同学的课程数不超过100门。全班同学人数不超过100名。

输入说明：

输入若干行。

每行一个学生的信息：第一个输入是学生的名字，第二个输入是第一门课程的学分，第三个输入是第一门课程的成绩，第四个输入是第二门课程的学分，第五个输入是第二门课程的成绩，以此类推，最后以-1表示该行输入结束。每个学生的课程数不超过100门。

最后以 no 表示输入结束。

输出一行，即该全班同学的平均绩点。

### 函数接口定义：

```c++
这是求全部同学平均绩点的友元函数的声明：
friend double averagegrade(student *stu, int count)
```

其中 `*stu` 和 `count` 都是用户传入的参数。 `*stu` 是传入的学生对象数组的首指针，`count`是全班学生数量。

### 裁判测试程序样例：

```c++

#include<iostream>
#include<string>
using namespace std;
class student{
   private:
      double *grade;
      double *score;
      string name;
public:
      student( )
     {
      grade=NULL;
      score=NULL;
      }
      student(string n, double *g, double *s)
      {
            name=n;
            grade=g;
            score=s;
       }
     friend double averagegrade(student *stu, int count);
};
/* 请在这里填写答案 */


int main()
{
   student stu[100];
   double s[100][100], g[100][100];
   int count=0;
   string n;
   for(int i=0;i<100;i++)
   {
         cin>>n;
         if(n=="no") break;
         count++;
         for(int j=0;j<100;j++)
        {
            cin>>s[i][j];
            if(s[i][j]==-1) break;
            cin>>g[i][j];
        }
       stu[i]=student(n, g[i], s[i]);
   }
   cout<<averagegrade(stu, count);
   return 0;
}
```

### 输入样例：

```in
bob 3 90 2 68.5 2.5 50 -1
andy 3 80 2 77 -1
no
```

### 输出样例：

```out
2.408
```

# 解答

```cpp
// 友元函数实现：计算全班同学的平均绩点
double averagegrade(student *stu, int count) {
    double total_gpa = 0.0;    // 所有课程的学分绩点总和
    double total_credits = 0.0; // 所有课程的学分总和

    // 遍历每个学生
    for (int i = 0; i < count; ++i) {
        int course_idx = 0;    // 课程索引，用于访问学分和成绩数组
        while (true) {
            double credit = stu[i].score[course_idx];  // 当前课程的学分
            if (credit == -1) {  // 遇到-1，说明该学生的课程结束
                break;
            }
            double grade = stu[i].grade[course_idx];   // 当前课程的成绩
            // 计算当前课程的学分绩点并累加到总和
            total_gpa += credit * (grade / 10 - 5);
            // 累加当前课程的学分
            total_credits += credit;
            course_idx++;  // 移动到下一门课程
        }
    }

    // 计算并返回平均绩点（避免除以零，题目中默认总学分不为零）
    return total_credits == 0 ? 0.0 : total_gpa / total_credits;
}		
```