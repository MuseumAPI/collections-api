###
  The id parser takes html, and returns an error and id object
  the html body must be a string
  the callback passes an error or parsed id object

  for example:

    parseids = require 'lib/parsers/ids'

    http.get 'http://metmuseum.org/search-the-collections/3', (response) ->
      parseids response, (err, ids) ->
        console.log err or ids
###

cheerio = require 'cheerio'
restify = require 'restify'
_ = require '../util'

parseIds = (body, cb) ->
  throw new Error "[parseIds] missing body" unless body?
  throw new Error "[parseIds] missing callback" unless cb?

  $ = cheerio.load body

  if $('.artefact-listing li').length
    result = ids: (_.a_to_id $(a) for a in $('.object-image'))

    get_id = (selector) -> /pg=(\d+)/.exec($(selector)?.first()?.attr('href'))?[1]
    [prev, next, last] = (+ get_id sel for sel in ['.prev a', '.next a', '.pagination li:last-child a'])

    pages = {next, prev, last, first: 1}
    delete pages[page] for page,number of pages when isNaN number
    result['pages'] = pages

    cb null, result
  else
    cb new restify.NotFoundError

module.exports = parseIds
