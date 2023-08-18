class Column < ApplicationRecord
  self.inheritance_column = :_type_disabled
  belongs_to :table
  has_many :select_options, dependent: :destroy

  enum type: {
    single_select: 'single_select',
    single_line_text: 'single_line_text',
    date: 'date',
    number: 'number'
  }
end
