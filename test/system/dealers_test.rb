require "application_system_test_case"

class DealersTest < ApplicationSystemTestCase
  setup do
    @dealer = dealers(:one)
  end

  test "visiting the index" do
    visit dealers_url
    assert_selector "h1", text: "Dealers"
  end

  test "creating a Dealer" do
    visit dealers_url
    click_on "New Dealer"

    fill_in "Adress", with: @dealer.adress
    fill_in "Miasto", with: @dealer.miasto
    fill_in "Nazwa", with: @dealer.nazwa
    fill_in "Przychody", with: @dealer.przychody
    fill_in "Samochody", with: @dealer.samochody
    fill_in "Telefon", with: @dealer.telefon
    fill_in "Wlasciciel", with: @dealer.wlasciciel
    click_on "Create Dealer"

    assert_text "Dealer was successfully created"
    click_on "Back"
  end

  test "updating a Dealer" do
    visit dealers_url
    click_on "Edit", match: :first

    fill_in "Adress", with: @dealer.adress
    fill_in "Miasto", with: @dealer.miasto
    fill_in "Nazwa", with: @dealer.nazwa
    fill_in "Przychody", with: @dealer.przychody
    fill_in "Samochody", with: @dealer.samochody
    fill_in "Telefon", with: @dealer.telefon
    fill_in "Wlasciciel", with: @dealer.wlasciciel
    click_on "Update Dealer"

    assert_text "Dealer was successfully updated"
    click_on "Back"
  end

  test "destroying a Dealer" do
    visit dealers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Dealer was successfully destroyed"
  end
end
