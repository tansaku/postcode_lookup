# frozen_string_literal: true

require "spec_helper"
require "whitelist_checker"

describe WhitelistChecker, focuse: true do
  let(:postcodes) { double :postcodes, lookup: result }
  let(:postcodes_io) { double :postcodes_io, new: postcodes }
  subject { described_class }

  context "Lambeth postcode" do
    let(:result) { double :result, lsoa: "Lambeth 036" }
    it "is whitelisted" do
      expect(subject.whitelisted?("SE1 7QA", postcodes_io)).to be_truthy
    end
  end

  context "Southwark postcode" do
    let(:result) { double :result, lsoa: "Southwark 034A" }
    it "is whitelisted" do
      expect(subject.whitelisted?("SE1 7QD", postcodes_io)).to be_truthy
    end
  end

  context "specifically whitelisted API unknown postcode" do
    let(:postcodes) { double :postcodes, lookup: nil }
    it "is whitelisted, e.g. 'SH24 1AA'" do
      expect(subject.whitelisted?("SH24 1AA")).to be_truthy
    end
    it "is whitelisted, e.g. 'SH24 1AB'" do
      expect(subject.whitelisted?("SH24 1AB")).to be_truthy
    end
  end

  context "Harrow postcode" do
    let(:result) { double :result, lsoa: "Harrow 021A" }
    it "is not whitelisted" do
      expect(subject.whitelisted?("HA1 4LX")).to be_falsy
    end
  end

  context "API unknown postcodes that are not on the whitelist" do
    let(:postcodes) { double :postcodes, lookup: nil }
    it "is not whitelisted" do
      expect(subject.whitelisted?("RR5 7QQ")).to be_falsy
    end
  end
  context "Errors" do
    context "lsoa is empty string" do
      let(:result) { double :result, lsoa: "" }
      it "postcode is not whitelisted" do
        expect(subject.whitelisted?("RR5 7QQ")).to be_falsy
      end
    end
  end
end
