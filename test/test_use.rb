require "yaml"
require "test/unit"

class TestUser < Test::Unit::TestCase
  def setup
    config = YAML::load("appfigures_fixture.yml")

    assert_not_nil(config, "you must create appfigures_fixture.yml")
    assert_not_nil(config[:username], "you must configure username")
    assert_not_nil(config[:password], "you must configure password")

    assert_not_equals("", config[:username], "you must configure username")
    assert_not_equals("", config[:password], "you must configure password")

    Appfigures::User.basic_auth config[:username], config[:password]
  end

  def test_user_by_email
    user = Appfigures::User.user(email)
    assert_not_nil(user)
  end
end