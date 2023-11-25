# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.contains_official(official)
    current_reps = Representative.all
    current_reps.each do |rep|
      return true if rep.name == official.name
    end
    false
  end

  def self.civic_api_to_representative_params(rep_info)
    reps = []

    rep_info.officials.each_with_index do |official, index|
      next if contains_official(official)

      ocdid_temp = ''
      title_temp = ''

      rep_info.offices.each do |office|
        if office.official_indices.include? index
          title_temp = office.name
          ocdid_temp = office.division_id
        end
      end

      rep = Representative.create!({ name: official.name, ocdid: ocdid_temp,
          title: title_temp })
      reps.push(rep)
    end

    reps
  end
end
