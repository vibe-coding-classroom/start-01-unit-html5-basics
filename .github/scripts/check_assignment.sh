#!/bin/bash

# Configuration
REQUIRED_FILES=("index.html" "style.css" "assets/mobile-preview.png")
POINTS_PER_STEP=25
TOTAL_SCORE=0

echo "🚀 Starting HTML5 Basics Assignment Check..."

# Step 1: File Existence (25 points)
echo "--------------------------------------------------"
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

if [ $MISSING_FILES -eq 0 ]; then
    TOTAL_SCORE=$((TOTAL_SCORE + POINTS_PER_STEP))
    echo "Subtotal: $TOTAL_SCORE / 100"
else
    echo "⚠️  Some required files are missing. Students must submit a screenshot at assets/mobile-preview.png."
fi

# Step 2: HTML Structure & Viewport (25 points)
echo "--------------------------------------------------"
echo "🌐 Checking HTML structure..."
if [ -f "index.html" ]; then
    if grep -q "<meta name=\"viewport\"" index.html; then
        echo "✅ Viewport meta tag found."
        if grep -q "href=\"style.css\"" index.html; then
            echo "✅ CSS link found."
            TOTAL_SCORE=$((TOTAL_SCORE + POINTS_PER_STEP))
        else
            echo "❌ Link to style.css not found in index.html"
        fi
    else
        echo "❌ Viewport meta tag missing in index.html. This is critical for mobile-first design!"
    fi
else
    echo "❌ Skip: index.html missing."
fi
echo "Subtotal: $TOTAL_SCORE / 100"

# Step 3: CSS Mobile Optimizations (25 points)
echo "--------------------------------------------------"
echo "🎨 Checking CSS optimizations..."
if [ -f "style.css" ]; then
    TOUCH_ACTION=$(grep "touch-action" style.css)
    USER_SELECT=$(grep "user-select: none" style.css)
    
    if [[ ! -z "$TOUCH_ACTION" ]] && [[ ! -z "$USER_SELECT" ]]; then
        echo "✅ Mobile touch optimizations (touch-action, user-select) found."
        TOTAL_SCORE=$((TOTAL_SCORE + POINTS_PER_STEP))
    else
        [ -z "$TOUCH_ACTION" ] && echo "❌ touch-action optimization missing in style.css"
        [ -z "$USER_SELECT" ] && echo "❌ user-select: none missing in style.css"
    fi
else
    echo "❌ Skip: style.css missing."
fi
echo "Subtotal: $TOTAL_SCORE / 100"

# Step 4: FPV Container & Layout (25 points)
echo "--------------------------------------------------"
echo "📺 Checking FPV container styling..."
if [ -f "style.css" ]; then
    OBJECT_FIT=$(grep "object-fit" style.css)
    VH_VW=$(grep -E "100vh|100vw" style.css)
    
    if [[ ! -z "$OBJECT_FIT" ]] && [[ ! -z "$VH_VW" ]]; then
        echo "✅ Responsive layout and object-fit found."
        TOTAL_SCORE=$((TOTAL_SCORE + POINTS_PER_STEP))
    else
        [ -z "$OBJECT_FIT" ] && echo "❌ object-fit missing for FPV image."
        [ -z "$VH_VW" ] && echo "❌ 100vh or 100vw not found for full-screen layout."
    fi
else
    echo "❌ Skip: style.css missing."
fi

echo "--------------------------------------------------"
echo "📊 Final Score: $TOTAL_SCORE / 100"

if [ $TOTAL_SCORE -eq 100 ]; then
    echo "🎉 Excellent work! All criteria met."
    exit 0
else
    echo "💡 Please review the missing items above and try again."
    # We exit with 0 to let the reporter handle the score, or exit 1 if we want it to fail the job
    # GitHub Classroom autograding-grading-reporter usually looks for the score in the logs or from test results.
    # However, for simple script runners, a non-zero exit code indicates failure.
    exit 1
fi
