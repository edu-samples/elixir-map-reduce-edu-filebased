
## Map Reduce - Educational File Based

This project will be eduational example of Elixir/Erlang OTP usage.

Will show simplified educational example doing "map-reduce" over files.

It will:

* code of one actor will transform incoming message with {directory name, to whom to send filenames} and then send all paths of filenames (scripts) inside this directory to other actor that is pointed.
* other actor will be launched in parallel, executing all those files with bash, and once completed sending results to third actor
* third actor will be receiving all those results, and combining them together into one log file, writing `# YYYY-DD-MM HH:MM:ss scriptname` followed by results enclosed in ````````` , ````````` (nine backticks as opening and ending)


