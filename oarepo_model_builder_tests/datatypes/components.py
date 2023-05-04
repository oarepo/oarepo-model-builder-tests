import marshmallow as ma
from oarepo_model_builder.datatypes import DataTypeComponent, ModelDataType


class ModelTestComponent(DataTypeComponent):
    eligible_datatypes = [ModelDataType]

    class ModelSchema(ma.Schema):
        extra_fixtures = ma.fields.List(
            ma.fields.String(),
            data_key="extra-fixtures",
            attribute="extra-fixtures",
            required=False,
        )


components = [ModelTestComponent]
