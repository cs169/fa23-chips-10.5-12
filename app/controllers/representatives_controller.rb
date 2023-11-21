# frozen_string_literal: true

class RepresentativesController < ApplicationController
  def index
    @representatives = Representative.all
  end

  def show
    #look up representative by id (ocdid?)
    #id = params[:id]
    #@representative = Representative.find(id)
  end
end
