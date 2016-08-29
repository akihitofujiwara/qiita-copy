module HomeHelper
  def active_in(path)
    "active" if current_page? path
  end
end
