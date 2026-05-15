#!/bin/bash
# ============================================================
#  fix-math-delimiters.sh
#  预处理 Markdown 文件中的 LaTeX 数学公式定界符，
#  将 \(...\) 替换为 $...$，将 \[...\] 替换为 $$...$$，
#  避免 Kramdown 将反斜杠当作转义处理导致 MathJax 无法渲染。
#
#  用法: ./scripts/fix-math-delimiters.sh [目录...]
#  默认扫描 _posts 和 _pages 目录下的所有 .md 文件
# ============================================================

set -euo pipefail

# 默认扫描目录
DIRS=("$@")
if [ ${#DIRS[@]} -eq 0 ]; then
    DIRS=("_posts" "_pages")
fi

echo "=== 开始预处理 LaTeX 定界符 ==="

# 统计信息
TOTAL_FILES=0
MODIFIED_FILES=0

for dir in "${DIRS[@]}"; do
    if [ ! -d "$dir" ]; then
        echo "  跳过不存在的目录: $dir"
        continue
    fi

    while IFS= read -r -d '' file; do
        TOTAL_FILES=$((TOTAL_FILES + 1))

        # 用 sed 进行替换：
        # 1. 将 \(...\) 替换为 $...$    (inline math)
        #    注意: 需要处理多行的情况，但 LaTeX 行内公式通常不跨行
        #    这里用 sed 的连续匹配处理
        # 2. 将 \[...\] 替换为 $$...$$  (display math)

        # 先处理 display math \[...\] -> $$...$$
        # - 匹配 \[ 和 \] 出现在单独行的情况（最常见）
        # - 也匹配行内的 \[...\]
        sed -i \
            -e 's/\\\[/$$/g' \
            -e 's/\\\]/$$/g' \
            -e 's/\\\(/$/g' \
            -e 's/\\\)/$/g' \
            "$file"

        echo "    已处理: $file"
        MODIFIED_FILES=$((MODIFIED_FILES + 1))
    done < <(find "$dir" -type f -name "*.md" -print0)
done

echo ""
echo "=== 完成! ==="
echo "  扫描文件数: $TOTAL_FILES"
echo "  处理文件数: $MODIFIED_FILES"
