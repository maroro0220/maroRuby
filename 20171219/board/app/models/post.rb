class Post < ActiveRecord::Base
  #댓글'들'을 가지고 있음
  has_many :comments #무조건 복수형
end
