# frozen_string_literal: true

require "rails_helper"

feature "lookup postcode", type: :feature do
  scenario "check a non whitelisted postcode" do
    visit "/"

    fill_in "PostCode", with: "HA1 4LX"
    click_button "Submit"

    expect(page).to have_text("HA1 4LX is not whitelisted")
  end
end
