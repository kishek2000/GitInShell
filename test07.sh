#!/bin/dash

#### TESTS FOR SHRUG-STATUS ####

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
echo "========== Testing shrug-status... =========="
echo "============================================="
echo

##
## Test 01 - no repo
##

# === my file === #
rm -rf .shrug
./shrug-status a b c d e f g 2> status_t1_1
./shrug-status 2> status_t1_2

# === reference === #
rm -rf .shrug
2041 shrug-status a b c d e f g 2> status_t1_1a
2041 shrug-status 2> status_t1_2a

count=1
while test $count -le 2
do
    printf "."
    passed=`diff "status_t1_$count" "status_t1_$count"a | wc -l`
    if test $passed -gt 0; then
        printf " ${FAIL}Test 1 (no repo) --- failed${NC}\n"
        echo "difference below:"
        diff "status_t1_$count" "status_t1_$count"a
        exit
    fi
    count=$(($count + 1))
done
printf " ${PASS}Test 1 (no repo) --- passed!${NC}\n"
rm status_t1*

##
## Test 02 - no commits
##

# === my file === #
rm -rf .shrug
./shrug-init > status_tmp
./shrug-status a b c d e f g 2> status_t2_1
./shrug-status 2> status_t2_2

# === reference === #
rm -rf .shrug
2041 shrug-init > status_tmp
2041 shrug-status a b c d e f g 2> status_t2_1a
2041 shrug-status 2> status_t2_2a

count=1
while test $count -le 2
do
    printf "."
    passed=`diff "status_t2_$count" "status_t2_$count"a | wc -l`
    if test $passed -gt 0; then
        printf " ${FAIL}Test 2 (no commits) --- failed${NC}\n"
        echo "difference below:"
        diff "status_t2_$count" "status_t2_$count"a
        exit
    fi
    count=$(($count + 1))
done
printf " ${PASS}Test 2 (no commits) --- passed!${NC}\n"
rm status_t2*

##
## Test 03 - cmd args
##

# === my file === #
rm -rf .shrug
./shrug-init > status_tmp
echo hello_world > status_tmpfile_t3
./shrug-add status_tmpfile_t3
./shrug-commit -m "commit-0" > status_tmp
./shrug-status a b c d e f g 2> status_t3_1
./shrug-status x-5ufjfa._ 2> status_t3_2

# === reference === #
rm -rf .shrug
2041 shrug-init > status_tmp
echo hello_world > status_tmpfile_t3
2041 shrug-add status_tmpfile_t3
2041 shrug-commit -m "commit-0" > status_tmp
echo "usage: shrug-status" > status_t3_1a
echo "usage: shrug-status" > status_t3_2a

count=1
while test $count -le 2
do
    printf "."
    passed=`diff "status_t3_$count" "status_t3_$count"a | wc -l`
    if test $passed -gt 0; then
        printf " ${FAIL}Test 3 (cmd args) --- failed${NC}\n"
        echo "difference below:"
        diff "status_t3_$count" "status_t3_$count"a
        exit
    fi
    count=$(($count + 1))
done
printf " ${PASS}Test 3 (cmd args) --- passed!${NC}\n"
rm status_t3*

##
## Test 04 - variety of files
##

# === my file === #
rm -rf .shrug
./shrug-init > status_tmp
echo "hello world" > status_tmpfile_1_t4
echo "hello there" > status_tmpfile_2_t4
echo "goodbye" > status_tmpfile_3_t4
./shrug-add status_tmpfile_1_t4 status_tmpfile_2_t4
echo "adding change after commit" >> status_tmpfile_2_t4
./shrug-commit -m "commit-0" > status_tmp
./shrug-status | egrep -v "status*" 2> status_t4_1 > status_t4_1

# === reference === #
rm -rf .shrug
2041 shrug-init > status_tmp
echo "hello world" > status_tmpfile_1_t4a
echo "hello there" > status_tmpfile_2_t4a
echo "goodbye" > status_tmpfile_3_t4a
2041 shrug-add status_tmpfile_1_t4a status_tmpfile_2_t4a
echo "adding change after commit" >> status_tmpfile_2_t4a
2041 shrug-commit -m "commit-0" > status_tmp
2041 shrug-status | egrep -v "status*" 2> status_t4_1a > status_t4_1a

count=1
while test $count -le 1
do
    printf "."
    passed=`diff "status_t4_$count" "status_t4_$count"a | wc -l`
    file_comparisons=1
    while test $file_comparisons -le 3; 
    do
        printf ":"
        same=`diff "status_tmpfile_$file_comparisons"_t4 "status_tmpfile_$file_comparisons"_t4 | wc -l`
        if test $same -gt 0; then
            printf " ${FAIL}Test 4 (variety of files) --- different file contents present:${NC}\n"
            diff "status_tmpfile_$file_comparisons"_t4 "status_tmpfile_$file_comparisons"_t4
            exit
        fi
        file_comparisons=$(($file_comparisons + 1))
    done
    if test $passed -gt 0; then
        printf " ${FAIL}Test 4 (variety of files) --- failed${NC}\n"
        echo "difference below:"
        diff "status_t4_$count" "status_t4_$count"a
        exit
    fi
    count=$(($count + 1))
done
printf " ${PASS}Test 4 (variety of files) --- passed!${NC}\n"
rm status_t4*


rm status_*