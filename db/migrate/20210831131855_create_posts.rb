class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user
      t.string     :title, null: false
      t.datetime   :posted_at, null: false
      t.timestamps

      t.index :posted_at
    end
  end
end
