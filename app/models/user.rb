class User < ApplicationRecord
  has_many :reports
  paginates_per 3
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  after_create :assign_default_role
  validate :must_have_a_role, on: :update


  private
  def assign_default_role
    self.add_role(:newuser) if self.roles.blank?
  end

  def must_have_a_role
    unless roles.any?
      errors.add(:roles, 'There should be atleast 1 Role assigned.')
    end
  end
end
