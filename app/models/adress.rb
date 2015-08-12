class Adress < ActiveRecord::Base
  belongs_to :user
  belongs_to :purchase
  scope :active, lambda { where(:deleted => false) }
end
