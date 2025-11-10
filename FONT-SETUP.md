# 🎨 Nerd Fonts 安装指南

> 让 Neovim 显示漂亮的图标！

---

## 🎯 为什么需要 Nerd Fonts？

Nerd Fonts 包含大量图标字体，用于：

- ✨ **Markdown Typora 模式**：标题图标、列表符号、checkbox 图标
- 📁 **文件浏览器**：文件类型图标
- 📊 **状态栏**：Git 状态、LSP 状态图标
- 🎨 **更美观的界面**

**没有 Nerd Fonts 会显示问号或方块 ❌**

---

## 🚀 自动安装（推荐）

### 方法 1：使用安装脚本（最简单）

```bash
cd ~/nvim-config
./install-fonts.sh
```

脚本会：
1. 自动检测你的操作系统
2. 选择合适的安装方式
3. 安装 JetBrainsMono Nerd Font
4. 提供设置提醒

### 方法 2：运行主安装脚本

```bash
cd ~/nvim-config
./install.sh
```

安装过程中会提示是否安装 Nerd Fonts。

---

## 💻 手动安装

### macOS

#### 使用 Homebrew（推荐）

```bash
# 添加字体仓库
brew tap homebrew/cask-fonts

# 安装 JetBrainsMono Nerd Font
brew install --cask font-jetbrains-mono-nerd-font
```

#### 手动下载

1. 访问：https://github.com/ryanoasis/nerd-fonts/releases/latest
2. 下载 `JetBrainsMono.zip`
3. 解压并双击 `.ttf` 文件安装
4. 或拖到 Font Book

### Linux (Ubuntu/Debian)

```bash
# 创建字体目录
mkdir -p ~/.local/share/fonts

# 下载字体
cd /tmp
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip

# 解压到字体目录
unzip JetBrainsMono.zip -d ~/.local/share/fonts/JetBrainsMono

# 更新字体缓存
fc-cache -fv

# 清理
rm JetBrainsMono.zip
```

### Arch Linux

```bash
# 使用 yay
yay -S ttf-jetbrains-mono-nerd

# 或使用 paru
paru -S ttf-jetbrains-mono-nerd
```

### Fedora/RHEL

```bash
# 与 Ubuntu 相同的步骤
mkdir -p ~/.local/share/fonts
cd /tmp
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip JetBrainsMono.zip -d ~/.local/share/fonts/JetBrainsMono
fc-cache -fv
rm JetBrainsMono.zip
```

---

## ⚙️ 终端设置

安装字体后，**必须在终端中设置字体**：

### iTerm2 (macOS)

1. 打开 iTerm2 Preferences（`⌘,`）
2. Profiles → Text
3. Font: 选择 `JetBrainsMono Nerd Font` 或 `JetBrainsMono Nerd Font Mono`
4. 重启 iTerm2

### Terminal.app (macOS)

1. 打开 Terminal Preferences（`⌘,`）
2. Profiles → Font
3. 点击 Change
4. 选择 `JetBrainsMono Nerd Font`
5. 重启 Terminal

### GNOME Terminal (Linux)

1. 打开 Edit → Preferences
2. Profiles → 选择你的 profile
3. Text → 取消勾选 "Use system font"
4. 选择 `JetBrainsMono Nerd Font Mono`
5. 重启终端

### Alacritty

编辑 `~/.config/alacritty/alacritty.yml`:

```yaml
font:
  normal:
    family: JetBrainsMono Nerd Font
  size: 12.0
```

### Kitty

编辑 `~/.config/kitty/kitty.conf`:

```conf
font_family JetBrainsMono Nerd Font
font_size 12.0
```

### tmux

在 `~/.tmux.conf` 中添加（如果使用 tmux）:

```bash
# 确保终端支持真彩色和特殊字符
set -g default-terminal "screen-256color"
set -ga terminal-overrides ",*256col*:Tc"
```

---

## ✅ 验证安装

### 方法 1：测试文件

创建测试文件：

```bash
nvim ~/test.md
```

输入以下内容：

```markdown
# 标题测试

- 列表测试
- [ ] Checkbox 测试
- [x] 完成测试
```

按 `<Space>mr` 启用 Typora 模式。

**应该看到**：
- 标题前有图标
- 列表使用圆点符号
- Checkbox 有图标

