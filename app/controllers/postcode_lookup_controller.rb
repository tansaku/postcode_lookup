# frozen_string_literal: true

require "whitelist_checker"

class PostcodeLookupController < ApplicationController
  def index
    @postcode = params[:postcode]
    @whitelisted = WhitelistChecker.whitelisted?(@postcode) if @postcode
  end
end
