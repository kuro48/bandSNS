require 'bundler/setup'
Bundler.require

if development?
  ActiveRecord::Base.establish_connection("sqlite3:db/development.db")
end

# class User < ActiveRecord::Base
#   has_secure_password
#   validates :password,
#     presence: {on: create}

#   validates :email,
#     uniqueness: true,
#     presence: true
#     # fomat: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

#   validates :nickname,
#     uniqueness: true,
#     presence: true

#   validates :username,
#     uniqueness: true,
#     presence: true

#   has_many :posts
# end

# class Post < ActiveRecord::Base
#   validates :text,
#   presence: true

#   belongs_to :user
# end