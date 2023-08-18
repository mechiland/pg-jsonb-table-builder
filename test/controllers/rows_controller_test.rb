require "test_helper"

class RowsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @row = rows(:one)
  end

  test "should get index" do
    get rows_url
    assert_response :success
  end

  test "should get new" do
    get new_row_url
    assert_response :success
  end

  test "should create row" do
    assert_difference("Row.count") do
      post rows_url, params: { row: { table_id: @row.table_id, values: @row.values } }
    end

    assert_redirected_to row_url(Row.last)
  end

  test "should show row" do
    get row_url(@row)
    assert_response :success
  end

  test "should get edit" do
    get edit_row_url(@row)
    assert_response :success
  end

  test "should update row" do
    patch row_url(@row), params: { row: { table_id: @row.table_id, values: @row.values } }
    assert_redirected_to row_url(@row)
  end

  test "should destroy row" do
    assert_difference("Row.count", -1) do
      delete row_url(@row)
    end

    assert_redirected_to rows_url
  end
end
