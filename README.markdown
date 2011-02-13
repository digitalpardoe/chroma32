Chroma32
========

Introduction
------------

Chroma32 was created between 2009/2010 as my final-year university
project and was built on top of alphas & betas of Rails 3 and
development versions of associated plugins.

The project is based on a simple document management framework with
support for plugins, theming and security. The code that turns the
framework into Chroma32 is contained entirely within plugins so can
easily be removed.

For those that are interested, plugin support is provided by a 'rails
engine' called Plugineer that can be found in the _lib/engines_
directory with an extension to ActiveRecord that can be found in
the _lib/extensions_ directory.

Licensing information for Chroma32 can be found in the LICENSE.txt
file contained in this repository.

About
-----

Chroma32 is a photographic asset management system built on a
custom document management framework. This system in it's
current guise provides a basic web application through which
digital images can be easily distributed to friends, family &
event clients. With full support or user authentication,
authorisation and event management.

Setup Instructions
------------------

### Post-Commit

Once you've checked out the app you'll need to run:

    git submodule init
    
And:

    git submodule update
    
To ensure you have the required libraries.

### Requirements

These requirements will need to be satisfied before the
application can be installed, automatically or manually;

- Ruby 1.8.x or above.
- RubyGems 1.3.6 or greater.
- Rake 0.8.x or higher (RubyGem).
- Bundler 0.9.16 or greater (RubyGem).
- The _freeimage_ libraries (for the _image\_science_ RubyGem).
- SQLite libraries (for the _sqlite3-ruby_ RubyGem).

### Installation

#### Automated Installation

From with the application directory (defaults to an SQLite3
databse);

- Run `ruby setup.rb`.

#### Manual Installation

From within the application directory;

- Run `bundle install`.

If the above step fails due to an error installing the MySQL gem
you will need to edit _Gemfile_ and comment or remove the line
containing `gem "mysql"`.

- Copy _config/database.example.yml_ to _config/database.yml_.
- Customise the configuration in this file to suit your needs.
- Run `rake tmp:create`.
- Run `rake db:migrate`.
- Run `rake db:seed`.


### Running The Application

After completing the installation steps you should be able to
the application by running the command `rails server`.

In your web browser you can then navigate to [http://localhost:3000/](http://localhost:3000/),
the default email address for logging in is _example@example.com_
and the default password is _changeme_. You can change both of these
in the administrative control panel.
