class CreateApplications < ActiveRecord::Migration[7.1]
  def change
    create_table :applications do |t|
      t.references :student, null: false, foreign_key: true
      t.references :job, null: false, foreign_key: true
      t.string :status, default: "pending" # pending, accepted, rejected
      t.text :cover_letter
      t.timestamps
    end
    add_index :applications, [:student_id, :job_id], unique: true
  end
end
