class Administrator < ActiveRecord::Base
  scope :active, lambda { where(:deleted => false) }
  has_secure_password
    
  validates :password, presence: { on: :create },
    confirmation: { allow_blank: true }
  
  def password=(val)
    if val.present?
      self.password_digest = BCrypt::Password.create(val)
    end
    @password = val
  end 
  

   
  class << self
    def authenticate(userid, password)
      administrator = find_by_userid(userid)
      if administrator && administrator.password_digest.present? &&
        BCrypt::Password.new(administrator.password_digest) == password
        administrator
      else
        nil
      end
    end
    
    
    def search(query)
      rel=order("id")
      if query.present?
        rel=rel.where("name Like ?", "%#{query}%")
      end
      rel
    end
  end
end
