from oarepo_model_builder.invenio.invenio_base import InvenioBaseClassPythonBuilder


class SampleRecordFixtureBuilder(InvenioBaseClassPythonBuilder):
    TYPE = "default_sample_record_fixture"
    template = "sample_record_fixtures"
    MODULE = "tests.conftest"

    def finish(self, **extra_kwargs):
        python_path = self.module_to_path(self.MODULE)
        self.process_template(
            python_path,
            self.template,
            schema=self.schema,
            **extra_kwargs,
        )