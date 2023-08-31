file = Rails.root.join('db/seed_data/100_Sales_Records.csv')
options = {}

table = Table.create name: "Sales" # assume table is there

table_columns = [
  { name: 'Region', type: 'single_select' },
  { name: 'Country', type: 'single_select' },
  { name: 'Item Type', type: 'single_select' },
  { name: 'Sales Channel', type: 'single_select' },
  { name: 'Order Priority', type: 'single_select' },
  { name: 'Order Date', type: 'date' },
  { name: 'Order ID', type: 'single_line_text' },
  { name: 'Ship Date', type: 'date' },
  { name: 'Units Sold', type: 'number' },
  { name: 'Unit Price', type: 'number' },
  { name: 'Unit Cost', type: 'number' },
  { name: 'Total Revenue', type: 'formula', setting: '{Units Sold} * {Unit Price}' },
  { name: 'Total Cost', type: 'formula', setting: '{Units Sold} * {Unit Cost}' },
  { name: 'Total Profit', type: 'formula', setting: '{Units Sold} * ({Unit Price} - {Unit Cost})' },
]

table_columns.each do |column|
  table.columns.create!(column)
end

mapping = {
  region: 'Region',
  country: 'Country',
  item_type: 'Item Type',
  sales_channel: 'Sales Channel',
  order_priority: 'Order Priority',
  order_date: 'Order Date',
  order_id: 'Order ID',
  ship_date: 'Ship Date',
  units_sold: 'Units Sold',
  unit_price: 'Unit Price',
  unit_cost: 'Unit Cost',
  total_revenue: 'Total Revenue',
  total_cost: 'Total Cost',
  total_profit: 'Total Profit'
}

column_mapping = {}
mapping.each do |key, value|
  column = table.columns.find_by(name: value)
  column_mapping[key.to_sym] = column
end

SmarterCSV.process(file, options) do |array|
  input = array.first

  values = {}
  input.each do |k, v|
    c = column_mapping[k]
    case c.type
    when "single_select"
      values[c.code] = c.select_options.find_or_create_by(text: v).id
    else
      values[c.code] = v
    end
  end

  table.rows.create!(values: values)
end