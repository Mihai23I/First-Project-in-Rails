require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'Mihai', email: 'mihai@mail.com')
  end

  # Tests for User.name validation

  def test_validation_name_smoke
    @user.name = 'Mihai'
    assert @user.valid?
  end

  def test_validation_name_blank
    @user.name = ''
    assert_not @user.valid?
  end

  def test_validation_name_white_spaces
    @user.name = '   '
    assert_not @user.valid?
  end

  def test_validation_name_only_numbers
    @user.name = '123'
    assert_not @user.valid?
  end

  # Tests for User.email validation

  def test_validation_email_should_pass
    @user.email = 'mihai@gmail.com'
    assert @user.valid?
  end

  def test_validation_email_blank
    @user.email = ''
    assert_not @user.valid?
  end

  def test_validation_email_white_spaces
    @user.email = '   '
    assert_not @user.valid?
  end
  # TODO: add more tests
end
