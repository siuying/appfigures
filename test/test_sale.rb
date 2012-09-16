require "yaml"
require "test/unit"

require "rubygems"
require "bundler"
Bundler.require(:default)

require "./lib/appfigures"

class TestSale < Test::Unit::TestCase
  def setup
    path = File.expand_path(File.dirname(__FILE__))
    @config = YAML::load(open("#{path}/appfigures_fixture.yml"))

    assert_not_nil(@config, "you must create appfigures_fixture.yml")
    assert_not_nil(@config[:username], "you must configure username")
    assert_not_nil(@config[:password], "you must configure password")

    assert_not_equal("", @config[:username], "you must configure username")
    assert_not_equal("", @config[:password], "you must configure password")

    @sale = Appfigures::Sale.new @config[:username], @config[:password]
    @user = Appfigures::User.new @config[:username], @config[:password]
    
    @day_minutes_one = (Time.now - 24*60*60).strftime("%Y-%m-%d")
    @day_minutes_two = (Time.now - 2*24*60*60).strftime("%Y-%m-%d")
  end

  def test_sales
    apps = @user.products(@config[:username])
    first_app = apps[apps.keys.first]
    assert_kind_of(Hash, first_app)

    param = {:query => {:apps => first_app["id"]}}  
    one_app_report = @sale.sales("dates", @day_minutes_two, @day_minutes_one, [first_app["id"]], param)
    assert_not_nil(one_app_report, "sales report (one app only) should be okay")
  end
  
end