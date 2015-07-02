/* global exports */
"use strict";

// module Data.Date.Locale

// jshint maxparams: 2
exports.dateMethod = function (method, date) {
  return function () {
    return date[method]();
  };
};

// jshint maxparams: 7
exports.jsDateFromValues = function (y, mo, d, h, mi, s, ms) {
  return function () {
    return new Date(y, mo, d, h, mi, s, ms);
  };
};
