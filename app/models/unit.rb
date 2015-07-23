class Unit < ActiveRecord::Base
  has_many :item_types
  scope :active, lambda { where(:deleted => false) }
    
  def name_and_unit
      self.name + ' (' + self.unit + ')'
  end
    
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
