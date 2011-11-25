#!/usr/bin/env ruby
require "rubygems"
require "bundler/setup"
require 'bitcoin'
require 'optparse'
require 'json'
require 'rest_client'
options = {}
options['currency'] =  "EUR"
OptionParser.new do |opts|
  opts.banner = "Usage: #{$0} [options]"
  opts.separator ""
  opts.separator "Specific options:"
  opts.on("-c", "--currency CURRENCY",
              "convert to a given currency, e.g. USD or EUR (EUR is default)") do |cur|
        options['currency'] = cur
  end
end.parse!
currency = options['currency']
balance = Bitcoin('user', 'password').balance
balanceCUR = JSON.parse(RestClient.get "https://mtgox.com/api/0/data/ticker.php?Currency=#{currency}")['ticker']['avg'] * balance
puts "You have #{balance} BTC, which is currently #{balanceCUR} #{currency}."