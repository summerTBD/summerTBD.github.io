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

---

## 9. 附录：谱分解与共轭——从海森矩阵到近世代数的统一视角

在判断多元函数凹凸性时，我们遇到了**特征值法**和**谱分解**。  
很多同学第一次看到对称矩阵的谱分解公式 \(\mathbf{H} = \mathbf{Q} \mathbf{\Lambda} \mathbf{Q}^\mathsf{T}\) 时，会觉得它和近世代数里的 **共轭** \(g a g^{-1}\) 很像。  
这不是错觉——它们在数学结构上确实是同一件事，只不过穿了两套不同的语言外衣。下面从线性代数出发，一步步揭示这层联系。

### 9.1 特征值判别法与二次型
对于海森矩阵 \(\mathbf{H}\)（实对称），我们关心二次型  
\[
\mathbf{v}^\mathsf{T} \mathbf{H} \mathbf{v}
\]
的符号，以判断函数的凹凸性。  
通过求解 **特征方程**  
\[
\det(\mathbf{H} - \lambda \mathbf{I}) = 0
\]
得到特征值 \(\lambda_1, \lambda_2, \dots, \lambda_n\)，二次型可以写成  
\[
\mathbf{v}^\mathsf{T} \mathbf{H} \mathbf{v} = \sum_{i=1}^n \lambda_i y_i^2,
\]
其中 \(y_i\) 是 \(\mathbf{v}\) 在特征向量坐标系下的坐标。因此：
- 所有 \(\lambda_i \ge 0\) \(\Leftrightarrow\) 矩阵半正定（函数凸）
- 所有 \(\lambda_i \le 0\) \(\Leftrightarrow\) 矩阵半负定（函数凹）

### 9.2 谱分解的完整形式
对称矩阵 \(\mathbf{H}\) 可以 **正交对角化**：存在正交矩阵 \(\mathbf{Q}\)（满足 \(\mathbf{Q}^{-1} = \mathbf{Q}^\mathsf{T}\)）和对角矩阵 \(\mathbf{\Lambda} = \operatorname{diag}(\lambda_1, \dots, \lambda_n)\)，使得  
\[
\mathbf{H} = \mathbf{Q} \mathbf{\Lambda} \mathbf{Q}^\mathsf{T}. \tag{1}
\]
这就是 **谱分解**（spectral decomposition）。  
\(\mathbf{Q}\) 的列是 \(\mathbf{H}\) 的单位正交特征向量，\(\mathbf{\Lambda}\) 的对角元是对应的特征值。

### 9.3 转置怎么变逆的？
关键就藏在"正交矩阵"的定义里：  
\[
\mathbf{Q}^\mathsf{T} \mathbf{Q} = \mathbf{I} \quad \Rightarrow \quad \mathbf{Q}^\mathsf{T} = \mathbf{Q}^{-1}.
\]
正因为对称矩阵的特征向量可以选为正交归一，变换矩阵 \(\mathbf{Q}\) 的逆恰好等于它的转置。  
于是 (1) 式可以等价地写成 **逆** 的形式：
\[
\mathbf{H} = \mathbf{Q} \mathbf{\Lambda} \mathbf{Q}^{-1}. \tag{2}
\]
现在它看起来就再熟悉不过了——**前后各乘一个矩阵和它的逆**。

### 9.4 这就是矩阵代数里的"共轭"
在线性代数中，对任意方阵 \(\mathbf{A}\)，变换  
\[
\mathbf{A} \longmapsto \mathbf{P} \mathbf{A} \mathbf{P}^{-1}
\]
称为 **相似变换**。  
如果把全体可逆矩阵看成一个群（一般线性群 \(GL_n\)），这个操作正是 **群作用下的共轭**：  
\[
\text{群共轭：} \quad g a g^{-1} \qquad \longleftrightarrow \qquad \text{矩阵相似：} \quad \mathbf{P} \mathbf{A} \mathbf{P}^{-1}.
\]
谱分解 (2) 式就是 **用一个正交矩阵 \(\mathbf{Q}\) 将 \(\mathbf{\Lambda}\) 共轭成了 \(\mathbf{H}\)**。

因为 \(\mathbf{Q}\) 恰好是正交的，它的逆又可以写成转置，所以教材上常用 \(\mathbf{Q}^\mathsf{T}\) 这种"计算友好"的形式，反而掩盖了它作为共轭的本质。

### 9.5 与近世代数的直接类比
| 近世代数（群） | 线性代数（矩阵） |
|:---:|:---:|
| 群 \(G\) | 全体可逆矩阵 \(GL_n\) |
| 元素 \(a\) | 对角矩阵 \(\mathbf{\Lambda}\) |
| 共轭元 \(g a g^{-1}\) | 相似矩阵 \(\mathbf{Q} \mathbf{\Lambda} \mathbf{Q}^{-1}\) |
| 共轭类 \([a]\) | 所有相似矩阵的集合 |
| 不变量：阶、迹 | 不变量：特征值、迹、秩 |

特征值就是矩阵共轭类里的 **代数不变量**。  
谱分解告诉我们：每一个实对称矩阵，都在它的共轭类里找到了一个最简代表——对角矩阵 \(\mathbf{\Lambda}\)。

### 9.6 几何解释：坐标旋转
共轭 \(g a g^{-1}\) 的直观含义是"换个角度看同一个东西"。谱分解正好在做这件事：
1. 从原坐标系看，二次型 \(f(\mathbf{v}) = \mathbf{v}^\mathsf{T} \mathbf{H} \mathbf{v}\) 的图像可能歪斜（有交叉项）。
2. 用 \(\mathbf{Q}^{-1}\)（即 \(\mathbf{Q}^\mathsf{T}\)）旋转坐标轴，把坐标轴对准图像的主轴。
3. 在新坐标系下，图像变得方方正正，完全由对角矩阵 \(\mathbf{\Lambda}\) 描述（只有平方项）。
4. 用 \(\mathbf{Q}\) 转回原坐标，就恢复了原来的矩阵 \(\mathbf{H}\)。

整个过程就是 \(\mathbf{Q} \mathbf{\Lambda} \mathbf{Q}^{-1}\)，一个标准的共轭作用——**把简单的东西"旋转"成原来的样子**。

### 9.7 总结：你看到的"共轭式"完全正确
- 谱分解 \(\mathbf{H} = \mathbf{Q} \mathbf{\Lambda} \mathbf{Q}^\mathsf{T}\) **本质上就是矩阵共轭** \(\mathbf{Q} \mathbf{\Lambda} \mathbf{Q}^{-1}\)，只不过正交矩阵使得逆可以写成转置。
- 它和群论中的 \(gag^{-1}\) 在代数结构上毫无二致，都是通过"包裹"一个元来改变坐标系，但不改变内在属性。
- 特征值就是这个共轭作用下的 **不变量**，所以通过判断特征值的正负，就能确定整个矩阵（从而函数）的凹凸性。

这种联系正是你之前想寻找的 **"代数逻辑重构"** 的一个生动例子：  
**对角化 = 共轭找最简形，特征值 = 共轭类的不变量，谱分解 = 矩阵版的坐标变换。**  
当你看到这些不同领域的术语其实是同一套思想的方言时，结构性的统一美感就自然浮现了。
