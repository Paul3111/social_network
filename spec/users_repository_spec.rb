require 'users_repository'
require 'user_model'

RSpec.describe UsersRepository do
  def reset_users_table
    seed_sql = File.read('spec/seeds_social_network_test.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_users_table
  end
      
  it "Gets all users." do
    repo = UsersRepository.new
    users = repo.all
    expect(users.length).to eq 3
    expect(users[0].id).to eq 1
    expect(users[0].username).to eq 'User1'
    expect(users[0].email_address).to eq 'user1@social_network.test'

    expect(users[1].id).to eq 2
    expect(users[1].username).to eq 'User2'
    expect(users[1].email_address).to eq 'user2@social_network.test'
  end

  it 'Gets a single user.' do
    repo = UsersRepository.new
    user = repo.find(3)
    expect(user.id).to eq 3
    expect(user.username).to eq 'User3'
    expect(user.email_address).to eq 'user3@social_network.test'
  end

  it 'Creates a user.' do
    repo = UsersRepository.new
    user = User.new
    user.username = 'User4'
    user.email_address = 'user4@social_network.test'
    repo.create(user)

    users = repo.all
    newest_user = users.last # or users[3]
    expect(newest_user.username).to eq 'User4'
    expect(newest_user.id).to eq 4
  end

  it 'Updates a user.' do
    repo = UsersRepository.new
    user = repo.find(2)
    user.email_address = 'paul@social_network.test'
    repo.update(user)
    updated_user = repo.find(2)
    expect(updated_user.email_address).to eq 'paul@social_network.test'
  end

  it 'Deletes a user.' do
    repo = UsersRepository.new

    new_user1 = User.new
    new_user1.username = 'User4'
    new_user1.email_address = 'user4@social_network.test'
    repo.create(new_user1)

    new_user2 = User.new
    new_user2.username = 'User5'
    new_user2.email_address = 'user5@social_network.test'
    repo.create(new_user2)

    repo.delete(4)    
    users = repo.all
    expect(users.length).to eq 4
  end
end