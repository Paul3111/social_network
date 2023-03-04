require './lib/post_model'

class PostsRepository
  def all
    sql = 'SELECT id, post_title, post_content, post_views, user_id FROM posts;'
    result = DatabaseConnection.exec_params(sql, [])

    posts_list = []
    result.each do |record|
      post = Post.new
      post.id = record['id'].to_i
      post.post_title = record['post_title']
      post.post_content = record['post_content']
      post.post_views = record['post_views'].to_i
      post.user_id = record['user_id'].to_i
      posts_list << post
    end
  return posts_list
  end

  def find(id)
    sql = 'SELECT id, post_title, post_content, post_views, user_id FROM posts WHERE id = $1'
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)
    record = result[0]

    post = Post.new
    post.id = record['id'].to_i
    post.post_title = record['post_title']
    post.post_content = record['post_content']
    post.post_views = record['post_views'].to_i
    post.user_id = record['user_id'].to_i
    return post
  end

  def create(post)
    sql = 'INSERT INTO posts (post_title, post_content, post_views, user_id) VALUES ($1, $2, $3, $4);'
    params = [post.post_title, post.post_content, post.post_views, post.user_id]
    result = DatabaseConnection.exec_params(sql, params)
    return nil
  end

  def update(post)
    sql = 'UPDATE posts SET post_title = $1, post_content = $2, post_views = $3, user_id = $4;'
    params = [post.post_title, post.post_content, post.post_views, post.user_id]
    result = DatabaseConnection.exec_params(sql, params)
    return nil    
  end

  def delete(id)
    sql = 'DELETE FROM posts WHERE id = $1;'
    result = DatabaseConnection.exec_params(sql,[id])
    return nil
  end
end