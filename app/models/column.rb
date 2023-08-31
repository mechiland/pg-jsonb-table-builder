class Column < ApplicationRecord
  self.inheritance_column = :_type_disabled
  belongs_to :table
  has_many :select_options, dependent: :destroy

  before_create :generate_code

  enum type: {
    single_select: 'single_select',
    single_line_text: 'single_line_text',
    date: 'date',
    number: 'number',
    formula: 'formula',
  }

  private

  def generate_code
    the_code = Nanoid.generate(size: 10, alphabet: '0123456789abcdefghijklmnopqrstuvwxyz')
    self.code = "col#{the_code}"
  end
end
