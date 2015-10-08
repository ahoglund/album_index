require 'rails_helper'

RSpec.describe Search, type: :model do

  let!(:song) { create(:song) }

  subject(:search) { build(:search) }

  it { is_expected.to be_instance_of(Search)}

  describe "#results" do

    it { is_expected.to respond_to(:results) }

    context "with result for song title search" do

      before do
      	search.q = song.title
        search.save
      end

      it "returns an array" do
        expect(search.results).to be_a(Array)
      end

      it "returns a single search result" do
        expect(search.results.first.song_title).to eq song.title
        expect(search.results.first.album_title).to eq song.album.title
        expect(search.results.first.artist_name).to eq song.album.artist.name
      end
    end

    context "with result for album title search" do

      before do
      	search.q = song.album.title
        search.save
      end

      it "returns a single search result" do
        expect(search.results.first.song_title).to eq song.title
        expect(search.results.first.album_title).to eq song.album.title
        expect(search.results.first.artist_name).to eq song.album.artist.name
      end
    end

    context "with result for artist name search" do

      before do
      	search.q = song.album.artist.name
        search.save
      end

      it "returns a single search result" do
        expect(search.results.first.song_title).to eq song.title
        expect(search.results.first.album_title).to eq song.album.title
        expect(search.results.first.artist_name).to eq song.album.artist.name
      end
    end
  end
end
