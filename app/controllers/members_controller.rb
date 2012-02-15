class MembersController < ApplicationController
  load_resource
  authorize_resource except: [:avatar]

  def index
    @organisational_unit ||= OrganisationalUnit.find(params[:organisational_unit_id]) if params[:organisational_unit_id]
    @organisational_unit ||= OrganisationalUnit.where(name: params[:organisational_unit_name]).first if params[:organisational_unit_name]
    @members = @organisational_unit.members.accessible_by(current_ability) if @organisational_unit.present?
    
    respond_to do |format|
      format.html { }
      format.json { render json: @members }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @member }
    end
  end

  def avatar
    if (@member.functions & [:stufenleiter, :al]).any? && @member.avatar.present?
      send_file @member.avatar.path(params[:size]), :type => @member.avatar_content_type, disposition: 'inline'
    else
      send_file "#{Rails.root}/app/assets/images/members/missing.jpg", type: 'image/jpeg', disposition: 'inline'
    end
  end

  def new
    @member.nationality ||= 'CH'
    @member.organisational_unit = current_user.member.organisational_unit

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
  end

  def create
    respond_to do |format|
      if @member.save
        format.html { redirect_to @member, notice: 'Member was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @member.update_attributes(params[:member])
        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @member.destroy

    respond_to do |format|
      format.html { redirect_to members_url }
    end
  end
end