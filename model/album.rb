require('../db/sql_runner')

class Album

  attr_accessor :artist_id, :title

  def initialize(options)
    @artist_id = options['artist_id']
    @id = options['id'].to_i if options['id'] != nil
    @title = options['title']
  end

  # Create

  def save()
    sql = "INSERT INTO albums (title) VALUES ($1) RETURNING id"
    values = [@title]
    album_hashes = SqlRunner.run(sql, values)
    @id = album_hashes[0]["id"].to_i
  end

  # Read

  def self.all()
    sql = "SELECT * FROM albums"
    album_hashes = SqlRunner.run(sql)
    return album_hashes.map { |album_hash| Album.new(album_hash) }
  end


  # Update


  # Delete

end
