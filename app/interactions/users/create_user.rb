# frozen_string_literal: true

require "active_interaction"

class Users::CreateUser < ActiveInteraction::Base
  attr_accessor :name, :patronymic, :surname, :email, :age, :nationality, :country, :gender,
                :interests, :skills

  hash :params do
    string :name
    string :patronymic, default: nil
    string :surname, default: nil
    string :email
    integer :age
    string :nationality
    string :country
    string :gender
    string :interests, default: ""
    string :skills, default: ""
  end

  def execute
    user = User.create(user_params.merge(
                         interest_ids: find_interests.pluck(:id),
                         skill_ids: find_skills.pluck(:id)
                       ))
    errors.merge!(user.errors) unless user.valid?
    user if user.valid?
  end

  private

  def user_params
    params.except(:interests, :skills)
  end

  def find_interests
    if params[:interests].present?
      params[:interests].split(",").map do |interests_name|
        Interest.find_or_create_by(name: interests_name.strip)
      end
    else
      []
    end
  end

  def find_skills
    if params[:skills].present?
      params[:skills].split(",").map do |skill_name|
        Skill.find_or_create_by(name: skill_name.strip)
      end
    else
      []
    end
  end
end
