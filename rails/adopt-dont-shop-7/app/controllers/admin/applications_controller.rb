class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find_by_id(params[:id])
    @pets = @application.pets
  end

  def update
    @application = Application.find_by_id(params[:id])
    
    if params[:pet_id] && params[:q]
      pet = Pet.find(params[:pet_id])
      application_pet = pet.find_application_pet(@application.id)
      
      if params[:q] == "Approved"
        application_pet.update!(status: 1)
        redirect_to admin_application_path(@application.id)
      elsif params[:q] == "Rejected"
        application_pet.update!(status: 2)
        redirect_to admin_application_path(@application.id)
      end
    end
  end
end