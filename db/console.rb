require("pry")
require_relative("../model/album")
require_relative("../model/artist")

# Testing create a new Artist object and save it to PG db
artist1 = Artist.new ({ 'name' => 'David Bowie' })
artist1.save()

artist2 = Artist.new ({ 'name' => 'Venga Boys' })
artist2.save()

# Testing create a new Album object and save it to PG db
album1 = Album.new({ 'artist_id' => artist1.id, 'title' => 'Blackstar', 'genre' => 'Rock'})
album1.save()

album2 = Album.new({ 'artist_id' => artist1.id, 'title' => 'The Party Album', 'genre' => 'Pop'})
album2.save()

# Testing setting the title variable on an instance of Album
# then updating the PG db with new value
album2.title = 'The Up and Down Album'
album2.update()

# Testing setting the name variable on an instance of Artist
# then updating the PG db with new value
artist2.name = 'Vengaboys'
artist2.update()

# Test finding an artist by id using a class method
p Artist.find_by_id(1)

# Test finding an album by id using a class method
p Album.find_by_id(1)

# Test finding the artist associated with an instance of Album
p album1.artist()

# Test finding the albums associated with an instance of Artist
p artist1.album()

# Test select all with class method
p Artist.all()
p Album.all()

# Test delete by id
artist2.delete()
album2.delete()

# Test delete all with class method
Album.delete_all
Artist.delete_all
