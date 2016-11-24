class Api::V1::WorkoutTypesController < ApplicationController
  load_and_authorize_resource

  def index
    render json: @workout_types.order('name'), status: 200
  end
end
