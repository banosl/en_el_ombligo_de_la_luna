class ApplicationsController < ApplicationController
  def show
    @application = Application.find_by_id(params[:id])
    @pets = @application.pets

    if params[:commit] == "Search"
      if Pet.find_by(name: params[:pet_search])
        @pet_result = Pet.find_by(name: params[:pet_search])
        @name = @pet_result.name
      else
        @name = "No pets by that name"
      end
    end

    if params[:q]
      pet = Pet.find(params[:q])
      ApplicationPet.create(pet_id: pet.id, application_id: @application.id)
    end
  end

  def new
    @shelter = Shelter.first
  end

  def create
    application = Application.new(application_params)
    
    if application.save
      redirect_to application_path(application.id)
    else
      redirect_to new_application_path
      flash.alert = "A field can't be empty"
    end
  end

  private
    def application_params
      params.permit(:first_name,
                    :last_name,
                    :address_1,
                    :address_2,
                    :city,
                    :state,
                    :zip_code,
                    :description,
                    :shelter_id)
    end
end