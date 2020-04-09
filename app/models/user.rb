class User < ApplicationRecord
    has_secure_password

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, length: { minimum: 6 }, presence: true

    has_many :tasks, dependent: :destroy

    before_destroy :least_admin_user

    private
    
    def least_admin_user
        if self.admin?
            throw :abort if User.where(admin: true).count < 2
        end
    end
end
