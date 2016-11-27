class Api::V1::WorkoutsController < ApplicationController
  load_and_authorize_resource

  # The index action for workouts is paginated by week or by month
  # This will only ever return the workouts for the current user
  def index
    if params[:ids]
      @workouts = @workouts.where(id: params[:ids])
    else
      offset      = (params[:offset] || 0).to_i
      count       = (params[:count] || 2).to_i
      range_type  = params[:range_type] || 'weekly'
      @workouts   = paginated_workouts(offset, range_type, count)
    end

    render json: @workouts, status: 200
  end

  def create
    @workout.save!
  rescue => e
    handle_create_failure(e, @workout)
  else
    handle_create_success(@workout)
  end

  def destroy
    workout = Workout.find(params[:id])
    workout.destroy!
    head 204
  end

  private

  def handle_create_failure(e, workout)
    # ExceptionNotifier.notify_exception(e, env: request.env, data: { workout_errors: @workout.errors.full_messages })
    render json: { errors: workout.errors }, status: 400
  end

  def handle_create_success(workout)
    render json: workout, status: 200
  end

  def create_params
    params.require(:workout).permit(
      :name, :date, :feeling, :notes,
      :level_1_duration, :level_2_duration, :level_3_duration,
      :level_4_duration, :level_5_duration, :strength_duration,
      :user_id, :workout_type_id
    )
  end

  def paginated_workouts(offset, range_type, count)
    @workouts.paginate_by_date(offset, range_type, count).order('date DESC').where(user_id: current_user.id)
  end
end
