---
layout: single
title: "Cost_of_a_Bracket_Sequence"
date: 2026-05-30
author: summerTBD
categories: [数学, 算法]
tags: [算法]
math: true
toc: true
toc_sticky: true
---

## 题目链接
https://codeforces.com/problemset/problem/2233/C

## 问题重述

给定一个长度为 $n$ 的括号序列 $s$（由 `(` 和 `)` 组成），以及一个整数 $k$。Alice 可以删除至多 $k$ 个括号，她的目标是最小化**剩余序列的最长合法括号子序列（LBS）的长度**。换句话说，Alice 希望无论如何操作，对手都无法在剩下的序列中找到太长的合法配对。

我们的任务是：判断 Alice 是否存在一种删除方案，使得剩余序列的最长合法括号子序列的长度**不超过某个下界**（或者等价地，求出她能做到的最小代价）。

## 核心观察

合法括号序列有一个基本的结构性质：任何合法的括号配对，左括号一定在对应的右括号之前。因此，如果我们想"破坏"尽可能多的配对，一个自然的想法是：

- 删除序列中**最左边的一些 `(`**，因为这些左括号最容易找到与之匹配的右括号；
- 删除序列中**最右边的一些 `)`**，因为这些右括号最容易找到与之匹配的左括号。

为什么这样做是最优的？考虑一对已经匹配的括号 $(i, j)$（$i < j$），其中 $s_i = \texttt{(}$，$s_j = \texttt{)}$。由于 $i$ 和 $j$ 在配对意义下是轮换对称的，我们只需关注其中一侧。假设我们删除了某个左括号 $s_i$，对手试图找一个 $i' \neq i$ 来代替 $s_i$ 与 $s_j$ 配对。如果我们删除的是**最左边的左括号**，那么在它之前没有任何 `(` 可以替代它——因此对手必然丢失这个配对，代价**确定性地**减少 1。同理，删除**最右边的右括号**也能保证同样的效果：在它之后没有任何 `)` 可以替代它。

反过来，如果我们删除的是中间的某个括号，对手**有可能**在它的左侧找到另一个 `(`（或在右侧找到另一个 `)`）来顶替，从而维持原有的配对数量。当然，这并不总是成立——在某些序列中删除中间括号确实也会减少代价（例如 `((()))` 中删除中间括号依然会破坏配对）。但问题在于：这种操作的收益**依赖于序列的具体结构**，我们无法保证每一次删除都能稳定地减少代价。相比之下，删除最左 `(` 或最右 `)` 是**无条件**保证代价减 1 的操作——无论序列长什么样，这个结论都成立。因此，最优策略必然选择后者。

**结论**：Alice 的最优策略一定是删除序列最左边的 $x$ 个 `(` 和最右边的 $y$ 个 `)`，其中 $x + y \le k$。

## 形式化分析

设 $x$ 为删除的最左 `(` 数量，$y$ 为删除的最右 `)` 数量，满足 $0 \le x + y \le k$。对每一组 $(x, y)$，我们可以模拟删除后剩余序列的最长合法括号子序列长度：

1. 从左到右扫描 $s$，跳过前 $x$ 个 `(`（即不将它们加入剩余序列）；
2. 从右到左扫描，跳过（标记删除）后 $y$ 个 `)`；
3. 在保留下来的字符中，用经典的栈/贪心方法计算最长合法括号子序列长度：维护一个计数器 `open`，遇到 `(` 则 `open += 1`，遇到 `)` 且 `open > 0` 则 `match += 1, open -= 1`。

我们枚举所有合法的 $(x, y)$ 组合，取使得匹配数最小的那一组，即可得到 Alice 的最优代价。

## 复杂度分析

设 $L$ 为 `(` 的总数，$R$ 为 `)` 的总数。$x$ 的取值范围是 $0 \sim \min(k, L)$，对于每个 $x$，$y$ 取 $\min(k - x, R)$。因此枚举量是 $O(k)$。每次模拟计算匹配数的复杂度是 $O(n)$。总复杂度 $O(kn)$，在题目给定的数据范围内可以通过。

## 代码

```cpp
#include <bits/stdc++.h>
using namespace std;

const int INF = 0x3f3f3f3f;

int n, k;
string s;

// 删除最左 x 个 '(' 和最右 y 个 ')' 后，计算剩余序列的最长合法括号子序列长度
int calculate_match(int x, int y) {
    vector<char> kept;

    int left_deleted = 0;
    for (auto c : s) {
        if (c == '(' && left_deleted < x) {
            left_deleted += 1;
        } else {
            kept.emplace_back(c);
        }
    }

    int right_deleted = 0;
    for (int i = (int)kept.size() - 1; i >= 0 && right_deleted < y; --i) {
        if (kept[i] == ')') {
            kept[i] = '\0';       // 标记删除
            right_deleted += 1;
        }
    }

    int open = 0, match = 0;
    for (auto c : kept) {
        if (c == '\0') continue;

        if (c == '(') {
            open += 1;
        } else if (open > 0) {
            match += 1;
            open -= 1;
        }
    }
    return match;
}

// 构造具体的删除方案（1 表示删除，0 表示保留）
vector<int> generate_result(int x, int y) {
    vector<int> res(n, 0);

    int left_deleted = 0;
    for (int i = 0; i < n && left_deleted < x; ++i) {
        if (s[i] == '(') {
            res[i] = 1;
            left_deleted += 1;
        }
    }

    int right_deleted = 0;
    for (int i = n - 1; i >= 0 && right_deleted < y; --i) {
        if (s[i] == ')') {
            res[i] = 1;
            right_deleted += 1;
        }
    }

    return res;
}

void solve() {
    cin >> n >> k >> s;

    int total_left = 0, total_right = 0;
    for (char c : s) {
        if (c == '(') total_left++;
        else          total_right++;
    }

    int min_match = INF;
    int best_x = 0, best_y = 0;

    int max_x = min(k, total_left);
    for (int x = 0; x <= max_x; ++x) {
        int y = min(k - x, total_right);
        if (y < 0) continue;

        int match = calculate_match(x, y);
        if (match < min_match) {
            best_x = x;
            best_y = y;
            min_match = match;
        }
    }

    auto result = generate_result(best_x, best_y);
    for (auto x : result) cout << x;
    cout << "\n";
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int t;
    cin >> t;
    while (t--) {
        solve();
    }
    return 0;
}
```

## 小结

本题的关键在于认识到：为了最大化破坏配对的效果，Alice 应当优先删除两端的括号——最左边的 `(` 和最右边的 `)`。这个结论可以通过"被删除括号的可替代性"来论证：只有最左的左括号和最右的右括号是**不可替代**的，删除它们才能保证配对数量一定减少。在此基础上，枚举删除数量即可得到最优解。