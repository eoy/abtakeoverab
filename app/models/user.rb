class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  if Rails.env.production?
    devise :database_authenticatable, :recoverable,
           :rememberable, :trackable, :validatable,
            :timeoutable, :timeout_in => 15.minutes
  else
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable,
           :validatable, :timeoutable, :timeout_in => 15.minutes
  end
end
