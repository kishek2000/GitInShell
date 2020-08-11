## by running this script, then all of the autotests for shrug, and the test scripts, will run.

echo
echo "============================================="
echo "============== TESTING SHRUG... ============="
echo "============================================="
echo
echo "============================================="
echo "=========== Running automarking... =========="
echo "============================================="
echo
2041 autotest shrug shrug-*
echo
echo "============================================="
echo "========== Running test scripts... =========="
echo "============================================="
echo
sh test01.sh
sh test02.sh
sh test03.sh
sh test04.sh
sh test05.sh
sh test06.sh
sh test07.sh
sh test08.sh
sh test09.sh
sh test10.sh
echo
echo "============================================="
echo "=========== TESTING SHRUG COMPLETE =========="
echo "============================================="
