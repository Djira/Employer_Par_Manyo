class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
  include SessionsHelper

  before_action :login_required
  
  private
    def login_required
      redirect_to new_session_path, alert: "Se connecter." unless current_user
    end

    def already_logged_in
      redirect_to tasks_path, alert: "Déconnexion." if current_user
    end

    def admin_required
      redirect_to tasks_path, alert: "Seuls les administrateurs y ont accès." unless current_user.admin
    end
    
    def current_user_required(user)
      redirect_to tasks_path, alert: "Il est le seul à y avoir accès." unless current_user ==  user
    end
end
