-- Markdown Preview Configuration
-- https://github.com/iamcco/markdown-preview.nvim

-- 设置浏览器
-- 'chrome', 'firefox', 'safari', 等
-- 留空使用系统默认浏览器
vim.g.mkdp_browser = ''

-- 打开预览时自动打开浏览器
vim.g.mkdp_auto_start = 0

-- 切换到其他 buffer 时自动关闭预览
vim.g.mkdp_auto_close = 1

-- 刷新 markdown 时重新渲染（设为 0 可提高性能）
vim.g.mkdp_refresh_slow = 0

-- 指定浏览器打开的命令
vim.g.mkdp_command_for_global = 0

-- 在所有文件中启用预览（设为 0 仅在 markdown 文件中启用）
vim.g.mkdp_open_to_the_world = 0

-- 预览服务器的 IP 地址
vim.g.mkdp_open_ip = ''

-- 指定端口（留空则自动选择）
vim.g.mkdp_port = ''

-- 使用自定义的 markdown 样式
-- 绝对路径或者相对路径都可以
vim.g.mkdp_markdown_css = ''

-- 使用自定义的高亮样式
vim.g.mkdp_highlight_css = ''

-- 启用内容同步滚动，0 为关闭
vim.g.mkdp_preview_options = {
  mkit = {},
  katex = {},
  uml = {},
  maid = {},
  disable_sync_scroll = 0,
  sync_scroll_type = 'middle',
  hide_yaml_meta = 1,
  sequence_diagrams = {},
  flowchart_diagrams = {},
  content_editable = false,
  disable_filename = 0,
  toc = {}
}

-- 使用自定义的 markdown 渲染器
vim.g.mkdp_markdown_renderer = ''

-- 识别的文件类型
vim.g.mkdp_filetypes = {'markdown'}

-- 主题：dark 或 light
vim.g.mkdp_theme = 'dark'

-- 结合 mkdp_auto_start = 1，只在指定的文件类型中自动打开
vim.g.mkdp_combine_preview = 0

-- 自动滚动到光标位置
vim.g.mkdp_combine_preview_auto_refresh = 1
