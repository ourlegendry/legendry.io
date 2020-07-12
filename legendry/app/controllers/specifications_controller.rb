class SpecificationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @organization = Organization.find(params[:organization_id])
  end

  def create
    @organization = Organization.find(params[:organization_id])
    @spec = Specification.new(specification_params)
    @spec.organization_id = @organization.id


    if @spec.save
      redirect_to organization_specification_path(@organization, @spec)
    else
      render 'new'
    end
  end

  def show
    @spec = Specification.find(params[:id])
  end

  def index
    @organization = Organization.find(params[:organization_id])
    @specs = Specification.all
  end

  def edit
    @spec = Specification.find(params[:id])
  end

  def update
    @spec = Specification.find(params[:id])
    if @spec.update(specification_params)
      redirect_to organization_specification_path(@spec.organization, @spec)
    else
      render 'edit'
    end
  end

  def destroy
    @spec = Specification.find(params[:id])
    @spec.destroy

    redirect_to organization_specifications_path
  end

  private

  def specification_params
    params[:specification].permit(:title)
  end
end
