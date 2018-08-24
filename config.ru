require "sinatra"
require "sinatra/contrib"
require "sinatra/reloader" if development?
require "pry"
require "pg"
require_relative "./models/post.rb"
require_relative "./controllers/posts_controller.rb"

# Direct request to the correct controller
use Rack::Reloader
use Rack::MethodOverride
run PostsController
