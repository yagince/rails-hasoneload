class User < ApplicationRecord
  has_many :posts

  has_one :latest_post_order, -> { order(posted_at: :desc) }, class_name: :Post

  has_one :latest_post_not_exists, -> {
    where(
      <<~SQL
        NOT EXISTS (
          SELECT 1 FROM posts AS p
            WHERE
              posts.posted_at < p.posted_at AND
              posts.user_id = p.user_id
        )
      SQL
    )
  }, class_name: :Post

  has_one :latest_post_max, -> {
    where(id: Post.group(:user_id).select("MAX(id)"))
  }, class_name: :Post
end
