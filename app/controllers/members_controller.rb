class MembersController < ApplicationController
  before_filter :load_parent_resource
  load_resource
  authorize_resource except: [:avatar]

  def index
    @members = @ou.members.accessible_by(current_ability)

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
        format.html { redirect_to [@ou, @member], notice: 'Member was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @member.update_attributes(params[:member])
        format.html { redirect_to [@ou, @member], notice: 'Member was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @member.destroy

    respond_to do |format|
      format.html { redirect_to [@ou, Member] }
    end
  end

  private
  def load_parent_resource
    @ou = OrganisationalUnit.by_name(params[:organisational_unit_id])
  end
end
