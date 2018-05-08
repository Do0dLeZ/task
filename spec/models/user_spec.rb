require 'rails_helper'

describe User do

  before {@user = User.new(first_name: "Example Name", last_name: "Example Last Name", email: "user@example.com",
                           password: "koloma", password_confirmation: "koloma")}

  subject {@user}

  it {should respond_to(:first_name)}
  it {should respond_to(:last_name)}
  it {should respond_to(:email)}
  it {should be_valid}
  it {should respond_to(:password_digest) }
  it {should respond_to(:password) }
  it {should respond_to(:password_confirmation) }

  describe "when full name valid" do
    let(:example_full_name) {"Example Name Example Last Name"}
    it 'should be valid' do
      expect(@user.full_name).to eq example_full_name
    end
  end

  describe "when full name invalid" do
    let(:example_full_name) {"Example NameExample Last Name"}
    it "should not be valid" do
      expect(@user.full_name).not_to eq example_full_name
    end
  end

  describe "when password is not present" do
    before {@user.password = @user.password_confirmation = " "}
    it {should_not be_valid}
  end

  describe "when password and confirmation don't mismatch" do
    before {@user.password_confirmation = "mismatch"}
    it {should_not be_valid}
  end

  describe "when first name is not present" do
    before {@user.first_name = " "}
    it {should_not be_valid}
  end

  describe "when email is not present" do
    before {@user.email = ""}
    it {should_not be_valid}
  end

  describe "should not be longer then 50 chars" do
    before {@user.first_name = "a" * 51}
    it {should_not be_valid}
  end

  describe "when email format is invalid" do
    it 'should not be valid' do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |address|
        @user.email = address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it 'should be valid' do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn koloma@mail.com]
      addresses.each do |address|
        @user.email = address
        expect(@user).to be_valid
      end
    end
  end

  describe "when email is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.save
    end
    it {should_not be_valid}
  end

  describe "when email is already taken in different cases" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email.upcase
      user_with_same_email.save
    end
    it {should_not be_valid}
  end

  describe "email address with mixed case" do
    let(:mixed_case_email) {"KolOmA@MaiL.CoM"}

    it "should be saved in low case" do
      @user.email = mixed_case_email
      @user.save
      expect(@user.reload.email).to eq mixed_case_email.downcase
    end
  end

  #auth tests

  describe "when password is too short" do
    before {@user.password = @user.password_confirmation = "a" * 5}
    it {should_not be_valid}
  end

  describe "auth test" do
    before {@user.save}
    let(:founded_user) {User.find_by(email: @user.email)}

    describe "with valid pass" do
      it {should eq founded_user.authenticate(@user.password)}
    end

    describe "with wrong password" do
      let(:user_with_wrong_password) {founded_user.authenticate("doodlez")}
      it {should_not eq user_with_wrong_password}
      specify {expect(user_with_wrong_password).to be_falsey}
    end
  end
end