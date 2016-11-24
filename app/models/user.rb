# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string
#  last_name              :string
#  email                  :string
#  birthday               :date
#  gender                 :integer
#  slug                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string           default("email"), not null
#  uid                    :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  tokens                 :json
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # note that this include statement comes AFTER the devise block above
  include DeviseTokenAuth::Concerns::User

  extend FriendlyId
  friendly_id :friendly_name, use: [:slugged, :finders]

  has_many :workouts, inverse_of: :user, dependent: :destroy

  private
  # ============================================================
  #                 FriendlyID Customizations
  # ============================================================
  # Tells rails to only generate new Friendly ID if its a new record.
  def should_generate_new_friendly_id?
    new_record? || slug.blank?
  end

  def friendly_name
    "#{first_name.capitalize if first_name} #{last_name.capitalize if last_name}"
  end

  def active_model_serializer
    CurrentUserSerializer
  end
end
