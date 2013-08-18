Mango.js
===

Mango.js lets you easily work with user stories from your favorite project management tools like Pivotal Tracker, Asana, or Trello in your Node.js app.



* Convert user stories into Cucumber features
* Update the state of your user stories when tests pass directly from  your Cucumber tests
* Have more fun testing

## Installation

`$ npm install mangojs`

## Usage

### Conversion

To convert your user stories into Cucumber features:

1. Go to [<%= root_url %>](<%= root_path %>) and sign in using
your Pivotal Tracker *API token* and *project ID*.
2. Choose a user story and click **Convert** to turn that story into a Cucumber feature.
3. Then copy and paste the generated feature into your Cucumber features folder

### Updating stories when tests pass

Mango.js lets you update your stories' status from your tests using the Mango.js Node package.
