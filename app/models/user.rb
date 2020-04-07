class User < ApplicationRecord
    before_save { self.email.downcase! }
    # 名前は最大40文字
    validates :name, presence: true, length: { maximum: 40 }
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
    has_secure_password
    has_secure_token

    has_many :tasks, dependent: :destroy
end
