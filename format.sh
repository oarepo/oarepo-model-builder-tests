black oarepo_model_builder_tests tests --target-version py310
autoflake --in-place --remove-all-unused-imports --recursive oarepo_model_builder_tests tests
isort oarepo_model_builder_tests tests  --profile black
