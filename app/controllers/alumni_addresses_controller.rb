class AlumniAddressesController < ApplicationController
  load_and_authorize_resource except: [:new, :create]
  load_resource only: [:new, :create]

  def index
  end

  def show
  end

  def new
    @alumni_address.build_address
  end

  def edit
  end

  def create
    respond_to do |format|
      if @alumni_address.save
        format.html { redirect_to jubilaeum2014_path, notice: 'Der Eintrag wurde erfolgreich gespeichert. Vielen Dank.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @alumni_address = AlumniAddress.find(params[:id])

    respond_to do |format|
      if @alumni_address.update_attributes(alumni_address_params)
        format.html { redirect_to @alumni_address, notice: 'Alumni address was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @alumni_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alumni_addresses/1
  # DELETE /alumni_addresses/1.json
  def destroy
    @alumni_address = AlumniAddress.find(params[:id])
    @alumni_address.destroy

    respond_to do |format|
      format.html { redirect_to alumni_addresses_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def alumni_address_params
      params.require(:alumni_address).permit(:address, :comment, :email, :name, :vulgo)
    end
end
