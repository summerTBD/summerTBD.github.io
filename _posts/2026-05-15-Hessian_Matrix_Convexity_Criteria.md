---
layout: single
title: "多元函数凹凸性判断：海森矩阵判别法的完整推导"
date: 2026-05-15 15:07:00 +0800
author: summerTBD
categories: [数学, 优化理论]
tags: [凸优化, 海森矩阵, 凹凸性]
math: true
toc: true
toc_sticky: true
---

## 1. 从一元函数说起
对于一元函数 $f(x)$，凹凸性的二阶判别大家都很熟悉：
- $f''(x) \ge 0$  $\iff$  $f$ 是凸函数（曲线在切线上方）
- $f''(x) \le 0$  $\iff$  $f$ 是凹函数（曲线在切线下方）

背后的直觉：泰勒展开 $f(y) \approx f(x) + f'(x)(y-x) + \frac{1}{2}f''(x)(y-x)^2$，二次项的非负性保证了曲线不下垂。

**推广到多元函数**的思想是：沿任意方向截出一条一元函数，用一元的二阶导数判断，然后要求所有方向都满足，这个条件最终会转化为海森矩阵的半正定性。

---

## 2. 构造方向函数，把多元问题化为一元问题
设 $f(\mathbf{x}) : \mathbb{R}^n \to \mathbb{R}$，$\mathbf{x}$ 是 $n$ 维列向量：
$$
\mathbf{x} = \begin{pmatrix} x_1 \\ x_2 \\ \vdots \\ x_n \end{pmatrix}.
$$
任取一个非零方向向量 $\mathbf{v}$（也是列向量）：
$$
\mathbf{v} = \begin{pmatrix} v_1 \\ v_2 \\ \vdots \\ v_n \end{pmatrix}.
$$
沿 $\mathbf{v}$ 方向移动一小步 $t$，得到新点 $\mathbf{x} + t\mathbf{v}$，定义
$$
g(t) = f(\mathbf{x} + t\mathbf{v}).
$$
现在 $g(t)$ 是一个普通的一元函数。**如果原来的 $f$ 是凸函数，那么沿任意方向截出来的 $g(t)$ 也一定是凸函数**，因此对所有 $t$ 和 $\mathbf{v}$，都应有 $g''(t) \ge 0$（凸）或 $\le 0$（凹）。

---

## 3. 求一阶导数 $g'(t)$ —— 方向导数
用多元复合函数求导的链式法则：
$$
g(t) = f(x_1 + t v_1, x_2 + t v_2, \dots, x_n + t v_n).
$$
对 $t$ 求导：
$$
g'(t) = \frac{\partial f}{\partial x_1} \cdot \frac{\mathrm{d}(x_1+tv_1)}{\mathrm{d}t} + \frac{\partial f}{\partial x_2} \cdot \frac{\mathrm{d}(x_2+tv_2)}{\mathrm{d}t} + \cdots + \frac{\partial f}{\partial x_n} \cdot \frac{\mathrm{d}(x_n+tv_n)}{\mathrm{d}t}.
$$
因为 $\frac{\mathrm{d}(x_i+tv_i)}{\mathrm{d}t} = v_i$，所以
$$
g'(t) = \frac{\partial f}{\partial x_1} v_1 + \frac{\partial f}{\partial x_2} v_2 + \cdots + \frac{\partial f}{\partial x_n} v_n.
\tag{1}
$$
这个和式恰好就是**梯度向量**（列向量）与方向向量 $\mathbf{v}$ 的内积。

