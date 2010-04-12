Chroma32
========

Introduction
------------

Chroma32, the photographic asset management system built atop of
the CoreDM document management framework. This system in it's
current guise provides a basic web application through which
digital images can be easily distributed to friends, family &
event clients. With full support or user authentication,
authorisation and event management.

Setup Instructions
------------------

### Requirements

These requirements will need to be satisfied before the
application can be installed, automatically or manually;

- Ruby 1.8.x or above.
- RubyGems 1.3.6 or greater.
- Rake 0.8.x or higher (RubyGem).
- Bundler 0.9.16 or greater (RubyGem).
- The '_freeimage_' libraries (for the '_image\_science_' RubyGem).

### Installation

From within the application directory;

- Run '_bundle install_'.

If the above step fails due to an error installing the MySQL gem
you will need to edit '_Gemfile_' and comment or remove the line
containing '_gem \"mysql\"_'.

- Copy '_config/database.example.yml_' to '_config/database.yml_'.
- Customise the configuration in this file to suit your needs.
- Create the directory '_tmp/pids_'.
- Create the directory '_tmp/documents_'.
- Run '_rake db:migrate_'.
- Run '_rake db:seed_'.


### Running The Application

After completing the installation steps you should be able to
the application by running the command '_rails server_'.

In your web browser you can then navigate to '_http://localhost:3000/_',
the default email address for logging in is '_example@example.com_'
and the default password is '_changeme_'. You can change both of these
in the administrative control panel.
