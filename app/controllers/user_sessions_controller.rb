class UserSessionsController < ApplicationController
  load_and_authorize_resource

  def new
  end

  def create
    if @user_session.save
      flash[:notice] = "Login erfolgreich!"
      redirect_back_or_default dashboard_path
    else
      render action: :new, alert: "Login fehlgeschlagen!"
    end
  end

  def destroy
    current_user_session.destroy
    redirect_back_or_default login_path
  end
end
