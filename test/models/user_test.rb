require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'Mihai', email: 'mihai@mail.com')
    @name_length_max = 50
    @name_length_min = 3
    @email_max_length = 200
    @email_min_length = 8
  end

  # Tests for User.name validation

  test 'smoke test name should' do
    @user.name = 'Mihai'
    assert @user.valid?
  end

  test 'empty name should NOT' do
    @user.name = ''
    assert_not @user.valid?
  end

  test 'name with white spaces should NOT' do
    @user.name = '   '
    assert_not @user.valid?
  end

  test 'name with only numbers / special characters should NOT' do
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

  test 'empty email should NOT' do
    @user.email = ''
    assert_not @user.valid?
  end

  test 'only white spaces email should NOT' do
    @user.email = '    '
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

  def test_validation_email_length_max
    email_domain = '@a.aa'
    email_length_max_without_domain = @email_max_length - email_domain.length
    # TODO: better name for variable
    @user.email = 'a' * email_length_max_without_domain + email_domain
    assert @user.valid?
    @user.email = 'a' * (email_length_max_without_domain + 1) + email_domain
    assert_not @user.valid?
  end

  def test_validation_email_has_at
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    check_array_is_valid(valid_addresses, true)
  end

  def test_validation_email_doesnt_have_at
    invalid_addresses = %w[user USERfoo A_US-ERfoo.bar
                           first.last alice+bob]
    check_array_is_valid(invalid_addresses, false)
  end

  def text_validation_email_double_dot
    @user.email = 'mihai@g..com'
    assert_not @user.valid?
  end

  def test_validation_email_blank_spaces
    invalid_addresses = ['mihai 123 blanks@mail.com', 'mihai123blanks@ma il.com']
    check_array_is_valid(invalid_addresses, false)
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end
  # other methods

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
end
