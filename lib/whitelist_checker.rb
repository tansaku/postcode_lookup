# frozen_string_literal: true

require "postcodes_io"

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

    # Heidar made point that we could
    # hit the non-API element first for efficiency
    def whitelisted?
      whitelisted_via_list? || whitelisted_via_lsoa?
    end

    def whitelisted_via_lsoa?
      result&.lsoa&.start_with?(Regexp.union(whitelisted_boroughs))
    end

    def whitelisted_via_list?
      whitelisted_postcodes.include?(postcode)
    end

    # should go back into services now we are dependent on Rails classes
    def whitelisted_boroughs
      Borough.all.pluck(:name)
    end

    def whitelisted_postcodes
      Postcode.all.pluck(:name)
    end
end
