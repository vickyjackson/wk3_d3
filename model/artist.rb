class Artist

  attr_accessor :name
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id'] != nil
    @name = options['name']
  end

  # Create
  def save()
    sql = "INSERT INTO artists (name) VALUES ($1) RETURNING id"
    values = [@name]
    artists = SqlRunner.run(sql, values)
    @id = artists[0]["id"].to_i
  end

  # Read
  def self.all()
    sql = "SELECT * FROM artists"
    artist_hashes = SqlRunner.run(sql)
    return artist_hashes.map { |artist_hash| Artist.new(artist_hash) }
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    artist_hash_array = SqlRunner.run(sql, values)
    artist_hash = artist_hash_array[0]
    artist = Artist.new(artist_hash)
  end

  def album
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [@id]
    albums = SqlRunner.run(sql, values)
    return albums.map { | album | Album.new(album) }
  end

  # Update
  def update()
    sql = "UPDATE artists SET name = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  # Delete
  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM artists WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

end
