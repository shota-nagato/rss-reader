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
    text: nil,
    color: "primary"
  )
    @data = data
    @href = href
    @icon = icon
    @name = name
    @type = type
    @text = text
    @size = size
    @variant = variant
    @color = color
  end

  def class_text
    "border-2 border-#{@color} data-[button-variant=outline]:border-#{@color} data-[button-variant=outline]:text-#{@color} inline-flex items-center justify-center gap-2 data-[button-variant=primary]:bg-#{@color} text-white font-bold py-1 px-2 data-[button-size=large]:py-2 data-[button-size=large]:px-4 rounded w-full"
  end
end
