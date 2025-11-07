#!/bin/bash
# ============================================================================
# Neovim 实时监控脚本
# 持续监控 nvim 进程，当 CPU 超过阈值时自动记录详细信息
# ============================================================================

CPU_THRESHOLD=50  # CPU 占用阈值（百分比）
CHECK_INTERVAL=2   # 检查间隔（秒）
LOG_FILE="nvim-monitor-$(date +%Y%m%d-%H%M%S).log"

echo "======================================"
echo "Neovim 实时监控"
echo "======================================"
echo "CPU 阈值: ${CPU_THRESHOLD}%"
echo "检查间隔: ${CHECK_INTERVAL}秒"
echo "日志文件: $LOG_FILE"
echo ""
echo "按 Ctrl+C 停止监控"
echo "======================================"
echo ""

# 初始化日志
{
    echo "======================================"
    echo "Neovim 监控日志 - $(date)"
    echo "======================================"
    echo ""
} > "$LOG_FILE"

# 计数器
alert_count=0

while true; do
    # 获取当前时间
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')

    # 检查 nvim 进程
    nvim_procs=$(ps aux | grep -E '[n]vim')
    nvim_count=$(echo "$nvim_procs" | wc -l)

    if [ $nvim_count -gt 0 ]; then
        # 检查是否有高 CPU 占用
        high_cpu=$(echo "$nvim_procs" | awk -v threshold="$CPU_THRESHOLD" '$3 > threshold')

        if [ -n "$high_cpu" ]; then
            # 发现高 CPU 占用
            alert_count=$((alert_count + 1))

            echo "⚠ [$timestamp] 检测到高 CPU 占用！(警报 #$alert_count)"
            echo "$high_cpu" | awk '{printf "  PID: %-6s CPU: %-6s MEM: %-6s CMD: %s\n", $2, $3"%", $4"%", $11}'
            echo ""

            # 记录详细信息到日志
            {
                echo "========== 警报 #$alert_count - $timestamp =========="
                echo "高 CPU 占用进程："
                echo "$high_cpu"
                echo ""

                echo "所有 nvim 进程："
                echo "$nvim_procs"
                echo ""

                echo "进程树："
                pstree -p | grep nvim 2>/dev/null || echo "无法获取进程树"
                echo ""

                echo "Python 相关进程："
                ps aux | grep -E '[p]ython.*nvim'
                echo ""

                # 如果有 strace 可以跟踪系统调用
                for pid in $(echo "$high_cpu" | awk '{print $2}'); do
                    echo "--- PID $pid 系统调用采样 ---"
                    timeout 2 strace -c -p $pid 2>&1 || echo "无法 strace（可能需要 sudo 或未安装 strace）"
                    echo ""
                done

                echo "========================================"
                echo ""
            } >> "$LOG_FILE"

        else
            # CPU 正常
            echo "✓ [$timestamp] nvim 进程: $nvim_count, CPU 正常"
        fi
    else
        echo "  [$timestamp] 未检测到 nvim 进程"
    fi

    sleep $CHECK_INTERVAL
done
