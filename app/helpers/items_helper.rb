module ItemsHelper
  def stock_link_of(item, options = {})
    btn_class = "btn btn-#{options[:btn_type] || "primary"}"
    if user_signed_in?
      if current_user.stocks? item
        link_to "Unstock", item_stock_path(item), method: :delete, class: "btn btn-#{options[:btn_type] || "danger"}"
      else
        link_to "Stock", item_stock_path(item), method: :post, class: "btn btn-#{options[:btn_type] || "primary"}"
      end
    end
  end
end

