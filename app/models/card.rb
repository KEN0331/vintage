class Card < ActiveRecord::Base
  has_one :user
  belongs_to :purchase
  scope :active, lambda { where(:deleted => false) }
end
