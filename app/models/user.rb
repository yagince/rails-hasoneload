class User < ApplicationRecord
  has_many :posts

  has_one :latest_post, -> { order(posted_at: :desc) }, class_name: :Post
end
