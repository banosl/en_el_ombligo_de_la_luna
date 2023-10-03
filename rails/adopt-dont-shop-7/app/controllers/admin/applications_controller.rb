class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find_by_id(params[:id])
    @pets = @application.pets
  end
end