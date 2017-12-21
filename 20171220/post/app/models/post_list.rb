class PostList < ActiveRecord::Base
  has_many :comments
end
