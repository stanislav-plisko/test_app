# frozen_string_literal: true

class User < ApplicationRecord
  has_and_belongs_to_many :interests
  has_and_belongs_to_many :skills

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, :patronymic, :email, :age, :nationality, :country, :gender, presence: true
  validates :age, numericality: { greater_than: 0, less_than_or_equal_to: 90 }
  validates :gender, inclusion: { in: %w[male female] }
end
