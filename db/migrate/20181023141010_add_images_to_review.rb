class AddImagesToReview < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :images, :string
  end
end
