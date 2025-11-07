#!/bin/bash
# ============================================================================
# Neovim 进程清理脚本
# 用于杀死占用高 CPU 的多余 nvim 进程
# ============================================================================

echo "======================================"
echo "正在检查 Neovim 进程..."
echo "======================================"
echo ""

# 显示所有 nvim 相关进程
echo "当前运行的 nvim 进程："
ps aux | grep -E '[n]vim|[p]ython.*nvim' | awk '{printf "%-10s %-8s %-8s %s\n", $1, $2, $3, $11}'
echo ""

# 统计进程数量
nvim_count=$(ps aux | grep -E '[n]vim' | wc -l)
python_nvim_count=$(ps aux | grep -E '[p]ython.*nvim' | wc -l)

echo "发现 $nvim_count 个 nvim 进程"
echo "发现 $python_nvim_count 个 Python nvim 相关进程"
echo ""

if [ $nvim_count -eq 0 ] && [ $python_nvim_count -eq 0 ]; then
    echo "✓ 没有发现 nvim 进程"
    exit 0
fi

# 询问用户是否要杀死所有进程
echo "======================================"
echo "选项："
echo "1) 杀死所有 nvim 进程"
echo "2) 杀死高 CPU 占用的 nvim 进程 (>50%)"
echo "3) 仅显示进程，不杀死"
echo "4) 退出"
echo "======================================"
read -p "请选择 (1-4): " choice

case $choice in
    1)
        echo "正在杀死所有 nvim 进程..."
        pkill -9 nvim
        # 杀死相关的 Python 进程
        ps aux | grep -E '[p]ython.*nvim' | awk '{print $2}' | xargs -r kill -9 2>/dev/null
        echo "✓ 完成"
        ;;
    2)
        echo "正在杀死高 CPU 占用的 nvim 进程..."
        # 找出 CPU 占用超过 50% 的进程并杀死
        ps aux | grep -E '[n]vim' | awk '$3 > 50 {print $2}' | xargs -r kill -9 2>/dev/null
        ps aux | grep -E '[p]ython.*nvim' | awk '$3 > 50 {print $2}' | xargs -r kill -9 2>/dev/null
        echo "✓ 完成"
        ;;
    3)
        echo "仅显示进程信息，不进行操作"
        ;;
    4)
        echo "退出"
        exit 0
        ;;
    *)
        echo "无效的选择"
        exit 1
        ;;
esac

echo ""
echo "======================================"
echo "清理后的进程状态："
echo "======================================"
ps aux | grep -E '[n]vim|[p]ython.*nvim' | awk '{printf "%-10s %-8s %-8s %s\n", $1, $2, $3, $11}' || echo "✓ 没有 nvim 进程"
