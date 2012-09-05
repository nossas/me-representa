class AddShortUrlToCandidate < ActiveRecord::Migration
  def change
    add_column :candidates, :short_url, :string
  end
end
