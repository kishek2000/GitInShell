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
echo "========== Testing shrug-commit... =========="
echo

##
## Test 01 - no repo
##

# === my file === #
rm -rf .shrug
./shrug-commit a b c d e f g > commit_t1_1 2> commit_t1_1  
./shrug-commit > commit_t1_2 2> commit_t1_2

# === reference === #
rm -rf .shrug
2041 shrug-commit a b c d e f g > commit_t1_1a 2> commit_t1_1a
2041 shrug-commit > commit_t1_2a 2> commit_t1_2a

count=1
while test $count -le 2
do
    printf "."
    passed=`diff "commit_t1_$count" "commit_t1_$count"a | wc -l`
    if test $passed -gt 0; then
        printf "${FAIL} Test 1 (no repo) --- failed${NC}\n"
        echo "difference below:"
        diff "commit_t1_$count" "commit_t1_$count"a
        exit
    fi
    count=$(($count + 1))
done
printf "\n${PASS} Test 1 (no repo) ---> passed!${NC}\n"
rm commit_t1*

##
## Test 02 - command line arguments
##

# === my file === #
rm -rf .shrug
./shrug-init > commit_tmp
./shrug-commit a b c d e f g > commit_t2_1 2> commit_t2_1  
./shrug-commit -am message > commit_t2_2 2> commit_t2_2
./shrug-commit abcd ._- -a -m message > commit_t2_3 2> commit_t2_3

# === reference === #
rm -rf .shrug
2041 shrug-init > commit_tmp
2041 shrug-commit a b c d e f g > commit_t2_1a 2> commit_t2_1a
2041 shrug-commit > commit_t2_2a 2> commit_t2_2a
2041 shrug-commit abcd ._- -a -m message > commit_t2_3a 2> commit_t2_3a

count=1
while test $count -le 3
do
    printf "."
    passed=`diff "commit_t2_$count" "commit_t2_$count"a | wc -l`
    if test $passed -gt 0; then
        printf "${FAIL} Test 2 (command line arguments) --- failed${NC}\n"
        echo "difference below:"
        diff "commit_t2_$count" "commit_t2_$count"a
        exit
    fi
    count=$(($count + 1))
done
printf "\n${PASS} Test 2 (command line arguments) ---> passed!${NC}\n"
rm commit_t2*

rm commit_*