**定义梯度向量：**
$$
\nabla f = \begin{pmatrix} \frac{\partial f}{\partial x_1} \\ \frac{\partial f}{\partial x_2} \\ \vdots \\ \frac{\partial f}{\partial x_n} \end{pmatrix}.
$$
内积的矩阵写法要求**行向量 $\times$ 列向量**，因此将梯度转置：
$$
\nabla f^\mathsf{T} \mathbf{v} = \big( \frac{\partial f}{\partial x_1}, \frac{\partial f}{\partial x_2}, \dots, \frac{\partial f}{\partial x_n} \big) \begin{pmatrix} v_1 \\ v_2 \\ \vdots \\ v_n \end{pmatrix}
= \frac{\partial f}{\partial x_1}v_1 + \frac{\partial f}{\partial x_2}v_2 + \cdots + \frac{\partial f}{\partial x_n}v_n.
$$
对比 (1) 式，得到简洁形式：
$$
\boxed{g'(t) = \nabla f^\mathsf{T} \mathbf{v}}.
$$
这就是**方向导数**的矩阵表示，转置只是为了实现内积运算，没有"随便转置"。

---

## 4. 求二阶导数 $g''(t)$ —— 海森矩阵的登场
对 $g'(t)$ 再求一次导数。因为 $g'(t)$ 是由若干项 $\frac{\partial f}{\partial x_i}$ 组成的，而每个 $\frac{\partial f}{\partial x_i}$ 仍然是 $\mathbf{x} + t\mathbf{v}$ 的函数，所以需要再次使用链式法则：
$$
\frac{\mathrm{d}}{\mathrm{d}t}\left( \frac{\partial f}{\partial x_i} \right) = 
\frac{\partial}{\partial x_1}\left( \frac{\partial f}{\partial x_i} \right) v_1 +
\frac{\partial}{\partial x_2}\left( \frac{\partial f}{\partial x_i} \right) v_2 +
\cdots +
\frac{\partial}{\partial x_n}\left( \frac{\partial f}{\partial x_i} \right) v_n.
$$
它可以写成更紧凑的求和形式：
$$
\frac{\mathrm{d}}{\mathrm{d}t}\left( \frac{\partial f}{\partial x_i} \right) = \sum_{j=1}^n \frac{\partial^2 f}{\partial x_j \partial x_i} \, v_j.
\tag{2}
$$
这里的 $\frac{\partial^2 f}{\partial x_j \partial x_i}$ 表示先对 $x_j$ 求偏导，再对 $x_i$ 求偏导。

现在求 $g''(t)$：
$$
g''(t) = \frac{\mathrm{d}}{\mathrm{d}t} g'(t) = \frac{\mathrm{d}}{\mathrm{d}t} \sum_{i=1}^n \left( \frac{\partial f}{\partial x_i} v_i \right)
= \sum_{i=1}^n \left( \frac{\mathrm{d}}{\mathrm{d}t} \frac{\partial f}{\partial x_i} \right) v_i.
$$
将 (2) 式代入：
$$
g''(t) = \sum_{i=1}^n \left( \sum_{j=1}^n \frac{\partial^2 f}{\partial x_j \partial x_i} \, v_j \right) v_i
= \sum_{i=1}^n \sum_{j=1}^n \frac{\partial^2 f}{\partial x_j \partial x_i} \, v_j v_i.
\tag{3}
$$
这是一个双重求和。通常混合偏导数连续时相等：$\frac{\partial^2 f}{\partial x_i \partial x_j} = \frac{\partial^2 f}{\partial x_j \partial x_i}$，但这里我们先保留这种形式。

**定义海森矩阵 $\mathbf{H}$**：把所有二阶偏导数排成一个 $n \times n$ 的对称矩阵，其中第 $i$ 行第 $j$ 列的元素是 $\frac{\partial^2 f}{\partial x_i \partial x_j}$：
$$
\mathbf{H} =
\begin{pmatrix}
\frac{\partial^2 f}{\partial x_1^2} & \frac{\partial^2 f}{\partial x_1 \partial x_2} & \cdots & \frac{\partial^2 f}{\partial x_1 \partial x_n} \\
\frac{\partial^2 f}{\partial x_2 \partial x_1} & \frac{\partial^2 f}{\partial x_2^2} & \cdots & \frac{\partial^2 f}{\partial x_2 \partial x_n} \\
\vdots & \vdots & \ddots & \vdots \\
\frac{\partial^2 f}{\partial x_n \partial x_1} & \frac{\partial^2 f}{\partial x_n \partial x_2} & \cdots & \frac{\partial^2 f}{\partial x_n^2}
\end{pmatrix}.
$$
（在混合偏导相等的条件下，$\mathbf{H}$ 是实对称矩阵。）

现在关键一步：**把双重求和 (3) 式翻译成矩阵乘法**。按照矩阵乘法规则：
1. 先计算矩阵 $\mathbf{H}$ 乘以列向量 $\mathbf{v}$，得到一个列向量：
$$
\mathbf{H}\mathbf{v} = \begin{pmatrix}
\sum_{j=1}^n H_{1j} v_j \\
\sum_{j=1}^n H_{2j} v_j \\
\vdots \\
\sum_{j=1}^n H_{nj} v_j
\end{pmatrix}.
$$
2. 再用行向量 $\mathbf{v}^\mathsf{T}$ 左乘这个结果：
$$
\mathbf{v}^\mathsf{T} (\mathbf{H} \mathbf{v}) = (v_1, v_2, \dots, v_n) \begin{pmatrix}
\sum_{j} H_{1j} v_j \\
\sum_{j} H_{2j} v_j \\
\vdots \\
\sum_{j} H_{nj} v_j
\end{pmatrix} = \sum_{i=1}^n v_i \left( \sum_{j=1}^n H_{ij} v_j \right) = \sum_{i=1}^n \sum_{j=1}^n H_{ij} v_i v_j.
$$
因为矩阵乘法满足**结合律**，所以我们可以不加括号，直接写：
$$
\mathbf{v}^\mathsf{T} \mathbf{H} \mathbf{v}.
$$
无论你先算 $\mathbf{H}\mathbf{v}$ 再左乘 $\mathbf{v}^\mathsf{T}$，还是先算 $\mathbf{v}^\mathsf{T}\mathbf{H}$ 再右乘 $\mathbf{v}$，结果完全相同。这个表达式称为**二次型**，计算出来是一个标量。

对比 (3) 式，注意到如果我们在海森矩阵中取 $H_{ij} = \frac{\partial^2 f}{\partial x_i \partial x_j}$，则双重求和变为 $\sum_{i,j} H_{ij} v_i v_j$，这与 (3) 式中的 $\sum_{i,j} \frac{\partial^2 f}{\partial x_j \partial x_i} v_j v_i$ 仅指标记号不同，因为混合偏导对称且求和哑标可交换，两者完全等价。因此我们得到：
$$
\boxed{g''(t) = \mathbf{v}^\mathsf{T} \mathbf{H}(\mathbf{x}+t\mathbf{v}) \, \mathbf{v}}.
$$

---

## 5. 凹凸性与海森矩阵的半定性的等价关系
现在回到凹凸性的判断。如果 $f$ 是凸函数，那么对任意方向 $\mathbf{v}$，截出的一元函数 $g(t)$ 也必须是凸的。对于二阶可微的一元函数，凸等价于 $g''(t) \ge 0$。
特别地，在 $t=0$ 处考察原函数在 $\mathbf{x}$ 点的凹凸性质，我们有：
$$
g''(0) = \mathbf{v}^\mathsf{T} \mathbf{H}(\mathbf{x}) \mathbf{v} \ge 0, \quad \forall \mathbf{v} \in \mathbb{R}^n.
$$
这正是**海森矩阵 $\mathbf{H}(\mathbf{x})$ 半正定**的定义：对所有非零向量 $\mathbf{v}$，二次型均非负。

反过来，如果 $\mathbf{H}(\mathbf{x})$ 在定义域内每一点都半正定，则利用带拉格朗日余项的一阶泰勒展开可以证明函数满足凸性不等式，因此：
$$
\boxed{f \text{ 是凸函数} \quad \iff \quad \text{海森矩阵 } \mathbf{H}(\mathbf{x}) \text{ 在定义域内处处半正定}}
$$
同理：
- $f$ 是**凹函数** $\iff$ $\mathbf{H}(\mathbf{x})$ 处处**半负定**（二次型 $\le 0$）。
- 若 $\mathbf{H}(\mathbf{x})$ 处处**正定**（二次型 $>0$，$\mathbf{v} \neq 0$），则 $f$ 是**严格凸函数**（逆命题不一定成立，比如 $f(x)=x^4$ 在 $x=0$ 处二阶导为 0 但严格凸）。

---

## 6. 怎么判断矩阵的半正定性（半负定性）
实际计算时，只需要检验海森矩阵的定性，常用方法：

### 方法一：特征值法
计算 $\mathbf{H}$ 的所有特征值 $\lambda_1, \dots, \lambda_n$：
- 全部 $\lambda_i \ge 0$ $\Rightarrow$ 半正定（凸）
- 全部 $\lambda_i > 0$ $\Rightarrow$ 正定（严格凸）
- 全部 $\lambda_i \le 0$ $\Rightarrow$ 半负定（凹）

### 方法二：主子式法（低阶时常用）
- **正定**：所有顺序主子式 $>0$。  
  顺序主子式即矩阵左上角各阶子矩阵的行列式：  
  $\Delta_1 = H_{11}$, $\Delta_2 = \begin{vmatrix} H_{11} & H_{12} \\ H_{21} & H_{22} \end{vmatrix}$, $\Delta_3, \dots$
- **半正定**：需要**所有**主子式（不仅顺序）非负，但实际中常通过配方或特征值判断。
- 对于 $2\times2$ 矩阵，半正定的充要条件是：对角元 $\ge 0$，且行列式 $\ge 0$。  
  正定则要求对角元 $>0$ 且行列式 $>0$。

---

## 7. 完整应用步骤
1. 写出函数的梯度 $\nabla f$ 和海森矩阵 $\mathbf{H}(\mathbf{x})$（求所有二阶偏导）。
2. 确认定义域是凸集。
3. 判断 $\mathbf{H}(\mathbf{x})$ 在定义域内每一点的半正定性（或半负定性）。
4. 得出结论。

## 8. 实例：二元函数 $f(x,y) = x^2 + 3xy + 2y^2$
- 梯度：$\nabla f = \begin{pmatrix} 2x+3y \\ 3x+4y \end{pmatrix}$。
- 海森矩阵：  
  $\frac{\partial^2 f}{\partial x^2} = 2$, $\frac{\partial^2 f}{\partial x \partial y} = 3$, $\frac{\partial^2 f}{\partial y^2} = 4$，所以  
  $$
  \mathbf{H} = \begin{pmatrix} 2 & 3 \\ 3 & 4 \end{pmatrix}.
  $$
- 顺序主子式：$\Delta_1 = 2 > 0$，$\Delta_2 = \begin{vmatrix} 2&3\\3&4 \end{vmatrix} = 8-9 = -1 < 0$。  
  行列式为负，说明特征值一正一负，$\mathbf{H}$ 既不是半正定也不是半负定。因此这个函数**既不是凸函数也不是凹函数**（实际上它是鞍形）。

如果我们换成 $f(x,y) = x^2 + 2xy + 2y^2$，则海森矩阵 $\begin{pmatrix} 2 & 2 \\ 2 & 4 \end{pmatrix}$，顺序主子式 $2>0$，行列式 $4>0$，正定，故函数严格凸。

---

以上就是海森矩阵判别法的完整推导，从一元到多元，从链式法则到二次型，再到矩阵半定性的检验，中间没有任何跳步。所有看似"随意"的转置和结合律，其实都是为了让矩阵乘法的维度匹配并产出正确的标量。
