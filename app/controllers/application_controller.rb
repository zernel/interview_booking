class ApplicationController < ActionController::Base
  def admin_controllers?
    false
  end
  helper_method :admin_controllers?
end
