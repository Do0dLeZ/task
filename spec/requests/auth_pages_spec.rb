require 'rails_helper'

RSpec.describe "AuthPages", type: :request do
  subject {page}

  describe "Sign In page" do
    before {visit signin_path}

    it {should have_content('Sign In')}
    it {should have_title('Sign In')}

    it {should_not have_content('Profile')}
    it {should_not have_content('Settings')}
    it {should_not have_content('Sign out')}

    describe "With invalid information" do
      before {click_button "Sign in"}

      it {should have_title("Sign In")}
      it {should have_selector('div.alert.alert-error')}

      describe "After visiting another page" do
        before {click_link "Tasks"}
        it {should_not have_selector('div.alert.alert-errorS')}
      end
    end

    describe "With valid information" do
      let(:user) {FactoryGirl.create(:user)}
      before do
        fill_in "Email", with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "Sign in"
      end

      it {should have_title(user.full_name)}
      it {should have_link('Profile', href: user_path(user))}
      it {should have_link('Sign out', href: signout_path)}
      it {should_not have_link('Sign in', href: signin_path)}

      describe "Followed by Sign out" do
        before {click_link "Sign out"}
        it {should have_link('Sign in')}
        it {should_not have_link('Settings', href: edit_user_path(user))}
        it {should_not have_link('Profile', href: user_path(user))}
        it {should_not have_link('Sign out', href: signout_path)}
      end
    end
  end
end
