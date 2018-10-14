module ApplicationHelper
  def pretty_checkbox(name, options = {})
    # TODO : recup args dans un hash
    # puis faire un delete de pretty class/label et passer le reste au helper checkbox
    content_tag(:div,
      check_box_tag(name, options[:value], options[:checked], id: options[:id], class: options[:class].presence) +
      content_tag(:div, content_tag(:label, options[:label]), class: "state p-#{options[:pretty_class]}"),
      class: "pretty p-default")
  end
end
