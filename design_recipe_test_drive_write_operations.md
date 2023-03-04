SOCIAL NETWORK Model and Repository Classes Design Recipe

As a social network user,
So I can have my information registered,
I'd like to have a user account with my email address.

As a social network user,
So I can have my information registered,
I'd like to have a user account with my username.

As a social network user,
So I can write on my timeline,
I'd like to create posts associated with my user account.

As a social network user,
So I can write on my timeline,
I'd like each of my posts to have a title and a content.

As a social network user,
So I can know who reads my posts,
I'd like each of my posts to have a number of views.

Nouns:

user, email_address, username, posts, post_title, post_content, post_views

1. Design and create the Tables

Table: users

Columns:
id | username | email_address

Table: posts

Columns:
id | post_title | post_content | post_views | user_id

foreign key => user_id

2. Create Test SQL seeds

Original data:
-- (file: spec/seeds_social_network.sql)

CREATE TABLE users (
    id SERIAL,
    username TEXT,
    email_address TEXT
);

CREATE TABLE posts (
    id SERIAL,
    post_title TEXT,
    post_content TEXT,
    post_views INT,
    user_id INT
);

INSERT INTO users (username, email_address) VALUES ('User1', 'user1@social_network.test');
INSERT INTO users (username, e-mail_address) VALUES ('User2', 'user2@social_network.test');
INSERT INTO users (username, e-mail_address) VALUES ('User3', 'user3@social_network.test');

INSERT INTO posts (post_title, post_content, post_views, user_id) VALUES ('Post1', 'This is post content 1', '2', 1);
INSERT INTO posts (post_title, post_content, post_views, user_id) VALUES ('Post2', 'This is post content 2', '5', 2);
INSERT INTO posts (post_title, post_content, post_views, user_id) VALUES ('Post3', 'This is post content 3', '10', 3);
INSERT INTO posts (post_title, post_content, post_views, user_id) VALUES ('Post4', 'This is post content 4', '3', 2);


Test data:
-- (file: spec/seeds_social_network_test.sql)

TRUNCATE users TABLE RESTART IDENTITY;
INSERT INTO users (username, email_address) VALUES ('User1', 'user1@social_network.test');
INSERT INTO users (username, email_address) VALUES ('User2', 'user2@social_network.test');
INSERT INTO users (username, email_address) VALUES ('User3', 'user3@social_network.test');

TRUNCATE users TABLE RESTART IDENTITY;
INSERT INTO posts (post_title, post_content, post_views, user_id) VALUES ('Post1', 'This is post content 1', '2', 1);
INSERT INTO posts (post_title, post_content, post_views, user_id) VALUES ('Post2', 'This is post content 2', '5', 2);
INSERT INTO posts (post_title, post_content, post_views, user_id) VALUES ('Post3', 'This is post content 3', '10', 3);
INSERT INTO posts (post_title, post_content, post_views, user_id) VALUES ('Post4', 'This is post content 4', '3', 2);

psql -h 127.0.0.1 social_network < seeds_init.sql # this is run once for the original DB and DB_test
psql -h 127.0.0.1 social_network < seeds_social_network.sql # this is run once for the test DB
psql -h 127.0.0.1 social_network_test < seeds_social_network_test.sql

3. Define the class names

# Table name: users

# Model class
# (in lib/user_model.rb)
class User
end

# Repository class
# (in lib/users_repository.rb)
class UsersRepository
end

# Table name: posts

# Model class
# (in lib/post_model.rb)
class Post
end

# Repository class
# (in lib/posts_repository.rb)
class PostsRepository
end

4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

# Table name: users

# Model class
# (in lib/user_model.rb)

class User
  attr_accessor :id, :name, :cohort_name
end

# Table name: posts

# Model class
# (in lib/post_model.rb)

class Post
  attr_accessor :id, :post_title, :post_content, :post_views, :user_id
end

5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

# Table name: users

# Repository class
# (in lib/users_repository.rb)

