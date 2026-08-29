class CreateStudentSkills < ActiveRecord::Migration[7.1]
  def change
    create_table :student_skills do |t|
      t.references :student, null: false, foreign_key: true
      t.references :skill, null: false, foreign_key: true
      t.integer :level, default: 1 # 1 = debutant .. 5 = expert
      t.timestamps
    end
    add_index :student_skills, [:student_id, :skill_id], unique: true
  end
end
