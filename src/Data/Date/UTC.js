/* global exports */
"use strict";

// module Data.Date.UTC

exports.dateMethod = function (method, date) {
  return date[method]();
};

exports.jsDateFromValues = function (y, mo, d, h, mi, s, ms) {
  return new Date(Date.UTC(y, mo, d, h, mi, s, ms));
};
