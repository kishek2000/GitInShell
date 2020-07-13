#!/bin/dash

#### TESTS FOR SHRUG-INIT ####

## The process I've taken here, is to first do the error checks,
## and then do some weirder situations. This will be for all the test
## scripts.

## My thought process in doing each of these files was to test things
## that aren't already tested by the given basic autotests.s

## I will be using the ref implementation as my source of confirmation
## for passing or failing a test.

#### COLOURS FOR FAIL/PASS ####
PASS='\033[0;32m'
FAIL='\033[0;31m'
NC='\033[0m'

echo "Testing shrug-init..."

##
## Test 01 - command line args provided
##

# === my file === #
rm -rf .shrug
./shrug-init a b c d e f g 2> init_t1_1
./shrug-init a b c 2> init_t1_2
./shrug-init \/0-a a-a d-a 2> init_t1_3

# === reference === #
rm -rf .shrug
2041 shrug-init a b c d e f g 2> init_t1_1a
2041 shrug-init a b c 2> init_t1_2a
2041 shrug-init \/0-a a-a d-a 2> init_t1_3a

count=1
while test $count -le 3
do
    echo .
    passed=`diff "init_t1_$count" "init_t1_$count"a | wc -l`
    if test $passed -gt 0; then
        printf "${FAIL}==> Test 1 (command line args) --- failed${NC}\n"
        echo "difference below:"
        diff "init_t1_$count" "init_t1_$count"a
        exit
    fi
    count=$(($count + 1))
done
printf "${PASS}==> Test 1 (command line args) --- passed!${NC}\n"
rm init_t1*

##
## Test 02 - shrug already exists
##

# === my file === #
rm -rf .shrug
./shrug-init > init_t2_1 2> init_t2_1
./shrug-init > init_t2_2 2> init_t2_2
./shrug-init askljfha fsdf > init_t2_3 2> init_t2_3

# === reference === #
rm -rf .shrug
2041 shrug-init > init_t2_1a 2> init_t2_1a
2041 shrug-init > init_t2_2a 2> init_t2_2a
2041 shrug-init askljfha fsdf > init_t2_3a 2> init_t2_3a

count=1
while test $count -le 3
do
    echo .
    passed=`diff "init_t2_$count" "init_t2_$count"a | wc -l`
    if test $passed -gt 0; then
        printf "${FAIL}==> Test 2 (shrug existing already) --- failed${NC}\n"
        echo "difference below:"
        diff "init_t2_$count" "init_t2_$count"a
        exit
    fi
    count=$(($count + 1))
done
printf "${PASS}==> Test 2 (shrug existing already) --- passed!${NC}\n"
rm init_t2*

