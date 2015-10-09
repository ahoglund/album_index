require 'rails_helper'

RSpec.describe Search::Result  do

  describe '.build' do 

    subject(:query) { Search::Result }

    it { is_expected.to respond_to(:build) }

    it "returns a hash with passed block as key/value" do 
      q = query.build { song_title "Song Title" }

      expect(q).to be_instance_of(Hash)
      expect(q).to have_key(:song_title)
      expect(q[:song_title]).to eq "Song Title"
    end
  end
end