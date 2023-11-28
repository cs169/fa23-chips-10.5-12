# frozen_string_literal: true
class AddMoreDetailsToRepresentatives < ActiveRecord::Migration[5.2]
  def change
    add_column :representatives, :address, :string
    add_column :representatives, :city, :string
    add_column :representatives, :zip, :string
    add_column :representatives, :party, :string
    add_column :representatives, :photo, :string
  end
end
