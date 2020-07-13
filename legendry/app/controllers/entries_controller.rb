class EntriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @entries = Entry.where(specification_id: params[:specification_id])
  end

  def new
    @spec = Specification.find(params[:specification_id])
    @organization = Organization.find(params[:organization_id])
    @entry = Entry.new
  end

  def create
    @entry = Entry.new entry_params
    @entry.specification_id = params[:specification_id]

    if @entry.save
      redirect_to organization_specification_path(
        params[:organization_id],
        params[:specification_id]
      )
    else
      render 'new'
    end
  end

  private

  def entry_params
    params[:entry].permit(:title, :description)
  end
end
