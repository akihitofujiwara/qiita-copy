require "rails_helper"

describe Item, :type => :model do
  let! (:user) { create(:user) }
  let! (:item) { create(:item, author: user) }
  let! (:tag) { item.tags.first }

  describe "#search" do
    subject { Item.search("#{item.title} user:#{user.username} tag:#{tag.name}").first.title }
    it { is_expected.to eq item.title}
  end

  describe "#search_by_users" do
    subject { Item.search_by_users([user.username]).first.title }
    it { is_expected.to eq item.title}
  end

  describe "#search_by_tags" do
    subject { Item.search_by_tags([tag.name]).first.title }
    it { is_expected.to eq item.title}
  end

  describe "#search_by_titles" do
    subject { Item.search_by_titles([item.title]).first.title }
    it { is_expected.to eq item.title}
  end

  describe "#tag_list" do
    subject {item.tag_list}
    it { is_expected.to eq (item.tags.map(&:name).join " ")}
  end

  describe "#tag_list=" do
    before { item.tag_list = "hoge fuga" }
    subject { item.tag_list }
    it { is_expected.to eq "hoge fuga" }
  end

  describe "#public?" do
    subject { item.public? }
    it { is_expected.to eq true }
  end

  describe "#private?" do
    subject { item.private? }
    it { is_expected.to eq false }
  end
end
