`emplace_back` 是 C++ 标准库中容器（如 `vector`、`list` 等）的成员函数，用于**在容器末尾直接构造一个新元素**，而无需先创建临时对象。它是 `push_back` 的更高效版本。


### 与 `push_back` 的区别：
- `push_back` 需要先构造一个对象（或临时对象），再将其复制/移动到容器中。
- `emplace_back` 直接在容器的内存空间中构造对象，**省去了复制/移动的步骤**，效率更高。


### 在你的代码中：
```cpp
events.emplace_back(s, 1);
```
- `events` 是 `vector<pair<int, int>>` 类型的容器（存储成对的整数）。
- `emplace_back(s, 1)` 会直接在 `events` 的末尾构造一个 `pair<int, int>` 对象，其第一个元素是 `s`（时间戳，整数），第二个元素是 `1`（事件类型）。

这等价于：
```cpp
events.push_back(pair<int, int>(s, 1));  // 先构造临时pair，再复制到容器
```
但 `emplace_back` 更高效，因为它直接在容器内部构造，避免了临时对象的创建和复制。


### 适用场景：
当容器存储的是**结构体、类或 pair 等复杂类型**时，`emplace_back` 能显著提升性能（减少内存开销和复制操作）。对于简单类型（如 `int`），两者效率差异不大。


总结：`emplace_back` 是 C++11 引入的高效插入函数，用于在容器末尾直接构造元素，推荐优先使用以优化性能。