class Item < ActiveRecord::Base
  has_one :subcaregory
  has_one :denomination
  has_one :condition
  has_one :fabric
  has_many :purchases
  has_one :main_image
  accepts_nested_attributes_for :main_image, allow_destroy: true, update_only: true
  has_many :subimages
  accepts_nested_attributes_for :subimages, allow_destroy: true, update_only: true
  has_one :new_arrival  
  accepts_nested_attributes_for :new_arrival, allow_destroy: true, update_only: true
  has_one :recommendation
  accepts_nested_attributes_for :recommendation, allow_destroy: true, update_only: true
  scope :active, lambda { where(:deleted => false) }

 class << self
   def search(query)
     rel=order("id")
     if query.present?
       rel=rel.where("name Like ?", "%#{query}%")
     end
     rel
   end
 end

end
