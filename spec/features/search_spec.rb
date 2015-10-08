  require 'rails_helper'

RSpec.feature "Search", type: :feature do

  context "nothing filled in" do

    let(:song) { create(:song) }

    it "displays blank warning" do

      visit search_new_path

      click_button "Search Album Index"

      expect(page).to have_content "can't be blank"
    end
  end

  context "search q too short" do

    it "displays too short warning" do 
      visit search_new_path
      fill_in "search_q", with: "a"
      click_button "Search Album Index"
      expect(page).to have_content "is too short (minimum is 2 characters)" 
    end   
  end

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

  context "single song" do
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

  context "single artist" do

    let(:song) { create(:song) }

    it "displays result" do

      visit search_new_path

      fill_in "search_q", with: song.album.artist.name

      click_button "Search Album Index"

      expect(page).to have_content song.album.artist.name

    end
  end

  context "album title" do
    
    let(:song) { create(:song) }

    it "displays result" do

      visit search_new_path

      fill_in "search_q", with: song.album.artist.name

      click_button "Search Album Index"

      expect(page).to have_content song.album.artist.name

    end
  end

  context "song and album" do
    let(:song) { create(:song) }

    it "displays result" do

      visit search_new_path

      fill_in "search_q", with: song.title + " " + song.album.title

      click_button "Search Album Index"

      expect(page).to have_content song.title
      expect(page).to have_content song.album.title

    end
  end

  # context "artist and album" do
  # end
end
