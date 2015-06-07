class Subject < ActiveRecord::Base

  has_many:admissions
  
  def self.options_for_select
  order('LOWER(subjectname)').map { |e| [e.subjectname, e.id] }
  end
  
end
