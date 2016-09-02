module ApplicationHelper
  def css_namespace
    "#{controller.controller_name} #{controller.action_name}"
  end

  def render_unless_empty(items)
    items.length > 0 ?
      render(items)
    : "<div class=\"no-items\">No Items</div>".html_safe
  end
end
