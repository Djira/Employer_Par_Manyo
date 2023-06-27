class Admin::UsersController < ApplicationController
    before_action :set_user, only: %i(show edit update destroy)
    before_action :admin_required
  
    def index
      @users = User.includes(:tasks).all
    end
  
    def show
    end
  
    def new
      @user = User.new
    end
  
    def edit
    end
  
    def create
      @user = User.new(user_params)
  
      if @user.save
        redirect_to admin_users_path, notice: 'L utilisateur a été enregistré.'
      else
        render :new
      end
    end
  
    def update
      if @user.update(user_params)
        redirect_to admin_users_path, notice: 'Utilisateur mis à jour.'
      else
        render :edit
      end
    end
  
    def destroy
      if @user.destroy
        redirect_to admin_users_path, notice: 'Utilisateur supprimé.'
      else
        redirect_to admin_users_path, alert: 'Ne peut être supprimé car il n y a aucun compte ayant des droits d administration.'
      end
    end
  
    private
      def set_user
        @user = User.find(params[:id])
      end
  
      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
      end
  end