# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    outcome = Users::CreateUser.run(params: user_params)

    if outcome.valid?
      render json: { message: 'User created successfully', user: outcome.result }, status: :created
    else
      render json: { errors: outcome.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :patronymic, :surname, :email, :age, :nationality,
                                 :country, :gender, :interests, :skills)
  end
end
