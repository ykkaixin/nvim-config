# 📝 Markdown 编辑和预览完整指南

> 最强大的 Markdown 编辑体验！包含实时预览、表格编辑、自动列表等功能

---

## 🚀 快速开始

### 第一步：安装插件

```bash
# 拉取最新代码
git pull origin claude/fix-python-nvim-cpu-usage-011CUrFUWgDFSZWhyJdLGGrL

# 重启 nvim（首次会自动安装 Markdown 插件）
pkill -9 nvim
nvim
```

### 第二步：创建测试文件

```bash
# 创建一个 markdown 文件
nvim test.md
```

### 第三步：开始预览

在 nvim 中按快捷键：
```
<Space>mp    打开实时预览（浏览器会自动打开）
```

---

## 🎯 已安装的插件

### 1️⃣ **markdown-preview.nvim** (5.7k+ ⭐)
- ✅ 浏览器实时预览
- ✅ 自动滚动同步
- ✅ 支持 GitHub 风格
- ✅ 支持 Mermaid 图表、数学公式

### 2️⃣ **vim-markdown** (4.3k+ ⭐)
- ✅ 高级语法高亮
- ✅ 自动折叠
- ✅ 标题导航
- ✅ 目录生成

### 3️⃣ **vim-table-mode** (1.5k+ ⭐)
- ✅ 快速创建表格
- ✅ 自动对齐表格
- ✅ 公式模式

### 4️⃣ **bullets.vim** (300+ ⭐)
- ✅ 自动列表编号
- ✅ 自动缩进
- ✅ Checkbox 支持

---

## ⚡ 快捷键速查表

### 预览控制

| 快捷键 | 功能 | 说明 |
|--------|------|------|
| `<Space>mp` | 打开预览 | 在浏览器中打开实时预览 |
| `<Space>ms` | 关闭预览 | 关闭预览窗口 |
| `<Space>mt` | 切换预览 | 开/关预览 |

### 导航（仅 Markdown 文件）

| 快捷键 | 功能 |
|--------|------|
| `]]` | 跳到下一个标题 |
| `[[` | 跳到上一个标题 |
| `][` | 跳到下一个同级标题 |
| `[]` | 跳到上一个同级标题 |
| `]u` | 跳到父级标题 |
| `<Space>mo` | 显示目录 |

### 格式化

#### 加粗/斜体/代码

| 快捷键 | 模式 | 功能 | 示例 |
|--------|------|------|------|
| `<Space>mb` | 普通 | 加粗当前单词 | **word** |
| `<Space>mb` | 可视 | 加粗选中文本 | **selected** |
| `<Space>mi` | 普通 | 斜体当前单词 | *word* |
| `<Space>mi` | 可视 | 斜体选中文本 | *selected* |
| `<Space>mc` | 普通 | 代码当前单词 | `word` |
| `<Space>mc` | 可视 | 代码选中文本 | `selected` |

#### 链接和插入

| 快捷键 | 模式 | 功能 | 示例 |
|--------|------|------|------|
| `<Space>ml` | 普通 | 创建链接 | [word]() |
| `<Space>ml` | 可视 | 选中文本创建链接 | [selected]() |
| `<Space>mh` | 普通 | 插入 H1 标题 | # |
| `<Space>mH` | 普通 | 插入 H2 标题 | ## |
| `<Space>m-` | 普通 | 插入列表项 | - |
| `<Space>m[` | 普通 | 插入复选框 | - [ ] |

### 表格编辑

| 快捷键 | 功能 |
|--------|------|
| `<Space>tm` | 切换表格模式 |
| `<Space>tr` | 重新对齐表格 |
| `\|\|` (表格模式下) | 快速创建表格分隔符 |

---

## 💡 实战教程

### 🎯 教程 1：实时预览

```markdown
1. 创建文件：nvim tutorial.md
2. 输入以下内容：

# 我的第一篇文档

这是一个**测试**文档。

## 功能列表

- 实时预览
- 语法高亮
- 自动格式化

3. 按 <Space>mp 打开预览
4. 编辑文档，浏览器会自动更新！✨
```

### 🎯 教程 2：快速格式化文本

```markdown
任务：把 "重要内容" 加粗

方法 1：普通模式
1. 光标移到 "重要内容" 的任意位置
2. 按 <Space>mb
3. 完成！结果：**重要内容**

方法 2：可视模式
1. v 进入可视模式
2. 选中 "重要内容"
3. 按 <Space>mb
4. 完成！结果：**重要内容**
```

### 🎯 教程 3：创建完美对齐的表格

