class ApplicationsController < ApplicationController
  def show
    @application = Application.find_by_id(params[:id])
  end
end