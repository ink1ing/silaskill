#!/bin/bash
# PDF to EPUB 转换脚本
# 使用方法: ./convert.sh input.pdf [output.epub]

set -e

# 检查参数
if [ $# -lt 1 ]; then
    echo "使用方法: $0 input.pdf [output.epub]"
    echo "示例: $0 example.pdf"
    echo "      $0 example.pdf output.epub"
    exit 1
fi

INPUT_FILE="$1"
OUTPUT_FILE="${2:-${INPUT_FILE%.pdf}.epub}"

# 检查输入文件是否存在
if [ ! -f "$INPUT_FILE" ]; then
    echo "错误: 文件 '$INPUT_FILE' 不存在"
    exit 1
fi

# 检查Calibre是否安装
EBOOK_CONVERT="/Applications/calibre.app/Contents/MacOS/ebook-convert"
if [ ! -f "$EBOOK_CONVERT" ]; then
    echo "错误: 未找到Calibre，请先安装:"
    echo "brew install --cask calibre"
    exit 1
fi

# 提取文件名作为标题（去掉扩展名）
TITLE=$(basename "$INPUT_FILE" .pdf)

echo "================================"
echo "PDF to EPUB 转换工具"
echo "================================"
echo "输入文件: $INPUT_FILE"
echo "输出文件: $OUTPUT_FILE"
echo "书名: $TITLE"
echo "================================"
echo ""
echo "开始转换..."

# 执行转换
"$EBOOK_CONVERT" "$INPUT_FILE" "$OUTPUT_FILE" \
  --title "$TITLE" \
  --language zh \
  --enable-heuristics \
  --margin-top 72 \
  --margin-bottom 72 \
  --margin-left 72 \
  --margin-right 72 \
  --base-font-size 16 \
  --unsmarten-punctuation

echo ""
echo "================================"
echo "转换完成！"
echo "输出文件: $OUTPUT_FILE"
echo "文件大小: $(du -h "$OUTPUT_FILE" | cut -f1)"
echo "================================"
echo ""
echo "可以使用以下命令打开查看:"
echo "open -a calibre '$OUTPUT_FILE'"
