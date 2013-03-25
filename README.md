mongoose-times
==============

[![Build Status](https://secure.travis-ci.org/nicholasconfer/mongoose-times.png?branch=master)](https://travis-ci.org/nicholasconfer/mongoose-times)

Plugin for [Mongoose](https://github.com/LearnBoost/mongoose) that adds `created` and `lastUpdated` date properties to your Schema.  The property names `created` and `lastUpdated` can be customized and the properties automatically generate timestamps when saving a document in mongoose.

## Installation

```
npm install mongoose-times
```

## Usage

The examples below create a message model that will include `created` and `lastUpdated` properties in their schema.  Those properties will have timestamps that are automatically generated and updated when you save your document.

### [CoffeeScript](https://github.com/jashkenas/coffee-script) Example
```CoffeeScript
mongoose = require "mongoose"
timestamps = require "mongoose-times"

ExampleSchema = new Schema {}
ExampleSchema.plugin timestamps

example = mongoose.model "Example", ExampleSchema
```
If you'd like to change the name of the key properties in your document just set them when calling the plugin method with the `created` and `lastUpdated` options
```
ExampleSchema.plugin timestamps { created: "created_at", lastUpdated: "updated_at" }
```

### JavaScript Example
```JavaScript
var mongoose = require("mongoose"),
    timestamps = require("mongoose-times");

var ExampleSchema = new Schema({});
ExampleSchema.plugin(timestamps);

var example = mongoose.model("Example", ExampleSchema);
```

Again, if you'd like to change the name of the key properties in your document just then when calling the plugin method with the `created` and `lastUpdated` options
```
ExampleSchema.plugin(timestamps, { created: "created_at", lastUpdated: "updated_at" });
```

## MIT License

Copyright (c) 2013 [Nicholas Confer](https://github.com/nicholasconfer)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## Final Note

There are other Mongoose plugins for timestamps, but I wanted to learn to write a mongoose plugin, so I started a new repo and added a new feature of customizable key names for the properties.

This plugin was based on previous work from [mongoose-timestamp](https://github.com/drudge/mongoose-timestamp): Copyright (c) 2012 [Nicholas Penree](https://github.com/drudge) and [mongoose-time](https://github.com/yields/mongoose-time): Copyright (c) 2012 [Amir Abu Shareb](https://github.com/yields).  Thanks go out to both of these developers for sharing their code under MIT.
