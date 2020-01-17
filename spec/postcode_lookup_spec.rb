# frozen_string_literal: true

require "rails_helper"

feature "lookup postcode", type: :feature do
  scenario "check a non whitelisted postcode" do
    visit "/"

    fill_in "postcode", with: "HA1 4LX"
    click_button "Submit"

    expect(page).to have_text("HA1 4LX is not whitelisted")
  end
  scenario "check a Southwark whitelisted postcode", focus: false do
    visit "/"

    fill_in "postcode", with: "SE1 7QD"
    click_button "Submit"

    expect(page).to have_text("SE1 7QD is whitelisted")
  end
  scenario "check a Lambeth whitelisted postcode" do
    visit "/"

    fill_in "postcode", with: "SE1 7QA"
    click_button "Submit"

    expect(page).to have_text("SE1 7QA is whitelisted")
  end
end
