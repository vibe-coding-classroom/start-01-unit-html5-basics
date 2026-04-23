#!/bin/bash

# Configuration
REQUIRED_FILES=("index.html" "style.css" "assets/mobile-preview.png")
POINTS_PER_STEP=25
TOTAL_SCORE=0

echo "🚀 Starting HTML5 Basics Assignment Check..."

# Step 1: File Existence
check_files() {
    echo "📂 Checking required files..."
    MISSING_FILES=0
    for file in "${REQUIRED_FILES[@]}"; do
        if [ -f "$file" ]; then
            echo "✅ Found $file"
        else
            echo "❌ Missing $file"
            MISSING_FILES=$((MISSING_FILES + 1))
        fi
    done
    [ $MISSING_FILES -eq 0 ] && return 0 || return 1
}

# Step 2: HTML Structure & Viewport
check_html() {
    echo "🌐 Checking HTML structure..."
    if [ ! -f "index.html" ]; then echo "❌ index.html missing"; return 1; fi
    if ! grep -q "<meta name=\"viewport\"" index.html; then echo "❌ Viewport meta tag missing"; return 1; fi
    if ! grep -q "href=\"style.css\"" index.html; then echo "❌ CSS link missing"; return 1; fi
    echo "✅ HTML structure looks good."
    return 0
}

# Step 3: CSS Mobile Optimizations
check_css_mobile() {
    echo "🎨 Checking CSS mobile optimizations..."
    if [ ! -f "style.css" ]; then echo "❌ style.css missing"; return 1; fi
    if ! grep -q "touch-action" style.css; then echo "❌ touch-action missing"; return 1; fi
    if ! grep -q "user-select: none" style.css; then echo "❌ user-select: none missing"; return 1; fi
    echo "✅ CSS mobile optimizations found."
    return 0
}

# Step 4: FPV Container & Layout
check_layout() {
    echo "📺 Checking FPV container styling..."
    if [ ! -f "style.css" ]; then echo "❌ style.css missing"; return 1; fi
    if ! grep -q "object-fit" style.css; then echo "❌ object-fit missing"; return 1; fi
    if ! grep -E -q "100vh|100vw" style.css; then echo "❌ 100vh/vw missing"; return 1; fi
    echo "✅ Layout styling found."
    return 0
}

case "$1" in
    files) check_files ;;
    html) check_html ;;
    css) check_css_mobile ;;
    layout) check_layout ;;
    *) 
        echo "Usage: $0 {files|html|css|layout}"
        exit 1
        ;;
esac
