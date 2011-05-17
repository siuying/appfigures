require "yaml"
require "test/unit"

require "rubygems"
require "bundler"
Bundler.require(:default)

require "lib/appfigures"

class TestUser < Test::Unit::TestCase
  def setup
    path = File.expand_path(File.dirname(__FILE__))
    @config = YAML::load(open("#{path}/appfigures_fixture.yml"))

    assert_not_nil(@config, "you must create appfigures_fixture.yml")
    assert_not_nil(@config[:username], "you must configure username")
    assert_not_nil(@config[:password], "you must configure password")

    assert_not_equal("", @config[:username], "you must configure username")
    assert_not_equal("", @config[:password], "you must configure password")

    Appfigures::User.basic_auth @config[:username], @config[:password]
  end

  def test_user_details
    user = Appfigures::User.details(@config[:username])
    assert_not_nil(user)

    assert_not_nil(user["region"])
    assert_not_nil(user["id"])
    assert_not_nil(user["account"])
    assert_not_nil(user["apps"])

    assert_kind_of(Hash, user["account"])
    assert_kind_of(Array, user["apps"])
  end
  
  def test_user_apps
    apps = Appfigures::User.apps(@config[:username])
    assert_not_nil(apps)
    assert_kind_of(Hash, apps)

    assert(apps.size > 0, "account should have at least one app")
    first_app = apps[apps.keys.first]
    assert_kind_of(Hash, first_app)
    assert_kind_of(Array, first_app["in_apps"])
    assert_not_nil(first_app["name"])
    assert_not_nil(first_app["id"])
  end

  def test_user_external
    acct = Appfigures::User.external(@config[:username])
    assert_not_nil(acct)
    assert_kind_of(Hash, acct)

    assert(acct.size > 0, "account should have at least one itc_account")
    first_acct = acct[acct.keys.first]
    assert_kind_of(Hash, first_acct)
    assert_not_nil(first_acct["account_id"])
    assert_not_nil(first_acct["id"])
  end

  
end