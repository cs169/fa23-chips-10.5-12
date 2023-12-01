# frozen_string_literal: true

class RepresentativesController < ApplicationController
  def index
    @representatives = Representative.all
  end

  def show
    @representative = Representative.find(
      params[:id]
    )
    officials = Representative.get_representatives_by_ocdid(@representative.ocdid)
    @details = officials.find { |official| official.name == @representative.name }
    if @details.respond_to?(:photo_url) && @details.photo_url
      @photo_url_exists = true
    else
      @photo_url_exists = false
    end
  end
end
