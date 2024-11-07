require "rails_helper"

RSpec.describe UsersController, type: :controller do
  describe "POST #create" do
    let(:valid_attributes) do
      {
        user: {
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
      }
    end

    let(:invalid_attributes) do
      {
        user: {
          name: "",
          email: "invalid_email",
          age: -1,
          nationality: "",
          country: "",
          gender: "unknown"
        }
      }
    end

    context "with valid params" do
      it "creates a new User" do
        expect do
          post :create, params: valid_attributes
        end.to change(User, :count).by(1)
      end

      it "renders a JSON response with the new user" do
        post :create, params: valid_attributes
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(JSON.parse(response.body)["message"]).to eq("User created successfully")
      end
    end

    context "with invalid params" do
      it "does not create a new User" do
        expect do
          post :create, params: invalid_attributes
        end.to change(User, :count).by(0)
      end

      it "renders a JSON response with errors for the new user" do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(JSON.parse(response.body)["errors"]).not_to be_empty
      end
    end
  end
end
