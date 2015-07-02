/* global exports */
"use strict";

// module Data.Date

exports.nowEpochMilliseconds = function () {
  return Date.now();
};

exports.nowImpl = function (ctor) {
  return function () {
    return ctor(new Date());
  };
};

exports.jsDateConstructor = function (x) {
  return new Date(x);
};

// jshint maxparams: 2
exports.jsDateMethod = function (method, date) {
  return date[method]();
};

// jshint maxparams: 3
exports.strictJsDate = function (just, nothing, s) {
  var epoch = Date.parse(s);
  if (isNaN(epoch)) return nothing;
  var date = new Date(epoch);
  var s2 = date.toISOString();
  var idx = s2.indexOf(s);
  return idx < 0 ? nothing : just(date);
};
