// Generated by CoffeeScript 1.6.2
(function() {
  var Schema, TestCustomModel, TestCustomSchema, TestModel, TestSchema, database, mocha, mongoose, should, timestamps;

  mocha = require("mocha");

  should = require("should");

  timestamps = require("..");

  mongoose = require("mongoose");

  database = require("./db").database;

  Schema = mongoose.Schema;

  mongoose.connect(database);

  mongoose.connection.on("error", function(err) {
    console.error("MongoDB error: " + err.message);
    return console.log("Make sure MongoDB is up and running on " + database + ".");
  });

  TestSchema = new Schema({});

  TestSchema.plugin(timestamps);

  TestModel = mongoose.model("Test", TestSchema);

  TestCustomSchema = new Schema({});

  TestCustomSchema.plugin(timestamps, {
    created: "posted",
    lastUpdated: "updated"
  });

  TestCustomModel = mongoose.model("TestCustom", TestCustomSchema);

  after(function(done) {
    mongoose.connection.db.dropDatabase();
    return done();
  });

  describe("mongoose-times", function() {
    it("should create properties `created` and `lastUpdated`", function(done) {
      var timestamp;

      timestamp = Date.now();
      return new TestModel().save(function(err, doc) {
        if (err) {
          done(err);
        }
        doc.created.should.be.within(timestamp, Date.now());
        doc.lastUpdated.should.be.within(timestamp, Date.now());
        return done();
      });
    });
    it("should only set lastUpdated when a doc is being updated", function(done) {
      var test;

      test = new TestModel();
      return test.save(function(err, old) {
        var oldCache;

        if (err) {
          done(err);
        }
        oldCache = {
          created: old.created,
          lastUpdated: old.lastUpdated
        };
        return setTimeout(function() {
          return test.save(function(err, doc) {
            if (err) {
              done(err);
            }
            doc.lastUpdated.should.be.above(doc.created);
            doc.lastUpdated.should.be.above(oldCache.lastUpdated);
            doc.created.should.be.equal(oldCache.created);
            return done();
          });
        }, 1000);
      });
    });
    return it("should create properties `posted` and `updated` instead of `created` and `lastUpdated`", function(done) {
      var timestamp;

      timestamp = Date.now();
      return new TestCustomModel().save(function(err, doc) {
        if (err) {
          done(err);
        }
        doc.posted.should.be.within(timestamp, Date.now());
        doc.updated.should.be.within(timestamp, Date.now());
        return done();
      });
    });
  });

}).call(this);
