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
pip install "invenio-app>=1.3.3"
pip install "invenio-db[postgresql,mysql,versioning]>=1.0.14,<2.0.0"
pip install "pytest-invenio>=1.4.11"
pip install "invenio_search[elasticsearch7]>=2.0.0"
    #Sphinx>=4.5
    #openpyxl>=3.0.0<4.0.0
pip install "Werkzeug<2.2.0"
pip install "Flask-Login>=0.6.1"
pip install "pyyaml>=6.0"
python tests/conftest.py
python tests/test_resource.py
python tests/test_service.py
echo "test passed successfully"
