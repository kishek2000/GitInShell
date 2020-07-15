#!/bin/dash

#### TESTS FOR SHRUG-MERGE ####

## The process I've taken here, is to first do the error checks,
## and then do some weirder situations. This will be for all the test
## scripts.

## My thought process in doing each of these files was to test things
## that aren't already tested by the given basic autotests, besides some
## stuff that felt naturally necessary to test anyway.

## I will be using the ref implementation as my source of confirmation
## for passing or failing a test.

#### COLOURS FOR FAIL/PASS ####
PASS='\033[0;32m'
FAIL='\033[0;31m'
NC='\033[0m'

echo "Testing shrug-merge..."

echo
echo "=========== Testing shrug-merge... =========="
echo

##
## Test 01 - no repo
##

# === my file === #
rm -rf .shrug
./shrug-merge a b c d e f g 2> merge_t1_1
./shrug-merge 2> merge_t1_2

# === reference === #
rm -rf .shrug
2041 shrug-merge a b c d e f g 2> merge_t1_1a
2041 shrug-merge 2> merge_t1_2a

count=1
while test $count -le 2
do
    printf "."
    passed=`diff "merge_t1_$count" "merge_t1_$count"a | wc -l`
    if test $passed -gt 0; then
        printf " ${FAIL}Test 1 (no repo) --- failed${NC}\n"
        echo "difference below:"
        diff "merge_t1_$count" "merge_t1_$count"a
        exit
    fi
    count=$(($count + 1))
done
printf "\n${PASS}Test 1 (no repo) ---> passed!${NC}\n"
rm merge_t1*

##
## Test 02 - no commits
##

# === my file === #
rm -rf .shrug
./shrug-init > merge_tmp
./shrug-merge a b c d e f g 2> merge_t2_1
./shrug-merge 2> merge_t2_2

# === reference === #
rm -rf .shrug
2041 shrug-init > merge_tmp
2041 shrug-merge a b c d e f g 2> merge_t2_1a
2041 shrug-merge 2> merge_t2_2a

count=1
while test $count -le 2
do
    printf "."
    passed=`diff "merge_t2_$count" "merge_t2_$count"a | wc -l`
    if test $passed -gt 0; then
        printf " ${FAIL}Test 2 (no commits) --- failed${NC}\n"
        echo "difference below:"
        diff "merge_t2_$count" "merge_t2_$count"a
        exit
    fi
    count=$(($count + 1))
done
printf "\n${PASS}Test 2 (no commits) ---> passed!${NC}\n"
rm merge_t2*

##
## Test 03 - cmd args
##

# === my file === #
rm -rf .shrug
./shrug-init > merge_tmp
echo hello_world > merge_tmpfile_t3
./shrug-add merge_tmpfile_t3
./shrug-commit -m "commit-0" > merge_tmp
./shrug-merge a b c d e f g 2> merge_t3_1
./shrug-merge x-5ufjfa_ 2> merge_t3_2
./shrug-merge x -m "" 2> merge_t3_3
./shrug-merge 2> merge_t3_4
./shrug-merge x -m 2> merge_t3_5

# === reference === #
rm -rf .shrug
2041 shrug-init > merge_tmp
echo hello_world > merge_tmpfile_t3
2041 shrug-add merge_tmpfile_t3
2041 shrug-commit -m "commit-0" > merge_tmp
2041 shrug-merge a b c d e f g 2> merge_t3_1a
2041 shrug-merge x-5ufjfa_ 2> merge_t3_2a
2041 shrug-merge x -m "" 2> merge_t3_3a
2041 shrug-merge 2> merge_t3_4a
2041 shrug-merge x -m 2> merge_t3_5a

count=1
while test $count -le 5
do
    printf "."
    passed=`diff "merge_t3_$count" "merge_t3_$count"a | wc -l`
    if test $passed -gt 0; then
        printf " ${FAIL}Test 3 (cmd args) --- failed${NC}\n"
        echo "difference below:"
        diff "merge_t3_$count" "merge_t3_$count"a
        exit
    fi
    count=$(($count + 1))
done
printf "\n${PASS}Test 3 (cmd args) ---> passed!${NC}\n"
rm merge_t3*

##
## Test 04 - merging the deletion of files
##

