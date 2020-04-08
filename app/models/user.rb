class User < ApplicationRecord
    has_secure_password

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, length: { minimum: 6 }, presence: true

    has_many :tasks, dependent: :destroy

    before_destroy :least_admin_user

    private

    def least_admin_user
        if User.count < 2 && User.where('admin = true')
            throw :abort
        end
    end
end
