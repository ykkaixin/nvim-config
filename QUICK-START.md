# 🎓 IntelliJ 风格功能 - 快速入门教程

## 📥 第一步：应用更新

```bash
# 1. 拉取最新代码
git pull origin claude/fix-python-nvim-cpu-usage-011CUrFUWgDFSZWhyJdLGGrL

# 2. 重启 nvim（首次会自动安装插件）
pkill -9 nvim
nvim

# 3. 等待插件安装（首次启动需要等待 10-30 秒）
# 你会看到底部状态栏显示 "Installing plugins..."
```

---

## 🎯 第二步：创建测试文件

打开一个 Python 文件测试功能：

```bash
nvim test_example.py
```

复制这段代码进去（按 `i` 进入插入模式，粘贴后按 `Esc` 退出）：

```python
def calculate_total(price, tax_rate, discount):
    """计算商品总价"""
    # 计算税额
    tax_amount = price * tax_rate

    # 计算折扣后的价格
    discounted_price = price - discount

    # 计算最终总价
    total = discounted_price + tax_amount

    # 打印调试信息
    print(f"Price: {price}")
    print(f"Tax: {tax_amount}")
    print(f"Total: {total}")

    return total

def apply_coupon(price, coupon_code):
    """应用优惠券"""
    if coupon_code == "SAVE10":
        price = price * 0.9
    elif coupon_code == "SAVE20":
        price = price * 0.8

    return price

# 测试代码
result = calculate_total(100, 0.1, 5)
final_price = apply_coupon(result, "SAVE10")
print(f"Final price: {final_price}")
```

---

## ⭐ 功能 1：自动变量高亮（最常用！）

### 如何使用：

1. **普通模式**下，把光标移到任意变量上（比如第 6 行的 `price`）
2. **等待 100ms**，你会看到：
   - 所有 `price` 都会自动高亮显示 ✨
   - 只高亮真正的变量引用（不会高亮注释、字符串里的）

### 快速跳转：

```
]]    按两次右方括号 - 跳到下一个 price
[[    按两次左方括号 - 跳回上一个 price
```

### 💡 实战演示：

```
1. 光标移到第 3 行的 "price" → 自动高亮所有 price
2. 按 ]]  → 跳到第 6 行的 price
3. 按 ]]  → 跳到第 9 行的 price
4. 按 [[  → 跳回第 6 行的 price
```

---

## ⭐ 功能 2：快速选择代码块

### 选择函数：

```
vaf    - 选择整个函数（包括 def 和函数体）
vif    - 选择函数内部（不包括 def 那一行）
```

### 💡 实战演示：

```
1. 光标移到第 2 行 calculate_total 函数里
2. 按 vaf  → 选中整个函数（第 2-15 行）
3. 按 Esc  → 取消选择
4. 按 vif  → 只选中函数体（第 3-15 行）
5. 按 d    → 删除函数体（演示用，可以按 u 撤销）
```

### 选择参数：

```
vaa    - 选择参数（包括逗号）
via    - 选择参数内容（不包括逗号）
```

### 💡 实战演示：

```
1. 光标移到第 2 行的 "tax_rate" 上
2. 按 vaa  → 选中 "tax_rate, "（包括后面的逗号和空格）
3. 按 Esc  → 取消
4. 按 via  → 只选中 "tax_rate"（不包括逗号）
```

---

## ⭐ 功能 3：快速跳转函数/类

### 快捷键：

```
]f    - 跳到下一个函数
[f    - 跳到上一个函数
]c    - 跳到下一个类（如果有）
[c    - 跳到上一个类
```

### 💡 实战演示：

```
1. 光标在文件开头
2. 按 ]f  → 跳到第 2 行 calculate_total 函数
3. 按 ]f  → 跳到第 17 行 apply_coupon 函数
4. 按 [f  → 跳回 calculate_total 函数
```

---

## ⭐ 功能 4：交换参数位置

### 快捷键：

```
<Space>sa    - 和下一个参数交换
<Space>sA    - 和上一个参数交换
```

### 💡 实战演示：

```
1. 光标移到第 2 行的 "price" 上
2. 按 空格 + s + a  → price 和 tax_rate 交换位置
   结果：def calculate_total(tax_rate, price, discount):
3. 按 u  → 撤销回来
```

