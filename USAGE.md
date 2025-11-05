# 使用指南（Usage & Plugins）

## 快速上手
- 首次启动：`nvim`（lazy.nvim 会自动安装插件）。
- LSP 服务器：在 Neovim 执行 `:Mason` 安装 `pyright`、`lua_ls`、`ts_ls`（Mason 中显示为 `typescript-language-server`）等；用 `:LspInfo` 查看状态。
- AI 补全（Codeium）：执行 `:Codeium Auth` 完成鉴权。

## 常用按键（Leader = 空格）
- 通用：`<leader>w` 保存，`<leader>q` 退出，`jk` 回到普通模式。
- 文件树：`<leader>e` 切换，`<leader>ef` 定位文件，`<leader>ec` 折叠，`<leader>er` 刷新。
- 搜索（Telescope）：`<leader>ff` 查文件，`<leader>fr` 最近文件，`<leader>fs` 全局文本，`<leader>fd` 诊断。
- LSP：`K` 悬浮文档，`gd/gD/gi/gr` 跳转，`<leader>rn` 重命名，`<leader>ca` Code Action，`<leader>f` 格式化，`[d`/`]d` 诊断跳转，`<leader>d` 诊断浮窗，`gs` 签名帮助。
- Buffer：`<S-h>/<S-l>` 切换，`<leader>bd` 关闭。
- 注释：`gcc` 行注释，`gbc` 块注释（可视模式 `gc`）。
- 自动补全（nvim-cmp）：`<C-Space>` 触发，`<C-j>/<C-k>` 选择，`<Tab>/<S-Tab>` 导航/跳片段，`<CR>` 确认。
- Codeium：接受 `<C-g>`，下一条 `<C-]>`，上一条 `<C-\>`，清除 `<C-x>`。

## 插件使用
- lazy.nvim：`:Lazy` 管理插件，`:Lazy sync` 同步，`:Lazy clean` 清理未使用。
- Mason（LSP 管理）：`:Mason` 安装/更新 LSP；`i` 安装，`X` 卸载；`:LspInfo` 查看当前缓冲绑定的服务器。
- Telescope：`:Telescope find_files`、`live_grep`、`buffers`、`help_tags` 等；若 `telescope-fzf-native` 构建失败，请安装构建工具（macOS: `xcode-select --install`，Debian/Ubuntu: `sudo apt install build-essential`）。
- Nvim-tree：`:NvimTreeToggle` 切换，`:NvimTreeFindFile` 定位当前文件。
- Gitsigns：`:Gitsigns preview_hunk`、`reset_hunk`、`blame_line`、`toggle_current_line_blame`。
- Treesitter：`:TSUpdate` 更新所有解析器，`:TSInstall <lang>` 安装某语言解析器。
- nvim-cmp：已与 LSP、LuaSnip、buffer、path 源集成；支持片段跳转与 Tab 导航。
- Which-key：按下 `<leader>` 查看可用前缀键提示。
- Bufferline：`:BufferLinePick` 跳转；配合 `<S-h>/<S-l>` 切换。
- Indent guides（ibl）：`:IBLToggle` 开关缩进参考线。

## 故障排查
- 插件未加载：`:Lazy clean` → `:Lazy sync`。
- LSP 无法工作：`:Mason` 检查是否安装；`:LspInfo` 查看附着状态；确认 Node/Python 是否可用。
- 全局搜索失败：安装 ripgrep（macOS: `brew install ripgrep`，Debian/Ubuntu: `sudo apt install ripgrep`）。
