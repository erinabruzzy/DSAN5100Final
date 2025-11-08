# using bash, this script downloads the cloud repo, updates local repo, and pushes to cloud repo
#!/bin/bash 

# make the script executable: 
chmod +x git.sh

# pull cloud repo to local
git pull 

# change buffer settings 
git config http.postBuffer 524288000

# sync to local repo to cloud 
read -p 'enter commit message: ' message
echo "commit message = "$message; 

# add changes to queue
git add .; 

# commit changes with message
git commit -m "$message"; 

# detect current branch
current_branch=$(git branch --show-current)

# prompt to push current branch or main. If no is selected, push main branch
printf "Do you want to push the current branch '$current_branch'? (Y/n): "
read push_branch

if [ "$push_branch" != "${push_branch#[Yy]}" ] || [ -z "$push_branch" ]; then
    # push current branch
    git push -u origin "$current_branch"
else
    # push main branch instead
    git push origin main
fi