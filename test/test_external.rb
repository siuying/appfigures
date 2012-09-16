require "yaml"
require "test/unit"

require "rubygems"
require "bundler"
Bundler.require(:default)

require "./lib/appfigures"

class TestUser < Test::Unit::TestCase
  # def test_external
  #   path = File.expand_path(File.dirname(__FILE__))
  #   @config = YAML::load(open("#{path}/appfigures_fixture.yml"))
  #   @details = @user.details(@config[:username])

  #   if @details["role"] == "admin"
  #     @external = Appfigures::External.new @config[:username], @config[:password]
  #     acct = @external.external
  #     assert_not_nil(acct)
  #     assert_kind_of(Hash, acct)
  #     assert(acct.size > 0, "account should have at least one itc_account")

  #     first_acct = acct[acct.keys.first]
  #     assert_kind_of(Hash, first_acct)
  #     assert_not_nil(first_acct["account_id"])
  #     assert_not_nil(first_acct["id"])
  #   else
  #     assert_equal(acct.parsed_response["additional"], "You do not have permission to access this resource.")
  #   end

  # end
end