require_relative 'lib/database_connection'
require './lib/users_repository'
require './lib/posts_repository'

#DatabaseConnection.connect('social_network')

#users_repo = UsersRepository.new
#posts_repo = PostsRepository.new

#users_repo.all.each do |user|
#  puts "#{user.username} - #{user.email_address}"
#end

#posts_repo.all.each do |post|
#  puts "#{post.id}: #{post.post_title}, #{post.post_content}, #{post.post_views} views. Written by user: #{post.user_id}"
#end

class Application
    def initialize(database_name, io, users_repository, posts_repository)
        DatabaseConnection.connect(social_network)
        @io = io
        @users_repository = users_repository
        @posts_repository = posts_repository
    end

    def run
        # Runs the terminal application
        # so it can ask the user to enter some input
        # and then decide to run the appropriate action
        # or behaviour.
        # Use @io.puts or @io.gets to write output and ask for user input.
    end
end

if __FILE__ == $0
    app = Application.new(
        'social_network',
        Kernel,
        UsersRepository,
        PostsRepository
    )
    app.run
end