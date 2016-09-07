module ApplicationHelper
  def css_namespace
    [
      controller.controller_name,
      controller.action_name,
      user_signed_in? ? "sined-in" : "not-signed-in"
    ].join " "
  end

  def render_unless_empty(items)
    items.length > 0 ?
      render(items)
    : "<div class=\"no-items\">No Items</div>".html_safe
  end
end
