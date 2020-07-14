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
printf " ${PASS}Test 1 (no repo) --- passed!${NC}\n"
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
printf " ${PASS}Test 2 (no commits) --- passed!${NC}\n"
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
printf " ${PASS}Test 3 (cmd args) --- passed!${NC}\n"
rm merge_t3*

