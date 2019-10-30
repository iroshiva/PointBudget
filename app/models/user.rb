# frozen_string_literal: true

class User < ApplicationRecord
  after_create :welcome_send
  before_destroy :goodbye_send
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  devise :omniauthable, omniauth_providers: [:facebook]

  validates :phone_number,
            format: { with: /\A((\+)33|0)[1-9](\d{2}){4}\Z/ },
            allow_blank: true

  belongs_to :city, optional: true
  has_many :full_simulations, dependent: :destroy
  has_many :gas_simulations, through: :full_simulations, dependent: :destroy
  has_many :box_simulations, through: :full_simulations, dependent: :destroy
  has_many :bank_simulations, through: :full_simulations, dependent: :destroy
  has_many :ele_simulations, through: :full_simulations, dependent: :destroy
  has_many :mobil_simulations, through: :full_simulations, dependent: :destroy


  # For omniauth faceboook
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

# For omniauth faceboook
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end
  
  # return true if the user has a city
  def city?
    city.nil? || city.blank? ? false : true
  end

  # return true if the user is the last admin
  def last_admin?
    is_admin && User.select{ |user| user.is_admin == true }.count == 1
  end

  # verify if he has a gas simulation with the good id (for callbacks)
  def has_gas_simulation(id)
    self.gas_simulations.include?{ |simu| simu.id == id }
  end
  # verify if he has a box simulation with the good id (for callbacks)
  def has_box_simulation(id)
    self.box_simulations.include?{ |simu| simu.id == id }
  end

# verify if he has a bank simulation with the good id (for callbacks)
  def has_bank_simulation(id)
    self.bank_simulations.include?{ |simu| simu.id == id }
  end

  # verify if he has a mobil simulation with the good id (for callbacks)
  def has_mobil_simulation(id)
    self.mobil_simulations.include?{ |simu| simu.id == id }
  end
  # verify if he has a elec simulation with the good id (for callbacks)

  def has_ele_simulation(id)
    self.ele_simulations.include?{ |simu| simu.id == id }
  end

  # verify if he has a full simulation with the good id (for callbacks)
  def has_full_simulation(id)
    self.full_simulations.include?{ |simu| simu.id == id }
  end

  private

  # send an email when sign up
  def welcome_send
    begin
    UserMailer.welcome_email(self).deliver_now
    rescue
    end
  end

  # send an email when cancel the account
  def goodbye_send
    begin
    UserMailer.goodbye_email(self).deliver_now
    rescue
    end
  end
end
