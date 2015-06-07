class Admission < ActiveRecord::Base


  validates_presence_of :sclass_id, :totalfee, :startdate, :enddate, :user, :sclass, :subject
  validate :end_date_is_after_start_date

  belongs_to :user
  belongs_to :sclass
  belongs_to :subject

  has_attached_file :feestructure, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :feestructure, :content_type => /\Aimage\/.*\Z/


  filterrific :default_filter_params => { :sorted_by => 'totalfee_desc' },
              :available_filters => %w[
                sorted_by
                search_query
                with_subject_id
                with_sclass_id
                with_user_name
                with_user_city
                with_user_state
                with_totalfee_gte
                with_totalfee_lt
                with_startdate_gte
                with_enddate_lt
                with_user_schooltype
              ]
  
  self.per_page = 15
  
  
  scope :search_query, lambda { |query|
         where("users.pincode LIKE ?", "%#{query}%").joins(:user)
         }
  
  # always include the lower boundary for semi open intervals
  scope :with_totalfee_gte, lambda { |total_fee|
      where('admissions.totalfee >= ?', total_fee)
  }

# always exclude the upper boundary for semi open intervals
  scope :with_totalfee_lt, lambda { |total_fee|
      where('admissions.totalfee < ?', total_fee)
  }
  # always include the lower boundary for semi open intervals
  scope :with_startdate_gte, lambda { |start_ddate|
      where('admissions.startdate >= ?', start_ddate)
  }

# always exclude the upper boundary for semi open intervals
  scope :with_enddate_lt, lambda { |end_ddate|
      where('admissions.enddate < ?', end_ddate)
  }  
  scope :with_user_name, lambda { |user_name|
        where('users.name LIKE ?', "%#{user_name}%").joins(:user)
      }
  
  scope :with_user_city, lambda { |user_city|
        where('users.city = ?', user_city).joins(:user)
      }
  
  scope :with_user_state, lambda { |user_state|
        where('users.state = ?', user_state).joins(:user)
    }

  scope :with_user_schooltype, lambda { |school_type|
        where('users.schooltype = ?', school_type).joins(:user)
    }
  
  scope :sorted_by, lambda { |sort_option|
   direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
        case sort_option.to_s
        when /^enddate_/
          order("admissions.enddate #{ direction }")
        when /^startdate_/
          order("admissions.startdate #{ direction }")
        when /^totalfee_/
          order("admissions.totalfee #{ direction }")
        when /^user_name_/
          order("LOWER(users.name) #{ direction }").joins(:user)
        when /^user_city_/
          order("LOWER(users.city) #{ direction }").joins(:user)
        else
        raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
        end
}

  scope :with_subject_id, lambda { |subject_ids|
  return nil if subject_ids == [""]
  where(subject_id: [*subject_ids])
}
  
  scope :with_sclass_id, lambda { |sclass_ids|
  return nil if sclass_ids == [""]
  where(sclass_id: [*sclass_ids])
}
  
  def self.options_for_sorted_by
    [
      ['Start date(newest)', 'startdate_desc'],
      ['Start date(last)', 'startdate_asc'],
      [],
      ['Closing date(newest)', 'enddate_desc'],
      ['Closing date(last)', 'enddate_asc'],
      [],
      ['FEE lowest to highest', 'totalfee_asc'],
      ['FEE highest to lowest', 'totalfee_desc'],
      [],
      ['User name (A-Z)', 'user_name_asc'],
      ['User name (Z-A)', 'user_name_desc'],
      [],
      ['City name (A-Z)', 'user_city_asc'],
      ['City name (Z-A)', 'user_city_desc']      
    ]
    
  end
  

private


def end_date_is_after_start_date
  return if enddate.blank? || startdate.blank?
  if enddate < startdate
    errors.add(:enddate, "cannot be before the Opening date") 
  end 
end


  #def self.search(query)
  #  # where(:title, query) -> This would return an exact match of the query
  #  where("subject_id like ?", "%#{query}%") 
  #end
  
end
