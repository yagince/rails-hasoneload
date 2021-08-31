class User < ApplicationRecord
  has_many :posts

  has_one :latest_post, -> {
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
end
