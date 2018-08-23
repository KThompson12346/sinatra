class PostsController < Sinatra::Base

  # sets the root as the parent-directory (sinatra folder) of the current File
  set :root, File.join(File.dirname(__FILE__), '..')

  # sets the view directory correctly
  set :views, Proc.new{File.join(root, "views")}

  configure :development do
    register Sinatra::Reloader
  end

  $posts = [{
    id: 0,
    title: "Post 0",
    post_body: "This is post 0"
    },
    {
      id: 1,
      title: "Post 1",
      post_body: "This is post 1"
      },
      {
        id: 2,
        title: "Post 2",
        post_body: "This is post 2"
        }]

  get "/" do
    @title = "Blog posts"
    @posts = $posts
    erb :"posts/index"
  end

  get "/new" do
    @title = "A new blog"
    @post = {
      id: "",
      title: "",
      post_body: ""
    }
    erb :"posts/new"
  end

  get "/:id" do
    id = params[:id].to_i
    @title = "post #{id}"
    @post = $posts[id]
    erb :"posts/show"
  end

  post "/" do
    new_post = {
      id: $posts.length,
      title: params[:title],
      post_body: params[:post_body]
    }
    $posts.push(new_post)
    redirect "/"
  end

  put "/:id" do
    id = params[:id].to_i

    post = $posts[id]

    post[:title] = params[:title]
    post[:post_body] = params[:post_body]

    $posts[id] = post

    redirect "/"
  end

  delete "/:id" do
    id = params[:id].to_i
    $posts.delete_at(id)
    redirect "/"
  end

  get "/:id/edit" do
    @title = "Edit a post"
    id = params[:id].to_i
    @post = $posts[id]

    erb :"posts/edit"
  end

end
