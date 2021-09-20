class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  add_flash_types :info, :success

  include Pundit

  # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    def user_not_authorized
     flash[:alert] = "You are not authorized to perform this action."
     redirect_to(root_path)
    end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/ || params[:controller] == "onboarding/dashboards" || params[:controller] == "profiles" || params[:controller] == "documents" || params[:controller] == "videos" || params[:controller] == "blogs" || params[:controller] == "headshots" || params[:controller] == "socials" || params[:controller] == "support_tasks" || params[:controller] == "licenses"
  end
end
