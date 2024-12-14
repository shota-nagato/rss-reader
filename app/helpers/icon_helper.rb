module IconHelper
  def icon(name, css: nil)
    file_path = File.read(Rails.root.join("app", "assets", "svgs", "#{name}.svg"))
    svg_file = Nokogiri::HTML::DocumentFragment.parse(file_path).at_css("svg")

    svg_file["class"] = [svg_file["class"], css].compact.join(" ") unless css.nil?

    svg_file.to_html.html_safe
  end
end
