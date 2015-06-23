class VisitorsController < ApplicationController
  def listing
    
  end
  
  def index 
    
    @filterrific = initialize_filterrific(
      Admission,
      params[:filterrific],
      :select_options => {
        sorted_by: Admission.options_for_sorted_by,
        with_subject_id: Subject.options_for_select,
        with_sclass_id: Sclass.options_for_select,
        with_user_city: User.options_for_select1,
        with_user_state: User.options_for_select2,
        with_user_schooltype: User.options_for_select3
      }
    ) or return
    @admissions = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end
  
end
