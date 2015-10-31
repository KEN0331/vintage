class Recommendation < ActiveRecord::Base
  belongs_to :item
  has_one :recommendation_image
  accepts_nested_attributes_for :recommendation_image, allow_destroy: true, update_only: true
  scope :active, lambda { where(:deleted => false) }
    
  class << self
    def search(query)
      rel=order("id")
      if query.present?
        rel=rel.where("item_id Like ?", "%#{query}%")
      end
      rel
    end
  end
end
