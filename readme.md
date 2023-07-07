# Git repo update script

A small utility script for powershell that updates all git repos in a directory.

## Usage

Drop the script in your main git repo directory and then run it.

## Features

- Switches to master branch if not currently checked out
- Switches back to previous branch if a switch to master was made
- Pulls on master, and prunes remote references no longer present on the remote repository.

## Known issues

- Assumes primary branch name is 'master'
- Doesn't work if there are uncommitted changes
