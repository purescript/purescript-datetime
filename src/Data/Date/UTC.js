/* global exports */
"use strict";

// module Data.Date.UTC

// jshint maxparams: 2
exports.dateMethod = function (method, date) {
  return date[method]();
};

// jshint maxparams: 7
exports.jsDateFromValues = function (y, mo, d, h, mi, s, ms) {
  return new Date(Date.UTC(y, mo, d, h, mi, s, ms));
};
