class OrganizationsController < ApplicationController
  def new
  end

  def create
    @organization = Organization.new(organization_params)
    @organization.save
    redirect_to @organization
  end

  def show
    @organization = Organization.find(params[:id])
  end

  def index
    @organizations = Organization.all
  end

  private

  def organization_params
    params[:organization].permit(:name)
  end
end
