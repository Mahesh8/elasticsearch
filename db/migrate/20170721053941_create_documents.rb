class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.string :name
      t.string :service
      t.boolean :stamp_required
      t.string :default_price
      t.string :tat
      t.boolean :automated
      t.string :template_url
      t.string :status
      t.string :description
      t.string :priorty
      t.integer :user_id

      t.timestamps
    end
  end
end
