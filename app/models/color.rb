class Color < ActiveRecord::Base
  belongs_to :status
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
