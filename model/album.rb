require('../db/sql_runner')
require_relative('artist')

class Album

  attr_accessor :artist_id, :title, :genre

  def initialize(options)
    @artist_id = options['artist_id']
    @id = options['id'].to_i if options['id'] != nil
    @title = options['title']
    @genre = options['genre']
  end

  # Create
  def save()
    sql = "INSERT INTO albums (artist_id, title, genre) VALUES ($1, $2, $3) RETURNING id"
    values = [@artist_id, @title, @genre]
    album_hashes = SqlRunner.run(sql, values)
    @id = album_hashes[0]["id"].to_i
  end

  # Read
  def self.all()
    sql = "SELECT * FROM albums"
    album_hashes = SqlRunner.run(sql)
    return album_hashes.map { |album_hash| Album.new(album_hash) }
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    album_hash_array = SqlRunner.run(sql, values)
    album_hash = album_hash_array[0]
    album = Album.new(album_hash)
  end

  def artist
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_id]
    artist_array = SqlRunner.run(sql, values)
    artist_hash = artist_array[0]
    artist = Artist.new(artist_hash)
  end

  # Update
  def update()
    sql = "UPDATE albums SET (artist_id, title, genre) = ($1, $2, $3) WHERE id = $4"
    values = [@artist_id, @title, @genre, @id]
    SqlRunner.run(sql, values)
  end

  # Delete
  def self.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM albums WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

end
