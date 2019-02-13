class EntriesController < ApplicationController

  # Load entry by ID on appropriate actions.
  before_action :set_entry,
                only: [:show, :edit, :update, :destroy]

  # GET /entries
  def index

    # Retrieve all entries for display.
    @entries = Entry.all.order(entry_on: :desc)

    # Calculate stats.
    @first_entry = @entries.last
    @days_since_first_entry = (Date.today - @first_entry.entry_on).to_i
    @weeks_since_first_entry = @days_since_first_entry / 7.0
    @tracking_rate = 100 * (@entries.count / (1.0 * (@days_since_first_entry + 1)))
    @total_flags = @entries.sum(&:flag_score)
    @flags_possible = @entries.count * 7
    @perfect_flag_days = @entries.count{|e|e.flag_score == 7}
    @flag_rate = 100 * (@total_flags / (1.0 * @flags_possible))
    @perfect_flag_rate = 100 * (@perfect_flag_days / (1.0 * (@days_since_first_entry + 1)))
    @starting_weight = @entries.where.not(weight: nil).last.weight
    @most_recent_weight = @entries.where.not(weight: nil).first.weight
    @total_weight_change = @most_recent_weight - @starting_weight
    @weight_change_rate = @total_weight_change / @weeks_since_first_entry
    @max_steps = nil
    @max_total_calories = nil
    @max_active_calories = nil
    @entries.each do |e|
      if e.steps && (@max_steps.nil? || e.steps > @max_steps.steps)
        @max_steps = e
      end
      if e.calories_entered?
        if @max_total_calories.nil? || e.total_calories_burned > @max_total_calories.total_calories_burned
          @max_total_calories = e
        end
        if @max_active_calories.nil? || e.active_calories_burned > @max_active_calories.active_calories_burned
          @max_active_calories = e
        end
      end
    end
    @first_with_measurements = @entries.where.not(calf_measurement: nil).last
    if @first_with_measurements.nil?
      @calf_change = 0.0
      @thigh_change = 0.0
      @waist_change = 0.0
      @stomach_change = 0.0
      @shoulder_change = 0.0
      @arm_change = 0.0
      @neck_change = 0.0
    else
      @most_recent_with_measurements = @entries.where.not(calf_measurement: nil).first
      @calf_change = @most_recent_with_measurements.calf_measurement - @first_with_measurements.calf_measurement
      @thigh_change = @most_recent_with_measurements.thigh_measurement - @first_with_measurements.thigh_measurement
      @waist_change = @most_recent_with_measurements.waist_measurement - @first_with_measurements.waist_measurement
      @stomach_change = @most_recent_with_measurements.stomach_measurement - @first_with_measurements.stomach_measurement
      @shoulder_change = @most_recent_with_measurements.shoulder_measurement - @first_with_measurements.shoulder_measurement
      @arm_change = @most_recent_with_measurements.arm_measurement - @first_with_measurements.arm_measurement
      @neck_change = @most_recent_with_measurements.neck_measurement - @first_with_measurements.neck_measurement
    end

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
      redirect_to entries_url, flash: { success: 'Entry was successfully created.' }
    else
      render :new
    end
  end

  # PATCH/PUT /entries/1
  def update
    if @entry.update(entry_params)
      redirect_to entries_url, flash: { success: 'Entry was successfully updated.' }
    else
      render :edit
    end
  end

  # DELETE /entries/1
  def destroy
    @entry.destroy
    redirect_to entries_url, flash: { success: 'Entry was successfully destroyed.' }
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