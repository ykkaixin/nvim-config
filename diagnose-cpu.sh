#!/bin/bash
# ============================================================================
# Neovim CPU 占用问题诊断脚本
# 收集所有必要的调试信息
# ============================================================================

OUTPUT_FILE="nvim-diagnostics-$(date +%Y%m%d-%H%M%S).txt"

echo "======================================"
echo "Neovim CPU 占用问题诊断"
echo "======================================"
echo ""
echo "正在收集信息，请稍候..."
echo ""

{
    echo "======================================"
    echo "诊断报告 - $(date)"
    echo "======================================"
    echo ""

    # 1. Neovim 版本信息
    echo "========== 1. Neovim 版本 =========="
    nvim --version 2>/dev/null || echo "未安装 nvim"
    echo ""

    # 2. 当前运行的 nvim 进程
    echo "========== 2. 当前 nvim 进程 =========="
    ps aux | grep -E '[n]vim' | head -20
    echo ""
    echo "进程总数: $(ps aux | grep -E '[n]vim' | wc -l)"
    echo ""

    # 3. 详细的进程信息（包括 CPU、内存、运行时间）
    echo "========== 3. 详细进程信息 =========="
    echo "USER       PID  %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND"
    ps aux | grep -E '[n]vim' | awk '{printf "%-10s %-6s %-5s %-4s %7s %6s %-8s %-4s %-7s %-7s %s\n", $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11}'
    echo ""

    # 4. Python 相关进程
    echo "========== 4. Python 相关进程 =========="
    ps aux | grep -E '[p]ython.*nvim' | head -20
    echo ""
    echo "Python 进程总数: $(ps aux | grep -E '[p]ython.*nvim' | wc -l)"
    echo ""

    # 5. 系统资源占用
    echo "========== 5. 系统资源概览 =========="
    echo "CPU 核心数: $(nproc 2>/dev/null || echo "未知")"
    echo "内存信息:"
    free -h 2>/dev/null || echo "无法获取内存信息"
    echo ""
    echo "负载均衡:"
    uptime 2>/dev/null || echo "无法获取负载信息"
    echo ""

    # 6. Neovim 配置文件位置
    echo "========== 6. 配置文件位置 =========="
    echo "当前目录: $(pwd)"
    echo ""
    if [ -f "init.lua" ]; then
        echo "✓ 找到 init.lua"
        ls -lh init.lua
    fi
    if [ -f "$HOME/.config/nvim/init.lua" ]; then
        echo "✓ 找到 ~/.config/nvim/init.lua"
        ls -lh "$HOME/.config/nvim/init.lua"
    fi
    if [ -f "$HOME/.vimrc" ]; then
        echo "✓ 找到 ~/.vimrc"
        ls -lh "$HOME/.vimrc"
    fi
    echo ""

    # 7. Lua 模块列表
    echo "========== 7. Lua 配置模块 =========="
    if [ -d "lua" ]; then
        find lua -name "*.lua" -type f 2>/dev/null
    else
        echo "未找到 lua 目录"
    fi
    echo ""

    # 8. 插件列表（lazy.nvim）
    echo "========== 8. 已安装插件 =========="
    if [ -f "lazy-lock.json" ]; then
        echo "✓ 找到 lazy-lock.json"
        cat lazy-lock.json 2>/dev/null | head -50
    else
        echo "未找到 lazy-lock.json"
    fi
    echo ""

    # 9. LSP 日志
    echo "========== 9. LSP 日志 =========="
    if [ -f "$HOME/.local/state/nvim/lsp.log" ]; then
        echo "✓ LSP 日志最后 50 行:"
        tail -50 "$HOME/.local/state/nvim/lsp.log" 2>/dev/null
    else
        echo "未找到 LSP 日志文件"
    fi
    echo ""

    # 10. Neovim 日志
    echo "========== 10. Neovim 日志 =========="
    if [ -f ".nvimlog" ]; then
        echo "✓ 本地 .nvimlog 最后 50 行:"
        tail -50 .nvimlog 2>/dev/null
    fi
    if [ -f "$HOME/.local/state/nvim/log" ]; then
        echo "✓ Neovim 日志最后 50 行:"
        tail -50 "$HOME/.local/state/nvim/log" 2>/dev/null
    fi
    echo ""

    # 11. Mason 已安装的 LSP
    echo "========== 11. Mason LSP 服务器 =========="
    if [ -d "$HOME/.local/share/nvim/mason/bin" ]; then
        echo "已安装的 LSP 服务器:"
        ls -1 "$HOME/.local/share/nvim/mason/bin" 2>/dev/null
    else
        echo "未找到 Mason 安装目录"
    fi
    echo ""

    # 12. Python 环境
    echo "========== 12. Python 环境 =========="
    echo "Python3 版本:"
    python3 --version 2>/dev/null || echo "未安装 python3"
    echo ""
    echo "pynvim 状态:"
    python3 -m pip show pynvim 2>/dev/null || echo "未安装 pynvim"
    echo ""

    # 13. 进程树
    echo "========== 13. 进程树 =========="
    pstree -p | grep nvim 2>/dev/null || echo "无法获取进程树（未安装 pstree）"
    echo ""

    # 14. 打开的文件描述符
    echo "========== 14. Neovim 打开的文件 =========="
    for pid in $(pgrep nvim); do
        echo "--- PID $pid ---"
        lsof -p $pid 2>/dev/null | head -30 || echo "无法获取（未安装 lsof 或权限不足）"
        echo ""
    done

    # 15. 性能优化设置检查
    echo "========== 15. 性能优化设置检查 =========="
    if [ -f "lua/core/perf.lua" ]; then
        echo "✓ 找到 lua/core/perf.lua"
        echo "Provider 禁用状态:"
        grep "loaded_python" lua/core/perf.lua 2>/dev/null || echo "未找到 provider 设置"
    else
        echo "⚠ 未找到 lua/core/perf.lua"
    fi
    echo ""

    if [ -f "lua/core/options.lua" ]; then
        echo "✓ 找到 lua/core/options.lua"
        echo "关键性能设置:"
        grep -E "relativenumber|updatetime|lazyredraw" lua/core/options.lua 2>/dev/null || echo "未找到性能设置"
    fi
    echo ""

    # 16. 最近修改的文件
    echo "========== 16. 最近修改的配置文件 =========="
    find . -name "*.lua" -o -name "*.vim" -o -name ".vimrc" 2>/dev/null | xargs ls -lt 2>/dev/null | head -10
    echo ""

    echo "======================================"
    echo "诊断完成！"
    echo "======================================"

} > "$OUTPUT_FILE"

echo "✓ 诊断信息已保存到: $OUTPUT_FILE"
echo ""
echo "======================================"
echo "关键信息预览："
echo "======================================"
echo ""

# 显示关键信息
echo "1. 当前运行的 nvim 进程数:"
ps aux | grep -E '[n]vim' | wc -l

echo ""
echo "2. 高 CPU 占用的进程 (>50%):"
ps aux | grep -E '[n]vim' | awk '$3 > 50 {print "PID:", $2, "CPU:", $3"%", "CMD:", $11}'

echo ""
echo "3. Neovim 版本:"
nvim --version 2>/dev/null | head -1

echo ""
echo "======================================"
echo "请将文件 '$OUTPUT_FILE' 发送给开发者"
echo "或粘贴文件内容以获取帮助"
echo "======================================"
