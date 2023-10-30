#!/bin/bash
set -e

OAREPO_VERSION=${OAREPO_VERSION:-11}
OAREPO_VERSION_MAX=$((OAREPO_VERSION+1))

if [ -d .venv-builder ] ; then
    rm -rf .venv-builder
fi

python3 -m venv .venv-builder
source .venv-builder/bin/activate
.venv-builder/bin/pip install -U setuptools pip wheel
.venv-builder/bin/pip install -e .


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

deactivate

if [ -d .model_venv ] ; then
    rm -rf .model_venv
fi

python3 -m venv .model_venv
. .model_venv/bin/activate
pip install -U setuptools pip wheel
pip install "oarepo>=$OAREPO_VERSION,<$OAREPO_VERSION_MAX"
pip install -e "$DIR/.[tests]"
python $DIR/tests/conftest.py
python $DIR/tests/test_resource.py
python $DIR/tests/test_service.py
pytest $DIR/tests/
echo "test passed successfully"
