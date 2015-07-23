class ItemType < ActiveRecord::Base
  has_many :units
  scope :active, lambda { where(:deleted => false) }
  serialize :unit_id_list
  accepts_nested_attributes_for :units
  
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
