require 'rails_helper'

describe Comment, type: :model do
  let! (:user) { create :user }

  describe "#stocks?, #stock, #unstock" do
    let! (:item) { create :item }
    subject { user.stocks? item }
    context "before stock" do
      it { is_expected.to be false }
    end
    context "after stock" do
      subject { user.stocked_items.length }
      before { user.stock item }
      it { is_expected.to be 1 }
      context "after unstock" do
        before { user.unstock item }
        it { is_expected.to be 0 }
      end
    end
  end

  describe "#follows?, #follow, #unfollow" do
    let! (:tag) { create :tag }
    subject { user.follows? tag }
    context "before follow" do
      it { is_expected.to be false }
    end
    context "after follow" do
      before { user.follow tag }
      it { is_expected.to be true }
      context "after unfollow" do
        subject { user.followee_tags.length }
        before { user.unfollow tag }
        it { is_expected.to be 0 }
      end
    end
  end
end

