class CreateSelectOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :select_options do |t|
      t.references :column, null: false, foreign_key: true
      t.string :text

      t.timestamps
    end
  end
end
