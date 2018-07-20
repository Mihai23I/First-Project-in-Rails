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

  def test_validation_name_length_min
    @user.name = 'a' * 3
    assert @user.valid?
    @user.name = 'a' * 2
    assert_not @user.valid?
  end

  def test_validation_name_length_max
    @user.name = 'a' * 50
    assert @user.valid?
    @user.name = 'a' * 51
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

  def test_validation_email_length_min
    @user.email = 'a' * 3 + '@a.aa'
    assert @user.valid?
    @user.email = 'a' * 2 + '@a.aa'
    assert_not @user.valid?
  end

  def test_validation_email_length_max
    @user.email = 'a' * 188 + '@example.com'
    assert @user.valid?
    @user.email = 'a' * 189 + '@example.com'
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
