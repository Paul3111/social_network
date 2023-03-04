require './lib/posts_repository'
require './lib/post_model'

RSpec.describe PostsRepository do
    def reset_posts_table
      seed_sql = File.read('spec/seeds_social_network_test.sql')
      connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
      connection.exec(seed_sql)
    end
  
    before(:each) do 
      reset_posts_table
    end
        
    it "Gets all posts." do
      repo = PostsRepository.new
      posts = repo.all
      expect(posts.length).to eq 4
      expect(posts[0].id).to eq 1
      expect(posts[0].post_title).to eq 'Post1'
      expect(posts[0].post_content).to eq 'This is post content 1'
  
      expect(posts[1].id).to eq 2
      expect(posts[1].post_title).to eq 'Post2'
      expect(posts[1].post_content).to eq 'This is post content 2'
    end
  
    it 'Gets a single post.' do
      repo = PostsRepository.new
      post = repo.find(3)
      expect(post.id).to eq 3
      expect(post.post_title).to eq 'Post3'
      expect(post.post_content).to eq 'This is post content 3'
    end
  
    it 'Creates a post.' do
      repo = PostsRepository.new
      post = Post.new
      post.post_title = 'Post4'
      post.post_content = 'This is post content 4'
      repo.create(post)
  
      posts = repo.all
      newest_post = posts.last # or posts[3]
      expect(newest_post.post_title).to eq 'Post4'
      expect(newest_post.id).to eq 5
    end
  
    it 'Updates a post.' do
      repo = PostsRepository.new
      post = repo.find(2)
      post.post_content = 'This is the amended post content 2'
      repo.update(post)
      updated_post = repo.find(2)
      expect(updated_post.post_content).to eq 'This is the amended post content 2'
    end
  
    it 'Deletes a post.' do
      repo = PostsRepository.new
  
      new_post1 = Post.new
      new_post1.post_title = 'Post5'
      new_post1.post_content = 'This is post content 5'
      repo.create(new_post1)
  
      new_post2 = Post.new
      new_post2.post_title = 'Post6'
      new_post2.post_content = 'This is post content 6'
      repo.create(new_post2)
  
      repo.delete(5)    
      posts = repo.all
      expect(posts.length).to eq 5
    end
  end