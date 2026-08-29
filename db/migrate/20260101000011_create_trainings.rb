class CreateTrainings < ActiveRecord::Migration[7.1]
  def change
    create_table :trainings do |t|
      t.references :trainer, null: false, foreign_key: true
      t.references :category, foreign_key: true
      t.string :title, null: false
      t.text :description
      t.datetime :starts_at
      t.datetime :ends_at
      t.integer :capacity
      t.timestamps
    end
  end
end
