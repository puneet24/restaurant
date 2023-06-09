class User < ApplicationRecord
    require "securerandom"

    has_secure_password
    has_many :orders

    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, on: :create
    validates :username, presence: true, uniqueness: true

    def is_admin
        self.role == "admin"
    end
end
