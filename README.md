couchrest_model_cloudant
========================

Cloudant Search support for the CouchRest Model Ruby library

https://cloudant.com/for-developers/search/

http://github.com/couchrest/couchrest_model

## Install

### Gem

    $ sudo gem install couchrest_model_cloudant

### Bundler

If you're using bundler, define a line similar to the following in your project's Gemfile:

    gem 'couchrest_model_cloudant'

## General Usage
### Define an index

    require 'couchrest_model_cloudant'

    class User < CouchRest::Model::Base
      property :email,                String
      property :gender,              String, :default => 'f'

      design do
        index :users, :index => 'function(doc){
           index("email", doc.email, {"store": "yes"});
           index("gender", doc.gender);
          }'
       end
     end

### Query an index and get back casted models

    @users = User.search('users', 'gender:Female', :limit => 20, :sort => 'email<string>', :include_docs => true)

    @users.size => 20
    @users.total_rows => 99 
    @users.bookmark => 'loripepsomdkjdfkdfjdfjkdfjkdfj'
    @users.first.class => User

### Query an index and get back raw results
    res = User.database.search("User", "users", "gender:Female", :limit => 20)
    res['total_rows'] => 99

## Testing

couchrest_model_cloudant comes with a Gemfile to help with development. If you want to make changes to the code, download a copy then run:

    bundle install

That should set everything up for `rake` to be run correctly which will launch the test suite.  

## Contact

couchrest_model_cloudant was developed by Gabe Malicki 

the original couchrest_model project can be found here http://github.com/couchrest/couchrest_model

Please post bugs, suggestions and patches relating to cloudant search functionality to the bug tracker at [http://github.com/gxbe/couchrest_model_cloudant/issues](http://github.com/gxbe/couchrest_model_cloudant/issues).  

Issues that are not related to cloudant search functionality should be directed to the main couchrest_model issue tracker here [http://github.com/couchrest/couchrest_model/issues](http://github.com/couchrest/couchrest_model/issues)


Copyright 2013 Gabriel Malicki