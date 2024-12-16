# frozen_string_literal: true

class FormFieldComponent < ViewComponent::Base
  def initialize(form: nil, label: nil, field_type: :text_field, attribute_key: nil, placeholder: "", data: {}, size: "lg")
    @form = form
    @label = label
    @field_type = field_type
    @attribute_key = attribute_key
    @placeholder = placeholder
    @data = data
    @size = size
  end

  def size_class
    (@size == "lg") ? "py-2 px-4" : "py-1 px-2"
  end
end
