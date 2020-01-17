# frozen_string_literal: true

require "spec_helper"
require "whitelist_checker"

describe WhitelistChecker do
  subject { described_class }
  it "whitelists Lambeth postcodes" do
    expect(subject.whitelisted?("SE1 7QA")).to be_truthy
  end
  it "whitelists Southwark postcodes" do
    expect(subject.whitelisted?("SE1 7QD")).to be_truthy
  end
  it "whitelists some API unknown postcodes, e.g. 'SH24 1AA'" do
    expect(subject.whitelisted?("SH24 1AA")).to be_truthy
  end
  it "whitelists some API unknown postcodes, e.g. 'SH24 1AB'" do
    expect(subject.whitelisted?("SH24 1AB")).to be_truthy
  end
  it "does not whitelist Harrow postcodes" do
    expect(subject.whitelisted?("HA1 4LX")).to be_falsy
  end
end
