# frozen_string_literal: true

require "whitelist_checker"

class PostcodeLookupController < ApplicationController
  def index
    @postcode = params[:postcode]
    @whitelisted = WhitelistChecker.whitelisted?(@postcode) if @postcode
  rescue => e
    logger.error("Error while grabbing postcode from params and looking up via postcodes gem")
    logger.error(e)
    @whitelisted = false
  end
end
