require("pry")
require_relative("../model/album")
require_relative("../model/artist")

artist1 = Artist.new ({ 'name' => 'David Bowie' })
artist1.save()

album1 = Album.new({ 'title' => 'Life on Mars' })
album1.save()

p Artist.all()
p Album.all()
