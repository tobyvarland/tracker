class ProjectionsController < ApplicationController

  # Load projection by ID on appropriate actions.
  before_action :set_projection,
                only: [:show, :edit, :update, :destroy]

  # GET /projections
  def index

    # Retrieve all projections for display.
    @projections = Projection.all.order(:projection_date)

    # Calculate current weight & change rate.
    most_recent_weight = Entry.where.not(weight: nil).order(entry_date: :desc).first
    first_weight = Entry.where.not(weight: nil).order(:entry_date).first
    @target_weight = 180
    @current_weight = most_recent_weight.weight
    total_change = most_recent_weight.weight - first_weight.weight
    elapsed_days = (most_recent_weight.entry_date - first_weight.entry_date).to_i
    elapsed_weeks = elapsed_days / 7.0
    @current_rate = total_change / elapsed_weeks

  end

  # GET /projections/1
  def show
  end

  # GET /projections/new
  def new
    @projection = Projection.new
  end

  # GET /projections/1/edit
  def edit
  end

  # POST /projections
  def create
    @projection = Projection.new(projection_params)
    if @projection.save
      redirect_to projections_url, flash: { success: 'Projection was successfully created.' }
    else
      render :new
    end
  end

  # PATCH/PUT /projections/1
  def update
    if @projection.update(projection_params)
      redirect_to projections_url, flash: { success: 'Projection was successfully updated.' }
    else
      render :edit
    end
  end

  # DELETE /projections/1
  def destroy
    @projection.destroy
    redirect_to projections_url, flash: { success: 'Projection was successfully destroyed.' }
  end

private

  # Load projection by ID.
  def set_projection
    @projection = Projection.find(params[:id])
  end

  # Define permissable parameters.
  def projection_params
    params.require(:projection).permit(:projection_date,
                                       :label,
                                       :goal_weight)
  end

end