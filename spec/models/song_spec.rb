require 'rails_helper'

RSpec.describe Song, type: :model do
  describe "#album" do

    subject { create(:song) }

    it { is_expected.to respond_to(:album) }
  end
end