---

## ⭐ 功能 5：查看错误详情（VSCode 风格）

### 如何使用：

1. 写错代码（比如删除第 6 行末尾的冒号）
2. **光标停在错误行上，等待 2 秒**
3. 自动弹出错误详情窗口 📋

### 手动查看错误：

```
<Space>e     - 显示当前行错误详情
<Space>q     - 显示所有错误列表
]d           - 跳到下一个错误
[d           - 跳到上一个错误
```

---

## 📋 快捷键速查表

### 变量高亮 & 跳转：
| 快捷键 | 功能 |
|--------|------|
| `光标停留` | 自动高亮变量 |
| `]]` | 下一个引用 |
| `[[` | 上一个引用 |

### 选择代码：
| 快捷键 | 功能 | 示例 |
|--------|------|------|
| `vaf` | 选择整个函数 | 包括 def |
| `vif` | 选择函数内部 | 不包括 def |
| `vac` | 选择整个类 | 包括 class |
| `vic` | 选择类内部 | 不包括 class |
| `vaa` | 选择参数（含逗号） | `tax_rate, ` |
| `via` | 选择参数（不含） | `tax_rate` |

### 快速导航：
| 快捷键 | 功能 |
|--------|------|
| `]f` | 下一个函数 |
| `[f` | 上一个函数 |
| `]c` | 下一个类 |
| `[c` | 上一个类 |

### 代码操作：
| 快捷键 | 功能 |
|--------|------|
| `<Space>sa` | 与下一参数交换 |
| `<Space>sA` | 与上一参数交换 |

### 错误诊断：
| 快捷键 | 功能 |
|--------|------|
| `光标停留 2 秒` | 自动显示错误 |
| `<Space>e` | 手动显示错误 |
| `]d` | 下一个错误 |
| `[d` | 上一个错误 |

---

## 🎯 实战练习

### 练习 1：重命名变量（使用变量高亮）

```
任务：把所有 "price" 改成 "amount"

1. 光标移到任意 "price" 上
2. 按 ]]  → 跳转到每个 price
3. 按 ciw → 删除当前单词并进入插入模式
4. 输入 amount
5. 按 Esc
6. 重复步骤 2-5 直到改完所有
```

### 练习 2：调整函数参数顺序

```
任务：把 calculate_total(price, tax_rate, discount)
     改成 calculate_total(discount, price, tax_rate)

1. 光标移到 "price"
2. 按 <Space>sA  → price 移到最前面
3. 光标移到 "tax_rate"
4. 按 <Space>sA  → tax_rate 往前移
5. 完成！
```

### 练习 3：快速删除函数

```
任务：删除 apply_coupon 函数

1. 按 ]f ]f  → 跳到 apply_coupon 函数
2. 按 vaf    → 选中整个函数
3. 按 d      → 删除
4. 按 u      → 撤销（练习用）
```

---

## ❓ 常见问题

### Q1: 变量高亮没有自动显示？

**A:** 等待 100ms，如果还是没有：
- 确保安装了 LSP（Python 需要 pyright）
- 运行 `:Lazy sync` 重新安装插件
- 重启 nvim

### Q2: 快捷键不生效？

**A:** 检查是否在**普通模式**（按 `Esc` 确保退出插入模式）

### Q3: 错误详情不自动弹出？

**A:**
- 光标需要停留在错误行上 2 秒
- 或者手动按 `<Space>e` 显示

### Q4: `vaf` 选不中函数？

**A:**
- 光标必须在函数内部（第 2-15 行之间）
- 不能在函数外面

---

## 🚀 下一步

熟练使用后，你会发现：

1. **不再需要手动搜索变量**：光标一停就自动高亮 ✨
2. **重构代码超快**：vaf 选中 → 复制 → 粘贴
3. **导航飞快**：]f [f 跳来跳去
4. **零性能消耗**：所有功能都不会导致 CPU 暴涨

享受 IntelliJ IDEA 级别的编辑体验吧！🎉

---

## 📚 更多信息

- 详细功能说明：`INTELLIJ-FEATURES.md`
- CPU 优化说明：`ERROR-CPU-FIX.md`
- 完整快捷键列表：`lua/core/keymaps.lua`

有问题随时问我！💪
