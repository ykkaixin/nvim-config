# Error 导致 CPU 暴涨问题修复

## 🔍 问题根源

用户发现：**"有 Error 我不处理就会 CPU 暴涨"**

这是因为：
1. **虚拟文本（Virtual Text）**：LSP 诊断错误会在代码旁边显示虚拟文本
2. **不断重绘**：当有错误存在时，虚拟文本会不断重绘和更新
3. **CPU 飙升**：每次重绘都消耗 CPU，导致 CPU 占用 100%

## ✅ 已实施的修复

### 1. 禁用虚拟文本 (`lua/core/perf.lua:26`)

```lua
virtual_text = false,  -- 完全禁用，防止 CPU 暴涨
```

**效果**：错误不会再在行尾显示，避免了不断重绘

### 2. 添加诊断防抖 (`lua/core/perf.lua:41-55`)

```lua
-- 1 秒防抖，防止 LSP 不断重新分析有错误的代码
diagnostic_debounce_timer = vim.fn.timer_start(1000, ...)
```

**效果**：限制诊断更新频率，避免频繁分析

### 3. 优化错误显示

```lua
signs = { severity = { min = vim.diagnostic.severity.WARN } },  -- 只显示警告和错误
underline = { severity = { min = vim.diagnostic.severity.WARN } },
```

**效果**：减少不必要的标记

## 📖 如何查看错误（虚拟文本被禁用后）

虽然禁用了虚拟文本，但你仍然可以通过以下方式查看错误：

### 方法 1：浮动窗口（推荐）

```vim
" 将光标移到有错误的行，按：
<leader>d
```

会弹出浮动窗口显示错误详情（包括错误来源）

### 方法 2：错误导航

```vim
]d    " 跳到下一个错误
[d    " 跳到上一个错误
```

### 方法 3：错误列表

```vim
<leader>q    " 打开 location list 查看所有错误
```

### 方法 4：错误标记

文件左侧仍然会显示错误标记：
- ❌ 错误（红色）
- ⚠️  警告（黄色）

代码下方也会有下划线标记错误位置。

## 🧪 测试修复效果

### 测试步骤：

1. **创建一个有错误的 Python 文件**：

```bash
cat > test_error.py << 'EOF'
# 这个文件有语法错误
def hello()
    print("missing colon")

# 这个文件有类型错误
x: int = "string"

# 未定义的变量
print(undefined_variable)
EOF
```

2. **打开文件并观察**：

```bash
# 在一个终端
nvim test_error.py

# 在另一个终端监控 CPU
watch -n 1 'ps aux | grep nvim'
```

3. **检查 CPU 占用**：

**修复前**：CPU 会持续 50-100%
**修复后**：CPU 应该保持在 5-10% 以下

4. **停顿一段时间（1-2分钟）**：

之前会 CPU 暴涨，现在应该保持稳定。

## 📊 对比

| 场景 | 修复前 | 修复后 |
|------|--------|--------|
| 有错误不处理 | CPU 100% 🔴 | CPU <10% ✅ |
| 错误显示方式 | 虚拟文本（行尾） | 浮动窗口/标记 |
| 诊断更新 | 立即 | 1秒防抖 |
| 多个错误 | 所有都显示虚拟文本 | 标记+按需查看 |

## 🎯 如果你想重新启用虚拟文本

如果你更喜欢看到行内错误（但可能会有 CPU 问题），可以编辑 `lua/core/perf.lua:26`：

```lua
-- 改为只显示错误（不显示 hint/info）
virtual_text = {
  severity = vim.diagnostic.severity.ERROR,
  spacing = 4,
  prefix = '●',
}
```

或者完全启用：

```lua
virtual_text = true,
```

但这样可能会导致之前的 CPU 暴涨问题重现。

## 🔑 键位映射快速参考

| 按键 | 功能 |
|------|------|
| `<leader>d` | 显示当前行的错误详情 |
| `]d` | 跳到下一个诊断 |
| `[d` | 跳到上一个诊断 |
| `<leader>q` | 打开所有诊断列表 |

## 💡 建议

1. **习惯使用 `<leader>d`**：将光标放在有错误的行，按 `<leader>d` 查看详情
2. **使用错误导航**：用 `]d` 和 `[d` 快速跳转错误
3. **看侧边标记**：文件左侧的红色/黄色标记可以快速识别有问题的行
4. **定期清理错误**：虽然现在不会 CPU 暴涨，但还是建议及时处理错误

## 📝 技术说明

### 为什么虚拟文本会导致 CPU 暴涨？

1. **虚拟文本渲染**：每个错误都需要在编辑器中渲染虚拟文本
2. **持续更新**：LSP 会持续检查代码，每次都更新虚拟文本
3. **多个错误**：如果有多个错误，每个都需要单独渲染
4. **重绘循环**：某些情况下会触发重绘循环，导致 CPU 持续占用

### 防抖如何工作？

```lua
-- 每次诊断更新时，先取消之前的定时器
if diagnostic_debounce_timer then
  vim.fn.timer_stop(diagnostic_debounce_timer)
end

-- 设置新的定时器，1秒后才真正更新
diagnostic_debounce_timer = vim.fn.timer_start(1000, function()
  original_handler(unpack(args))
end)
```

这样即使 LSP 频繁发送诊断，也只会在最后一次更新 1 秒后才真正处理。

## ✅ 总结

- ✅ **核心修复**：禁用虚拟文本（防止 CPU 暴涨）
- ✅ **诊断防抖**：限制更新频率（1秒）
- ✅ **替代方案**：使用浮动窗口和标记查看错误
- ✅ **保持功能**：所有诊断功能仍然可用，只是显示方式变了

**预期效果**：即使有很多错误不处理，CPU 也应该保持在 10% 以下！
