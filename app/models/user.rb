class User < ActiveRecord::Base
  has_many :adresses
  accepts_nested_attributes_for :adresses, allow_destroy: true, update_only: true
  has_many :cards
  accepts_nested_attributes_for :cards, allow_destroy: true, update_only: true
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  scope :active, lambda { where(:deleted => false) }

  class << self
    def search(query)
      rel=order("id")
      if query.present?
        rel=rel.where("name Like ?", "%#{query}%")
      end
      rel
    end
    
    def search_by_email(query)
      rel=order("id")
      if query.present?
        rel=rel.where("email Like ?", "%#{query}%")
      end
      rel
    end
  end
end
