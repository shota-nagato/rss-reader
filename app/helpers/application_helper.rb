module ApplicationHelper
  def flash_color(key)
    case key.to_sym
    when :notice
      "text-green-500 bg-green-100"
    when :alert
      "text-red-500 bg-red-100"
    end
  end
end
