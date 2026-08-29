class CreateJobs < ActiveRecord::Migration[7.1]
  def change
    create_table :jobs do |t|
      t.references :company, null: false, foreign_key: true
      t.references :category, foreign_key: true
      t.string :title, null: false
      t.text :description
      t.string :contract_type # stage, cdi, cdd, freelance
      t.string :location
      t.boolean :active, default: true
      t.timestamps
    end
  end
end
