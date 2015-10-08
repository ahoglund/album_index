require 'rails_helper'

RSpec.describe Artist, type: :model do
  describe "#albums" do
    subject { create(:artist) }

    it { is_expected.to respond_to(:albums) }
  end
end
