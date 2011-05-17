path = File.expand_path(File.dirname(__FILE__))
$:.unshift(path) unless $:.include?(path)

module Appfigures
  API_URL = "https://api.appfigures.com/v1"
end

require 'appfigures/user'
require 'appfigures/data'
require 'appfigures/sale'
require 'appfigures/rank'