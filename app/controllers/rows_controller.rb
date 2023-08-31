class RowsController < ApplicationController
  before_action :set_table
  before_action :set_row, only: %i[ show edit update destroy ]

  # GET /rows or /rows.json
  def index
    @rows = Row.all
  end

  # GET /rows/1 or /rows/1.json
  def show
  end

  # GET /rows/new
  def new
    @row = @table.rows.new
  end

  # GET /rows/1/edit
  def edit
  end

  # POST /rows or /rows.json
  def create
    @row = @table.rows.new(row_params)

    respond_to do |format|
      if @row.save
        format.html { redirect_to table_rows_url(@table, @row), notice: "Row was successfully created." }
        format.json { render :show, status: :created, location: @row }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @row.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rows/1 or /rows/1.json
  def update
    respond_to do |format|
      updated_values = {}
      @table.columns.each do |column|
        case column.type
        when 'single_select'
          updated_values[column.code] = row_params[:values][column.code].to_i
        when 'single_line_text'
          updated_values[column.code] = row_params[:values][column.code]
        when 'date'
          updated_values[column.code] = row_params[:values][column.code]
        when 'number'
          updated_values[column.code] = row_params[:values][column.code].to_i
        when 'formula'
          # Do nothing
        end
      end
      puts updated_values
      puts row_params
      if @row.update_attribute :values, updated_values
        format.html { redirect_to table_url(@table), notice: "Row was successfully updated." }
        format.json { render :show, status: :ok, location: @row }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @row.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rows/1 or /rows/1.json
  def destroy
    @row.destroy

    respond_to do |format|
      format.html { redirect_to rows_url, notice: "Row was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_row
      @row = @table.rows.find(params[:id])
    end

    def set_table
      @table = Table.find(params[:table_id])
    end

    # Only allow a list of trusted parameters through.
    def row_params
      params.require(:row).permit(values: @table.columns.pluck(:code))
    end
end
