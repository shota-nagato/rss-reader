# frozen_string_literal: true

class DropdownItemComponent < ViewComponent::Base
  include IconHelper

  def initialize(href:, icon:, text:, data: {}, underline: false, css: "")
    @href = href
    @data = data
    @icon = icon
    @text = text
    @underline = underline
    @css = css
  end
end
