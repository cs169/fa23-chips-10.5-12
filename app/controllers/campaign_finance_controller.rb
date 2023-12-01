# frozen_string_literal: true

require_relative '../adapters/propublica_adapter'

class CampaignFinanceController < ApplicationController
  def index
    @cycles = (PropublicaAdapter::START_CYCLE..PropublicaAdapter::CURRENT_CYCLE).step(2).sort.to_a
    @categories = preprocess_categories(PropublicaAdapter::CATEGORIES)
  end

  def search
    @cycle = params[:cycle]
    @category = params[:category]
    @top_candidates = CampaignFinanceController.get_top_20_candidates_by_cycle_and_category(@cycle, @category)
  end

  def self.get_top_20_candidates_by_cycle_and_category(cycle, category)
    candidate_adapter = PropublicaAdapter::Candidate.new
    candidate_adapter.get_top_20_by_cycle_and_category(cycle, category)
  end

  private

  def preprocess_categories(categories)
    categories.transform_values { |v| v.titleize.gsub('-', ' ') }
  end
end
