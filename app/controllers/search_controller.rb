# frozen_string_literal: true

require 'google/apis/civicinfo_v2'

class SearchController < ApplicationController
  def search
    address = params[:address]
    if address.blank?
      flash[:alert] = 'Please enter a location.'
      redirect_to representatives_path and return
    end
    service = Google::Apis::CivicinfoV2::CivicInfoService.new
    service.key = Rails.application.credentials[:GOOGLE_API_KEY]
    begin
      result = service.representative_info_by_address(address: address)
      if result.officials.blank?
        flash[:notice] = 'No representative information found.'
        redirect_to representatives_path and return
      end
      @representatives = Representative.civic_api_to_representative_params(result)

      render 'representatives/search'
    rescue Google::Apis::Error
      flash[:alert] = 'Invalid location.'
      redirect_to representatives_path and return
    end
  end
end
