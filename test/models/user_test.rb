require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'Mihai',
                     email: 'mihai@mail.com',
                     password: 'foobar',
                     password_confirmation: 'foobar')
    @name_length_max = 50
    @name_length_min = 3
    @email_max_length = 200
    @email_min_length = 8
    @password_min_length = 6
  end

  # Tests for User.name validation

  test 'smoke test name should' do
    @user.name = 'Mihai'
    assert @user.valid?
    @user.name = 'Mihai ABC'
    assert @user.valid?
    @user.name = 'Mihai ABC DASD'
    assert @user.valid?
  end

  test "name shouldn't be empty" do
    @user.name = ''
    assert_not @user.valid?
  end

  test "name shouldn't have only white spaces" do
    @user.name = '          '
    assert_not @user.valid?
  end

  test "name shouldn't have only numbers" do
    @user.name = '123'
    assert_not @user.valid?
  end

  test 'names length min' do
    @user.name = 'a' * @name_length_min
    assert @user.valid?
    @user.name = 'a' * (@name_length_min - 1)
    assert_not @user.valid?
  end

  test 'names length max' do
    @user.name = 'a' * @name_length_max
    assert @user.valid?
    @user.name = 'a' * (@name_length_max + 1)
    assert_not @user.valid?
  end

  # Tests for User.email validation

  test 'smoke test email' do
    @user.email = 'mihai@gmail.com'
    assert @user.valid?
  end

  test 'email should not be empty' do
    @user.email = ''
    assert_not @user.valid?
  end

  test 'only white spaces email should NOT' do
    @user.email = '           '
    assert_not @user.valid?
  end

  test 'minimum length email' do
    email_domain_min = '@a.aa'
    email_length_min_without_domain = @email_min_length - email_domain_min.length
    # TODO: better name for variable
    @user.email = 'a' * email_length_min_without_domain + email_domain_min
    assert @user.valid?
    @user.email = 'a' * (email_length_min_without_domain - 1) + email_domain_min
    assert_not @user.valid?
  end

  test 'maximum length email' do
    email_domain = '@a.aa'
    email_length_max_without_domain = @email_max_length - email_domain.length
    # TODO: better name for variable
    @user.email = 'a' * email_length_max_without_domain + email_domain
    assert @user.valid?
    @user.email = 'a' * (email_length_max_without_domain + 1) + email_domain
    assert_not @user.valid?
  end

  test 'emails should have @' do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    check_array_is_valid(valid_addresses, true)
  end

  test "emails shouldn't work without @" do
    invalid_addresses = %w[user USERfoo A_US-ERfoo.bar
                           first.last alice+bob]
    check_array_is_valid(invalid_addresses, false)
  end

  test 'emails should not have ".."' do
    @user.email = 'mihai@g..com'
    assert_not @user.valid?
  end

  test 'emails should not have white spaces' do
    invalid_addresses = ['mihai 123 blanks@mail.com', 'mihai123blanks@ma il.com']
    check_array_is_valid(invalid_addresses, false)
  end

  test 'email addresses should be unique' do
    @user.email = 'mihai@mail.com'
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'email addresses should be saved as lower-case' do
    mixed_case_email = 'Foo@ExAMPle.CoM'
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test 'password should not be blank' do
    @user.password = @user.password_confirmation = ' ' * @password_min_length
    assert_not @user.valid?
    @user.password = @user.password_confirmation = ' ' * @password_min_length + 'a'
    assert @user.valid?
  end

  test 'password minnumum length' do
    @user.password = @user.password_confirmation = 'a' * @password_min_length
    assert @user.valid?
    @user.password = @user.password_confirmation = 'a' * (@password_min_length - 1)
    assert_not @user.valid?
  end

  private

  def check_array_is_valid(array, valid)
    array.each do |value|
      @user.email = value
      if valid
        assert @user.valid?, "#{value.inspect} should be valid"
      else
        assert_not @user.valid?, "#{value.inspect} should be invalid"
      end
    end
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end

  test "should follow and unfollow a user" do
    michael = users(:michael)
    archer  = users(:archer)
    assert_not michael.following?(archer)
    michael.follow(archer)
    assert michael.following?(archer)
    assert archer.followers.include?(michael)
    michael.unfollow(archer)
    assert_not michael.following?(archer)
  end
end
