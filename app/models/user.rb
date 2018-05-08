class User < ApplicationRecord
    has_secure_password

    validates :email, :username, :password_digest, presence: true
end
