---
layout: single
title: "Symmetric Convex/Concave Functions: A Property of Their Extremizers"
date: 2026-05-14
author: summerTBD
categories: [Mathematics]
tags: [convexity, symmetry, convex optimization, convex analysis]
math: true
toc: true
toc_sticky: true
---

## Abstract

This note discusses a fundamental property of symmetric convex (concave) functions: if a symmetric convex function attains a minimum, then there exists a minimizer lying on the diagonal; the analogous statement holds for symmetric concave functions. We present a rigorous treatment for the 2-dimensional case, an $n$-dimensional generalization, important corollaries, and remarks.

The core idea of the proof is: symmetry generates a set of symmetric extremizers, and convexity (via Jensen's inequality) implies that their arithmetic mean — which necessarily lies on the diagonal — is also an extremizer. Differentiability is not required.

---

## 2-Dimensional Case

### Theorem 1 (Minimum)

Let $F: \mathbb{R}^2 \to \mathbb{R}$ satisfy:

1. **Symmetry**: $F(x, y) = F(y, x)$ for all $x, y \in \mathbb{R}$;
2. **Convexity**: $F$ is convex;
3. **Existence of an extremum**: $F$ has a local minimum on $\mathbb{R}^2$ (for a convex function, any local minimum is global).

Then there exists $t \in \mathbb{R}$ such that $(t, t)$ is also a (global) minimizer of $F$.

#### Proof

Let $(a, b)$ be a global minimizer of $F$, and denote $m = F(a, b) = \min_{(x,y) \in \mathbb{R}^2} F(x, y)$.

**Step 1: Symmetry yields another minimizer.**  
By symmetry, $F(b, a) = F(a, b) = m$, so $(b, a)$ is also a global minimizer.

**Step 2: Convexity controls the value at the midpoint.**  
Since $F$ is convex, Jensen's inequality states that for any $\mathbf{u}, \mathbf{v} \in \mathbb{R}^2$ and $\lambda \in [0, 1]$,

$$
F(\lambda \mathbf{u} + (1 - \lambda) \mathbf{v}) \le \lambda F(\mathbf{u}) + (1 - \lambda) F(\mathbf{v}).
$$

Take $\mathbf{u} = (a, b)$, $\mathbf{v} = (b, a)$, $\lambda = \frac{1}{2}$. The midpoint

$$
\frac{1}{2}(a, b) + \frac{1}{2}(b, a) = \left( \frac{a + b}{2},\; \frac{a + b}{2} \right)
$$

lies on the line $y = x$. Substituting into the inequality gives

$$
F\!\left( \frac{a + b}{2},\; \frac{a + b}{2} \right) \le \frac{1}{2} F(a, b) + \frac{1}{2} F(b, a).
$$

**Step 3: The minimum forces equality.**  
Since $F(a, b) = F(b, a) = m$, the right-hand side is $\frac{1}{2} m + \frac{1}{2} m = m$, hence

$$
F\!\left( \frac{a + b}{2},\; \frac{a + b}{2} \right) \le m.
$$

But $m$ is the global minimum, so no point can have value less than $m$. Therefore

$$
F\!\left( \frac{a + b}{2},\; \frac{a + b}{2} \right) = m.
$$

**Step 4: Conclusion.**  
The point $\displaystyle \left( \frac{a + b}{2},\; \frac{a + b}{2} \right)$ lies on the diagonal and attains the value $m$; setting $t = \dfrac{a + b}{2}$ completes the proof. $\square$

### Theorem 1' (Maximum)

If "convex" is replaced by "concave" and "minimum" by "maximum" in Theorem 1, the conclusion still holds: there exists $t \in \mathbb{R}$ such that $(t, t)$ is a (global) maximizer of $F$.

#### Proof

Let $(a, b)$ be a global maximizer of the concave function $F$, with maximum value $M = F(a, b)$. By symmetry, $(b, a)$ is also a maximizer.

For a concave function, Jensen's inequality reverses:

$$
F(\lambda \mathbf{u} + (1 - \lambda) \mathbf{v}) \ge \lambda F(\mathbf{u}) + (1 - \lambda) F(\mathbf{v}).
$$

Taking $\mathbf{u} = (a, b)$, $\mathbf{v} = (b, a)$, $\lambda = \frac{1}{2}$ yields

$$
F\!\left( \frac{a + b}{2},\; \frac{a + b}{2} \right) \ge \frac{1}{2} M + \frac{1}{2} M = M.
$$

Since $M$ is the global maximum, equality must hold, and the midpoint is also a maximizer. $\square$

---

## $n$-Dimensional Generalization

Let $F: \mathbb{R}^n \to \mathbb{R}$, and denote $x = (x_1, x_2, \dots, x_n)$.

$F$ is called **symmetric** if for every permutation $\sigma \in S_n$ (the symmetric group of degree $n$),

$$
F(x_1, x_2, \dots, x_n) = F(x_{\sigma(1)}, x_{\sigma(2)}, \dots, x_{\sigma(n)}).
$$

### Theorem 2 (Minimum)

Let $F: \mathbb{R}^n \to \mathbb{R}$ satisfy:

1. **Symmetry**: as defined above;
2. **Convexity**: $F$ is convex;
3. **Existence of an extremum**: $F$ has a local minimum on $\mathbb{R}^n$.

Then there exists $t \in \mathbb{R}$ such that $(t, t, \dots, t) \in \mathbb{R}^n$ is also a (global) minimizer of $F$.

#### Proof Sketch

Let $\mathbf{x}^\ast = (x_1^\ast, x_2^\ast, \dots, x_n^\ast)$ be a global minimizer of $F$ with value $m$. Consider all points obtained by permuting the coordinates:

$$
\mathbf{x}_\sigma = (x_{\sigma(1)}^\ast, x_{\sigma(2)}^\ast, \dots, x_{\sigma(n)}^\ast), \quad \sigma \in S_n.
$$

By symmetry, each $\mathbf{x}_\sigma$ is a minimizer with value $m$. The set of minimizers of a convex function is convex, so their arithmetic mean

$$
\frac{1}{n!} \sum_{\sigma \in S_n} \mathbf{x}_\sigma
$$

is also a minimizer. It is easy to verify that all coordinates of this mean are equal to the arithmetic mean of the original coordinates:

$$
\left( \frac{1}{n} \sum_{i=1}^n x_i^\ast,\; \frac{1}{n} \sum_{i=1}^n x_i^\ast,\; \dots,\; \frac{1}{n} \sum_{i=1}^n x_i^\ast \right).
$$

Thus $t = \frac{1}{n} \sum_{i=1}^n x_i^\ast$ gives a diagonal minimizer $(t, t, \dots, t)$. $\square$

### Theorem 2' (Maximum)

If "convex" is replaced by "concave" and "minimum" by "maximum" in Theorem 2, the conclusion holds analogously.

---

## Important Corollaries

### Corollary 1 (Uniqueness)

If a symmetric convex function $F$ has a unique minimizer, then that point must lie on the diagonal $(t, t, \dots, t)$. Similarly, if a symmetric concave function has a unique maximizer, it must also lie on the diagonal.

### Corollary 2 (Strictly Convex/Concave Case)

If $F$ is a strictly convex symmetric function and has a minimizer, then the minimizer is unique and lies on the diagonal. The analogous statement holds for strictly concave symmetric functions.

### Corollary 3 (Constrained Optimization)

Let $C \subseteq \mathbb{R}^n$ be a symmetric convex set (i.e., if $x \in C$, then $\sigma(x) \in C$ for every permutation $\sigma \in S_n$), and let $F: C \to \mathbb{R}$ be a symmetric convex function. If $F$ attains a minimum on $C$, then there exists $t \in \mathbb{R}$ such that $(t, t, \dots, t) \in C$ and this point is a minimizer of $F$ on $C$.

---

## Worked Example

### Problem

Find the minimum of

$$
f(x, y, z) = x^2 + y^2 + z^2 + xy + yz + zx - 2(x + y + z)
$$

over $\mathbb{R}^3$.

### Solution Using the Theorem

#### 1. Verify the hypotheses of the theorem

- **Symmetry**: Swapping any two variables leaves the expression unchanged, so $f$ is symmetric.
- **Convexity**: $f$ is a quadratic form plus a linear term. Its Hessian matrix is

  $$
  H = \begin{bmatrix}
  2 & 1 & 1 \\
  1 & 2 & 1 \\
  1 & 1 & 2
  \end{bmatrix}.
  $$

  Compute the leading principal minors:
  $$
  \Delta_1 = 2 > 0,\quad
  \Delta_2 = \begin{vmatrix} 2 & 1 \\ 1 & 2 \end{vmatrix} = 3 > 0,\quad
  \Delta_3 = \det(H) = 4 > 0,
  $$
  so $H$ is positive definite and $f$ is strictly convex.
- **Existence of a minimum**: Since the quadratic form is positive definite, $\|(x, y, z)\| \to \infty$ implies $f \to +\infty$. By continuity, $f$ attains a global minimum.

By the **Diagonal Minimizer Theorem for Symmetric Convex Functions** (Theorem 2), there exists a minimizer on the diagonal $x = y = z$.

#### 2. Reduce to a one-dimensional problem

Set $x = y = z = t$:

$$
f(t, t, t) = 3t^2 + 3t^2 - 6t = 6t^2 - 6t = 6\left(t - \frac12\right)^2 - \frac32.
$$

The minimum is $-\dfrac32$, attained at $t = \dfrac12$.

Hence the global minimum is $-\dfrac32$, achieved at $\left(\dfrac12, \dfrac12, \dfrac12\right)$.

#### 3. Verification

Directly compute the partial derivative:

$$
\frac{\partial f}{\partial x} = 2x + y + z - 2 = 0,
$$

and by symmetry the other two equations are identical, giving $x = y = z = \dfrac12$, confirming the result.

### Summary

Without the theorem, one would need to solve a $3 \times 3$ linear system. Using the theorem, we only need to verify symmetry and convexity, then reduce the problem to minimizing a single-variable quadratic function — a significant simplification.

---

## Remarks

### Differentiability Is Not Required

The theorem does not require $F$ to be differentiable. Only convexity (or concavity) and the existence of an extremum are needed. The proof relies solely on Jensen's inequality and the definition of an extremum — no gradients, Hessians, or other analytic tools are necessary.

### Necessity of Convexity

Without convexity (or concavity), the conclusion generally fails. Two counterexamples are given below.

**Counterexample 1:**

$$
F(x, y) = -[(x - y)^2 - 1]^2 - [e^{x+y} - (x - y)^2]^2
$$

is a differentiable symmetric function with two strict local maxima at $(0.5, -0.5)$ and $(-0.5, 0.5)$, yet has no critical point on the diagonal $y = x$.

**Counterexample 2:**

$$
F(x, y) = \bigl((x-1)^2 + (y+1)^2\bigr) \bigl((x+1)^2 + (y-1)^2\bigr)
$$

is also differentiable and symmetric, with minimizers at $(1, -1)$ and $(-1, 1)$, but has no extremum (not even a stationary point) on the diagonal $y = x$.

### Common Misconception

The theorem only guarantees the **existence** of an extremizer on the diagonal. It does **not** assert that all extremizers lie on the diagonal.

### Related Literature

The result presented here does not typically appear as a named theorem in standard textbooks, but related ideas can be found in the following areas:

1. **Majorization Theory and Schur-Convex Functions**: Symmetric convex functions are closely related to Schur-convex functions. A classical result states that if $F$ is a symmetric convex function, then $F$ is Schur-convex, and its minimum is attained at a point with equal components (i.e., on the diagonal). See Marshall, Olkin & Arnold (2011) *Inequalities: Theory of Majorization and Its Applications*.

2. **Convex Optimization Under Group Action**: More generally, if a convex function $F$ is invariant under the action of a group $G$ and the feasible set is also $G$-invariant, then the set of minimizers is $G$-invariant. By convexity, the $G$-orbit average yields a $G$-invariant minimizer. The symmetric group considered in this note is a special case of this framework.

---

> This theorem elegantly combines the **"dimension reduction"** effect of symmetry with the **"convexity of the solution set"** from convexity — a concise yet powerful tool in optimization, game theory, and the calculus of variations.
