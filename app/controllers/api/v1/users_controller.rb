class Api::V1::UsersController < ApplicationController
  load_and_authorize_resource

  def current
    # binding.pry
    user = User.find(1)
    render json: user, serializer: CurrentUserSerializer, root: :users, status: 200
  end
end
