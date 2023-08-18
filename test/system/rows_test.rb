require "application_system_test_case"

class RowsTest < ApplicationSystemTestCase
  setup do
    @row = rows(:one)
  end

  test "visiting the index" do
    visit rows_url
    assert_selector "h1", text: "Rows"
  end

  test "should create row" do
    visit rows_url
    click_on "New row"

    fill_in "Table", with: @row.table_id
    fill_in "Values", with: @row.values
    click_on "Create Row"

    assert_text "Row was successfully created"
    click_on "Back"
  end

  test "should update Row" do
    visit row_url(@row)
    click_on "Edit this row", match: :first

    fill_in "Table", with: @row.table_id
    fill_in "Values", with: @row.values
    click_on "Update Row"

    assert_text "Row was successfully updated"
    click_on "Back"
  end

  test "should destroy Row" do
    visit row_url(@row)
    click_on "Destroy this row", match: :first

    assert_text "Row was successfully destroyed"
  end
end
