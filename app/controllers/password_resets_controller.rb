# encoding: UTF-8

class PasswordResetsController < ApplicationController
  before_filter :load_user, only: [:update]
  def new
  end
  
  def create
    @user = User.where(email: params[:user][:email]).first
    
    respond_to do |format|
      if @user.present?
        @user.reset_password
        format.html { redirect_to index_path, notice: 'Rücksetzung eingeleitet. Bitte prüfe deine Mails.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def edit
    @user = User.new
  end
 
  def update
    respond_to do |format|
      if @user.present? && params[:user][:email] == @user.email
        @user.password = params[:user][:password]
        @user.password_confirmation = params[:user][:password_confirmation]
    
      
        if @user.save
          format.html { redirect_to index_path, notice: 'Passwort erfolgreich zurückgesetzt.' }
        else
          flash.now[:alert] = 'Passwort konnte nicht zurückgesetzt werden1.'
          format.html { render action: 'edit' }
        end
      else
        @user = User.new(params[:user])
        flash.now[:alert] = 'Passwort konnte nicht zurückgesetzt werden.'
        format.html { render action: 'edit' }
      end
    end
  end
    
  private
  def load_user
    @token = params[:id]
    @user = User.find_using_perishable_token(@token)
  end
end
