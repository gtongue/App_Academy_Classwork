# App_Academy_Classwork


# Steps to merge in days work

git clone https://github.com/gtongue/App_Academy_Classwork
put all local repo files except .git into folder called WXDX
cd into cloned repo
git remote add merge ./WXDX
git fetch merge
git merge merge/master --allow-unrelated-histories
(FIX PROBLEMS IF OCCUR)
git remote rm merge
git push
