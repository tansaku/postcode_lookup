# frozen_string_literal: true

require "postcodes_io"
WHITELISTED_POSTCODES = ["SH24 1AA", "SH24 1AB"]
WHITELISTED_BOROUGHS = %w[Southwark Lambeth]

class WhitelistChecker
  def self.whitelisted?(postcode, api = Postcodes::IO)
    pio = api.new
    result = pio.lookup(postcode)
    if result && result.lsoa
      result.lsoa.start_with?(Regexp.union(WHITELISTED_BOROUGHS))
    else
      WHITELISTED_POSTCODES.include?(postcode)
    end
  end
end
