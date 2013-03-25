mocha = require "mocha"
should = require "should"

timestamps = require ".."

mongoose = require "mongoose"
database = require("./db").database
Schema = mongoose.Schema

mongoose.connect database
mongoose.connection.on "error", (err) ->
  console.error "MongoDB error: #{err.message}"
  console.log "Make sure MongoDB is up and running on #{database}."

TestSchema = new Schema {}
TestSchema.plugin timestamps
TestModel = mongoose.model("Test", TestSchema)

TestCustomSchema = new Schema {}
TestCustomSchema.plugin timestamps, { created: "posted", lastUpdated: "updated" }
TestCustomModel = mongoose.model("TestCustom", TestCustomSchema)

after((done) ->
  mongoose.connection.db.dropDatabase()
  done()
)

describe "mongoose-times", ->
  it "should create properties `created` and `lastUpdated`", (done) ->
    timestamp = Date.now()
    new TestModel().save((err, doc) ->
      if err then done err
      doc.created.should.be.within timestamp, Date.now()
      doc.lastUpdated.should.be.within timestamp, Date.now()
      done()
    )

  it "should only set lastUpdated when a doc is being updated", (done) ->
    test = new TestModel()
    test.save (err, old) ->
      if err then done err
      oldCache = {
        created: old.created,
        lastUpdated: old.lastUpdated
      }
      setTimeout ->
        test.save (err, doc) ->
          if err then done err
          doc.lastUpdated.should.be.above doc.created
          doc.lastUpdated.should.be.above oldCache.lastUpdated
          doc.created.should.be.equal oldCache.created
          done()
      , 1000

  it "should create properties `posted` and `updated` instead of `created` and `lastUpdated`", (done) ->
    timestamp = Date.now()
    new TestCustomModel().save((err, doc) ->
      if err then done err
      doc.posted.should.be.within timestamp, Date.now()
      doc.updated.should.be.within timestamp, Date.now()
      done()
    )

