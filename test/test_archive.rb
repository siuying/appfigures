require "yaml"
require "test/unit"

require "rubygems"
require "bundler"
Bundler.require(:default)

require "./lib/appfigures"

class TestArchive < Test::Unit::TestCase
  def setup
    path = File.expand_path(File.dirname(__FILE__))
    @config = YAML::load(open("#{path}/appfigures_fixture.yml"))

    assert_not_nil(@config, "you must create appfigures_fixture.yml")
    assert_not_nil(@config[:username], "you must configure username")
    assert_not_nil(@config[:password], "you must configure password")

    assert_not_equal("", @config[:username], "you must configure username")
    assert_not_equal("", @config[:password], "you must configure password")

    @archive = Appfigures::Archive.new @config[:username], @config[:password]
    @user = Appfigures::User.new @config[:username], @config[:password]
    
    @day_minutes_one = (Time.now - 24*60*60).strftime("%Y-%m-%d")
    @day_minutes_two = (Time.now - 2*24*60*60).strftime("%Y-%m-%d")

    @apps = @user.products(@config[:username])
    @first_app = @apps[@apps.keys.first]
    assert_kind_of(Hash, @first_app)
  end

  def test_archives
    daily = @archive.archives("daily")
    assert_not_nil(daily, "daily archives should be okay")
    assert_kind_of(Hash, daily)
  end

  def test_latest
    latest = @archive.latest("daily")
    assert_not_nil(latest, "latest archives should be okay")
    assert_kind_of(Hash, latest)
  end

  def test_by_date_and_raw
    by_date = @archive.by_date("2012-09-10", "daily")
    assert_not_nil(by_date, "by_date report should be okay")
    assert_kind_of(Hash, by_date)

    # requires admin permission
    # raw = @archive.raw(by_date.values.first["id"])
    # assert_not_nil(raw, "raw report should be okay")
    # assert_kind_of(String, raw)
  end
end