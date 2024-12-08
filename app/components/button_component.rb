# frozen_string_literal: true

class ButtonComponent < ViewComponent::Base
  def initialize(
    data: {},
    href: nil,
    size: "medium",
    variant: "primary",
    icon: nil,
    name: nil,
    type: "button",
    text: nil
  )
    @data = data
    @href = href
    @icon = icon
    @name = name
    @type = type
    @text = text
    @size = size
    @variant = variant
  end
end
