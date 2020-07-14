#!/bin/dash

#### TESTS FOR SHRUG-LOG ####

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
echo "============================================="
echo "=========== Testing shrug-log... ============"
echo "============================================="
echo

##
## Test 01 - no repo
##

# === my file === #
rm -rf .shrug
./shrug-log a b c d e f g 2> log_t1_1
./shrug-log 2> log_t1_2

# === reference === #
rm -rf .shrug
2041 shrug-log a b c d e f g 2> log_t1_1a
2041 shrug-log 2> log_t1_2a

count=1
while test $count -le 2
do
    printf "."
    passed=`diff "log_t1_$count" "log_t1_$count"a | wc -l`
    if test $passed -gt 0; then
        printf " ${FAIL}Test 1 (no repo) --- failed${NC}\n"
        echo "difference below:"
        diff "log_t1_$count" "log_t1_$count"a
        exit
    fi
    count=$(($count + 1))
done
printf " ${PASS}Test 1 (no repo) --- passed!${NC}\n"
rm log_t1*

##
## Test 02 - no commits
##

# === my file === #
rm -rf .shrug
./shrug-init > log_tmp
./shrug-log a b c d e f g 2> log_t2_1
./shrug-log 2> log_t2_2

# === reference === #
rm -rf .shrug
2041 shrug-init > log_tmp
2041 shrug-log a b c d e f g 2> log_t2_1a
2041 shrug-log 2> log_t2_2a

count=1
while test $count -le 2
do
    printf "."
    passed=`diff "log_t2_$count" "log_t2_$count"a | wc -l`
    if test $passed -gt 0; then
        printf " ${FAIL}Test 2 (no commits) --- failed${NC}\n"
        echo "difference below:"
        diff "log_t2_$count" "log_t2_$count"a
        exit
    fi
    count=$(($count + 1))
done
printf " ${PASS}Test 2 (no commits) --- passed!${NC}\n"
rm log_t2*

##
## Test 03 - cmd args
##

# === my file === #
rm -rf .shrug
./shrug-init > log_tmp
echo hello_world > log_tmpfile_t2
./shrug-add log_tmpfile_t2
./shrug-commit -m "commit-0" > log_tmp
./shrug-log a b c d e f g 2> log_t2_1
./shrug-log x-5ufjfa._ 2> log_t2_2

# === reference === #
rm -rf .shrug
2041 shrug-init > log_tmp
echo hello_world > log_tmpfile_t2
2041 shrug-add log_tmpfile_t2
2041 shrug-commit -m "commit-0" > log_tmp
2041 shrug-log a b c d e f g 2> log_t2_1a
2041 shrug-log x-5ufjfa._ 2> log_t2_2a

count=1
while test $count -le 2
do
    printf "."
    passed=`diff "log_t2_$count" "log_t2_$count"a | wc -l`
    if test $passed -gt 0; then
        printf " ${FAIL}Test 3 (cmd args) --- failed${NC}\n"
        echo "difference below:"
        diff "log_t2_$count" "log_t2_$count"a
        exit
    fi
    count=$(($count + 1))
done
printf " ${PASS}Test 3 (cmd args) --- passed!${NC}\n"
rm log_t2*

rm log_*