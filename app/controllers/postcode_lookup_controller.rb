# frozen_string_literal: true

class PostcodeLookupController < ApplicationController
  def index
    @postcode = params[:postcode]
  end
end
