class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many:admissions
    
  def self.options_for_select1
  order('LOWER(TRIM(city))').map { |e| [e.city, e.city] }.uniq
  end
  
  def self.options_for_select2
    [
      ['Raj', 'Raj'],
      ['MH', 'MH'],
      ['MP', 'MP']
    ]
  end
  
  def self.options_for_select3
    [
      ['Co-ed', 'Co-ed'],
      ['Girls only', 'Girls only'],
      ['Boys only', 'Boys only']
    ]
  end
  
end
