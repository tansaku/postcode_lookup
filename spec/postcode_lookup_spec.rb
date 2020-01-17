# frozen_string_literal: true

require "rails_helper"

feature "lookup postcode", type: :feature do
  scenario "check a non whitelisted postcode" do
    submit_postcode("HA1 4LX")
    expect(page).to have_text("HA1 4LX is not whitelisted")
  end

  scenario "check a Southwark postcode is whitelisted", focus: false do
    submit_postcode("SE1 7QD")
    expect(page).to have_text("SE1 7QD is whitelisted")
  end

  scenario "check a Lambeth postcode is whitelisted" do
    submit_postcode("SE1 7QA")
    expect(page).to have_text("SE1 7QA is whitelisted")
  end

  scenario "check an unknown postcode is whitelisted" do
    submit_postcode("SH24 1AA")
    expect(page).to have_text("SH24 1AA is whitelisted")
  end

  scenario "check an API unknown postcode is whitelisted when specified" do
    submit_postcode("SH24 1AA")
    expect(page).to have_text("SH24 1AA is whitelisted")
  end

  scenario "check an API unknown postcode is not whitelisted" do
    submit_postcode("RR24 1QQ")
    expect(page).to have_text("RR24 1QQ is not whitelisted")
  end

  scenario "handle error from WhitelistChecker" do
    expect(WhitelistChecker).to receive(:whitelisted?).and_raise(StandardError, "some failure")
    submit_postcode("RR24 1QQ")
    expect(page).to have_text("RR24 1QQ is not whitelisted")
  end
end

def submit_postcode(postcode)
  visit "/"

  fill_in "postcode", with: postcode
  click_button "Submit"
end
