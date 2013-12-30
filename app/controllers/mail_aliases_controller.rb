class MailAliasesController < ApplicationController
  # GET /mail_aliases
  # GET /mail_aliases.json
  def index
    @mail_aliases = MailAlias.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mail_aliases }
    end
  end

  # GET /mail_aliases/1
  # GET /mail_aliases/1.json
  def show
    @mail_alias = MailAlias.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mail_alias }
    end
  end

  # GET /mail_aliases/new
  # GET /mail_aliases/new.json
  def new
    @mail_alias = MailAlias.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mail_alias }
    end
  end

  # GET /mail_aliases/1/edit
  def edit
    @mail_alias = MailAlias.find(params[:id])
  end

  # POST /mail_aliases
  # POST /mail_aliases.json
  def create
    @mail_alias = MailAlias.new(params[:mail_alias])

    respond_to do |format|
      if @mail_alias.save
        format.html { redirect_to @mail_alias, notice: 'Mail alias was successfully created.' }
        format.json { render json: @mail_alias, status: :created, location: @mail_alias }
      else
        format.html { render action: "new" }
        format.json { render json: @mail_alias.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mail_aliases/1
  # PUT /mail_aliases/1.json
  def update
    @mail_alias = MailAlias.find(params[:id])

    respond_to do |format|
      if @mail_alias.update_attributes(params[:mail_alias])
        format.html { redirect_to @mail_alias, notice: 'Mail alias was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mail_alias.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mail_aliases/1
  # DELETE /mail_aliases/1.json
  def destroy
    @mail_alias = MailAlias.find(params[:id])
    @mail_alias.destroy

    respond_to do |format|
      format.html { redirect_to mail_aliases_url }
      format.json { head :no_content }
    end
  end
end
