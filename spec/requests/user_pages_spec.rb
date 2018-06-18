require 'spec_helper'
require 'rails_helper'

describe "User pages" do

  subject { page }

  describe "Profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.full_name) }
    it { should have_title(user.full_name) }
  end

  describe "Signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title('Sign up') }
  end
end
