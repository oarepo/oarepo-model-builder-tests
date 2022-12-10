#!/bin/bash
set -e
DIR="example_model"
cd $(dirname $0)/..
if test -d $DIR; then
	rm -rf $DIR
fi
oarepo-compile-model ./tests/model/model_app.yaml --output-directory ./$DIR -vvv

echo "checking existence of test files"

check_or_die()
{	
	FILE=$1
	if test -f $FILE; then
		return 0
	else
		echo "File $FILE doesn't exist."
		exit 1
	fi
}

check_or_die $DIR/tests/conftest.py
check_or_die $DIR/tests/test_resource.py
check_or_die $DIR/tests/test_service.py

echo "checking the test files are runnable"

cd $DIR
python3 -m venv venv
. venv/bin/activate
pip install -e ".[tests]"
python tests/conftest.py
python tests/test_resource.py
python tests/test_service.py
echo "test passed successfully"
