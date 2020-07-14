#!/bin/dash

#### TESTS FOR SHRUG-COMMIT ####

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

echo
echo "========== Testing shrug-branch... =========="
echo

##
## Test 01 - no repo
##

# === my file === #
rm -rf .shrug
./shrug-branch a b c d e f g 2> branch_t1_1
./shrug-branch 2> branch_t1_2

# === reference === #
rm -rf .shrug
2041 shrug-branch a b c d e f g 2> branch_t1_1a
2041 shrug-branch 2> branch_t1_2a

count=1
while test $count -le 2
do
    printf "."
    passed=`diff "branch_t1_$count" "branch_t1_$count"a | wc -l`
    if test $passed -gt 0; then
        printf " ${FAIL}Test 1 (no repo) --- failed${NC}\n"
        echo "difference below:"
        diff "branch_t1_$count" "branch_t1_$count"a
        exit
    fi
    count=$(($count + 1))
done
printf "\n${PASS}Test 1 (no repo) ---> passed!${NC}\n"
rm branch_t1*

##
## Test 02 - no commits
##

# === my file === #
rm -rf .shrug
./shrug-init > branch_tmp
./shrug-branch a b c d e f g 2> branch_t2_1
./shrug-branch 2> branch_t2_2

# === reference === #
rm -rf .shrug
2041 shrug-init > branch_tmp
2041 shrug-branch a b c d e f g 2> branch_t2_1a
2041 shrug-branch 2> branch_t2_2a

count=1
while test $count -le 2
do
    printf "."
    passed=`diff "branch_t2_$count" "branch_t2_$count"a | wc -l`
    if test $passed -gt 0; then
        printf " ${FAIL}Test 2 (no commits) --- failed${NC}\n"
        echo "difference below:"
        diff "branch_t2_$count" "branch_t2_$count"a
        exit
    fi
    count=$(($count + 1))
done
printf "\n${PASS}Test 2 (no commits) ---> passed!${NC}\n"
rm branch_t2*

##
## Test 03 - cmd args
##

# === my file === #
rm -rf .shrug
./shrug-init > branch_tmp
echo hello_world > branch_tmpfile_t3
./shrug-add branch_tmpfile_t3
./shrug-commit -m "commit-0" > branch_tmp
./shrug-branch a b c d e f g 2> branch_t3_1
./shrug-branch x-5ufjfa_ 2> branch_t3_2

# === reference === #
rm -rf .shrug
2041 shrug-init > branch_tmp
echo hello_world > branch_tmpfile_t3
2041 shrug-add branch_tmpfile_t3
2041 shrug-commit -m "commit-0" > branch_tmp
2041 shrug-branch a b c d e f g 2> branch_t3_1a
2041 shrug-branch x-5ufjfa_ 2> branch_t3_2a

count=1
while test $count -le 2
do
    printf "."
    passed=`diff "branch_t3_$count" "branch_t3_$count"a | wc -l`
    if test $passed -gt 0; then
        printf " ${FAIL}Test 3 (cmd args) --- failed${NC}\n"
        echo "difference below:"
        diff "branch_t3_$count" "branch_t3_$count"a
        exit
    fi
    count=$(($count + 1))
done
printf "\n${PASS}Test 3 (cmd args) ---> passed!${NC}\n"
rm branch_t3*

##
## Test 04 - form a branch
##

# === my file === #
rm -rf .shrug
./shrug-init > branch_tmp
echo hello_world > branch_tmpfile_t4
./shrug-add branch_tmpfile_t4
./shrug-commit -m "commit-0" > branch_tmp
echo "hello there" > branch_tmpfile_t4
./shrug-branch a 2> branch_t4_1 > branch_t4_1
./shrug-branch > branch_t4_2

# === reference === #
rm -rf .shrug
2041 shrug-init > branch_tmp
echo hello_world > branch_tmpfile_t4
2041 shrug-add branch_tmpfile_t4
2041 shrug-commit -m "commit-0" > branch_tmp
echo "hello there" > branch_tmpfile_t4
2041 shrug-branch a 2> branch_t4_1a > branch_t4_1a
2041 shrug-branch > branch_t4_2a

count=1
while test $count -le 2
do
    printf "."
    passed=`diff "branch_t4_$count" "branch_t4_$count"a | wc -l`
    if test $passed -gt 0; then
        printf " ${FAIL}Test 4 (form a branch) --- failed${NC}\n"
        echo "difference below:"
        diff "branch_t4_$count" "branch_t4_$count"a
        exit
    fi
    count=$(($count + 1))
done
printf "\n${PASS}Test 4 (form a branch) ---> passed!${NC}\n"
rm branch_t4*
rm branch_*

##
## Test 05 - incorrect deletions
##

# === my file === #
rm -rf .shrug
./shrug-init > branch_tmp
echo hello_world > branch_tmpfile_t4
./shrug-add branch_tmpfile_t4
./shrug-commit -m "commit-0" > branch_tmp
./shrug-branch -d "a" 2> branch_t4_1 > branch_t4_1
./shrug-branch -d "master" 2> branch_t4_2 > branch_t4_2
./shrug-branch > branch_t4_2

# === reference === #
rm -rf .shrug
2041 shrug-init > branch_tmp
echo hello_world > branch_tmpfile_t4
2041 shrug-add branch_tmpfile_t4
2041 shrug-commit -m "commit-0" > branch_tmp
2041 shrug-branch -d "a" 2> branch_t4_1a > branch_t4_1a
2041 shrug-branch -d "master" 2> branch_t4_2a > branch_t4_2a
2041 shrug-branch > branch_t4_2a

count=1
while test $count -le 2
do
    printf "."
    passed=`diff "branch_t4_$count" "branch_t4_$count"a | wc -l`
    if test $passed -gt 0; then
        printf " ${FAIL}Test 5 (incorrect deletions) --- failed${NC}\n"
        echo "difference below:"
        diff "branch_t4_$count" "branch_t4_$count"a
        exit
    fi
    count=$(($count + 1))
done
printf "\n${PASS}Test 5 (incorrect deletions) ---> passed!${NC}\n"
rm branch_t4*
rm branch_*