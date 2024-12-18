# frozen_string_literal: true

class DropdownComponent < ViewComponent::Base
  include IconHelper

  def initialize(icon: "ellipsis-horizontal", css: "")
    @icon = icon
    @css = css
  end
end
