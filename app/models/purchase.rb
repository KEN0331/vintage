class Purchase < ActiveRecord::Base
  has_many :items
  scope :active, lambda { where(:deleted => false) }
  serialize :item_id_list
  accepts_nested_attributes_for :items
  
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