# === my file === #
rm -rf .shrug
./shrug-init > merge_tmp
seq 1 7 > file.txt
./shrug-add file.txt 
./shrug-commit -m "first-commit, no.0" > merge_tmp
./shrug-branch b1 > merge_tmp
./shrug-checkout b1 > merge_tmp
echo "hello world" > b
./shrug-add b
./shrug-commit -m "second-commit, no.1" > merge_tmp
./shrug-status | egrep -v "merge_t4" 2> merge_t4_1 > merge_t4_1
./shrug-rm b
./shrug-status | egrep -v "merge_t4" 2> merge_t4_2 > merge_t4_2
./shrug-commit -m "third commit - deleted b, no.2" > merge_tmp
./shrug-status | egrep -v "merge_t4" 2> merge_t4_3 > merge_t4_3
./shrug-checkout master > merge_tmp
./shrug-merge b1 -m "merge branch" > merge_t4_4
./shrug-show :b 2> merge_t4_5 > merge_t4_5
./shrug-show 1:b 2> merge_t4_6 > merge_t4_6
./shrug-log 2> merge_t4_7 > merge_t4_7
./shrug-status | egrep -v "merge_t4" 2> merge_t4_8 > merge_t4_8

# === reference === #
rm -rf .shrug
2041 shrug-init > merge_tmp
seq 1 7 > file.txt
2041 shrug-add file.txt 
2041 shrug-commit -m "first-commit, no.0" > merge_tmp
2041 shrug-branch b1 > merge_tmp
2041 shrug-checkout b1 > merge_tmp
echo "hello world" > b
2041 shrug-add b
2041 shrug-commit -m "second-commit, no.1" > merge_tmp
2041 shrug-status | egrep -v "merge_t4" 2> merge_t4_1a > merge_t4_1a
2041 shrug-rm b
2041 shrug-status | egrep -v "merge_t4" 2> merge_t4_2a > merge_t4_2a
2041 shrug-commit -m "third commit - deleted b, no.2" > merge_tmp
2041 shrug-status | egrep -v "merge_t4" 2> merge_t4_3a > merge_t4_3a
2041 shrug-checkout master > merge_tmp
2041 shrug-merge b1 -m "merge branch" > merge_t4_4a
2041 shrug-show :b 2> merge_t4_5a > merge_t4_5a
2041 shrug-show 1:b 2> merge_t4_6a > merge_t4_6a
2041 shrug-log 2> merge_t4_7a > merge_t4_7a
2041 shrug-status | egrep -v "merge_t4" 2> merge_t4_8a > merge_t4_8a

count=1
while test $count -le 7
do
    printf "."
    passed=`diff "merge_t4_$count" "merge_t4_$count"a | wc -l`
    if test $passed -gt 0; then
        printf " ${FAIL}Test 4 (merging file deletions) --- failed${NC}\n"
        echo "difference below:"
        echo "merge_t4_$count" "merge_t4_$count"a
        diff "merge_t4_$count" "merge_t4_$count"a
        exit
    fi
    count=$(($count + 1))
done
printf "\n${PASS}Test 4 (merging file deletions) ---> passed!${NC}\n"
rm merge_t4*

##
## Test 05 - consecutive line changes (additon, replacement and deletion all in one)
##

# === my file === #
rm -rf .shrug
./shrug-init > merge_tmp
seq 2 7 > file.txt
./shrug-add file.txt 
./shrug-commit -m "first-commit, no.0" > merge_tmp
./shrug-branch b1 > merge_tmp
./shrug-checkout b1 > merge_tmp
seq 2 5 > file.txt
./shrug-commit -a -m "second-commit, no.1" > merge_tmp
./shrug-status | egrep -v "merge_t5" 2> merge_t5_1 > merge_t5_1
./shrug-checkout master > merge_tmp
seq 0 5 > file.txt
./shrug-commit -a -m "third-commit, no.2" > merge_tmp
./shrug-merge b1 -m "merge branch" 2> merge_t5_2 > merge_t5_2
cat file.txt 2> merge_t5_3 > merge_t5_3
./shrug-log 2> merge_t5_4 > merge_t5_4
./shrug-status | egrep -v "merge_t5" 2> merge_t5_5 > merge_t5_5

