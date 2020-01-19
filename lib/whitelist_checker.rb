# frozen_string_literal: true

require "postcodes_io"
WHITELISTED_POSTCODES = ["SH24 1AA", "SH24 1AB"]

class WhitelistChecker
  def self.whitelisted?(postcode, api = Postcodes::IO)
    self.send(:new, postcode, api).send(:whitelisted?)
  end

  private
    attr_reader :pio, :postcode, :result

    def initialize(postcode, api)
      @pio = api.new
      @postcode = postcode
      @result = pio.lookup(postcode)
    end

    def whitelisted?
      return whitelisted_via_lsoa? if lsoa_present?

      whitelisted_via_list?
    end

    def lsoa_present?
      result && result.lsoa
    end

    def whitelisted_via_lsoa?
      result.lsoa.start_with?(Regexp.union(whitelisted_boroughs))
    end

    def whitelisted_via_list?
      whitelisted_postcodes.include?(postcode)
    end

    def whitelisted_boroughs
      Borough.all.pluck(:name)
    end

    def whitelisted_postcodes
      Postcode.all.pluck(:name)
    end
end
