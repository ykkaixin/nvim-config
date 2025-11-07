# Modern Neovim Configuration

可移植的现代 Neovim 配置，适合在任何新电脑上快速同步与使用。

> **⚠️ 重要提示：CPU 占用优化**
>
> 本配置已针对 CPU 占用问题进行了优化：
> - ✅ **修复 Error 导致 CPU 暴涨**：禁用虚拟文本，添加诊断防抖 → [ERROR-CPU-FIX.md](./ERROR-CPU-FIX.md)
> - ✅ **多进程问题**：禁用不必要的 providers 和优化性能设置 → [CPU-USAGE-FIX.md](./CPU-USAGE-FIX.md)
> - 🔍 **诊断工具**：`./diagnose-cpu.sh` 和 `./monitor-nvim.sh`
> - 🔧 **清理脚本**：`./kill-nvim-processes.sh`

## Requirements
- Neovim ≥ 0.11.3
- Git
- 推荐：Python3+pip、Node.js、ripgrep、fd（Telescope 更快）、基础构建工具（用于 `telescope-fzf-native`）

## Quick Install（推荐）
1) 克隆仓库：
```bash
git clone https://github.com/ykkaixin/nvim-config.git
cd nvim-config
```

2) 运行安装脚本（选择符号链接或复制）：
```bash
./install.sh
```

3) 启动 Neovim：
```bash
nvim
```

首次启动会自动安装插件。LSP 采用 Neovim 0.11 的新 API（`vim.lsp.config`），请使用 Neovim ≥ 0.11.3。安装/管理 LSP 服务器：在 Neovim 内执行 `:Mason`。使用 AI 补全请执行 `:Codeium Auth` 完成鉴权。

## Docs
- 使用与插件说明：USAGE.md
- 贡献者指南：AGENTS.md

更新配置：进入仓库目录 `git pull`，在 Neovim 执行 `:Lazy sync` 同步插件。
