require "yaml"
require "test/unit"

require "rubygems"
require "bundler"
Bundler.require(:default)

require "./lib/appfigures"

class TestUser < Test::Unit::TestCase
  def setup
    path = File.expand_path(File.dirname(__FILE__))
    @config = YAML::load(open("#{path}/appfigures_fixture.yml"))
    
    assert_not_nil(@config, "you must create appfigures_fixture.yml")
    assert_not_nil(@config[:username], "you must configure username")
    assert_not_nil(@config[:password], "you must configure password")

    assert_not_equal("", @config[:username], "you must configure username")
    assert_not_equal("", @config[:password], "you must configure password")

    @user = Appfigures::User.new @config[:username], @config[:password]
  end

  def test_details
    details = @user.details(@config[:username])
    assert_not_nil(details)

    assert_not_nil(details["region"])
    assert_not_nil(details["id"])
    assert_not_nil(details["account"])
    assert_not_nil(details["products"])

    assert_kind_of(Hash, details["account"])
    assert_kind_of(Array, details["products"])
  end
  
  def test_apps
    apps = @user.products(@config[:username])
    assert_not_nil(apps)
    assert_kind_of(Hash, apps)

    assert(apps.size > 0, "account should have at least one app")
    first_app = apps[apps.keys.first]
    assert_kind_of(Hash, first_app)
    assert_kind_of(Array, first_app["in_apps"])
    assert_not_nil(first_app["name"])
    assert_not_nil(first_app["id"])
  end
  
end