class Api::V1::UsersController < ApplicationController
  load_and_authorize_resource

  def current
    render json: current_user, serializer: CurrentUserSerializer, root: :users, status: 200
  end
end
