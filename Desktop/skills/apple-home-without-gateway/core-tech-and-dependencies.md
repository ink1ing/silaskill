# Core Tech And Dependencies

## 核心技术

### 1. Home.app

- 这是配件的真实控制入口
- 没有稳定可用的公开 AppleScript 配件控制接口
- 在新版 macOS 中，内部 UI 结构可能随系统更新发生变化

### 2. macOS Accessibility API

- 通过 `AXUIElement` 读取 Home 窗口中的控件树
- 用于发现设备名称、开关控件、状态文本、激活点
- 是这套方案的核心依赖

### 3. Swift

- 直接调用 `AppKit` 与 `ApplicationServices`
- 比 AppleScript 更适合复杂的 UI 节点遍历与状态判断
- 可执行文件入口稳定，适合后续挂到 `launchd`

### 4. AppleScript

- 主要用于激活 `Home.app`
- 不负责核心控制逻辑
- 只作为辅助入口，不作为主控制层

### 5. launchd / LaunchAgents

- 用于定时调度本地脚本
- 适合“每天几点开、几点关”的固定计划
- 可结合日志文件做长期观察

## 依赖项目

### 系统依赖

- macOS
- `/System/Applications/Home.app`
- `/usr/bin/swift`

### Swift Frameworks

- `AppKit`
- `ApplicationServices`
- `Foundation`

### 运行前提

- 当前 macOS 用户已登录 iCloud / Apple Account
- 该用户在 Home 中对目标配件有控制权限
- 目标配件在局域网内可达
- Mac 已开启 Accessibility 权限给执行脚本的终端或宿主程序

### 可选配套

- `bash` 包装脚本
- `LaunchAgents` plist
- 本地日志目录
- 错误轮转或外部日志收集

## 关键限制

- 无 Gateway 时通常无法离家远程控制
- Mac 侧 GUI 自动化对系统界面变化敏感
- 某些系统版本里，`AXPress` 可能存在但不真正触发状态切换
- 睡眠、锁屏、显示器布局变化都可能影响自动化成功率
