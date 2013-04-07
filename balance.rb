#!/usr/bin/env ruby
require "rubygems"
require "bundler/setup"
require "thor"
require 'bitcoin'
require 'json'
require 'rest_client'

class Balance < Thor
  
  desc "", "Show what's in your wallet and how much that is worth"
  method_option :currency, :type => :string, :aliases => "-c", :default => "EUR"
  def balance
    user = get_user()
    password = get_password()
    balance = Bitcoin(user, password).balance
    balanceCUR = Float(JSON.parse(RestClient.get "http://data.mtgox.com/api/1/BTC#{options[:currency].upcase}/ticker")['return']['avg']['value']) * balance
    puts "You have #{balance} BTC in your wallet on this computer, which is currently #{balanceCUR} #{options[:currency].upcase}."
  end
  
  no_tasks do
    def determine_os
      if RUBY_PLATFORM =~ /linux/ then
        return "Linux"
      elsif RUBY_PLATFORM =~ /mswin32/ then
        return "Windows"
      elsif RUBY_PLATFORM =~ /darwin/ then
        return "Mac OS X"
      end
    end
    
    def parse_configuration
      return Hash[File.read(get_configuration().to_s).scan(/(\w*)=(\w*)/)]
    end
    
    def get_configuration
      require 'etc'
      os = determine_os()
      cfg = "bitcoin.conf"
      if os == "Mac OS X" then
        return Etc.getpwuid.dir + "/Library/Application\ Support/Bitcoin/" + cfg
      elsif os == "Linux" then
        return Etc.getpwuid.dir + "/.bitcoin/" + cfg
      elsif os == "Windows"
        return Etc.getpwuid.dir + "\\Bitcoin\\" + cfg
      end
    end
    
    def get_user
      return parse_configuration()['rpcuser']
    end
      
    def get_password
      return parse_configuration()['rpcpassword']
    end
  end
  
end

ARGV.unshift("balance")
Balance.start
