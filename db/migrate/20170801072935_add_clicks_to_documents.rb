class AddClicksToDocuments < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :clicks, :integer, :default => 0
  end
end
