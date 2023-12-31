# frozen_string_literal: true

class RepresentativesController < ApplicationController
  def index
    @representatives = Representative.all
  end

  def show
    @representative = Representative.find(params[:id])
    officials = Representative.get_representatives_by_ocdid(@representative.ocdid)
    @details = officials.find { |official| official.name == @representative.name }
    @photo_url_exists = @details.respond_to?(:photo_url) && @details.photo_url
  end
end
