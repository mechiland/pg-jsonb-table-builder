class CreateColumns < ActiveRecord::Migration[7.0]
  def change
    create_table :columns do |t|
      t.references :table, null: false, foreign_key: true
      t.string :name
      t.string :code
      t.string :type
      t.string :setting

      t.timestamps
    end
    add_index :columns, :code, unique: true
  end
end
