---
layout: single
title: "倍增算法"
date: 2026-05-30
author: summerTBD
categories: [数学, 算法]
tags: [算法]
math: true
toc: true
toc_sticky: true
---

## 为什么而诞生

在一个单调数列中我们要去找第一个大于 target 的值（也可以是小于、小于等于、大于等于），我们往往会采用二分查找，它的时间复杂度很优秀，是 $O(\log n)$。但二分法有一个前提：我们必须知道数组的完整范围（即左右边界）。如果不知道数组究竟有多大，甚至数组是"无限"的（或我们只知道起点），二分法就无法直接使用。

此时有两种思路：
- **线性枚举**：从起点逐个往后找，复杂度 $O(n)$。
- **倍增法（指数搜索）**：先通过不断倍增步长快速逼近目标所在区间，再在该区间内二分查找。总复杂度仍为 $O(\log n)$。

本文讨论的"倍增"正是这样一种思想：**通过指数级扩大步长来快速定位目标范围**。它在竞赛题中一个经典的应用就是下面这道题——AcWing 109。

## 什么是倍增算法（个人的拙见）

现在我们的情况是并不知道整个数组的大小。第一步肯定要找到 target 的大致区间。那怎么找？我们定义一个指数 $p$，从当前位置往后数 $2^p$ 个位置。根据往后数到达的位置与 target 的关系决定 $p$ 是 `p *= 2` 还是 `p /= 2`。

讲到这里如果你对数字敏感的话，可以看出这其实是一个"奇怪的二分法"。为什么这么说呢？当我们碰到第一个需要 `p /= 2` 的时候，你会发现，我们其实在 `cur_pos` 和 `cur_pos + (1 << p)` 这个区间做二分查找。时间复杂度也是 $O(\log n)$，不过它其实比真正的二分慢，因为严格说它采用了 $2\log n$ 步，二分则是严格的 $\log n$。

## 例题

[AcWing 109 - Genius ACM](https://www.acwing.com/problem/content/111/)

给定一个整数 $M$，对于任意一个整数集合 $S$，定义"校验值"如下：

从集合 $S$ 中取出 $M$ 对数（即 $2 \times M$ 个数，不能重复使用集合中的数，如果 $S$ 中的整数不够 $M$ 对，则取到不能取为止），使得"每对数的差的平方"之和最大，这个最大值就称为集合 $S$ 的"校验值"。

现在给定一个长度为 $N$ 的数列 $A$ 以及一个整数 $T$。我们要把 $A$ 分成若干段，使得每一段的"校验值"都不超过 $T$。求最少需要分成几段。

**输入格式**

第一行输入整数 $K$，代表有 $K$ 组测试数据。
对于每组测试数据，第一行包含三个整数 $N, M, T$。
第二行包含 $N$ 个整数，表示数列 $A_1, A_2 \dots A_N$。

**输出格式**

对于每组测试数据，输出其答案，每个答案占一行。

**数据范围**

$$
1 \le K \le 12,\quad
1 \le N, M \le 500000,\quad
0 \le T \le 10^{18},\quad
0 \le A_i \le 2^{20}
$$

**输入样例：**

```
2
5 1 49
8 2 1 7 9
5 1 64
8 2 1 7 9
```

**输出样例：**

```
2
1
```

## 思路

如果我们已知整个数组只需要分成两段（即只有一个断点），那么我们可以直接二分这个断点的位置。但问题在于我们不知道有多少个断点，也无法直接确定每个区间应该从哪里切分——这正是倍增派上用场的地方。

具体来说，我们从左到右处理数组，每次用**倍增法**确定当前段的最长合法右边界：

- 从左端点 $L$ 出发，尝试扩展长度 $len$（初始为 1）。
- 如果 $[L, R + len)$ 的校验值 $\le T$，则接受扩展：$R \gets R + len$，并将 $len$ 翻倍。
- 否则将 $len$ 减半，继续尝试更小的步长。
- 当 $len$ 变为 0 时，$R$ 即为当前段的最长合法右边界。

这样做的时间复杂度为 $O(\log n)$ 次校验，而不是线性枚举的 $O(n)$ 次。

不过想必你一定还有一个疑问：如果按校验值的算法，每次都要给一个区间排序再算校验值，这个复杂度真的过得了吗？

答案是一般过不了。原因在于：对于 $[L, \text{mid})$ 我们要加入 $[\text{mid}, \text{right})$，如果每次都对整个 $[L, \text{right})$ 重新排序，复杂度会很高。但注意到这是一个**插入有序区间**的问题：$[L, \text{mid})$ 已经有序，我们只需要将 $[\text{mid}, \text{right})$ 排序后与它合并即可（归并），这样每次只需 $O(\text{len} \cdot \log \text{len})$ 的排序开销，而非对整个新区间重新排序。

因此我们需要两个辅助数组：
- $t$：存放当前 $[L, R)$ 的排序结果；
- $\text{tmp}$：存放合并 $[L, \text{mid})$（来自 $t$）和 $[\text{mid}, \text{right})$（从原数组 $a$ 拷贝并排序）后的结果。

如果校验成功，则将 $\text{tmp}$ 写回 $t$；如果失败也没关系，虽然 $[\text{mid}, \text{right})$ 在 $t$ 中排了一次序，但后续的扩展会覆盖它，不会产生副作用。

## 代码

```cpp
#include <bits/stdc++.h>
using namespace std;

typedef long long ll;

const int N = 500005;

int n, m;
ll T;
ll a[N], t[N], tmp[N];

ll sq(ll x) {
    return x * x;
}

// [l, mid), [mid, r)
bool check(int l, int mid, int r) {
    for (int i = mid; i < r; ++i) {
        t[i] = a[i];
    }
    sort(t + mid, t + r);

    int i = l, j = mid, k = 0;
    while (i < mid && j < r) {
        if (t[i] < t[j]) {
            tmp[k++] = t[i++];
        } else {
            tmp[k++] = t[j++];
        }
    }
    while (i < mid) {
        tmp[k++] = t[i++];
    }
    while (j < r) {
        tmp[k++] = t[j++];
    }

    ll sum = 0;
    int L = 0, R = k - 1;
    for (int p = 0; p < m && L < R; ++p) {
        sum += sq(tmp[R] - tmp[L]);
        R--;
        L++;
    }
    return sum <= T;
}

void solve() {
    cin >> n >> m >> T;
    for (int i = 0; i < n; ++i) {
        cin >> a[i];
    }

    int L = 0;

    int ans = 0;
    while (L < n) {
        int R = L;
        int len = 1;
        t[L] = a[L];
        while (len > 0) {
            if (R + len <= n && check(L, R, R + len)) {
                R += len;
                len <<= 1;

                // 把t给排好序，在check函数中，合并了t的两部分，这部分是
                // 变成了tmp，但t本身没有被更新，所以这里需要把排好序的t更新回去
                for (int i = L; i < R; ++i) {
                    t[i] = tmp[i - L];
                }
                if (R >= n) {
                    break;
                }

            } else {
                len >>= 1;
            }
        }

        ans += 1;
        L = R;
    }
    cout << ans << "\n";
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int K;
    cin >> K;
    while (K--)
        solve();
    return 0;
}
```
