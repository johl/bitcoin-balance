# bitcoin-balance
bitcoin-balance is a very simple Ruby script to show what's in your Bitcoin wallet and how much that is worth. It's meant to be run as a standalone command line application.

# Prerequisites

You need to have the Bitcoin client installed and configured for accepting JSON-RPC. Please [see the Bitcoin wiki](https://en.bitcoin.it/wiki/Running_bitcoind) for the configuration details.

You also need to have *Bundler* installed. If you haven't done this already, please run
    
    gem install bundler

# Installation and running he application

Install the required gems
     
    bundle install

You may now run the application

    chmod a+x ./balance.rb
    ./balance.rb
    
By default, you balance is converted to Euro. If you want it converted to US$, try

    ./balance.rb --currency=USD
    
or
 
    ./balance.rb -c USD
    

