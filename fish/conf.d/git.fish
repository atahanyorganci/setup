#!/usr/bin/env fish

function gc --wraps "git commit" --description "Git Commit - Record changes to the repository"
    command git commit $argv
end

function gcm --wraps "git commit -m" --description "Git Commit Message - Record changes to the repository"
    command git commit -m $argv
end

function gr --wraps "git rebase" --description "Git Rebase - Reapply commits on top of another base tip"
    command git rebase $argv
end

function gri --wraps "git rebase -i" --description "Git Rebase Interactive - Reapply commits on top of another base tip"
    command git rebase -i $argv
end

function ga --wraps "git add" --description "Git Add - Add file contents to the index"
    if test (count $argv) -gt 0
        command git add $argv
    else
        command git add .
    end
end

function gl --wraps "git log" --description "Git Log - Show commit logs"
    if test (count $argv) -gt 0
        command git log $argv
    else
        command git log --oneline --pretty=format:'%Cgreen(%cr)%Creset %Cred%h%Creset %s %C(yellow)%d%Creset'
    end
end

function gsl --wraps "git stash list" --description "Git Stash List - List stashed changesets"
    command git stash list $argv
end

function gbl --wraps "git branch -lv" --description "Git Branch List - List branches"
    command git branch -lv $argv
end

function __gs
    git diff --color --stat=(math (tput cols) - 3) HEAD | sed '$d; s/^ //'
    git -c color.status=always status -sb
end

function gs --description "Pretty-print git status"
    __gs | gawk '
    $2 == "|" {
        nums[$1] = $3
        diff[$1] = $4;
    }
    $1 == "##" {
        print $0;
        stage = "status";
        max_file = 0;
        max_num = 0;
        for (i in diff) {
            max_file = max_file > length(i) ? max_file : length(i);
            max_num = max_num > length(nums[i]) ? max_num : length(nums[i]);
        }
    }
    stage == "status" && $1 != "##" {
        if ($2 in diff) {
            printf("%+10s %-*s | %+*s %s\n", $1, max_file, $2, max_num, nums[$2], diff[$2]);
        } else {
            print $0;
        }
    }
'
end
