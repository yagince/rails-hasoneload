require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#latest_post" do
    let!(:user)   { create(:user) }
    let!(:post_1) { create(:post, user: user, posted_at: Time.zone.now) }
    let!(:post_2) { create(:post, user: user, posted_at: Time.zone.now + 1.day) }
    let!(:post_3) { create(:post, user: user, posted_at: Time.zone.now - 1.day) }

    context "when single user" do
      subject { user.latest_post }

      it { is_expected.to eq post_2 }
    end

    context "when exits other user" do
      let!(:other_user)   { create(:user) }
      let!(:other_posts)  { create_list(:post, 10, user: other_user) }
      let!(:other_post_1) { create(:post, user: other_user, posted_at: Time.zone.now + 1.day) }
      let!(:other_post_2) { create(:post, user: other_user, posted_at: Time.zone.now - 1.day) }

      let(:users) { User.all.order(:id).includes(:latest_post) }

      subject { users.map(&:latest_post) }

      it { is_expected.to eq [post_2, other_post_1] }
    end
  end
end
