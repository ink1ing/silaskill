# PDF to EPUB Converter Skill

将PDF文件转换为EPUB格式的电子书转换工具。

## 功能

- 支持PDF到EPUB格式转换
- 保留文本和图片
- 自动提取元数据
- 优化中文显示
- 支持批量转换

## 快速开始

### 1. 安装依赖

```bash
brew install --cask calibre
```

### 2. 使用转换脚本

```bash
cd /Users/silas/Desktop/skills/pdf-to-epub
./convert.sh ~/Desktop/币安人生.pdf
```

### 3. 手动转换

```bash
/Applications/calibre.app/Contents/MacOS/ebook-convert input.pdf output.epub \
  --title "书名" \
  --language zh \
  --enable-heuristics
```

## 文件结构

```
pdf-to-epub/
├── SKILL.md                      # Skill定义和使用指南
├── README.md                     # 本文件
├── convert.sh                    # 转换脚本
└── references/
    ├── calibre-guide.md         # Calibre详细指南
    ├── conversion-options.md    # 转换参数详解
    └── faq.md                   # 常见问题解答
```

## 使用示例

### 示例1：基本转换

```bash
./convert.sh 币安人生.pdf
```

输出：`币安人生.epub`

### 示例2：指定输出文件名

```bash
./convert.sh 币安人生.pdf binance-life.epub
```

### 示例3：批量转换

```bash
for pdf in *.pdf; do
  ./convert.sh "$pdf"
done
```

## 转换参数说明

脚本默认使用以下优化参数：

- `--language zh`: 中文语言
- `--enable-heuristics`: 启用智能格式处理
- `--margin-top/bottom/left/right 72`: 设置合适的边距
- `--base-font-size 16`: 基础字体大小16pt
- `--unsmarten-punctuation`: 保留原始标点（适合中文）

## 转换质量说明

- **文本PDF**: 转换质量最好，文本可复制
- **扫描PDF**: 需要先进行OCR识别
- **图文混排**: 会保留图片和文本
- **加密PDF**: 需要先解除保护

## 查看转换结果

使用Calibre打开：

```bash
open -a calibre 币安人生.epub
```

或使用系统默认阅读器：

```bash
open 币安人生.epub
```

## 常见问题

### Q: 转换速度慢？
A: PDF转换需要时间，特别是大文件。通常30MB的文件需要1-2分钟。

### Q: 图片丢失？
A: 脚本已设置保留图片，如果仍然丢失，可能是PDF本身问题。

### Q: 文本乱码？
A: 如果是扫描版PDF，需要先进行OCR处理。

更多问题请查看 [references/faq.md](references/faq.md)

## 成功案例

已成功转换：
- 币安人生.pdf (33MB) → 币安人生.epub (13MB)
  - 原文件：237页
  - 转换时间：约2分钟
  - 质量：良好

## 参考资料

- [SKILL.md](SKILL.md) - 完整的Skill文档
- [references/calibre-guide.md](references/calibre-guide.md) - Calibre使用指南
- [references/conversion-options.md](references/conversion-options.md) - 参数详解
- [references/faq.md](references/faq.md) - 常见问题

## 版权声明

- 仅转换自己拥有或有权使用的PDF文件
- 尊重原作者版权
- 不用于商业用途
