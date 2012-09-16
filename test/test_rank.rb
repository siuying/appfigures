require "yaml"
require "test/unit"

require "rubygems"
require "bundler"
Bundler.require(:default)

require "./lib/appfigures"
require 'uri'
class TestRank < Test::Unit::TestCase
  def setup
    path = File.expand_path(File.dirname(__FILE__))
    @config = YAML::load(open("#{path}/appfigures_fixture.yml"))

    assert_not_nil(@config, "you must create appfigures_fixture.yml")
    assert_not_nil(@config[:username], "you must configure username")
    assert_not_nil(@config[:password], "you must configure password")

    assert_not_equal("", @config[:username], "you must configure username")
    assert_not_equal("", @config[:password], "you must configure password")

    @user = Appfigures::User.new @config[:username], @config[:password]
    @rank = Appfigures::Rank.new @config[:username], @config[:password]
    
    @day_minutes_one = (Time.now - 24*60*60).strftime("%Y-%m-%d")
    @day_minutes_two = (Time.now - 2*24*60*60).strftime("%Y-%m-%d")
  end

  def test_ranks
    apps = @user.products(@config[:username])
    first_app = apps[apps.keys.first]
    assert_kind_of(Hash, first_app)

    ranks = @rank.ranks(first_app["id"], "daily", @day_minutes_two, @day_minutes_one)
    assert_not_nil(ranks, "ranks report should be okay")
  end
  
  def test_ranks_complex
    apps = @user.products(@config[:username])
    apps = apps.keys[0..10].join(";")
    ranks = @rank.ranks(apps, "daily", @day_minutes_two, @day_minutes_one)
    assert_not_nil(ranks, "ranks report should be okay")
  end
end