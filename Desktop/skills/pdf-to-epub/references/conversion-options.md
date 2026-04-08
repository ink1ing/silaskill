# 转换参数详解

## 参数分类

### 1. 元数据参数

这些参数用于设置EPUB文件的元数据信息：

| 参数 | 说明 | 示例 |
|------|------|------|
| `--title` | 书名 | `--title "币安人生"` |
| `--authors` | 作者（多个用&分隔） | `--authors "作者1 & 作者2"` |
| `--publisher` | 出版社 | `--publisher "某出版社"` |
| `--language` | 语言代码 | `--language zh` |
| `--tags` | 标签（逗号分隔） | `--tags "传记,科技"` |
| `--isbn` | ISBN号码 | `--isbn "9787111111111"` |
| `--pubdate` | 出版日期 | `--pubdate "2026-01-01"` |
| `--comments` | 简介描述 | `--comments "这是一本好书"` |
| `--rating` | 评分（1-5） | `--rating 5` |
| `--series` | 系列名称 | `--series "编程系列"` |
| `--series-index` | 系列索引 | `--series-index 1` |

### 2. PDF输入参数

针对PDF格式的特殊处理参数：

| 参数 | 说明 | 默认值 | 推荐值 |
|------|------|--------|--------|
| `--pdf-no-images` | 是否移除图片 | false | false |
| `--pdf-use-toc` | 使用PDF内嵌目录 | false | true（如有目录） |
| `--pdf-unmarked-toc` | 使用未标记的目录 | false | - |
| `--pdf-engine` | PDF解析引擎 | auto | auto |

### 3. 格式处理参数

控制文本格式和排版的参数：

| 参数 | 说明 | 推荐使用场景 |
|------|------|-------------|
| `--enable-heuristics` | 启用智能格式处理 | 大多数情况 |
| `--markup-chapter-headings` | 标记章节标题 | 有明确章节的书籍 |
| `--italicize-patterns` | 斜体化特定模式 | 需要强调特定文本 |
| `--smarten-punctuation` | 智能标点转换 | 英文书籍 |
| `--unsmarten-punctuation` | 禁用智能标点 | 中文或代码书籍 |
| `--unwrap-lines` | 解除换行 | PDF文本有异常换行 |

### 4. 章节和目录参数

| 参数 | 说明 | 示例 |
|------|------|------|
| `--chapter` | 章节检测XPath | `--chapter "//*[@class='chapter']"` |
| `--chapter-mark` | 章节标记方式 | `--chapter-mark pagebreak` |
| `--page-breaks-before` | 分页位置 | `--page-breaks-before "/"` |
| `--remove-first-image` | 删除首图 | `--remove-first-image` |
| `--insert-blank-line` | 插入空行 | `--insert-blank-line` |
| `--insert-blank-line-size` | 空行大小 | `--insert-blank-line-size 1.0` |

### 5. 页面布局参数

| 参数 | 说明 | 单位 | 推荐值 |
|------|------|------|--------|
| `--margin-top` | 上边距 | pt | 50-72 |
| `--margin-bottom` | 下边距 | pt | 50-72 |
| `--margin-left` | 左边距 | pt | 50-72 |
| `--margin-right` | 右边距 | pt | 50-72 |
| `--change-justification` | 对齐方式 | - | left/justify |

### 6. 字体参数

| 参数 | 说明 | 示例 |
|------|------|------|
| `--embed-font-family` | 嵌入字体族 | `--embed-font-family "宋体"` |
| `--subset-embedded-fonts` | 子集嵌入字体 | `--subset-embedded-fonts` |
| `--base-font-size` | 基础字体大小 | `--base-font-size 16` |
| `--font-size-mapping` | 字体映射 | `--font-size-mapping "12,14,16,18,20,22,24"` |
| `--minimum-line-height` | 最小行高 | `--minimum-line-height 120` |

### 7. 图片处理参数

| 参数 | 说明 | 推荐值 |
|------|------|--------|
| `--no-inline-toc` | 不内联目录 | - |
| `--max-toc-links` | 最大目录链接数 | 50 |
| `--duplicate-links-in-toc` | 目录中重复链接 | false |

### 8. 输出优化参数

| 参数 | 说明 | 使用场景 |
|------|------|---------|
| `--pretty-print` | 美化输出HTML | 调试用 |
| `--no-default-epub-cover` | 不使用默认封面 | 已有自定义封面 |
| `--preserve-cover-aspect-ratio` | 保持封面比例 | 有封面图片 |
| `--epub-version` | EPUB版本 | `--epub-version 3` |

## 场景化参数组合

### 场景1：中文小说

```bash
ebook-convert input.pdf output.epub \
  --title "书名" \
  --authors "作者" \
  --language zh \
  --enable-heuristics \
  --chapter-mark pagebreak \
  --margin-top 72 \
  --margin-bottom 72 \
  --base-font-size 16 \
  --pdf-no-images=false
```

### 场景2：技术书籍（带代码）

```bash
ebook-convert input.pdf output.epub \
  --title "技术书" \
  --language zh \
  --unsmarten-punctuation \
  --pdf-no-images=false \
  --preserve-cover-aspect-ratio \
  --base-font-size 14
```

### 场景3：图文并茂的书籍

```bash
ebook-convert input.pdf output.epub \
  --title "图文书" \
  --language zh \
  --enable-heuristics \
  --pdf-no-images=false \
  --preserve-cover-aspect-ratio \
  --no-default-epub-cover
```

### 场景4：扫描版PDF（已OCR）

```bash
ebook-convert input.pdf output.epub \
  --title "扫描书" \
  --language zh \
  --enable-heuristics \
  --pdf-use-toc \
  --unwrap-lines \
  --margin-top 50 \
  --margin-bottom 50
```

## 调试参数

| 参数 | 说明 |
|------|------|
| `--verbose` | 显示详细输出 |
| `--debug-pipeline` | 调试处理流程 |

## 性能参数

| 参数 | 说明 | 影响 |
|------|------|------|
| `--max-toc-links 0` | 禁用目录处理 | 加快速度，失去目录 |
| `--no-inline-toc` | 不生成内联目录 | 稍微加快 |

## 参数优先级

1. 命令行参数 > 配置文件参数
2. 后面的参数会覆盖前面的同类参数
3. 布尔参数使用`--param=false`来禁用

## 常见参数错误

### 错误1：参数拼写错误

```bash
# 错误
--authers "作者"

# 正确
--authors "作者"
```

### 错误2：布尔参数格式错误

```bash
# 错误
--pdf-no-images false

# 正确
--pdf-no-images=false
```

### 错误3：路径包含空格未加引号

```bash
# 错误
ebook-convert my file.pdf output.epub

# 正确
ebook-convert "my file.pdf" output.epub
```

## 参数查找

查看所有可用参数：

```bash
ebook-convert --help

# 查看PDF输入特定参数
ebook-convert input.pdf output.epub --help
```
