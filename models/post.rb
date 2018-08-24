class Post
  attr_accessor(:id, :title, :post_body)

  def self.open_connection # Method to connect app to the database and vice versa
    conn = PG.connect(dbname: "blog") # Goes to the database and says I want to connect to this database called "blog"
  end

  def self.all # Gets all blog posts

  end

  def self.find(id) # Gets the one blog post with that id

  end

  def self.destroy(id) # Will delete the specific blog post with the given id

  end

  def self.hydrate(post_data) # Will make sure that data is in the correct form before inserted into database

  end

  def save # Will save the blog posts inside the database

  end

end
