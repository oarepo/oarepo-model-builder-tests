#!/bin/bash
set -e
DIR="example_model"
#cd $(dirname $0)
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

python3 -m venv .model_venv
. .model_venv/bin/activate
pip install -U setuptools pip wheel
pip install -e "$DIR/.[tests]"
python $DIR/tests/conftest.py
python $DIR/tests/test_resource.py
python $DIR/tests/test_service.py
pytest $DIR/tests/
echo "test passed successfully"
