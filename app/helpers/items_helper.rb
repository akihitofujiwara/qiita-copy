module ItemsHelper
  def stock_link_of(item)
    if user_signed_in?
      if current_user.stocks? item
        link_to "Unstock", item_stock_path(item), method: :delete, class: "btn btn-danger"
      else
        link_to "Stock", item_stock_path(item), method: :post, class: "btn btn-primary"
      end
    end
  end
end

