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

echo "Testing shrug-checkout..."

echo
echo "========= Testing shrug-checkout... ========="
echo

##
## Test 01 - no repo
##

# === my file === #
rm -rf .shrug
./shrug-checkout a b c d e f g 2> checkout_t1_1
./shrug-checkout 2> checkout_t1_2

# === reference === #
rm -rf .shrug
2041 shrug-checkout a b c d e f g 2> checkout_t1_1a
2041 shrug-checkout 2> checkout_t1_2a

count=1
while test $count -le 2
do
    printf "."
    passed=`diff "checkout_t1_$count" "checkout_t1_$count"a | wc -l`
    if test $passed -gt 0; then
        printf " ${FAIL}Test 1 (no repo) --- failed${NC}\n"
        echo "difference below:"
        diff "checkout_t1_$count" "checkout_t1_$count"a
        exit
    fi
    count=$(($count + 1))
done
printf "\n${PASS}Test 1 (no repo) ---> passed!${NC}\n"
rm checkout_t1*

##
## Test 02 - no commits
##

# === my file === #
rm -rf .shrug
./shrug-init > checkout_tmp
./shrug-checkout a b c d e f g 2> checkout_t2_1
./shrug-checkout 2> checkout_t2_2

# === reference === #
rm -rf .shrug
2041 shrug-init > checkout_tmp
2041 shrug-checkout a b c d e f g 2> checkout_t2_1a
2041 shrug-checkout 2> checkout_t2_2a

count=1
while test $count -le 2
do
    printf "."
    passed=`diff "checkout_t2_$count" "checkout_t2_$count"a | wc -l`
    if test $passed -gt 0; then
        printf " ${FAIL}Test 2 (no commits) --- failed${NC}\n"
        echo "difference below:"
        diff "checkout_t2_$count" "checkout_t2_$count"a
        exit
    fi
    count=$(($count + 1))
done
printf "\n${PASS}Test 2 (no commits) ---> passed!${NC}\n"
rm checkout_t2*

##
## Test 03 - cmd args
##

# === my file === #
rm -rf .shrug
./shrug-init > checkout_tmp
echo hello_world > checkout_tmpfile_t3
./shrug-add checkout_tmpfile_t3
./shrug-commit -m "commit-0" > checkout_tmp
./shrug-checkout a b c d e f g 2> checkout_t3_1
./shrug-checkout x-5ufjfa_ 2> checkout_t3_2

# === reference === #
rm -rf .shrug
2041 shrug-init > checkout_tmp
echo hello_world > checkout_tmpfile_t3
2041 shrug-add checkout_tmpfile_t3
2041 shrug-commit -m "commit-0" > checkout_tmp
2041 shrug-checkout a b c d e f g 2> checkout_t3_1a
2041 shrug-checkout x-5ufjfa_ 2> checkout_t3_2a

count=1
while test $count -le 2
do
    printf "."
    passed=`diff "checkout_t3_$count" "checkout_t3_$count"a | wc -l`
    if test $passed -gt 0; then
        printf " ${FAIL}Test 3 (cmd args) --- failed${NC}\n"
        echo "difference below:"
        diff "checkout_t3_$count" "checkout_t3_$count"a
        exit
    fi
    count=$(($count + 1))
done
printf "\n${PASS}Test 3 (cmd args) ---> passed!${NC}\n"
rm checkout_t3*

##
## Test 04 - files in branch switch
##

# === my file === #
rm -rf .shrug
./shrug-init > checkout_tmp
echo "hello world" > checkout_tmpfile_t4
./shrug-add checkout_tmpfile_t4
./shrug-commit -m "commit-0" > checkout_tmp
echo "hello there" > checkout_tmpfile_t4
./shrug-show :checkout_tmpfile_t4 > checkout_tmpfile_t4_commit
cat "checkout_tmpfile_t4" > checkout_tmpfile_t4_original
./shrug-checkout a 2> checkout_t4_1 > checkout_t4_1
echo "new file in branch" > checkout_tmpfile_t4_2
./shrug-add checkout_tmpfile_t4_2
./shrug-commit -m "commit-1" > checkout_tmp
./shrug-show :checkout_tmpfile_t4 > checkout_tmpfile_t4_2_commit
cat "checkout_tmpfile_t4" > checkout_tmpfile_t4_2_original
./shrug-status > status_final_branch
./shrug-checkout master 2> checkout_t4_2 > checkout_t4_2
./shrug-status > status_final_master
rm checkout_t4_*

# === reference === #
rm -rf .shrug
./shrug-init > checkout_tmp
echo "hello world" > checkout_tmpfile_t4a
./shrug-add checkout_tmpfile_t4a
./shrug-commit -m "commit-0" > checkout_tmp
echo "hello there" > checkout_tmpfile_t4a
./shrug-show :checkout_tmpfile_t4a > checkout_tmpfile_t4_commita
cat "checkout_tmpfile_t4" > checkout_tmpfile_t4_originala
./shrug-checkout a 2> checkout_t4_1a > checkout_t4_1a
echo "new file in branch" > checkout_tmpfile_t4_2a
./shrug-add checkout_tmpfile_t4_2a
./shrug-commit -m "commit-1" > checkout_tmp
./shrug-show :checkout_tmpfile_t4a > checkout_tmpfile_t4_2_commita
cat "checkout_tmpfile_t4" > checkout_tmpfile_t4_2_originala
./shrug-status > status_final_brancha
./shrug-checkout master 2> checkout_t4_2a > checkout_t4_2a
./shrug-status > status_final_mastera

status_branch=`diff "status_final_branch" "status_final_brancha" | wc -l`
status_master=`diff "status_final_master" "status_final_mastera" | wc -l`
temp_1_commit=`diff "checkout_tmpfile_t4_commit" "checkout_tmpfile_t4_commita" | wc -l`
temp_1_original=`diff "checkout_tmpfile_t4_original" "checkout_tmpfile_t4_originala" | wc -l`
temp_2_commit=`diff "checkout_tmpfile_t4_2_commit" "checkout_tmpfile_t4_2_commita" | wc -l`
temp_2_original=`diff "checkout_tmpfile_t4_2_original" "checkout_tmpfile_t4_2_originala" | wc -l`

test $status_branch -ne 0 && test $status_master -ne 0 && 
test $temp_1_commit -ne 0 && test $temp_1_original -ne 0 && 
test $temp_2_commit -ne 0 && test $temp_2_original -ne 0 &&
printf " ${FAIL}Test 4 (form a checkout) --- failed${NC}\n" &&
echo "difference below for checkout_t4_$count checkout_t4_$count a:" &&
diff "checkout_t4_$count" "checkout_t4_$count"a &&
exit

printf "......\n${PASS}Test 4 (form a checkout) ---> passed!${NC}\n"
rm checkout_t4*
rm checkout_*
rm status_*
