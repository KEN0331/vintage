class Condition < ActiveRecord::Base
  belongs_to :item
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
