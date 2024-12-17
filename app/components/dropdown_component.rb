# frozen_string_literal: true

class DropdownComponent < ViewComponent::Base
  include IconHelper

  def initialize(icon: "ellipsis-horizontal")
    @icon = icon
  end
end
