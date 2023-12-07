class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    if resource.class.name == "User"
       root_path
    else
      admin_homes_top_path
    end
  end
end
