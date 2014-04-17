###
  Toobusy is a mozilla module that checks if the server is under too much load to complete a request.
  Much better than having an unending queue and having to restart
###

module.exports = ->
  toobusy = require 'toobusy-js'

  (req, res, next) ->
    if toobusy()
      res.send 503, {code: 'InternalError', message: "I'm busy right now, sorry."}
    else
      next()
