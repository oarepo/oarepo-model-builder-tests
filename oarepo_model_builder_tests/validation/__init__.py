import marshmallow as ma
from marshmallow import fields


class FixturesModelSchema(ma.Schema):
    extra_fixtures = fields.List(
        fields.String(), data_key="extra-fixtures", required=False
    )


validators = {"model": FixturesModelSchema}
