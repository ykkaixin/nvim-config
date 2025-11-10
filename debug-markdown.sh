#!/bin/bash

echo "=== Markdown Preview 诊断工具 ==="
echo ""

echo "1. 检查 Node.js/npm..."
if command -v npm &> /dev/null; then
    echo "✅ npm 已安装: $(npm --version)"
else
    echo "❌ npm 未安装 - 需要安装 Node.js"
fi
echo ""

echo "2. 检查插件目录..."
PLUGIN_DIR="$HOME/.local/share/nvim/lazy/markdown-preview.nvim"
if [ -d "$PLUGIN_DIR" ]; then
    echo "✅ 插件目录存在: $PLUGIN_DIR"

    if [ -d "$PLUGIN_DIR/app/node_modules" ]; then
        echo "✅ node_modules 已安装"
    else
        echo "❌ node_modules 不存在 - 需要构建"
        echo "   运行: cd $PLUGIN_DIR/app && npm install"
    fi
else
    echo "❌ 插件目录不存在"
    echo "   在 nvim 中运行: :Lazy sync"
fi
echo ""

echo "3. 检查配置文件..."
if [ -f "$HOME/nvim-config/lua/plugins/markdown.lua" ]; then
    echo "✅ markdown.lua 配置存在"
else
    echo "❌ markdown.lua 配置不存在"
fi
echo ""

echo "4. 建议操作:"
echo "   1) 在 nvim 中运行: :Lazy sync"
echo "   2) 打开 markdown 文件: nvim test.md"
echo "   3) 检查插件状态: :Lazy"
echo "   4) 查看错误信息: :messages"
echo "   5) 手动触发预览: :MarkdownPreview"
echo ""
