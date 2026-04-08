---
name: pdf-to-epub
description: 将PDF文件转换为EPUB格式的电子书。使用Calibre的ebook-convert工具或Python的pdf2epub库进行转换，支持保留文本、图片和基本格式。适用于需要在电子书阅读器上阅读PDF内容的场景。
---

# PDF to EPUB

使用此skill将PDF文件转换为EPUB格式，以便在电子书阅读器、iPad或手机上更好地阅读。

## 功能特性

- 支持将PDF文件转换为标准EPUB格式
- 保留文本内容和图片
- 自动提取元数据（标题、作者等）
- 支持自定义输出参数
- 可批量转换多个PDF文件

## 适用场景

使用此skill当用户需要：

- 将PDF书籍转换为EPUB以便在Kindle、iPad或其他电子书阅读器上阅读
- 批量转换PDF文档集合
- 保留PDF中的文本和图片到EPUB格式
- 调整EPUB输出参数以优化阅读体验

## 转换方法

该skill支持两种转换方式：

### 方法1: Calibre ebook-convert（推荐）

使用Calibre提供的命令行工具，转换质量高且功能强大。

优点：
- 转换质量高
- 支持丰富的自定义选项
- 广泛使用且稳定

缺点：
- 需要安装Calibre应用

### 方法2: Python pdf2epub库

使用Python的pdf2epub或其他相关库进行转换。

优点：
- 轻量级
- 可编程控制

缺点：
- 转换质量可能不如Calibre
- 部分库可能缺乏维护

## 使用流程

### 1. 检查依赖

首先检查是否已安装Calibre：

```bash
which ebook-convert
```

如果未安装，在macOS上可通过Homebrew安装：

```bash
brew install --cask calibre
```

### 2. 基本转换

最简单的转换命令：

```bash
ebook-convert input.pdf output.epub
```

### 3. 带参数的转换

```bash
ebook-convert input.pdf output.epub \
  --authors "作者名" \
  --title "书名" \
  --language zh \
  --book-producer "转换工具" \
  --publisher "出版社"
```

### 4. 高级选项

针对中文PDF和特殊格式优化：

```bash
ebook-convert input.pdf output.epub \
  --authors "作者名" \
  --title "书名" \
  --language zh \
  --enable-heuristics \
  --pdf-no-images=false \
  --chapter "//*[@class='chapter']" \
  --page-breaks-before "/"
```

常用参数说明：
- `--enable-heuristics`: 启用启发式处理，改善格式
- `--pdf-no-images=false`: 保留图片
- `--language zh`: 设置语言为中文
- `--chapter`: 章节检测规则
- `--margin-top/bottom/left/right`: 设置边距

## 批量转换

如需批量转换多个PDF文件：

```bash
for pdf in *.pdf; do
  ebook-convert "$pdf" "${pdf%.pdf}.epub" \
    --language zh \
    --enable-heuristics
done
```

## 质量优化建议

1. **文本提取质量**：如果PDF是扫描版（图片），转换质量会很差，建议先进行OCR处理
2. **章节分割**：对于复杂的PDF，可能需要手动调整章节检测规则
3. **图片处理**：确保设置`--pdf-no-images=false`以保留图片
4. **字体问题**：部分特殊字体可能无法正确显示，这是PDF格式本身的限制

## 验证转换结果

转换完成后，建议：

1. 使用Calibre打开EPUB文件预览
2. 检查文本内容是否完整
3. 检查图片是否正常显示
4. 检查章节目录是否正确

```bash
# 使用Calibre打开EPUB查看
open -a "calibre" output.epub
```

## 故障排查

### 问题1: ebook-convert命令未找到

解决方案：
- 确保已安装Calibre
- 将Calibre的命令行工具添加到PATH：
  ```bash
  export PATH=$PATH:/Applications/calibre.app/Contents/MacOS
  ```

### 问题2: 转换后的EPUB文本乱码

可能原因：
- PDF包含特殊编码
- PDF是扫描版图片

解决方案：
- 尝试添加`--input-encoding utf-8`参数
- 如果是扫描版，需要先进行OCR

### 问题3: 转换速度很慢

原因：
- PDF文件过大
- 包含大量图片

解决方案：
- 耐心等待
- 或先压缩PDF文件

## 替代工具

如果Calibre不可用，可以考虑：

1. **在线转换工具**：
   - CloudConvert
   - Zamzar
   - Online-Convert

2. **其他命令行工具**：
   - pdftk
   - Pandoc（需要先转为markdown）

## 参考资料

- Calibre用户手册: [references/calibre-guide.md](references/calibre-guide.md)
- 转换参数详解: [references/conversion-options.md](references/conversion-options.md)
- 常见问题: [references/faq.md](references/faq.md)

## 注意事项

- 转换质量取决于源PDF的质量
- 扫描版PDF需要先进行OCR才能获得良好效果
- 部分PDF有DRM保护，无法转换
- 转换后请自行验证内容完整性
- 尊重版权，仅转换自己拥有的或有权使用的PDF文件
