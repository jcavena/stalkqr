url = require 'url'
GitHubStrategy = require('passport-github').Strategy
TwitterStrategy = require('passport-twitter').Strategy
user = require '../models/user'

TWITTER_CONSUMER_KEY = process.env.TWITTER_CONSUMER_KEY
TWITTER_CONSUMER_SECRET = process.env.TWITTER_CONSUMER_SECRET
TWITTER_CALLBACK_URL = url.resolve process.env.CALLBACK_BASE_URL, '/auth/twitter/callback'

GITHUB_CLIENT_ID = process.env.GITHUB_CLIENT_ID
GITHUB_CLIENT_SECRET = process.env.GITHUB_CLIENT_SECRET
GITHUB_CALLBACK_URL = url.resolve process.env.CALLBACK_BASE_URL, '/auth/github/callback'

twitterDone = (accessToken, tokenSecret, profile, callback) ->
  user.find_by_service 'twitter', profile.id, callback

githubDone = (accessToken, tokenSecret, profile, callback) ->
  user.find_by_service 'github', profile.id, callback

twitter = new TwitterStrategy
  consumerKey: TWITTER_CONSUMER_KEY
  consumerSecret: TWITTER_CONSUMER_SECRET
  callbackURL: TWITTER_CALLBACK_URL
  twitterDone

github = new GitHubStrategy
  clientID: GITHUB_CLIENT_ID
  clientSecret: GITHUB_CLIENT_SECRET
  callbackURL: GITHUB_CALLBACK_URL
  githubDone

module.exports = 
  twitter: twitter
  github: github