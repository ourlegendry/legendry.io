class SpecificationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @organization = Organization.find(params[:organization_id])
    @spec = @organization.specifications.build
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
    @entries = Entry
      .where(specification_id: @spec.id)
      .sort_by { |e|
        # TODO: 1000 here is arbitrary, I don't like it. I'd prefer a better system for picking a number.
        # but it ensures that TBD entries show up at the bottom of the list (if the list is less than 1000.
        # It also allows me to move on for the time being.
        num = e.number.nil? ? 1000 : e.number
        e.parent_number.nil? ? [num] : (e.parent_number.split('.').map(&:to_i) + [num])
      }
  end

  def index
    @organization = Organization.find(params[:organization_id])
    @specs = @organization.specifications
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
