class Post
  attr_accessor(:id, :title, :post_body)

  def self.open_connection # Method to connect app to the database and vice versa
    conn = PG.connect(dbname: "blog") # Goes to the database and says I want to connect to this database called "blog"
  end

  def self.all # Gets all blog posts
    # create a connection first
    conn = self.open_connection
    sql = "SELECT id, title, post_body FROM post ORDER BY id"
    results = conn.exec(sql)
    posts = results.map do |result|
      self.hydrate(result)
    end
    posts
  end

  def self.find(id) # Gets the one blog post with that id
    conn = self.open_connection
    sql = "SELECT * FROM post WHERE id = #{id} LIMIT 1"
    posts_results = conn.exec(sql)
    post = self.hydrate(posts_results[0])
  end

  def self.destroy(id) # Will delete the specific blog post with the given id
    conn = self.open_connection
    sql = "DELETE FROM post WHERE id = #{id}"
    conn.exec(sql)
  end

  def self.hydrate(post_data) # Will make sure that data is in the correct form before inserted into database
    post = Post.new

    post.id = post_data["id"]
    post.title = post_data["title"]
    post.post_body = post_data["post_body"]
    post
  end

  def save # Will save the blog posts inside the database
    conn = Post.open_connection
    if !self.id
      sql = "INSERT INTO post (title, post_body) VALUES ('#{self.title}', '#{self.post_body}')"
    else
      sql = "UPDATE post SET title = '#{self.title}', post_body = '#{self.post_body}' WHERE id = #{self.id}"
    end
    conn.exec(sql)
  end
end
