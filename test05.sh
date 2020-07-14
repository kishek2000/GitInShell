#!/bin/dash

#### TESTS FOR SHRUG-SHOW ####

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
echo "=========== Testing shrug-show... ==========="
echo

##
## Test 01 - no repo
##

# === my file === #
rm -rf .shrug
./shrug-show a b c d e f g 2> show_t1_1
./shrug-show 2> show_t1_2

# === reference === #
rm -rf .shrug
2041 shrug-show a b c d e f g 2> show_t1_1a
2041 shrug-show 2> show_t1_2a

count=1
while test $count -le 2
do
    printf "."
    passed=`diff "show_t1_$count" "show_t1_$count"a | wc -l`
    if test $passed -gt 0; then
        printf " ${FAIL}Test 1 (no repo) --- failed${NC}\n"
        echo "difference below:"
        diff "show_t1_$count" "show_t1_$count"a
        exit
    fi
    count=$(($count + 1))
done
printf "\n${PASS}Test 1 (no repo) ---> passed!${NC}\n"
rm show_t1*

##
## Test 02 - no commits
##

# === my file === #
rm -rf .shrug
./shrug-init > show_tmp
./shrug-show a b c d e f g 2> show_t2_1
./shrug-show 2> show_t2_2

# === reference === #
rm -rf .shrug
2041 shrug-init > show_tmp
2041 shrug-show a b c d e f g 2> show_t2_1a
2041 shrug-show 2> show_t2_2a

count=1
while test $count -le 2
do
    printf "."
    passed=`diff "show_t2_$count" "show_t2_$count"a | wc -l`
    if test $passed -gt 0; then
        printf " ${FAIL}Test 2 (no commits) --- failed${NC}\n"
        echo "difference below:"
        diff "show_t2_$count" "show_t2_$count"a
        exit
    fi
    count=$(($count + 1))
done
printf "\n${PASS}Test 2 (no commits) ---> passed!${NC}\n"
rm show_t2*

##
## Test 03 - cmd args
##

# === my file === #
rm -rf .shrug
./shrug-init > show_tmp
echo hello_world > show_tmpfile_t3
./shrug-add show_tmpfile_t3
./shrug-commit -m "commit-0" > show_tmp
./shrug-show a b c d e f g 2> show_t3_1
./shrug-show x-5ufjfa._ 2> show_t3_2

# === reference === #
rm -rf .shrug
2041 shrug-init > show_tmp
echo hello_world > show_tmpfile_t3
2041 shrug-add show_tmpfile_t3
2041 shrug-commit -m "commit-0" > show_tmp
2041 shrug-show a b c d e f g 2> show_t3_1a
2041 shrug-show x-5ufjfa._ 2> show_t3_2a

count=1
while test $count -le 2
do
    printf "."
    passed=`diff "show_t3_$count" "show_t3_$count"a | wc -l`
    if test $passed -gt 0; then
        printf " ${FAIL}Test 3 (cmd args) --- failed${NC}\n"
        echo "difference below:"
        diff "show_t3_$count" "show_t3_$count"a
        exit
    fi
    count=$(($count + 1))
done
printf "\n${PASS}Test 3 (cmd args) ---> passed!${NC}\n"
rm show_t3*

##
## Test 04 - committed file
##

# === my file === #
rm -rf .shrug
./shrug-init > show_tmp
echo hello_world > show_tmpfile_t4
./shrug-add show_tmpfile_t4
./shrug-commit -m "commit-0" > show_tmp
echo "hello there" > show_tmpfile_t4
./shrug-show :a 2> show_t4_1 > show_t4_1
cat show_tmpfile_t4 > show_t4_2

# === reference === #
rm -rf .shrug
2041 shrug-init > show_tmp
echo hello_world > show_tmpfile_t4
2041 shrug-add show_tmpfile_t4
2041 shrug-commit -m "commit-0" > show_tmp
echo "hello there" > show_tmpfile_t4
2041 shrug-show :a 2> show_t4_1a > show_t4_1a
cat show_tmpfile_t4 > show_t4_2a

count=1
while test $count -le 2
do
    printf "."
    passed=`diff "show_t4_$count" "show_t4_$count"a | wc -l`
    if test $passed -gt 0; then
        printf " ${FAIL}Test 4 (committed file) --- failed${NC}\n"
        echo "difference below:"
        diff "show_t4_$count" "show_t4_$count"a
        exit
    fi
    count=$(($count + 1))
done
printf "\n${PASS}Test 4 (committed file) ---> passed!${NC}\n"
rm show_t4*

rm show_*
