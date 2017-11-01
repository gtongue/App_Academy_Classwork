# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  validates :username, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}

  after_initialize :ensure_session_tokenn

  has_many :cats,
    foreign_key: :user_id,
    class_name: :Cat

  has_many :requests,
    foreign_key: :user_id,
    class_name: :CatRentalRequest

  has_many :session_tokens,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :SessionToken

  attr_reader :password
  attr_reader :session_token

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  # Adds session token to :session_token joins table
  def session_token=(session_token)
    @session_token = session_token

  end

  def valid_password?(password)
    password_hash = BCrypt::Password.new(self.password_digest)
    password_hash.is_password?(password)
  end

  def ensure_session_token
    @session_token ||= SecureRandom::urlsafe_base64
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil if user.nil?
    user.valid_password?(password) ? user : nil
  end

end
