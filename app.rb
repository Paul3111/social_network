require_relative 'lib/database_connection'
require './lib/users_repository'
require './lib/posts_repository'

DatabaseConnection.connect('social_network')

users_repo = UsersRepository.new
posts_repo = PostsRepository.new

users_repo.all.each do |user|
  puts "#{user.username} - #{user.email_address}"
end

posts_repo.all.each do |post|
  puts "#{post.id}: #{post.post_title}, #{post.post_content}, #{post.post_views} views. Written by user: #{post.user_id}"
end
