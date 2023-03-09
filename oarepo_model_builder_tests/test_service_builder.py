from oarepo_model_builder.invenio.invenio_base import InvenioBaseClassPythonBuilder


class TestServiceBuilder(InvenioBaseClassPythonBuilder):
    TYPE = "invenio_tests_service"
    template = "test_service"
    MODULE = "tests.test_service"

    def finish(self, **extra_kwargs):
        python_path = self.module_to_path(self.MODULE)
        self.process_template(
            python_path,
            self.template,
            schema=self.schema,
            **extra_kwargs,
        )