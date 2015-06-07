class Sclass < ActiveRecord::Base

  has_many:admissions
  
  def self.options_for_select
  order('LOWER(id)').map { |e| [e.sclassname, e.id] }
  end

end
