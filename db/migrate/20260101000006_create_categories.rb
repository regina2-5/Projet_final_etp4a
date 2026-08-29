class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.string :kind # "job" ou "training", pour reutiliser la meme table
      t.timestamps
    end
  end
end
