class UpdateReviews < ActiveRecord::Migration[7.0]
  def change
    execute 'ALTER TABLE reviews DROP CONSTRAINT fk_rails_74a66bd6c5'
    add_reference :reviews, :reviewable, polymorphic: true, null: false

    add_foreign_key :reviews, :users
  end
end
