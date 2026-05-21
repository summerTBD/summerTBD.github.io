---
layout: single
title: "无向图的最小顶点着色问题"
date: 2026-05-21
author: summerTBD
categories: [算法]
tags: [DFS, 回溯]
math: true
toc: true
toc_sticky: true
---

## 无向图的最小顶点着色问题概述

给你一个无向图，有 $$n$$ 个顶点和 $$m$$ 条边。现在需要给图中的每个顶点染色，要求**相邻的顶点不能染相同颜色**。请问最少需要多少种颜色才能完成染色？

这就是经典的**图着色问题（Graph Coloring Problem）**，属于 NP-完全问题，当图规模较小时可以用回溯法（DFS + 剪枝）求解。

## 思路

### 核心思想

我们采用**回溯法（DFS）**，逐一为每个顶点选择合法颜色，并利用当前已知的最优解进行剪枝。

由于有 $$n$$ 个顶点，最坏情况下每个顶点一种颜色，因此答案一定在 $$1 \sim n$$ 之间。我们可以**从小到大猜测**所需颜色数，尝试用不超过该数量的颜色给图染色。如果染色成功，说明当前猜测数可行；否则需要增加颜色数。

### 算法流程

定义 `dfs(u, cur_max)`：当前正在给第 $$u$$ 个顶点染色，猜测的最多可用颜色数为 `cur_max`。

1. **剪枝**：如果 `cur_max >= ans`（当前已找到的最优解），则直接返回，不再继续搜索。
2. **终止条件**：如果 $$u \geq n$$（所有顶点已染色完成），更新 `ans = cur_max` 并返回。
3. **尝试使用已有颜色**：遍历 `0` 到 `cur_max - 1` 号颜色，如果颜色 $$i$$ 与已染色的邻接顶点不冲突，则将顶点 $$u$$ 染成 $$i$$，然后递归 `dfs(u+1, cur_max)`，最后回溯 `color[u] = -1`。
4. **尝试使用新颜色**：如果已有颜色都不可用，则将顶点 $$u$$ 染成 `cur_max`（新颜色），递归 `dfs(u+1, cur_max+1)`，然后回溯 `color[u] = -1`。

### 关键细节

- 回溯时将 `color[u]` 重置为 **不可能的值**。若颜色编号从 0 开始，则重置为 `-1`；若从 1 开始，则重置为 `0`。
- 算法复杂度为指数级，适用于小规模图（$$n \leq 20$$ 左右）。

## 例题：蓝桥杯 2017 国赛 — 分考场

### 题目描述

> **问题描述**
>
> $$n$$ 个人参加某项特殊考试。为了公平，要求任何两个**认识的人**不能分在同一个考场。求至少需要分几个考场才能满足条件。

> **输入格式**
>
> 第一行一个整数 $$n$$（$$1 \le n \le 100$$），表示参加考试的人数。
> 第二行一个整数 $$m$$，表示接下来有 $$m$$ 行数据。
> 接下来 $$m$$ 行，每行两个整数 $$a, b$$（$$1 \le a, b \le n$$），表示第 $$a$$ 个人与第 $$b$$ 个人认识。

> **输出格式**
>
> 输出一行一个整数，表示最少分几个考场。

> **运行限制**
>
> - 最大运行时间：1s
> - 最大运行内存：256MB

> **样例输入**
>
> ```
> 5
> 8
> 1 2
> 1 3
> 1 4
> 2 3
> 2 4
> 2 5
> 3 4
> 4 5
> ```

> **样例输出**
>
> ```
> 4
> ```

### 题目分析

这道题正是图着色问题的经典应用：

- 将每个学生看作一个**顶点**
- 将"认识"关系看作**边**（认识的人之间不能在同一考场）
- 将每个考场看作一种**颜色**
- 目标：用最少的考场数（颜色数）完成分配

因此，上述回溯算法完全适用于此题。唯一需要注意的是，题目中 $$n$$ 的最大值可达 100，如果直接套用暴力回溯会超时。实际竞赛中通常采用**贪心策略**或**更优的剪枝方法**来解决较大规模的数据。

### 参考代码（适用于小规模数据）

