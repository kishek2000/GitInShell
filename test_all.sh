## by running this script, then all of the autotests for shrug, and the test scripts, will run.

echo "TESTING SHRUG VERSION CONTROL SYSTEM."
echo "================================================"
echo "Running the autotests from the spec..."
# 2041 autotest shrug shrug-*
echo "================================================"
echo "================================================"
echo "Running the autotests from test scripts..."
./test01.sh
./test02.sh
./test03.sh
./test04.sh
./test05.sh
./test06.sh
./test07.sh
./test08.sh
./test09.sh
echo "================================================"
echo "DONE."
