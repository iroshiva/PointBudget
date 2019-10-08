# frozen_string_literal: true

class FullSimulation < ApplicationRecord
  belongs_to :user
  has_one :gas_simulation, dependent: :destroy
  has_one :box_simulation, dependent: :destroy
  has_one :ele_simulation, dependent: :destroy
  has_one :bank_simulation, dependent: :destroy
  has_one :mobil_simulation, dependent: :destroy

  validates :total_cost_saved,
            presence: true,
            numericality: { greater_than_or_equal_to: 0.00 }

  # Check if the full simulation has already a gas simulation
  def only_one_gas_simulation
    gas_simulation.nil? ? false : true
  end

  # Check if the full simulation has already a box simulation
  def only_one_box_simulation
    box_simulation.nil? ? false : true
  end

  # Check if the full simulation has already a bank simulation
  def only_one_bank_simulation
    bank_simulation.nil? ? false : true
  end

  # Check if the full simulation has already a ele simulation
  def only_one_ele_simulation
    ele_simulation.nil? ? false : true
  end

  def only_one_mobil_simulation
    mobil_simulation.nil? ? false : true
  end

  private

  # For now we disabled it, to much spam but we keep it in case of...
  # Send an email when the full simulation is validated by the user
  def mail_if_validated
    UserMailer.simulation_validated_email(user).deliver_now if validated
  end
end
