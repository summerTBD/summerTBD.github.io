---
layout: post
title: "Understanding of Sweep Line Algorithm"
date: 2026-05-11 00:00:00 +0800
author: summerTBD
categories: [算法]
tags: [算法, 扫描线, C++]
math: true
---

> 本文同时提供中文版和 English Version。

---

## 🇨🇳 中文版

### 题目来源

# 区间相交最大数
### 题目描述
小红有 $n$ 个闭区间，第 $i$ 个区间为 $[l_i, r_i]$。

她现在想另外选择一个闭区间 $[L, L+k]$，其中 $L$ 可以是任意整数。如果两个区间的交集非空，那么称它们相交。

特别地，如果两个区间只有端点重合，我们也认为它们的交集非空。例如 $[1,3]$ 和 $[3,5]$ 相交。

注意，小红选的区间不要求等于给定的 $n$ 个区间中的某一个，它只需要长度恰好为 $k$ 即可。

请你求出，最多有多少个给定区间能够与她选择的区间 $[L, L+k]$ 相交。

---

### 输入描述
第一行输入两个整数 $n, k$（$1 \le n \le 2 \times 10^5$，$0 \le k \le 10^9$）。

接下来 $n$ 行，每行输入两个整数 $l_i, r_i$（$0 \le l_i \le r_i \le 10^9$），表示一个闭区间。

---

### 输出描述
输出一个整数，表示最多能与长度为 $k$ 的闭区间相交的给定区间数量。

---

### 我的第一个思路（错误的）

看到这道题，我一开始想通过枚举长度为 $k$ 的区间的起点来求解。但这里我搞混了——我把题目的意思理解成了"每个给定区间的长度都是 k"，所以忽略了每个区间的结束位置（右端点）。

于是我决定用二分查找，对每个点搜索其左右最近的区间边界，然后用 `|point1 - point2|` 来计算经过的区间数量。这个思路显然是错的。

---

### 最终思路（扫描线算法）

后来 DeepSeek 帮我检查代码，我才学到了真正的做法——**扫描线算法（Sweep Line Algorithm）**。

#### 核心思想

我们要找一个长度为 k 的区间 $[L, L+k]$ 与最多给定区间相交。对于每个给定区间 $[l_i, r_i]$，它和 $[L, L+k]$ 相交的条件是：

$$l_i \le L+k \quad \text{且} \quad L \le r_i$$

即：$$L \in [l_i - k,\ r_i]$$

所以对于每个区间 $[l_i, r_i]$：
- 当 $L = l_i - k$ 时，开始与这个区间相交 → 事件 `(l_i - k, +1)`
- 当 $L = r_i + 1$ 时，不再与这个区间相交 → 事件 `(r_i + 1, -1)`

#### 代码实现

```cpp
vector<pair<int, int>> events;
for (int i = 0; i < n; ++i) {
    int l, r;
    cin >> l >> r;
    events.emplace_back(l - k, 1);   // 进入
    events.emplace_back(r + 1, -1);  // 离开
}
```

然后排序并遍历：

```cpp
sort(events.begin(), events.end(), [](const auto &a, const auto &b) {
    if (a.first != b.first)
        return a.first < b.first;
    return a.second < b.second;  // -1 先于 +1
});

int ans = 0, cur = 0;
for (auto &[x, delta] : events) {
    cur += delta;
    ans = max(ans, cur);
}
```

#### ⚠️ 关键细节：为什么 -1 要先于 +1？

当同一个坐标上同时出现进入事件 (+1) 和离开事件 (-1) 时，**必须先处理 -1，再处理 +1**。

**为什么？**

用样例数据说明：
```
5 2
1 3
2 4
5 7
6 8
9 9
```

事件列表：
| 坐标 | 事件 | 说明 |
|:---:|:---:|:---:|
| -1 | +1 | 区间 [1,3] 开始 |
| 0 | +1 | 区间 [2,4] 开始 |
| 3 | +1 | 区间 [5,7] 开始 |
| **4** | **-1** | 区间 [1,3] 结束 |
| **4** | **+1** | 区间 [6,8] 开始 |
| 5 | -1 | 区间 [2,4] 结束 |
| 7 | +1 | 区间 [9,9] 开始 |
| 8 | -1 | 区间 [5,7] 结束 |
| 9 | -1 | 区间 [6,8] 结束 |
| 10 | -1 | 区间 [9,9] 结束 |

注意坐标 **4** 同时有 -1 和 +1。

**如果先 -1 再 +1（正确）：**
```
cur=3 → 2 → 3，max=3 ✅
```
当 L=4 时，选择区间 [4,6]，与 [2,4]、[5,7]、[6,8] 相交，共 **3 个**。

**如果先 +1 再 -1（错误）：**
```
cur=3 → 4 → 3，max=4 ❌
```
这会导致错误的 **4**。因为当 L=4 时，实际不可能同时与 4 个区间相交——区间 [1,3] 在 L=4 时已经离开了。

**直观理解：** 在同一个临界点上，**旧的区间先离开，新的区间再进来**。如果先让新区间进来再让旧区间离开，就会虚增一个计数，导致最大值偏大。

---

## 🇬🇧 English Version

### The Problem

We have $n$ intervals $[l_i, r_i]$. We choose an interval $[L, L+k]$ (length = k). We want the maximum number of given intervals that intersect with it.

Two intervals intersect if they share at least one point. Endpoints count. Example: $[1,3]$ and $[3,5]$ intersect.

---

### My First Idea (Wrong)

I misunderstood the problem. I thought every interval has length k, so I only looked at starting points. I used binary search, but it was wrong.

---

### The Correct Solution (Sweep Line)

The condition for an interval $[l, r]$ to intersect with $[L, L+k]$ is:

$$L \in [l - k,\ r]$$

So for each interval:
- At $l - k$: starts overlapping → event $(l - k, +1)$
- At $r + 1$: stops overlapping → event $(r + 1, -1)$

Sort all events by coordinate, then scan:

```cpp
sort(events.begin(), events.end(), [](const auto &a, const auto &b) {
    if (a.first != b.first) return a.first < b.first;
    return a.second < b.second; // -1 before +1
});
```

---

### ⚠️ Important: Why -1 comes before +1

At the same coordinate, if both -1 and +1 happen, **process -1 first, then +1**.

Why? Because:
- At that point, an old interval stops overlapping (should be removed first)
- And a new interval starts overlapping (should be added after)

If we do +1 first, the count temporarily goes up by one extra, making `max` too large.

**Wrong order (sort +1 before -1):**
```
At x=4: cur=3 → +1 → 4 → -1 → 3, max=4 ❌
```

**Correct order (sort -1 before +1):**
```
At x=4: cur=3 → -1 → 2 → +1 → 3, max=3 ✅
```

This bug happened to me! When I used `a.second > b.second` in my sort, I got answer 4 instead of 3 on the sample test.

---

### Key Takeaway

Sweep Line Algorithm is powerful for interval problems. But **order matters** at the same coordinate. In this problem: **exit (-1) before entry (+1)**. Otherwise, the maximum count will be too large.
