require 'rails_helper'

RSpec.describe Album, type: :model do

  subject { create(:album) }
  describe "#songs" do
    it { is_expected.to respond_to(:songs) }
  end

  describe "#artist" do
    it { is_expected.to respond_to(:artist) }
  end
end