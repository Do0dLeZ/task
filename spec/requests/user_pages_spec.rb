require 'spec_helper'

RSpec.describe "User pages", type: :request do
  subject {page}

  describe "Profile page" do
    let(:user) {FactoryGirl.create :user}
    before {visit user_path(user)}
  end
  
end
