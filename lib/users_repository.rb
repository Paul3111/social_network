require './lib/user_model'

class UsersRepository
  def all
    sql = 'SELECT id, username, email_address FROM users;'
    result = DatabaseConnection.exec_params(sql, [])

    users_list = []
    result.each do |record|
      user = User.new
      user.id = record['id'].to_i
      user.username = record['username']
      user.email_address = record['email_address']
      users_list << user
    end
    return users_list
  end

  def find(id)
    sql = 'SELECT id, username, email_address FROM users WHERE id = $1;'
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)
    record = result[0]
    
    user = User.new
    user.id = record['id'].to_i
    user.username = record['username']
    user.email_address = record['email_address']
    return user
  end

   def create(user)
    sql = 'INSERT INTO users (username, email_address) VALUES ($1, $2);'
    params = [user.username, user.email_address]
  
    DatabaseConnection.exec_params(sql, params)
    return nil
   end

   def update(user)
    sql = 'UPDATE users SET username = $1, email_address = $2;'
    params = [user.username, user.email_address]
    result = DatabaseConnection.exec_params(sql, params)
    return nil
   end

   def delete(id)
    sql = 'DELETE FROM users WHERE id = $1;'
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)
    return nil
   end
end