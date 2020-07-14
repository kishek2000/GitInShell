#!/bin/dash

#### TESTS FOR SHRUG-ADD ####

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
echo "============ Testing shrug-add... ==========="
echo

##
## Test 01 - no shrug repo present
##

# === my file === #
rm -rf .shrug
./shrug-add a b c d e f g 2> add_t1_1
./shrug-add 2> add_t1_2

# === reference === #
rm -rf .shrug
2041 shrug-add a b c d e f g 2> add_t1_1a
2041 shrug-add 2> add_t1_2a

count=1
while test $count -le 2
do
    printf "."
    passed=`diff "add_t1_$count" "add_t1_$count"a | wc -l`
    if test $passed -gt 0; then
        printf "${FAIL}Test 1 (no repo) --- failed${NC}\n"
        echo "difference below:"
        diff "add_t1_$count" "add_t1_$count"a
        exit
    fi
    count=$(($count + 1))
done
printf " ${PASS}Test 1 (no repo) --- passed!${NC}\n"
rm add_t1*

##
## Test 02 - nonexistent files
##

# === my file === #
rm -rf .shrug
./shrug-init > add_tmp
./shrug-add a > add_t2_1 2> add_t2_1
./shrug-add a b c d > add_t2_2 2> add_t2_2

# === reference === #
rm -rf .shrug
2041 shrug-init > add_tmp
2041 shrug-add a > add_t2_1a 2> add_t2_1a
2041 shrug-add a b c d > add_t2_2a 2> add_t2_2a

count=1
while test $count -le 2
do
    printf "."
    passed=`diff "add_t2_$count" "add_t2_$count"a | wc -l`
    if test $passed -gt 0; then
        printf "${FAIL}Test 2 (nonexistent files) --- failed${NC}\n"
        echo "difference below:"
        diff "add_t2_$count" "add_t2_$count"a
        exit
    fi
    count=$(($count + 1))
done
printf " ${PASS}Test 2 (nonexistent files) --- passed!${NC}\n"
rm add_t2*

##
## Test 03 - usage
##

# === my file === # ## duplicate test just in case :')
rm -rf .shrug
./shrug-init > add_tmp
./shrug-add 2> add_t3_1
./shrug-add 2> add_t3_2

# === reference === #
rm -rf .shrug
2041 shrug-init > add_tmp
2041 shrug-add 2> add_t3_1a
2041 shrug-add 2> add_t3_2a

count=1
while test $count -le 2
do
    printf "."
    passed=`diff "add_t3_$count" "add_t3_$count"a | wc -l`
    if test $passed -gt 0; then
        printf "${FAIL}Test 3 (usage) --- failed${NC}\n"
        echo "difference below:"
        diff "add_t3_$count" "add_t3_$count"a
        exit
    fi
    count=$(($count + 1))
done
printf " ${PASS}Test 3 (usage) --- passed!${NC}\n"
rm add_t3*

rm add_*