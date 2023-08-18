class CreateRows < ActiveRecord::Migration[7.0]
  def change
    create_table :rows do |t|
      t.references :table, null: false, foreign_key: true
      t.jsonb :values

      t.timestamps
    end
  end
end
