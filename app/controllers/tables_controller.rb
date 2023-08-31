require "dentaku"
require 'dentaku/parser'

FUNCTION_MAPPING = {
  'right' => 'right',
  'left' => 'left',
}


def translate_function_to_sql(formula)

  # Parse the formula into an AST
  tokens = Dentaku::Tokenizer.new.tokenize(formula)
  ast = Dentaku::Parser.new(tokens).parse

  # Walk the AST and translate it into SQL
  sql = ast_node_to_sql(ast)

  puts sql

  # Wrap the translated formula in a SELECT statement
  "#{sql}"
end

def ast_node_to_sql(node)
  if node.is_a?(Dentaku::AST::Function)
    sql_func_name = FUNCTION_MAPPING[node.name] || node.name
    "#{sql_func_name}(#{node.args.map{|a| ast_node_to_sql(a)}.join(',')})"
  elsif node.is_a?(Dentaku::AST::Arithmetic)
    " #{node.operator} "
  elsif node.is_a?(Dentaku::AST::Node)
    "#{node.value}"
  else
    node.value.to_s
  end

end


class TablesController < ApplicationController
  before_action :set_table, only: %i[ show edit update destroy ]

  # GET /tables or /tables.json
  def index
    @tables = Table.all
  end

  # GET /tables/1 or /tables/1.json
  def show


    @select_options = SelectOption.where(column_id: @table.columns.pluck(:id))
    # convert @select_options to hash
    @select_options_hash = {}
    @select_options.each do |select_option|
      @select_options_hash[select_option.id] = select_option.text
    end

    columnMap = {}
    @table.columns.each do |column|
      columnMap[column.name] = column
    end

    select_values = @table.columns.map do |column|
      if column.type == "formula"
        f_str = column.setting # "{Unit Sold} * ({Unit Price} - {Unit Cost})"

        columnMap.each do |cname, col|
          if col.type == "number"
            f_str.gsub! "{#{cname}}", "cast(values -> '#{col.code}' AS decimal)"
          elsif col.type == "formula"
            f_str.gsub! "{#{cname}}", "cast(values -> '#{col.code}' AS decimal)"
          else
            f_str.gsub! "{#{cname}}", "cast(values ->> '#{col.code}' AS text)"
          end
        end
        "#{f_str} AS values_#{column.code}"
      else
        "values -> '#{column.code}' AS values_#{column.code}"
      end
    end

    @rows = @table.rows.select([:id].concat(select_values)).page(params[:page]).per(100).order(:id)

  end

  # GET /tables/new
  def new
    @table = Table.new
  end

  # GET /tables/1/edit
  def edit
  end

  # POST /tables or /tables.json
  def create
    @table = Table.new(table_params)

    respond_to do |format|
      if @table.save
        format.html { redirect_to table_url(@table), notice: "Table was successfully created." }
        format.json { render :show, status: :created, location: @table }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @table.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tables/1 or /tables/1.json
  def update
    respond_to do |format|
      if @table.update(table_params)
        format.html { redirect_to table_url(@table), notice: "Table was successfully updated." }
        format.json { render :show, status: :ok, location: @table }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @table.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tables/1 or /tables/1.json
  def destroy
    @table.destroy

    respond_to do |format|
      format.html { redirect_to tables_url, notice: "Table was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_table
      @table = Table.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def table_params
      params.require(:table).permit(:name)
    end
end
