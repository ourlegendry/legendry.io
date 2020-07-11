class SpecificationsController < ApplicationController
  def new
  end

  def create
    @spec = Specification.new(specification_params)

    @spec.save
    redirect_to @spec
  end

  def show
    @spec = Specification.find(params[:id])
  end

  def index
    @specs = Specification.all
  end

  private

  def specification_params
    params[:specification].permit(:title)
  end
end
