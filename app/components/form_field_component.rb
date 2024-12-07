# frozen_string_literal: true

class FormFieldComponent < ViewComponent::Base
  def initialize(form: nil, label: nil, field_type: :text_field, attribute_key: nil, placeholder: "")
    @form = form
    @label = label
    @field_type = field_type
    @attribute_key = attribute_key
    @placeholder = placeholder
  end
end
