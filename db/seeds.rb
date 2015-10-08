# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times do
	artist = Artist.create(name: Faker::Name.name)
	10.times do
		album = Album.create(title: Faker::Book.title, artist_id: artist.id)
		5.times { Song.create(title: Faker::Hacker.adjective + " " + Faker::Hacker.noun + " " + Faker::Hacker.verb, album_id: album.id) }
	end
end