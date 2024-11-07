require "rails_helper"

RSpec.describe Users::CreateUser, type: :interaction do
  let(:user_params) do
    {
      name: "John",
      patronymic: "Doe",
      surname: "Smith",
      email: "john.doe@example.com",
      age: 30,
      nationality: "American",
      country: "USA",
      gender: "male",
      interests: "coding",
      skills: "Rails"
    }
  end
end
