require 'rails_helper'

RSpec.describe Search::Qwery do

  describe '.build' do 

    subject(:query) { Search::Qwery }

    it { is_expected.to respond_to(:build) }

    it "receives a block as its argument" do 
      
    end

    it "returns an instance of Search::Qwery" do 
      q = query.build { add :target, attributes: :attr }
      expect(q).to be_instance_of(Search::Qwery)
    end
  end

  describe "#perform" do 
    let!(:song) { create(:song, title: "Brotherhood of Man") }

    let(:query) { 
      Search::Qwery.build do 
        add  :song, attributes: :title
        add  :album, attributes: :title 
        add  :artist, attributes: :name
      end
    }

    it "return false if no relation defined" do 
      expect(query.perform("Brotherhood")).to eq false
    end

    it "returns an ActiveRecord::Relation" do 
      query.relation = Song.joins(album: :artist)
      expect(query.perform("Brotherhood")).to be_instance_of(Song::ActiveRecord_Relation)
    end
  end
end
