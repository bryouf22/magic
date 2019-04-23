# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  nickname               :string
#  avatar                 :string
#  presentation           :text
#

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_one :card_collection, dependent: :destroy

  has_many :decks, dependent: :destroy
  has_many :wishlists, dependent: :destroy

  after_create :create_card_collection

  def is_admin?
    ['jean@val.jean', 'bryouf@free.fr'].include?(email)
  end

  def name
    nickname.presence || email.split('@').first
  end

  private

  def create_card_collection
    CardCollection.create(user_id: id)
  end
end
