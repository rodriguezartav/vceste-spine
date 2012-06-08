class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :slug
      t.string :title
      t.string :description
      t.integer :parent
      t.integer :post_count

      t.timestamps
    end
  end
end