# === reference === #
rm -rf .shrug
2041 shrug-init > merge_tmp
seq 2 7 > file.txt
2041 shrug-add file.txt 
2041 shrug-commit -m "first-commit, no.0" > merge_tmp
2041 shrug-branch b1 > merge_tmp
2041 shrug-checkout b1 > merge_tmp
seq 2 5 > file.txt
2041 shrug-commit -a -m "second-commit, no.1" > merge_tmp
2041 shrug-status | egrep -v "merge_t5" 2> merge_t5_1a > merge_t5_1a
2041 shrug-checkout master > merge_tmp
seq 0 5 > file.txt
2041 shrug-commit -a -m "third-commit, no.2" > merge_tmp
2041 shrug-merge b1 -m "merge branch" 2> merge_t5_2a > merge_t5_2a
cat file.txt 2> merge_t5_3a > merge_t5_3a
2041 shrug-log 2> merge_t5_4a > merge_t5_4a
2041 shrug-status | egrep -v "merge_t5" 2> merge_t5_5a > merge_t5_5a


count=1
while test $count -le 5
do
    printf "."
    passed=`diff "merge_t5_$count" "merge_t5_$count"a | wc -l`
    if test $passed -gt 0; then
        printf " ${FAIL}Test 5 (merge with consecutive lines change) --- failed${NC}\n"
        echo "difference below:"
        echo "merge_t5_$count" "merge_t5_$count"a
        diff "merge_t5_$count" "merge_t5_$count"a
        exit
    fi
    count=$(($count + 1))
done
printf "\n${PASS}Test 5 (merge with consecutive lines change) ---> passed!${NC}\n"
rm merge_t5*

#
# Test 06 - harder merge (additon, replacement and deletion all in one) -> this currently fails.
#

# === my file === #
rm -rf .shrug
./shrug-init > merge_tmp
seq 2 7 > file.txt
./shrug-add file.txt 
./shrug-commit -m "first-commit, no.0" > merge_tmp
./shrug-branch b1 > merge_tmp
./shrug-checkout b1 > merge_tmp
seq 2 10 > file.txt
./shrug-commit -a -m "second-commit, no.1" > merge_tmp
./shrug-status | egrep -v "merge_t6" 2> merge_t6_1 > merge_t6_1
./shrug-checkout master > merge_tmp
echo 1 > file.txt
echo 3 >> file.txt
./shrug-commit -a -m "third-commit, no.2" > merge_tmp
./shrug-merge b1 -m "merge branch" 2> merge_t6_2 > merge_t6_2
cat file.txt 2> merge_t6_3 > merge_t6_3
./shrug-log 2> merge_t6_4 > merge_t6_4
./shrug-status | egrep -v "merge_t6" 2> merge_t6_5 > merge_t6_5

# === reference === #
rm -rf .shrug
2041 shrug-init > merge_tmp
seq 2 7 > file.txt
2041 shrug-add file.txt 
2041 shrug-commit -m "first-commit, no.0" > merge_tmp
2041 shrug-branch b1 > merge_tmp
2041 shrug-checkout b1 > merge_tmp
seq 2 10 > file.txt
2041 shrug-commit -a -m "second-commit, no.1" > merge_tmp
2041 shrug-status | egrep -v "merge_t6" 2> merge_t6_1a > merge_t6_1a
2041 shrug-checkout master > merge_tmp
echo 1 > file.txt
echo 3 >> file.txt
2041 shrug-commit -a -m "third-commit, no.2" > merge_tmp
2041 shrug-merge b1 -m "merge branch" 2> merge_t6_2a > merge_t6_2a
cat file.txt 2> merge_t6_3a > merge_t6_3a
2041 shrug-log 2> merge_t6_4a > merge_t6_4a
2041 shrug-status | egrep -v "merge_t6" 2> merge_t6_5a > merge_t6_5a

count=1
while test $count -le 5
do
    printf "."
    passed=`diff "merge_t6_$count" "merge_t6_$count"a | wc -l`
    if test $passed -gt 0; then
        printf "\n${FAIL}Test 6 (harder merge) --- failed${NC}\n"
        echo "difference below:"
        echo "merge_t6_$count" "merge_t6_$count"a
        diff "merge_t6_$count" "merge_t6_$count"a
        rm merge_*
        exit
    fi
    count=$(($count + 1))
done
printf "\n${PASS}Test 6 (harder merge) ---> passed!${NC}\n"
rm merge_t6*
rm merge_*