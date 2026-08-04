---
layout: single
title: "Feelings of Making an App"
date: 2026-08-04 00:00:00 +0800
author: summerTBD
categories: [数学，算法]
tags: [数学，算法]
toc: true
toc_sticky: true
---


### 题目链接 ###
https://codeforces.com/problemset/problem/2246/A

### 个人的一些看法 ###
这是一道A题，从A题的角度来看他似乎不够格，但做这道题时我发现它的思考角度是我很少考虑的，但却经常被使用的思路，那就是奇偶性，Codeforces Round 1108 (Div. 2)有很多题目都考察了奇偶性。

### 思路 ###
其实题目已经暗示了我们要考虑奇偶性，在题目中有一个even单词被加黑了，这是很明显的暗示。但这不是我们的目的，我们讨论真正的思路。我们不希望它的和有概率为1，那该怎么做，如果你在思考怎么避免成为1，那你很可能想错了，1是一个元素，他有很多种情况，你得考虑每一个元素的变化对整体的影响，那不妨以更高的角度思考这个问题，如果1是某个集合的元素，而这个集合被排除那也意味着1也会被排除，最简单的角度就是奇偶性，1是奇数，如果我可以保证它的和不为奇数，他就一定不能为1。那我可以考虑让他们的每一项都只能为偶数，又因为𝑆𝑖={−𝑖⋅𝑝𝑖,0,𝑖⋅𝑝𝑖}，我们可以让i为奇数时，让pi为偶数，当i为偶数时，pi为奇数。

### 代码 ###
```cpp


#include <bits/stdc++.h>
using namespace std;

using ll = long long;
using ull = unsigned long long;

namespace {
const int N = 1e6 + 1;
const int INF = 0x3f3f3f3f;
} // namespace

void solve() {
    int n;
    cin >> n;
    for (int i = 1; i <= n / 2; ++i) {
        cout << 2 * i << " " << 2 * i - 1 << ' ';
    }
    cout << '\n';
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int _ = 1;
    cin >> _;
    while (_--) {
        solve();
    }
    return 0;
}


```