# Marvin

Marvin is a [hubot](https://hubot.github.com/)-style Slackbot, tailor-made for
  [The Iron Yard in DC](http://theironyard.com/locations/washington-dc/).

It is currently running on Heroku (but free tier, without a web UI, and
  scheduled to throttle down between 1AM and 7AM EST) and powering our local
  Slack group.

A few notable points:

* [A plugin-based architecture](https://github.com/TIY-DC-ROR-2015-Sep/marvin-bot/blob/master/app/models/marvin.rb) makes it easy to add new tricks
* The chatbot communicates with Slack [using websockets](https://github.com/TIY-DC-ROR-2015-Sep/marvin-bot/blob/a16b38abcf37200557ccb4b243665b3cac56f3f2/app/models/marvin.rb#L61)
* Business logic [is tested](https://github.com/TIY-DC-ROR-2015-Sep/marvin-bot/blob/a16b38abcf37200557ccb4b243665b3cac56f3f2/test/models/marvin_test.rb) (using a bit of dependency injection for the Slack socket)

# Running Locally

Clone and `bundle` the project as usual.

Once that's done, run

    $ rails runner bin/firstbot.rb

and you should be good to go.

# Running Tests

    $ rake test