```markdown
1. 按 <Space>tm 启用表格模式
2. 输入：

| 姓名 | 年龄 | 城市 |

3. 按 Enter，然后输入 ||（两个竖线）
4. 自动生成分隔符：

| 姓名 | 年龄 | 城市 |
|------|------|------|

5. 继续输入数据：

| 姓名 | 年龄 | 城市 |
|------|------|------|
| 张三 | 25 | 北京 |
| 李四 | 30 | 上海 |

6. 表格会自动对齐！✨
```

### 🎯 教程 4：自动列表编号

```markdown
1. 输入：- 第一项
2. 按 Enter
3. 自动创建：- （光标在这里）
4. 输入：第二项
5. 按 Enter
6. 继续自动创建列表项！

结果：
- 第一项
- 第二项
- 第三项
```

### 🎯 教程 5：任务清单（Checkbox）

```markdown
1. 按 <Space>m[ 插入复选框
2. 输入任务内容

- [ ] 学习 Markdown
- [ ] 写文档
- [ ] 完成项目

3. 在行内按 Ctrl+d 切换状态：
- [x] 学习 Markdown  ← 完成！
- [ ] 写文档
- [ ] 完成项目
```

### 🎯 教程 6：标题导航

```markdown
假设你有一个长文档：

# 第一章
## 1.1 节
### 细节
## 1.2 节

# 第二章
## 2.1 节

导航技巧：
1. 按 ]] → 跳到下一个标题（任何级别）
2. 按 ][ → 跳到下一个同级标题
3. 按 ]u → 跳到父级标题
4. 按 <Space>mo → 显示整个文档目录
```

### 🎯 教程 7：创建链接

```markdown
方法 1：当前单词
1. 光标在 "GitHub" 上
2. 按 <Space>ml
3. 结果：[GitHub]()
4. 在括号里输入 URL：[GitHub](https://github.com)

方法 2：选中文本
1. v 进入可视模式
2. 选中 "点击这里"
3. 按 <Space>ml
4. 结果：[点击这里]()
5. 添加 URL：[点击这里](https://example.com)
```

### 🎯 教程 8：代码块高亮

```markdown
在预览中，代码块会自动语法高亮：

```python
def hello():
    print("Hello, World!")
```

支持的语言：
- Python, JavaScript, TypeScript
- Java, C, C++, Rust, Go
- Bash, SQL, YAML, JSON
- 以及更多...
```

### 🎯 教程 9：Mermaid 图表

```markdown
在 Markdown 文件中输入：

```mermaid
graph TD
    A[开始] --> B{判断}
    B -->|是| C[执行]
    B -->|否| D[结束]
    C --> D
```

按 <Space>mp 预览，会自动渲染成漂亮的流程图！
```

### 🎯 教程 10：数学公式

```markdown
行内公式：$E = mc^2$

块级公式：

$$
\frac{-b \pm \sqrt{b^2 - 4ac}}{2a}
$$

在预览中会自动渲染！
```

---

## 🎨 高级技巧

### 技巧 1：折叠长文档

```markdown
# 长标题
一大段内容...
一大段内容...

1. 光标移到标题上
2. 按 za → 折叠/展开这一节
3. 按 zM → 折叠所有
4. 按 zR → 展开所有
```

### 技巧 2：快速插入代码块

```markdown
1. 输入 ```python
2. 按 Enter
3. 写代码
4. 按 Enter
5. 输入 ```
```

### 技巧 3：表格快速输入

```markdown
启用表格模式后：
1. | 自动添加右侧的 |
2. || 自动创建分隔符
3. Tab 跳到下一个单元格
4. Enter 创建新行
```

### 技巧 4：自动编号列表

```markdown
输入：
1. 第一项
   （按 Enter）
2. （自动编号！）第二项
   （按 Enter）
3. 第三项
```

### 技巧 5：多级列表缩进

```markdown
- 一级
  （按 Tab）
  - 二级
    （按 Tab）
    - 三级
```

---

## 📋 完整快捷键列表

### 全局快捷键（所有文件）

```
=== 预览 ===
<Space>mp       打开预览
<Space>ms       关闭预览
<Space>mt       切换预览

=== 表格 ===
<Space>tm       切换表格模式
<Space>tr       重新对齐表格
```

### Markdown 文件专用快捷键

```
=== 导航 ===
]]              下一个标题
[[              上一个标题
][              下一个同级标题
[]              上一个同级标题
]u              父级标题
<Space>mo       显示目录

=== 格式化 ===
<Space>mb       加粗（普通/可视）
<Space>mi       斜体（普通/可视）
<Space>mc       代码（普通/可视）
<Space>ml       创建链接（普通/可视）

=== 插入 ===
<Space>mh       插入 H1 (#)
<Space>mH       插入 H2 (##)
<Space>m-       插入列表项 (-)
<Space>m[       插入复选框 (- [ ])

=== 折叠 ===
za              切换折叠
zM              折叠全部
zR              展开全部
```

