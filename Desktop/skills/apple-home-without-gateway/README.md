# Apple Home Without Gateway

这个文件夹整理的是“没有 Home Hub / Gateway 时，如何依赖本地 Mac 控制 Apple Home 配件”的两套实现布局。

适用场景：

- 只需要在家中局域网内控制设备
- 不要求离家远程访问
- 可以接受依赖一台本地 Mac 来执行自动化
- 设备已经能在 Apple Home App 中正常显示与操作

本资料包包含：

- `layout-1-direct-toggle/`
  直接控制型布局，适合单设备、单动作、低复杂度场景
- `layout-2-automation-stack/`
  自动化编排型布局，适合定时任务、日志追踪、可维护性要求更高的场景
- `core-tech-and-dependencies.md`
  核心技术栈、运行依赖、权限要求、系统前提
- `operational-notes.md`
  局限、风险、调试建议、验证方法

建议选型：

- 如果你只想稳定开关一个或少量插座，优先看布局一
- 如果你已经要用 `launchd`、日志、定时开关，优先看布局二

两套布局的共同原则：

- 不依赖 HomeKit 官方公开脚本 API，因为 `Home.app` 本身没有稳定可用的 AppleScript 配件控制接口
- 利用 macOS 的 Accessibility 能力定位 Home 界面中的控件
- 将真实控制动作下沉到本地脚本执行
- 所有状态验证都必须读取 Home 当前界面中的开关状态，而不是只假设点击成功
