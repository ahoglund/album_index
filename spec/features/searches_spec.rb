require 'rails_helper'

RSpec.feature "Search", type: :feature do

  context "no results" do

    let(:song) { create(:song) }

    it "displays 'No Results Found'" do

      visit search_new_path

      fill_in "search_q", with: "Not Song Title"

      click_button "Search Album Index"

      expect(page).to_not have_content "Song Title"
      expect(page).to have_content "No Results Found"
      expect(page).to have_content "Back"
    end
  end

  context "for a single song" do
    let(:song) { create(:song) }

    it "displays result" do

      visit search_new_path

      fill_in "search_q", with: song.title

      click_button "Search Album Index"

      expect(page).to have_content song.title
      expect(page).to have_content song.album.title
      expect(page).to have_content song.album.artist.name
    end
  end

  context "multiple songs" do
    before do
      10.times { |i| create(:song, title: "Song #{i}") }
    end

    it "displays result" do

      visit search_new_path

      fill_in "search_q", with: "Song"

      click_button "Search Album Index"

      Song.all.each do |song|
        expect(page).to have_content song.title
      end

    end
  end

  context "for a single artist" do

    let(:song) { create(:song) }

    it "displays result" do

      visit search_new_path

      fill_in "search_q", with: song.album.artist.name

      click_button "Search Album Index"

      expect(page).to have_content song.album.artist.name

    end
  end

  context "for a album title" do
    
    let(:song) { create(:song) }

    it "displays result" do

      visit search_new_path

      fill_in "search_q", with: song.album.artist.name

      click_button "Search Album Index"

      expect(page).to have_content song.album.artist.name

    end
  end

  # context "for a song and album" do
  # end

  # context "for a artist and album" do
  # end
end
