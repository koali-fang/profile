#!/bin/bash
# @describe:
# @author:   Jerry Yang(hy0kle@gmail.com)

#set -x

os=$(uname)

two_months_ago=$((3600 * 24 * 30 * 2))
current_time=`date +%s`

all_branch="./all_branch.txt"
git branch --all | awk '{
    count = split($1, cntr, "/");
    if (3 == count && "origin" == cntr[2] && "HEAD" != cntr[3] && "master" != cntr[3]) {
        print cntr[2] "/" cntr[3];
    }
}' > "$all_branch"

for branch in `cat $all_branch`
do
    last_date_str=`git log $branch -1 | awk -F "   " '{if ("Date:" == $1) {split($2, cntr, " "); print cntr[2] " " cntr[3] " " cntr[4] " " cntr[5]}}'`
    #echo $last_date_str
    if [ "Darwin" == $os ]
    then
        last_time=`date -v "$last_date_str" +%s`
    else
        last_time=`date -d"$last_date_str" +%s`
    fi
    #echo "current_time: "$current_time
    #echo "last_time:    "$last_time
    diff_time=$((current_time - last_time))
    #echo "diff_time:    "$diff_time
    if ((diff_time > two_months_ago))
    then
        echo "$branch 最后一次提交时间:[$last_date_str], 已经腐烂了"
        del_branch=`echo $branch | awk '{split($1, cntr, "/"); print cntr[2];}'`
        #cmd="git push origin --delete $del_branch"
        #echo $cmd
        git push origin --delete $del_branch
    fi
done

# 删除临时文件
rm "$all_branch"
# vim:set ts=4 sw=4 et fdm=marker:

