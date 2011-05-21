class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string :title
      t.string :slug
      t.integer :category_id
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end