class UsersRepository

  # Selecting all records
  # No arguments
  def all
    # SELECT id, username, email_address FROM users;
    # Returns an array of User objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # SELECT id, username, email_address FROM users WHERE id = $1;
    # Returns a single User object.
  end

   def create(user)
    # INSERT INTO users (username, email_address) VALUES ($1, $2);
    # Returns nil
   end

   def update(user)
    # UPDATE users SET username = $1, email_address = $2;
      # Returns nil
   end

   def delete(user)
    # DELETE FROM users WHERE id = $1;
    # Returns nil
   end
end

# Repository class
# (in lib/posts_repository.rb)
class PostsRepository

  # Selecting all records
  # No arguments
  def all
    # SELECT id, post_title, post_content, post_views, user_id FROM posts;
    # Returns an array of Post objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # SELECT id, post_title, post_content, post_views, user_id FROM posts WHERE id = $1;
    # Returns a single Post object.
  end

   def create(post)
    # INSERT INTO posts (post_title, post_content, post_views, user_id) VALUES ($1, $2, $3, $4);
    # Returns nil
   end

   def update(post)
    # UPDATE posts SET post_title = $1, post_content = $2, post_views = $3, user_id = $4;
      # Returns nil
   end

   def delete(post)
    # DELETE FROM posts WHERE id = $1;
      # Returns nil
   end
end

6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository classes, following your designs from the table written in step 5.

These examples will later be encoded as RSpec tests.

User Repository class
# 1
# Get all users

repo = UsersRepository.new
users = repo.all
users.length # =>  3
users[0].id # =>  1
users[0].username # =>  'User1'
users[0].email_address # =>  'user1@social_network.test'

users[1].id # =>  2
users[1].username # =>  'User2'
users[1].email_address # =>  'user2@social_network.test'

# 2
# Get a single user

repo = UsersRepository.new
user = repo.find(3)
user.id # =>  3
user.username # =>  'User3'
user.email_address # =>  'user3@social_network.test'

# 3
# Create a user

repo = UsersRepository.new
user = User.new
user.username # => 'User4'
user.email_address # => 'user4@social_network.test'
repo.create(user)
users = repo.all
newest_user = users.last
newest_user.id # =>  4

# 4
# Update a user

repo = UsersRepository.new
user = repo.find(2)
user.email_address = 'paul@social_network.test'
repo.update(user)
repo.find(2) # => ('User2', 'paul@social_network.test')

# 5
# Delete a user

repo = UsersRepository.new
users = repo.all
users.create # => ('User4','user4@social_network.test')
users.create # => ('User5','user5@social_network.test')
users.delete # => removes User4
users.length # =>  4

Post Repository class
# 1
# Get all posts

repo = PostsRepository.new
posts = repo.all
posts.length # =>  4
posts[0].post_title # =>  'Post1'
posts[0].post_content # =>  'This is post content 1'
posts[0].post_views # =>  2

users.last.id # =>  4
users.last.post_title # =>  'Post4'
users.last.post_views # =>  3

# 2
# Get a single post

repo = PostsRepository.new
post = repo.find(1)
post.user_id # =>  1
post.post_title # =>  'Post1'
post.post_content # =>  'This is post content 1'

# 3
# Create a post

repo = PostsRepository.new
posts = repo.all
posts.create # => ('Post5','This is post content 5', '10', '3')
posts.create # => ('Post6','This is post content 6', '15', '2')
posts.length # =>  6

# 4
# Update a post

repo = PostsRepository.new
post.update # => updates post_content 3 'This is an amended post content"
post = repo.find(3) # => ('Post3','This is an amended post content', '10', '3')
post.post_content # => 'This is an amended post content' - here expect

# 5
# Delete a post

repo = PostsRepository.new
posts = repo.all
posts.create # => ('Post5','This is post content 5', '10', '3')
posts.create # => ('Post6','This is post content 6', '15', '2')
posts.delete # => removes Post5
posts.length # =>  5

Encode this example as a test.
7. Reload the SQL seeds before each test run

# file: spec/users_repository_spec.rb

def reset_users_table
  seed_sql = File.read('spec/seeds_social_network_test.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network' })
  connection.exec(seed_sql)
end

describe UsersRepository do
  before(:each) do 
    reset_users_table
  end

  # (your tests will go here).
end

8. Test-drive and implement the Repository classes behaviour

After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.
