# Neovim CPU 占用问题修复指南

## 问题描述

编辑 Python 文件时，系统监视器显示多个 nvim 进程，每个都占用 100% CPU。

## 根本原因

1. **Python Provider 进程泄漏** - Neovim 的 Python provider 会启动后台 Python 进程，异常退出时可能不会正确清理
2. **相对行号和光标行高亮** - 频繁重绘导致 CPU 占用过高
3. **过短的 updatetime** - 频繁触发更新事件
4. **语法高亮性能问题** - 复杂的 Python 语法高亮在大文件中会导致性能问题

## 已实施的修复

### 1. 禁用不必要的 Providers (lua/core/perf.lua)

```lua
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
```

**作用：** 防止 Neovim 启动后台 Python/Ruby/Node.js 进程，这是导致多进程问题的主要原因。

**注意：** 如果你需要使用需要 Python 的插件，编辑 `lua/core/perf.lua` 并取消注释：
```lua
vim.g.loaded_python3_provider = 1
```

### 2. 性能优化设置 (lua/core/perf.lua & lua/core/options.lua)

```lua
-- 限制语法高亮
vim.opt.synmaxcol = 200
vim.opt.maxmempattern = 2000

-- 增加更新时间
vim.opt.updatetime = 2000  -- 从 250ms 增加到 2000ms

-- 延迟重绘
vim.opt.lazyredraw = true
```

### 3. UI 优化

```lua
-- 禁用相对行号（主要 CPU 消耗源）
-- opt.relativenumber = true  -- 已注释

-- Cursorline 仅在非插入模式启用
```

### 4. 大文件自动优化 (lua/core/perf.lua)

文件 >1MB 时自动禁用语法高亮和其他功能。

### 5. Python 文件特定优化

```lua
-- 使用更简单的 folding 方法
vim.opt_local.foldmethod = "indent"
vim.opt_local.foldlevel = 99
```

## 使用说明

### 方法 1：应用新配置（推荐）

1. 先清理现有的问题进程（见下文）
2. 重启 Neovim
3. 打开 Python 文件测试性能

### 方法 2：清理多余的 nvim 进程

使用提供的清理脚本：

```bash
# 运行清理脚本
./kill-nvim-processes.sh

# 或者手动查看进程
ps aux | grep nvim

# 手动杀死所有 nvim 进程
pkill -9 nvim
```

### 方法 3：一键清理命令

```bash
# 快速杀死所有 nvim 进程
pkill -9 nvim

# 杀死相关的 Python 进程
ps aux | grep python | grep nvim | awk '{print $2}' | xargs kill -9
```

## 验证修复

1. **重启 Neovim** 并打开一个 Python 文件
2. **在终端监控进程**：
   ```bash
   watch -n 1 'ps aux | grep nvim'
   ```
3. **检查 CPU 占用**：
   ```bash
   top -p $(pgrep nvim | tr '\n' ',' | sed 's/,$//')
   ```
4. **应该只看到一个 nvim 进程**，CPU 占用应该很低（<10%）

## 如果问题仍然存在

### 完全禁用语法高亮（临时测试）

在 Neovim 中执行：
```vim
:syntax off
```

如果这样解决了问题，说明是语法高亮的问题。

### 检查插件

某些插件（特别是 LSP 和补全插件）可能会导致性能问题。尝试禁用插件：

```lua
-- 在 lua/plugins/init.lua 中临时注释掉所有插件
```

### 重新启用 Python Provider（如果需要）

如果你确实需要 Python 功能，编辑 `lua/core/perf.lua`：

```lua
-- vim.g.loaded_python3_provider = 0  -- 注释掉这行
vim.g.loaded_python3_provider = 1     -- 添加这行重新启用
```

然后确保安装了 pynvim：
```bash
pip3 install pynvim
```

## 性能监控命令

```bash
# 持续监控 nvim 进程
watch -n 1 'ps aux | grep nvim'

# 查看进程树（了解父子进程关系）
pstree -p | grep nvim

# 查看详细的 CPU 占用
top -c | grep nvim

# 查看所有相关进程
ps aux | grep -E 'nvim|python.*nvim'
```

## 预防措施

1. **正确退出 Neovim** - 总是使用 `:q` 或 `:wq` 退出，避免强制关闭终端
2. **定期清理** - 如果经常出现问题，可以添加别名快速清理
3. **监控进程** - 使用 `htop` 或 `top` 监控资源占用
4. **避免编辑超大文件** - 对于 >10MB 的文件，考虑使用其他编辑器

## 添加到 shell 配置（可选）

在 `~/.bashrc` 或 `~/.zshrc` 中添加快捷命令：

```bash
# 快速清理 nvim 进程
alias killnvim='pkill -9 nvim'

# 查看 nvim 进程
alias psnvim='ps aux | grep nvim | grep -v grep'

# 清理所有高 CPU 占用的 nvim 进程
alias killnvim-cpu='ps aux | grep nvim | awk '"'"'$3 > 50 {print $2}'"'"' | xargs kill -9'
```

使配置生效：
```bash
source ~/.bashrc  # 或 source ~/.zshrc
```

## 配置文件位置

- **主配置**: `init.lua`
- **性能优化**: `lua/core/perf.lua`
- **选项设置**: `lua/core/options.lua`
- **键位映射**: `lua/core/keymaps.lua`

## 总结

主要修复点：
- ✅ 禁用 Python/Ruby/Node.js providers（防止后台进程）
- ✅ 禁用相对行号（减少重绘）
- ✅ 优化 cursorline（仅在非插入模式）
- ✅ 增加 updatetime（减少更新频率）
- ✅ 添加语法高亮限制（防止性能问题）
- ✅ 大文件自动优化
- ✅ 禁用备份和交换文件

如果问题持续存在，请提供以下信息：
- `nvim --version` 输出
- `ps aux | grep nvim` 输出
- 正在编辑的文件大小
- 安装的插件列表
