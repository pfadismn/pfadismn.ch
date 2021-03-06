# encoding: UTF-8

class UsersController < ApplicationController
  load_resource
  authorize_resource only: [:new, :edit, :create, :update, :destroy]
  
  def new
    @user.member = Member.find(params[:member]) if params[:member].present?
    
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
  end
  
  def edit_password
    authorize! :reset_password, @user
  end

  def create
    @user = User.new(params[:user])
    
    respond_to do |format|
      if @user.save
        format.html { redirect_to organisational_unit_member_path(@user.member.organisational_unit, @user.member), notice: 'User was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to [:edit, @user.member.organisational_unit, @user.member], notice: 'User was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end
  
  def update_password
    authorize! :reset_password, @user
    
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    
    respond_to do |format|
      if @user.save
        #format.html { redirect_to @user.member, notice: 'User was successfully updated.' }
        format.html { redirect_to [@user.member.organisational_unit, @user.member ] }
        
      else
        format.html { render action: "edit_password" }
      end
    end
  end
  

  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to organisational_unit_member_path(@user.member.organisational_unit, @user.member) }
    end
  end

  def user_params

  end
end
