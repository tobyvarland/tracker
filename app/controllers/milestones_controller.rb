class MilestonesController < ApplicationController

  # Load milestone by ID on appropriate actions.
  before_action :set_milestone,
                only: [:show, :edit, :update, :destroy]

  # GET /milestones
  def index

    # Retrieve all milestones for display.
    @milestones = Milestone.all.order(:label)

  end

  # GET /milestones/1
  def show
  end

  # GET /milestones/new
  def new
    @milestone = Milestone.new
  end

  # GET /milestones/1/edit
  def edit
  end

  # POST /milestones
  def create
    @milestone = Milestone.new(milestone_params)
    if @milestone.save
      redirect_to milestones_url, flash: { success: 'Milestone was successfully created.' }
    else
      render :new
    end
  end

  # PATCH/PUT /milestones/1
  def update
    if @milestone.update(milestone_params)
      redirect_to milestones_url, flash: { success: 'Milestone was successfully updated.' }
    else
      render :edit
    end
  end

  # DELETE /milestones/1
  def destroy
    @milestone.destroy
    redirect_to milestones_url, flash: { success: 'Milestone was successfully destroyed.' }
  end

private

  # Load milestone by ID.
  def set_milestone
    @milestone = Milestone.find(params[:id])
  end

  # Define permissable parameters.
  def milestone_params
    params.require(:milestone).permit(:milestone_date,
                                      :label,
                                      :notes)
  end

end