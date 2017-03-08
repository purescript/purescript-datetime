"use strict";

exports.canonicalDateImpl = function (ctor, y, m, d) {
  var date = new Date(Date.UTC(y, m - 1, d));
  return ctor(date.getUTCFullYear())(date.getUTCMonth() + 1)(date.getUTCDate());
};

exports.calcWeekday = function (y, m, d) {
  return new Date(Date.UTC(y, m - 1, d)).getUTCDay();
};

exports.calcDiff = function (y1, m1, d1, y2, m2, d2) {
  var dt1 = new Date(Date.UTC(y1, m1 - 1, d1));
  var dt2 = new Date(Date.UTC(y2, m2 - 1, d2));
  return dt1.getTime() - dt2.getTime();
};
