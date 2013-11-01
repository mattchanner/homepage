express = require "express"
path = require "path"
home = require "./routes/home"
feeds = require "./routes/feeds"
feed = require "./routes/feed"

app = express()

app.configure () ->
    app.use express.favicon()
    app.use express.static(path.join(__dirname, "/public"))

# development is the default. Can be set by an environment variable i.e. set NODE_ENV=production
app.configure "development", () ->
    app.use express.logger('dev')

app.configure "production", () ->
    app.use express.logger('prod')

app.get '/', home.index
app.get '/feeds', feeds.get
app.get '/feeds/:id', feed.get
app.get '/feeds/:feedId/:storyId', feed.summary

console.log "Starting server on port 3000"
app.listen 3000
