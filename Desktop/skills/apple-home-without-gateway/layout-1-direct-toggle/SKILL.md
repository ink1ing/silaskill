# Layout 1: Direct Toggle

## 目标

这是最直接的一种布局：一条脚本负责打开 `Home.app`、定位目标配件开关、切换状态、回读结果。

适合：

- 只控制一个设备，比如 `Water`
- 只需要 `on/off` 两种动作
- 希望最少文件、最少层级、最快落地

## 推荐目录

```text
layout-1-direct-toggle/
├── SKILL.md
└── home-water-toggle.swift
```

## 核心流程

1. 启动或激活 `Home.app`
2. 通过 Accessibility API 读取当前前台窗口
3. 在包含目标设备名称的区域内查找真正的开关控件
4. 优先点击控件的 `AXActivationPoint`
5. 回读 `On/Off` 状态，确认是否达到目标值

## 关键实现点

- 设备名称匹配不能只依赖旧版 `AXButton`
- 新版 macOS / Home 中，开关常表现为 `AXCheckBox` + `AXSwitch`
- `AXPress` 不一定可靠，必要时应退回真实鼠标点击
- 状态判断优先读取界面可见文本 `On/Off`

## 优点

- 结构最简单
- 易于调试
- 出问题时定位范围小
- 适合人工触发、手动执行、快捷指令封装

## 缺点

- 扩展到多设备时，逻辑容易堆在一个脚本里
- 日志、调度、失败重试通常要额外补
- 对 Home UI 结构变化更敏感

## 推荐依赖

- `/usr/bin/swift`
- `AppKit`
- `ApplicationServices`
- `Home.app`
- 已授予 Accessibility 权限的执行环境

## 最小命令示例

```bash
/usr/bin/swift /path/to/home-water-toggle.swift off
/usr/bin/swift /path/to/home-water-toggle.swift on
```

## 什么时候不该选它

- 你需要多个定时任务
- 你要维护多台设备
- 你需要分离“执行层”和“调度层”
- 你需要较完整的日志体系
