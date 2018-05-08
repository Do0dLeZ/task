require 'spec_helper'

RSpec.describe "User pages", type: :request do
  subject {page}

  describe "Sign up page" do
    before {visit signup_path}

    it {should have_content('Sign up')}
    #it {should have_title('Sign up')}
  end
end
