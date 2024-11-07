require "rails_helper"

RSpec.describe Interest, type: :model do
  it { should have_and_belong_to_many(:users) }
end
