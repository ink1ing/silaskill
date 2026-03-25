# Layout 2: Automation Stack

## 目标

这是面向长期运行的布局：把“控制逻辑”“包装脚本”“系统调度”“日志输出”拆成多层，便于维护与追踪。

适合：

- 有固定的开关时间
- 希望系统登录后自动接管调度
- 需要保留日志
- 希望不同动作拆开维护，例如 `water-on.sh` 与 `water-off.sh`

## 推荐目录

```text
layout-2-automation-stack/
├── SKILL.md
├── scripts/
│   ├── home-water-toggle.swift
│   ├── water-on.sh
│   └── water-off.sh
├── launchagents/
│   ├── com.example.home-water-on.plist
│   └── com.example.home-water-off.plist
└── logs/
    ├── water-on.log
    ├── water-on.err.log
    ├── water-off.log
    └── water-off.err.log
```

## 分层说明

### 1. 控制层

`home-water-toggle.swift`

- 负责真正与 Home UI 交互
- 接收 `on/off` 参数
- 负责状态回读与退出码

### 2. 包装层

`water-on.sh` / `water-off.sh`

- 固定参数调用 Swift 脚本
- 便于被 `launchd` 或其他外部系统直接调用
- 保持触发入口稳定，不把复杂逻辑写进 plist

### 3. 调度层

`LaunchAgents/*.plist`

- 负责定时执行
- 设置标准输出与错误日志路径
- 定义开和关的时间表

### 4. 观测层

`logs/`

- 标准输出用于记录前后状态
- 错误日志用于记录找不到控件、状态未切换、窗口不可用等异常

## 优点

- 分层清晰
- 便于排错
- 容易扩展更多设备与更多时间表
- 更适合长期运行

## 缺点

- 文件更多
- 初次配置比布局一复杂
- `launchd` 环境与交互式 shell 环境差异需要额外注意

## 推荐实践

- Swift 脚本只做控制，不做复杂调度
- 每个设备使用单独日志
- 定时任务的 stdout / stderr 分开存储
- 所有自动化都必须有显式退出码
- 失败时记录“目标状态”“当前状态”“当前系统版本”

## 扩展方式

- 增加 `heater-on.sh`、`heater-off.sh`
- 新增第二个 Swift 控制器，按房间或配件类型拆分
- 在日志目录下按设备名进一步分组
