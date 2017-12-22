class Comment < ActiveRecord::Base
  #너는 게시글 하나에 속해 있다고 말해줘야함
  belongs_to :post  #반드시 단수형
end
