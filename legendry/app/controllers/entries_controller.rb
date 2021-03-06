class EntriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @entries = Entry.where(specification_id: params[:specification_id])
  end

  def new
    @spec = Specification.find(params[:specification_id])
    @organization = Organization.find(params[:organization_id])
    @entry = Entry.new(parent_number: params[:parent_number])
  end

  def edit
    @entry = Entry.find(params[:id])
    puts (@entry.parent_number.empty? ? "nil" : @entry.parent_number)
  end

  def update
    @entry = Entry.find(params[:id])
    if @entry.update(entry_params)
      redirect_to organization_specification_path(
        params[:organization_id],
        params[:specification_id]
      )
    else
      render 'edit'
    end
  end

  def create
    @spec = Specification.find(params[:specification_id])
    @organization = Organization.find(params[:organization_id])
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

  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy

    redirect_to organization_specification_path(
      params[:organization_id],
      params[:specification_id]
    )
  end

  def commit
    @entry = Entry.find(params[:id])
    if @entry.number.nil?
      # determine the next number by:
      #   1. counting all of the siblings that have numbers
      #   2. adding 1 to the result
      #
      #   because you can currently delete an entry, if you do so, you lose
      #   that number forever, this will be addressed in the future
      all_siblings = Entry.where(parent_number: @entry.parent_number)
      @siblings = all_siblings.where.not(number: nil).or(all_siblings.where.not(number: ''))
      @entry.number = @siblings.count+1
      @entry.save
    end
  end

  private

  def entry_params
    params[:entry].permit(:title, :description, :parent_number)
  end
end
