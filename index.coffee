# default plugin options values
defaults = {
created: "created",
lastUpdated: "lastUpdated"
}

# dateJSON method to create JSON date property with key name
dateJSON = (key) ->
  json = {}
  json[key] = Date
  json

# mongoose-times plugin method
module.exports = (schema, options)->
  created = if options and options.created then options.created else defaults.created
  lastUpdated = if options and options.lastUpdated then options.lastUpdated else defaults.lastUpdated

  schema.add dateJSON(created)
  schema.add dateJSON(lastUpdated)

  schema.pre "save", (next) ->
    timestamp = Date.now()
    @[created] = timestamp unless @[created]?
    @[lastUpdated] = timestamp
    next()