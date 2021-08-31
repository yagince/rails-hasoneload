class User < ApplicationRecord
  has_many :posts

  has_one :latest_post, -> {
    where(id: Post.group(:user_id).select("MAX(id)"))
  }, class_name: :Post
end