---

## 🎁 特性总览

### ✨ 实时预览
- ✅ 浏览器自动打开
- ✅ 编辑即时同步
- ✅ 滚动位置同步
- ✅ 暗色主题

### ✨ 语法增强
- ✅ GitHub 风格高亮
- ✅ Front matter 支持（YAML/TOML/JSON）
- ✅ 代码块语法高亮
- ✅ 数学公式渲染（LaTeX）
- ✅ Mermaid 图表支持

### ✨ 编辑增强
- ✅ 自动列表续写
- ✅ 自动编号
- ✅ 自动缩进
- ✅ Checkbox 切换
- ✅ 表格自动对齐
- ✅ 智能折叠

### ✨ 导航增强
- ✅ 标题快速跳转
- ✅ 目录显示
- ✅ 同级标题导航
- ✅ 父子标题导航

---

## 🔧 自定义配置

### 更改预览主题

编辑 `lua/plugins/markdown.lua`：

```lua
-- 主题：dark 或 light
vim.g.mkdp_theme = 'light'  -- 改成浅色主题
```

### 更改默认浏览器

```lua
-- 'chrome', 'firefox', 'safari', etc
vim.g.mkdp_browser = 'firefox'
```

### 禁用自动滚动同步

```lua
vim.g.mkdp_preview_options = {
  disable_sync_scroll = 1,  -- 禁用同步滚动
}
```

### 自定义表格样式

编辑 `lua/plugins/init.lua` 中的 vim-table-mode 部分：

```lua
-- 使用不同的表格角字符
vim.g.table_mode_corner = '+'
vim.g.table_mode_corner_corner = '+'
vim.g.table_mode_header_fillchar = '='
```

---

## ❓ 常见问题

### Q1: 预览窗口没有打开？

**A:** 检查：
1. 是否在 Markdown 文件中（文件名以 `.md` 结尾）
2. 是否安装了浏览器
3. 运行 `:messages` 查看错误信息
4. 重启 nvim 并运行 `:Lazy sync`

### Q2: 表格没有自动对齐？

**A:**
1. 确保已启用表格模式：`<Space>tm`
2. 或者手动对齐：`<Space>tr`

### Q3: 列表没有自动续写？

**A:**
1. 确保在 Markdown 文件中
2. bullets.vim 只在特定文件类型中启用
3. 检查 `:set filetype` 确认是 `markdown`

### Q4: 快捷键 `]]` 不工作？

**A:**
1. 在 Markdown 文件中，`]]` 是跳转到下一个标题
2. 在其他文件中，`]]` 是 vim-illuminate 的跳转引用
3. 确认文件类型：`:set filetype`

### Q5: 预览不同步？

**A:**
1. 确保 `disable_sync_scroll` 设置为 0
2. 重启预览：`<Space>ms` 然后 `<Space>mp`

### Q6: 数学公式不渲染？

**A:**
- markdown-preview 默认支持 LaTeX
- 使用 `$...$` 表示行内公式
- 使用 `$$...$$` 表示块级公式

---

## 🚀 性能优化

所有 Markdown 插件都采用**懒加载**：
- ✅ 只在打开 `.md` 文件时加载
- ✅ 不影响其他文件类型的性能
- ✅ 零 CPU 消耗（在非 Markdown 文件中）

---

## 📚 更多资源

### 插件文档

- [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)
- [vim-markdown](https://github.com/preservim/vim-markdown)
- [vim-table-mode](https://github.com/dhruvasagar/vim-table-mode)
- [bullets.vim](https://github.com/dkarter/bullets.vim)

### Markdown 语法

- [GitHub Markdown 指南](https://guides.github.com/features/mastering-markdown/)
- [Markdown 官方文档](https://www.markdownguide.org/)

### Mermaid 图表

- [Mermaid 文档](https://mermaid-js.github.io/mermaid/)
- [在线编辑器](https://mermaid.live/)

---

## 🎉 总结

现在你拥有了**最强大的 Markdown 编辑环境**：

✅ 实时预览（像 Typora 一样）
✅ 快速格式化（一键加粗、斜体、链接）
✅ 完美表格（自动对齐）
✅ 智能列表（自动编号、缩进）
✅ 快速导航（标题跳转、目录）
✅ 零性能消耗（懒加载）

开始享受丝滑的 Markdown 写作体验吧！📝✨

---

**提示**：建议把 `MARKDOWN-GUIDE.md` 作为你的第一个测试文件，用 `<Space>mp` 打开预览看效果！
