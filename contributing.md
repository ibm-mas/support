contributing  
  
documents use markdown format: https://www.markdownguide.org/cheat-sheet/  
they are stored in the docs folder  
  
when adding a new page, a reference needs to be added in mkdocs.yml file. 
  
you can test your work locally using mkdocs  
https://www.mkdocs.org/getting-started/  






git pull https://github.com/ibm-mas/support.git  
create your own branch  
git checkout -b NEW_BRANCH_NAME  
  
make your changes  
  
test your work:  
rm -rf site  
mkdocs build --verbose --clean --strict --site-dir site  
mkdocs serve  
  
commit your changes  
git add .  
git commit -m  "your commit message"
git push --set-upstream origin NEW_BRANCH_NAME  