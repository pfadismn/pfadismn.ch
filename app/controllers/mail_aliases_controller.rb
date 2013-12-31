class MailAliasesController < ApplicationController
  load_and_authorize_resource

  def index
    @mail_aliases = MailAlias.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def new
  end

  def edit
  end

  def create
    respond_to do |format|
      if @mail_alias.save
        format.html { redirect_to mail_aliases_path, notice: 'Mail alias was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @mail_alias.update_attributes(params[:mail_alias])
        format.html { redirect_to mail_aliases_path, notice: 'Mail alias was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @mail_alias.destroy

    respond_to do |format|
      format.html { redirect_to mail_aliases_url }
    end
  end
end
