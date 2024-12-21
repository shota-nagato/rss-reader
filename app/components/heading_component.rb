# frozen_string_literal: true

class HeadingComponent < ViewComponent::Base
  def initialize(size:, text:)
    @size = size
    @text = text
  end

  def text_size
    return "text-2xl" if @size == "h1"
    return "text-xl" if @size == "h2"
    return "text-md" if @size == "h3"
    "text-lg"
  end
end
