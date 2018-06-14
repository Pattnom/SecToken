rsync -r src/ docs/
rsync build/contracts/* docs/
git add .
git commit -m "Compiles asset for GitHub Pages"
git push -u origin master