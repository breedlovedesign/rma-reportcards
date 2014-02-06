One person working from 2 machines on the same branch and trying to keep the server version as cannonical. Server version being on github

On the Mac:

Before working on the files ensure that: 

GitHub is running

The correct branch is selected

pull changes from the server(Repository/Pull?) 
This will pull changes from the server, if any have been made.


On Linux

cd into the working directory

Find out what is the situation.
git status

Ensure you are on the correct branch.
If yes skip to ___

If no,
git checkout <branch_name>

list branches with
git branch -a

Get in sync with the server version:
git pull  https://github.com/breedlovedesign/rma-reportcards.git

Get some work done:
use the following commands to delete or rename/move files
git rm
git mv

if a new file is created
git add <path/to/file>

Commit changes to whatever branch you are on to the local repository.
git commit -m "descriptive Message about this commit"

Publish back to the server:
git push