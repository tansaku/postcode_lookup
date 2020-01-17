# frozen_string_literal: true

require "postcodes_io"

class PostcodeLookupController < ApplicationController
  def index
    @postcode = params[:postcode]
    pio = Postcodes::IO.new
    postcode = pio.lookup(@postcode) if @postcode
    @whitelisted = postcode.lsoa.start_with?(/Southwark|Lambeth/) if postcode
  end
end
