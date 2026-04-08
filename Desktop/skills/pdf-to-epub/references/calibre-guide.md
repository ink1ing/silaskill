# Calibre 使用指南

## 简介

Calibre是一个功能强大的开源电子书管理和转换工具，支持多种电子书格式之间的转换。

## 安装

### macOS

```bash
# 使用Homebrew
brew install --cask calibre

# 或下载官方安装包
# https://calibre-ebook.com/download
```

### 配置命令行工具

安装后，需要将Calibre的命令行工具添加到PATH：

```bash
# 添加到 ~/.zshrc 或 ~/.bash_profile
export PATH=$PATH:/Applications/calibre.app/Contents/MacOS
```

## ebook-convert 命令详解

### 基本语法

```bash
ebook-convert input_file output_file [options]
```

### 支持的格式

输入格式：
- PDF
- DOCX
- MOBI
- AZW3
- HTML
- TXT
- 等等

输出格式：
- EPUB
- MOBI
- AZW3
- PDF
- TXT
- 等等

## PDF to EPUB 常用参数

### 元数据参数

```bash
--title "书名"
--authors "作者"
--publisher "出版社"
--language zh
--tags "标签1,标签2"
--book-producer "转换者"
--pubdate "2026-01-01"
--comments "书籍描述"
```

### PDF特定参数

```bash
--pdf-no-images=false          # 保留图片
--pdf-use-toc                  # 使用PDF的目录
--pdf-unmarked-toc             # 使用未标记的目录
--pdf-engine                   # PDF引擎选择
```

### 布局和格式参数

```bash
--enable-heuristics            # 启用启发式格式处理
--markup-chapter-headings      # 标记章节标题
--italicize-patterns           # 斜体模式
--smarten-punctuation          # 智能标点
--unsmarten-punctuation        # 禁用智能标点
```

### 页面和边距

```bash
--margin-top 50               # 上边距（pt）
--margin-bottom 50            # 下边距
--margin-left 50              # 左边距
--margin-right 50             # 右边距
--change-justification left   # 对齐方式
```

### 目录和章节

```bash
--chapter "//*[@class='chapter']"     # 章节检测XPath
--chapter-mark pagebreak              # 章节标记方式
--page-breaks-before "/"              # 分页位置
--remove-first-image                  # 删除首图
```

### 字体和文本

```bash
--embed-font-family           # 嵌入字体族
--subset-embedded-fonts       # 子集嵌入字体
--base-font-size 14           # 基础字体大小
--font-size-mapping "12,12,14,16,18,20,22,24"  # 字体大小映射
```

## 转换示例

### 示例1：基本转换

```bash
ebook-convert input.pdf output.epub
```

### 示例2：带完整元数据

```bash
ebook-convert "币安人生.pdf" "币安人生.epub" \
  --title "币安人生" \
  --authors "赵长鹏" \
  --language zh \
  --publisher "某出版社" \
  --tags "传记,加密货币,币安" \
  --enable-heuristics
```

### 示例3：优化中文PDF

```bash
ebook-convert input.pdf output.epub \
  --language zh \
  --enable-heuristics \
  --pdf-no-images=false \
  --margin-top 72 \
  --margin-bottom 72 \
  --margin-left 72 \
  --margin-right 72 \
  --base-font-size 16
```

### 示例4：批量转换

```bash
#!/bin/bash
for file in *.pdf; do
  output="${file%.pdf}.epub"
  echo "Converting $file to $output..."
  ebook-convert "$file" "$output" \
    --language zh \
    --enable-heuristics \
    --pdf-no-images=false
done
```

## 图形界面使用

如果不想使用命令行，也可以打开Calibre图形界面：

1. 打开Calibre应用
2. 点击"添加书籍"导入PDF
3. 选中书籍，点击"转换书籍"
4. 在转换对话框中设置各项参数
5. 点击"确定"开始转换

## 性能优化

### 提高转换速度

- 使用`--max-toc-links 0`减少目录处理
- 减小输出图片质量
- 禁用不必要的处理选项

### 提高转换质量

- 启用`--enable-heuristics`
- 调整章节检测规则
- 手动设置元数据
- 适当调整边距和字体大小

## 调试和日志

```bash
# 显示详细输出
ebook-convert input.pdf output.epub --verbose

# 保存日志到文件
ebook-convert input.pdf output.epub 2>&1 | tee conversion.log
```

## 最佳实践

1. **始终保留源文件**：转换过程可能失败或结果不理想
2. **先测试小文件**：大文件转换前先用小文件测试参数
3. **检查转换结果**：转换后务必打开EPUB检查质量
4. **逐步优化参数**：不要一次性添加太多参数，逐步调整
5. **记录成功参数**：找到适合特定类型PDF的参数组合后记录下来

## 常见问题

### Q: 转换后章节目录丢失
A: 尝试添加`--pdf-use-toc`参数，或手动设置章节检测规则

### Q: 图片质量变差
A: 使用`--pdf-no-images=false`确保保留图片

### Q: 转换速度很慢
A: PDF转换本身较慢，特别是大文件，需要耐心等待

### Q: 中文显示乱码
A: 设置`--language zh`并尝试`--input-encoding utf-8`
