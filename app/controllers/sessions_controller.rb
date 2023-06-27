class SessionsController < ApplicationController
    before_action :already_logged_in, except: :destroy
    skip_before_action :login_required, only: %i(new create)
  
    def new
    end
  
    def create
      user = User.find_by(email: params[:session][:email].downcase)
      if user&.authenticate(params[:session][:password])
        log_in(user)
        redirect_to tasks_path, notice: 'Connecté.'
      else
        flash.now[:alert] = 'Adresse e-mail ou mot de passe incorrect.'
        render :new
      end
    end
  
    def destroy
      session.delete(:user_id)
      redirect_to new_session_path, notice: 'Déconnecté.'
    end
  end