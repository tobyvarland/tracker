class EntriesController < ApplicationController

  # Load entry by ID on appropriate actions.
  before_action :set_entry,
                only: [:show, :edit, :update, :destroy]

  # GET /entries
  def index
    @entries = Entry.all
  end

  # GET /entries/1
  def show
  end

  # GET /entries/new
  def new
    @entry = Entry.new
  end

  # GET /entries/1/edit
  def edit
  end

  # POST /entries
  def create
    @entry = Entry.new(entry_params)
    if @entry.save
      redirect_to @entry, notice: 'Entry was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /entries/1
  def update
    if @entry.update(entry_params)
      redirect_to @entry, notice: 'Entry was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /entries/1
  def destroy
    @entry.destroy
    redirect_to entries_url, notice: 'Entry was successfully destroyed.'
  end

private

  # Load entry by ID.
  def set_entry
    @entry = Entry.find(params[:id])
  end

  # Define permissable parameters.
  def entry_params
    params.require(:entry).permit(:entry_on,
                                  :tracked_food,
                                  :stayed_under_calorie_goal,
                                  :closed_move_ring,
                                  :closed_exercise_ring,
                                  :closed_stand_ring,
                                  :went_to_gym,
                                  :met_sleep_goal,
                                  :steps,
                                  :total_calories_consumed,
                                  :total_calories_burned,
                                  :active_calories_burned,
                                  :weight,
                                  :calf_measurement,
                                  :thigh_measurement,
                                  :waist_measurement,
                                  :stomach_measurement,
                                  :shoulder_measurement,
                                  :arm_measurement,
                                  :neck_measurement,
                                  :notes)
  end

end