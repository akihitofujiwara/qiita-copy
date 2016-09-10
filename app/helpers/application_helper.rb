module ApplicationHelper
  def css_namespace
    [
      controller.controller_name,
      controller.action_name,
      user_signed_in? ? "sined-in" : "not-signed-in"
    ].join " "
  end
end
