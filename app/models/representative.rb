# frozen_string_literal: true

require 'google/apis/civicinfo_v2'

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.contains_official(official)
    Representative.exists?({ name: official.name })
  end

  def self.build_or_create_rep(official, ocdid_temp, title_temp)
    if contains_official(official)
      rep = Representative.find_by({ name: official.name })
      rep.title = title_temp
      rep.ocdid = ocdid_temp
      rep.save
      rep
    else
      Representative.create({ name: official.name, ocdid: ocdid_temp,
        title: title_temp })
    end
  end

  def self.civic_api_to_representative_params(rep_info)
    reps = []

    rep_info.officials.each_with_index do |official, index|
      ocdid_temp = ''
      title_temp = ''

      rep_info.offices.each do |office|
        if office.official_indices.include? index
          title_temp = office.name
          ocdid_temp = office.division_id
        end
      end
      rep = build_or_create_rep(official, ocdid_temp, title_temp)
      reps.push(rep)
    end
    reps
  end

  def self.get_representatives_by_ocdid(ocdid)
    service = civic_info_service
    service.key = Rails.application.credentials[:GOOGLE_API_KEY]
    begin
      service.representative_info_by_division(ocdid).officials
    rescue Google::Apis::ClientError
      []
    end
  end

  def self.civic_info_service
    Google::Apis::CivicinfoV2::CivicInfoService.new
  end
end
