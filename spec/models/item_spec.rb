require "rails_helper"

describe Item, :type => :model do
  let (:item) { Item.new }
  before {
    item.tags.build name: "tag1"
    item.tags.build name: "tag2"
  }

  describe "#tag_list" do
    subject {item.tag_list}
    it { is_expected.to eq "tag1 tag2" }
  end

  describe "#tag_list=" do
    before { item.tag_list = "tag3 tag4 tag5" }
    subject { item.tags }
    it { is_expected.to have_attributes(length: 3) }
  end
end