```cpp
#include <iostream>
#include <vector>
#include <functional>
using namespace std;

int main()
{
    int n, m;
    cin >> n >> m;

    vector<vector<bool>> adj(n, vector<bool>(n, false));
    for (int i = 0; i < m; ++i)
    {
        int a, b;
        cin >> a >> b;
        adj[a - 1][b - 1] = true;
        adj[b - 1][a - 1] = true;
    }

    vector<int> color(n, -1);
    int ans = n;

    auto is_safe = [&](int u, int c) -> bool
    {
        for (int i = 0; i < n; ++i)
        {
            if (adj[u][i] && color[i] == c)
                return false;
        }
        return true;
    };

    function<void(int, int)> dfs = [&](int u, int cur_max)
    {
        if (cur_max >= ans)
            return;

        if (u >= n)
        {
            ans = cur_max;
            return;
        }

        for (int i = 0; i < cur_max; ++i)
        {
            if (is_safe(u, i))
            {
                color[u] = i;
                dfs(u + 1, cur_max);
                color[u] = -1;
            }
        }

        color[u] = cur_max;
        dfs(u + 1, cur_max + 1);
        color[u] = -1;
    };

    dfs(0, 0);
    cout << ans << '\n';
    return 0;
}
```

## 代码

### 实现一：颜色从 0 开始编号

```cpp
#include <bits/stdc++.h>
using namespace std;

int main()
{
    int n, m;
    cin >> n >> m;
    vector<vector<bool>> adj(n, vector<bool>(n, 0));

    for (int i = 0; i < m; ++i)
    {
        int a, b;
        cin >> a >> b;
        adj[a - 1][b - 1] = true;
        adj[b - 1][a - 1] = true;
    }

    vector<int> color(n, -1);
    int ans = n;

    auto is_safe = [&](int u, int c) -> bool
    {
        for (int i = 0; i < n; ++i)
        {
            if (adj[u][i] && color[i] == c)
                return false;
        }
        return true;
    };

    function<void(int, int)> dfs = [&](int u, int cur_max)
    {
        if (cur_max >= ans)
            return;

        if (u >= n)
        {
            ans = cur_max;
            return;
        }

        // 尝试使用已有的颜色（0 ~ cur_max-1）
        for (int i = 0; i < cur_max; ++i)
        {
            if (is_safe(u, i))
            {
                color[u] = i;
                dfs(u + 1, cur_max);
                color[u] = -1; // 回溯
            }
        }

        // 尝试使用新颜色 cur_max
        color[u] = cur_max;
        dfs(u + 1, cur_max + 1);
        color[u] = -1; // 回溯
    };

    dfs(0, 0);
    cout << ans << '\n';
    return 0;
}
```

### 实现二：颜色从 1 开始编号

```cpp
#include <iostream>
#include <vector>
#include <functional>
using namespace std;

int main()
{
    ios::sync_with_stdio(false);
    cin.tie(0);
    cout.tie(0);

    int n, m;
    cin >> n >> m;

    vector<vector<bool>> adj(n + 1, vector<bool>(n + 1, false));
    vector<int> color(n + 1);

    for (int i = 0; i < m; ++i)
    {
        int u, v;
        cin >> u >> v;
        adj[u][v] = adj[v][u] = true;
    }

    function<bool(int, int)> is_safe;
    is_safe = [&](int u, int c) -> bool
    {
        for (int i = 1; i <= n; ++i)
        {
            if (adj[u][i] && color[i] == c)
                return false;
        }
        return true;
    };

    int ans = n;

    function<void(int, int)> dfs;
    dfs = [&](int u, int cur_max) -> void
    {
        if (cur_max >= ans)
            return;

        if (u > n)
        {
            ans = cur_max;
            return;
        }

        // 尝试使用已有的颜色（1 ~ cur_max）
        for (int i = 1; i <= cur_max; ++i)
        {
            if (is_safe(u, i))
            {
                color[u] = i;
                dfs(u + 1, cur_max);
                color[u] = 0; // 回溯（0 表示未染色）
            }
        }

        // 尝试使用新颜色 cur_max + 1
        color[u] = cur_max + 1;
        dfs(u + 1, cur_max + 1);
        color[u] = 0; // 回溯
    };

    dfs(1, 0);

    cout << ans << '\n';
    return 0;
}
```

## 总结

- 该算法本质上是**暴力搜索 + 剪枝**，遍历所有可能的染色方案。
- 通过维护当前最优解 `ans` 进行剪枝，大幅减少搜索空间。
- 适用于小规模图，当 $$n$$ 较大时需考虑其他算法（如贪心着色、分支定界等）。
