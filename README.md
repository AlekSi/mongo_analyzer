### mongo_analyzer
A Sinatra web application that allows you to enable the
[MongoDB profiler](http://www.mongodb.org/display/DOCS/Optimization#Optimization-UsingtheProfiler)
and see it's results. You can also see and manage the indexes of your collections.

Go to [http://www.lennartkoopmann.net/post/3603788835/mongo-analyzer](http://www.lennartkoopmann.net/post/3603788835/mongo-analyzer) for more information and screenshots.

### Installation
 1. Clone repository: `https://lennartkoopmann@github.com/lennartkoopmann/mongo_analyzer.git`
 2. Go to your new mongo_analyzer folder: `cd mongo_analyzer`
 3. Install the required gems: `bundle install` (You must have bundler installed: http://gembundler.com/)
 4. Copy the `config.yml.example` to `config.yml` and adjust it's content. Should be self-explanatory.
 5. Run mongo_analyzer: run `rackup`
 6. Go to http://localhost:9292/ (you can set the port like this: `rackup -p 9292`)

### License
Copyright 2011 Lennart Koopmann <lennart@socketfeed.com>

Licensed under the GNU General Public License Version 3 (GPLv3) - See LICENSE for more details.
