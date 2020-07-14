#!/bin/dash

#### TESTS FOR SHRUG-RM ####

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
echo "============ Testing shrug-rm... ============"
echo

##
## Test 01 - no repo
##

# === my file === #
rm -rf .shrug
./shrug-rm a b c d e f g 2> rm_t1_1
./shrug-rm 2> rm_t1_2

# === reference === #
rm -rf .shrug
2041 shrug-rm a b c d e f g 2> rm_t1_1a
2041 shrug-rm 2> rm_t1_2a

count=1
while test $count -le 2
do
    printf "."
    passed=`diff "rm_t1_$count" "rm_t1_$count"a | wc -l`
    if test $passed -gt 0; then
        printf " ${FAIL}Test 1 (no repo) --- failed${NC}\n"
        echo "difference below:"
        diff "rm_t1_$count" "rm_t1_$count"a
        exit
    fi
    count=$(($count + 1))
done
printf " ${PASS}Test 1 (no repo) --- passed!${NC}\n"
rm rm_t1*

##
## Test 02 - no commits
##

# === my file === #
rm -rf .shrug
./shrug-init > rm_tmp
./shrug-rm a b c d e f g 2> rm_t2_1
./shrug-rm 2> rm_t2_2

# === reference === #
rm -rf .shrug
2041 shrug-init > rm_tmp
2041 shrug-rm a b c d e f g 2> rm_t2_1a
2041 shrug-rm 2> rm_t2_2a

count=1
while test $count -le 2
do
    printf "."
    passed=`diff "rm_t2_$count" "rm_t2_$count"a | wc -l`
    if test $passed -gt 0; then
        printf " ${FAIL}Test 2 (no commits) --- failed${NC}\n"
        echo "difference below:"
        diff "rm_t2_$count" "rm_t2_$count"a
        exit
    fi
    count=$(($count + 1))
done
printf " ${PASS}Test 2 (no commits) --- passed!${NC}\n"
rm rm_t2*

##
## Test 03 - cmd args
##

# === my file === #
rm -rf .shrug
./shrug-init > rm_tmp
echo hello_world > rm_tmpfile_t3
./shrug-add rm_tmpfile_t3
./shrug-commit -m "commit-0" > rm_tmp
./shrug-rm 2> rm_t3_1
./shrug-rm x-5ufjfa._ 2> rm_t3_2

# === reference === #
rm -rf .shrug
2041 shrug-init > rm_tmp
echo hello_world > rm_tmpfile_t3
2041 shrug-add rm_tmpfile_t3
2041 shrug-commit -m "commit-0" > rm_tmp
2041 shrug-rm 2> rm_t3_1a
2041 shrug-rm x-5ufjfa._ 2> rm_t3_2a

count=1
while test $count -le 2
do
    printf "."
    passed=`diff "rm_t3_$count" "rm_t3_$count"a | wc -l`
    if test $passed -gt 0; then
        printf " ${FAIL}Test 3 (cmd args) --- failed${NC}\n"
        echo "difference below:"
        diff "rm_t3_$count" "rm_t3_$count"a
        exit
    fi
    count=$(($count + 1))
done
printf " ${PASS}Test 3 (cmd args) --- passed!${NC}\n"
rm rm_t3*

##
## Test 04 - nonexistent files
##

# === my file === #
rm -rf .shrug
./shrug-init > rm_tmp
echo hello_world > rm_tmpfile_t4
./shrug-add rm_tmpfile_t4
./shrug-commit -m "commit-0" > rm_tmp
./shrug-rm 2> rm_t4_1
./shrug-rm x-5ufjfa._ 2> rm_t4_2

# === reference === #
rm -rf .shrug
2041 shrug-init > rm_tmp
echo hello_world > rm_tmpfile_t4
2041 shrug-add rm_tmpfile_t4
2041 shrug-commit -m "commit-0" > rm_tmp
2041 shrug-rm 2> rm_t4_1a
2041 shrug-rm x-5ufjfa._ 2> rm_t4_2a

count=1
while test $count -le 2
do
    printf "."
    passed=`diff "rm_t4_$count" "rm_t4_$count"a | wc -l`
    if test $passed -gt 0; then
        printf " ${FAIL}Test 4 (non-existent files) --- failed${NC}\n"
        echo "difference below:"
        diff "rm_t4_$count" "rm_t4_$count"a
        exit
    fi
    count=$(($count + 1))
done
printf " ${PASS}Test 4 (non-existent files) --- passed!${NC}\n"
rm rm_t4*

rm rm_*