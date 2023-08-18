file = Rails.root.join('db/seed_data/10000_Sales_Records.csv')
options = {}

table = Table.first # assume table is there
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


  # table.columns.find_by(name: 'Region').select_options.find_or_create_by(text: input[:region])
  # table.columns.find_by(name: 'Country').select_options.find_or_create_by(text: input[:country])
  # table.columns.find_by(name: 'Item Type').select_options.find_or_create_by(text: input[:item_type])
  # table.columns.find_by(name: 'Sales Channel').select_options.find_or_create_by(text: input[:sales_channel])
  # table.columns.find_by(name: 'Order Priority').select_options.find_or_create_by(text: input[:order_priority])

  # insert data


  # table.rows.create!(values: )
end