require "yaml"
require "test/unit"

require "rubygems"
require "bundler"
Bundler.require(:default)

require "lib/appfigures"

class TestData < Test::Unit::TestCase
  def setup
    path = File.expand_path(File.dirname(__FILE__))
    @config = YAML::load(open("#{path}/appfigures_fixture.yml"))

    assert_not_nil(@config, "you must create appfigures_fixture.yml")
    assert_not_nil(@config[:username], "you must configure username")
    assert_not_nil(@config[:password], "you must configure password")

    assert_not_equal("", @config[:username], "you must configure username")
    assert_not_equal("", @config[:password], "you must configure password")

    Appfigures::Data.basic_auth @config[:username], @config[:password]
  end

  def test_categories
    data = Appfigures::Data.categories
    assert_not_nil(data)
    assert_kind_of(Hash, data)
  end

  def test_stores
    data = Appfigures::Data.stores
    assert_not_nil(data)
    assert_kind_of(Hash, data)
  end

  def test_languages
    data = Appfigures::Data.languages
    assert_not_nil(data)
    assert_kind_of(Hash, data)
  end

  def test_currencies
    data = Appfigures::Data.currencies
    assert_not_nil(data)
    assert_kind_of(Array, data)
  end

end