# 常见问题解答

## 安装和配置问题

### Q1: ebook-convert 命令找不到

**问题表现**：
```
zsh: command not found: ebook-convert
```

**解决方案**：

1. 确认是否已安装Calibre：
```bash
ls /Applications/calibre.app
```

2. 添加到PATH：
```bash
# 临时添加
export PATH=$PATH:/Applications/calibre.app/Contents/MacOS

# 永久添加（添加到 ~/.zshrc）
echo 'export PATH=$PATH:/Applications/calibre.app/Contents/MacOS' >> ~/.zshrc
source ~/.zshrc
```

3. 或创建符号链接：
```bash
sudo ln -s /Applications/calibre.app/Contents/MacOS/ebook-convert /usr/local/bin/
```

### Q2: macOS权限问题

**问题表现**：
```
Permission denied
```

**解决方案**：
- 使用`sudo`运行命令
- 或修改输出目录权限：`chmod 755 output_dir`

## 转换质量问题

### Q3: 转换后文本乱码

**可能原因**：
1. PDF使用了特殊编码
2. PDF中嵌入的字体不标准
3. PDF是扫描图片而非文本

**解决方案**：

1. 指定输入编码：
```bash
ebook-convert input.pdf output.epub --input-encoding utf-8
```

2. 如果是扫描版，需要先进行OCR：
   - 使用Adobe Acrobat的OCR功能
   - 使用在线OCR工具
   - 或使用ocrmypdf等命令行工具

3. 尝试不同的PDF引擎：
```bash
ebook-convert input.pdf output.epub --pdf-engine podofo
```

### Q4: 图片丢失或质量下降

**解决方案**：

1. 确保保留图片：
```bash
--pdf-no-images=false
```

2. 保持封面比例：
```bash
--preserve-cover-aspect-ratio
```

3. 不使用默认封面（如果已有封面）：
```bash
--no-default-epub-cover
```

### Q5: 章节目录丢失

**解决方案**：

1. 使用PDF内嵌目录：
```bash
--pdf-use-toc
```

2. 手动设置章节检测规则：
```bash
--chapter "//*[contains(@class,'chapter')]"
--chapter-mark pagebreak
```

3. 查看PDF是否有书签：
   - 打开PDF查看左侧是否有目录书签
   - 如果没有，可能需要手动创建目录

### Q6: 转换后格式混乱

**解决方案**：

1. 启用启发式处理：
```bash
--enable-heuristics
```

2. 调整边距：
```bash
--margin-top 72 --margin-bottom 72 --margin-left 72 --margin-right 72
```

3. 对于特殊格式的PDF，可能需要多次调整参数测试

## 性能问题

### Q7: 转换速度很慢

**原因分析**：
- PDF文件很大（>50MB）
- PDF包含大量图片
- 启用了复杂的处理选项

**解决方案**：

1. 耐心等待（大文件可能需要几分钟）
2. 减少处理选项：
```bash
# 最简转换
ebook-convert input.pdf output.epub --language zh
```

3. 查看进度（使用verbose）：
```bash
ebook-convert input.pdf output.epub --verbose
```

### Q8: 转换时内存占用过高

**解决方案**：
- 将大PDF分割成多个小文件分别转换
- 关闭其他占用内存的应用
- 使用更高配置的机器进行转换

## 格式兼容性问题

### Q9: EPUB在某些阅读器上无法打开

**可能原因**：
- 阅读器不支持EPUB 3
- EPUB文件损坏

**解决方案**：

1. 生成EPUB 2版本：
```bash
--epub-version 2
```

2. 验证EPUB文件：
```bash
# 使用epubcheck（需要安装）
java -jar epubcheck.jar output.epub
```

3. 用Calibre打开检查是否正常

### Q10: 在Kindle上无法阅读

**解决方案**：

1. Kindle需要转换为MOBI格式：
```bash
ebook-convert input.pdf output.mobi --language zh
```

2. 或使用Amazon的Send to Kindle功能
3. 或通过Calibre转换并推送到Kindle

## 内容问题

### Q11: 转换后内容不完整

**检查步骤**：

1. 对比原PDF页数和转换后的章节数
2. 搜索关键词确认内容是否存在
3. 检查是否有DRM保护

**解决方案**：

1. 如果PDF有密码保护，先解除保护
2. 检查PDF是否有复制限制
3. 尝试不同的转换参数

### Q12: 页码丢失

**说明**：
EPUB是流式布局，不保留固定页码是正常的。

**替代方案**：
- 使用章节导航
- 使用书签功能
- 或转换为保留页码的格式（如PDF）

## 中文特定问题

### Q13: 中文标点显示异常

**解决方案**：

1. 禁用智能标点：
```bash
--unsmarten-punctuation
```

2. 设置语言为中文：
```bash
--language zh
```

### Q14: 中文字体缺失

**解决方案**：

1. 嵌入字体：
```bash
--embed-font-family "宋体,黑体"
```

2. 注意：嵌入字体会增加文件大小

## 批量转换问题

### Q15: 批量转换某些文件失败

**解决方案**：

1. 添加错误处理的批量脚本：
```bash
#!/bin/bash
for pdf in *.pdf; do
  output="${pdf%.pdf}.epub"
  echo "Converting: $pdf"
  if ebook-convert "$pdf" "$output" --language zh 2>&1 | tee -a conversion.log; then
    echo "✓ Success: $pdf"
  else
    echo "✗ Failed: $pdf" >> failed.txt
  fi
done
```

2. 检查失败的文件是否有特殊原因

## 高级问题

### Q16: 需要自定义CSS样式

**解决方案**：

1. 创建自定义CSS文件
2. 使用参数：
```bash
--extra-css custom.css
```

### Q17: 需要添加或替换封面

**解决方案**：

```bash
--cover cover.jpg
```

### Q18: 转换后文件过大

**解决方案**：

1. 压缩图片
2. 移除不必要的图片：
```bash
--pdf-no-images
```

3. 使用压缩工具优化EPUB

## 求助途径

如果以上方法都无法解决问题：

1. 查看Calibre官方文档
2. 访问Calibre官方论坛
3. 查看转换日志找出具体错误信息
4. 尝试使用其他转换工具（如在线转换）

## 最佳实践总结

1. **保留原文件**：始终保留原始PDF
2. **先测试**：用小文件测试参数
3. **记录参数**：成功后记录参数组合
4. **验证结果**：转换后务必检查
5. **分批处理**：批量转换时分批进行
6. **查看日志**：出错时查看详细日志
