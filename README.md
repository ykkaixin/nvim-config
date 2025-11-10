# Modern Neovim Configuration

可移植的现代 Neovim 配置，适合在任何新电脑上快速同步与使用。

> **✨ 特色功能**
>
> - 🚀 **IntelliJ 风格代码导航**：自动变量高亮、智能跳转、快速选择 → [INTELLIJ-FEATURES.md](./INTELLIJ-FEATURES.md) ⭐⭐⭐
> - 📝 **Typora 模式**：编辑器内实时渲染 Markdown，所见即所得！→ [TYPORA-MODE.md](./TYPORA-MODE.md) ⭐⭐⭐
> - 🌐 **浏览器预览**：支持 Mermaid 图表、数学公式 → [MARKDOWN-GUIDE.md](./MARKDOWN-GUIDE.md)
> - ⚡ **VSCode 风格错误显示**：左侧标记+下划线+自动弹窗，零性能消耗
> - 🎨 **零 CPU 占用**：所有性能问题已优化 → [CPU-USAGE-FIX.md](./CPU-USAGE-FIX.md)
> - 🔍 **诊断工具**：`./diagnose-cpu.sh` 和 `./monitor-nvim.sh`
> - 🔧 **清理脚本**：`./kill-nvim-processes.sh`

## Requirements

### 必需
- Neovim ≥ 0.11.3
- Git
- **Nerd Fonts** ⭐ 重要！用于显示图标

### 推荐
- Python3 + pip（Python LSP）
- Node.js + npm（Markdown 预览、部分 LSP）
- ripgrep（Telescope 搜索）
- fd（Telescope 更快）
- 基础构建工具（telescope-fzf-native）

## Quick Install（推荐）
1) 克隆仓库：
```bash
git clone https://github.com/ykkaixin/nvim-config.git
cd nvim-config
```

2) 运行安装脚本（自动检测并安装依赖）：
```bash
./install.sh
```
脚本会自动检测 Nerd Fonts，并提示是否安装。

3) 如果跳过了字体安装，手动安装 Nerd Fonts：
```bash
./install-fonts.sh
```
安装后需要在终端设置中选择 Nerd Font 字体（如 JetBrainsMono Nerd Font）

4) 启动 Neovim：
```bash
nvim
```

首次启动会自动安装插件。LSP 采用 Neovim 0.11 的新 API（`vim.lsp.config`），请使用 Neovim ≥ 0.11.3。安装/管理 LSP 服务器：在 Neovim 内执行 `:Mason`。使用 AI 补全请执行 `:Codeium Auth` 完成鉴权。

## Docs

### 快速上手
- 🎓 **新手教程**：[QUICK-START.md](./QUICK-START.md) - IntelliJ 功能手把手教程
- ⚡ **快捷键速查**：[CHEATSHEET.md](./CHEATSHEET.md) - 可打印的速查表
- 📝 **Markdown 指南**：[MARKDOWN-GUIDE.md](./MARKDOWN-GUIDE.md) - 完整 Markdown 编辑指南

### 功能详解
- 🚀 **IntelliJ 功能**：[INTELLIJ-FEATURES.md](./INTELLIJ-FEATURES.md) - 详细功能说明
- 🐛 **CPU 优化**：[CPU-USAGE-FIX.md](./CPU-USAGE-FIX.md) - 性能问题解决方案
- 📚 **使用说明**：[USAGE.md](./USAGE.md) - 插件使用与配置

### 其他
- 贡献者指南：[AGENTS.md](./AGENTS.md)

更新配置：进入仓库目录 `git pull`，在 Neovim 执行 `:Lazy sync` 同步插件。
