# frozen_string_literal: true

require "postcodes_io"
WHITELISTED = ["SH24 1AA", "SH24 1AB"]

class WhitelistChecker
  def self.whitelisted?(postcode)
    pio = Postcodes::IO.new
    result = pio.lookup(postcode)
    if result
      result.lsoa.start_with?(/Southwark|Lambeth/)
    else
      # byebug
      WHITELISTED.include?(postcode)
    end
  end
end