**如果看到问号**：
- 检查终端字体设置
- 完全重启终端应用
- 确保选择的是 "Nerd Font" 版本

### 方法 2：命令行测试

```bash
echo -e "\ue0b0 \u00b1 \ue0a0 \u27a6 \u2718 \u26a1 \u2630 \ue0b2"
```

应该显示各种图标，而不是方块或问号。

---

## 🎨 推荐的 Nerd Fonts

除了 JetBrainsMono，还可以尝试：

### 编程专用

- **JetBrainsMono Nerd Font** ⭐ 推荐！清晰，易读
- **Fira Code Nerd Font** - 支持连字
- **Hack Nerd Font** - 经典选择
- **Cascadia Code Nerd Font** - 微软出品

### 个人喜好

- **Meslo Nerd Font** - 流行选择
- **Ubuntu Mono Nerd Font** - Ubuntu 风格
- **Source Code Pro Nerd Font** - Adobe 出品

### 安装其他字体

```bash
# macOS
brew install --cask font-fira-code-nerd-font
brew install --cask font-hack-nerd-font
brew install --cask font-cascadia-code-nerd-font

# 或手动下载
# 访问 https://www.nerdfonts.com/
```

---

## ❓ 常见问题

### Q1: 安装后还是显示问号？

**A:**
1. 确认字体已安装：
   ```bash
   # macOS
   ls ~/Library/Fonts/*Nerd*

   # Linux
   fc-list | grep -i "nerd"
   ```

2. **检查终端字体设置** ← 最常见的问题！
   - 必须在终端设置中选择 Nerd Font
   - 不是在 nvim 中设置

3. **完全重启终端**
   - 不是关闭窗口，而是退出应用
   - macOS: `⌘Q` 退出后重新打开

### Q2: 字体太小或太大？

**A:** 在终端设置中调整字体大小：
- iTerm2: Preferences → Profiles → Text → Font Size
- Terminal.app: Preferences → Profiles → Font → Size
- GNOME Terminal: Preferences → Profiles → Text

### Q3: 哪个 Nerd Font 变体？

Nerd Fonts 通常有多个变体：

- **Normal/Regular**: 普通宽度
- **Mono**: 等宽（推荐用于编程）
- **Propo**: 比例宽度

**推荐使用 Mono 变体**，例如：`JetBrainsMono Nerd Font Mono`

### Q4: Homebrew 安装失败？

**A:**
```bash
# 更新 Homebrew
brew update

# 重试安装
brew install --cask font-jetbrains-mono-nerd-font

# 如果还是失败，手动下载安装
```

### Q5: Linux 下字体缓存更新失败？

**A:**
```bash
# 清除字体缓存
rm -rf ~/.cache/fontconfig

# 重建缓存
fc-cache -frv

# 验证
fc-list | grep -i "nerd"
```

### Q6: WSL 如何安装？

**A:** WSL 需要在 Windows 终端中设置字体：

1. 在 Windows 上安装 Nerd Font（双击 .ttf 文件）
2. 打开 Windows Terminal 设置
3. Profiles → Defaults → Appearance
4. Font face: 选择 `JetBrainsMono Nerd Font`

---

## 🎉 完成检查清单

- [ ] 字体已安装（运行 `./install-fonts.sh` 或手动安装）
- [ ] 终端字体已设置为 Nerd Font
- [ ] 终端已完全重启
- [ ] 在 nvim 中测试 Markdown Typora 模式（`<Space>mr`）
- [ ] 图标正常显示，不是问号

**全部完成后，享受漂亮的图标吧！** ✨

---

## 📚 更多资源

- **Nerd Fonts 官网**: https://www.nerdfonts.com/
- **GitHub 仓库**: https://github.com/ryanoasis/nerd-fonts
- **图标速查**: https://www.nerdfonts.com/cheat-sheet
- **字体预览**: https://github.com/ryanoasis/nerd-fonts#font-patcher

---

## 💡 提示

- JetBrainsMono Nerd Font 是最受欢迎的选择
- 安装后必须在终端中设置字体
- 重启终端很重要
- 如果使用 tmux，确保 tmux 配置正确

**有问题？** 查看本文档或运行 `./install-fonts.sh` 获取帮助！
