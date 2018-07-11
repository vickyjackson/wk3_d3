class Artist

  attr_accessor :name

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


  # Update


  # Delete


end
