# Table ajoutee (non nommee telle quelle dans le cahier des charges) pour
# permettre a un etudiant de s'inscrire a plusieurs formations.
class CreateTrainingRegistrations < ActiveRecord::Migration[7.1]
  def change
    create_table :training_registrations do |t|
      t.references :student, null: false, foreign_key: true
      t.references :training, null: false, foreign_key: true
      t.string :status, default: "registered"
      t.timestamps
    end
    add_index :training_registrations, [:student_id, :training_id], unique: true, name: "idx_unique_student_training"
  end
end
