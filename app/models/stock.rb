class Stock < ApplicationModel
  belongs_to :stockable, polymorphic: true, counter_cache: :stockers_count
  belongs_to :stocker, class_name: "User", counter_cache: :stocked_items_count
end
