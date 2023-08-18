require "application_system_test_case"

class SelectOptionsTest < ApplicationSystemTestCase
  setup do
    @select_option = select_options(:one)
  end

  test "visiting the index" do
    visit select_options_url
    assert_selector "h1", text: "Select options"
  end

  test "should create select option" do
    visit select_options_url
    click_on "New select option"

    fill_in "Column", with: @select_option.column_id
    fill_in "Text", with: @select_option.text
    click_on "Create Select option"

    assert_text "Select option was successfully created"
    click_on "Back"
  end

  test "should update Select option" do
    visit select_option_url(@select_option)
    click_on "Edit this select option", match: :first

    fill_in "Column", with: @select_option.column_id
    fill_in "Text", with: @select_option.text
    click_on "Update Select option"

    assert_text "Select option was successfully updated"
    click_on "Back"
  end

  test "should destroy Select option" do
    visit select_option_url(@select_option)
    click_on "Destroy this select option", match: :first

    assert_text "Select option was successfully destroyed"
  end
end
