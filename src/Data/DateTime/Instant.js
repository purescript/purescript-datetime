"use strict";

var createDateTime = function (y, m, d, h, mi, s, ms) {
  var dateTime = new Date(Date.UTC(y, m, d, h, mi, s, ms));
  if (y >= 0 && y < 100) {
    dateTime.setUTCFullYear(y);
  }
  return dateTime;
};

exports.fromDateTimeImpl = function (y, mo, d, h, mi, s, ms) {
  return createDateTime(y, mo - 1, d, h, mi, s, ms).getTime();
};

exports.fromLocalDateTimeImpl = function (y, mo, d, h, mi, s, ms, o) {
  return createDateTime(y, mo - 1, d, h, mi, s, ms).getTime() + 6e4 * o;
};

exports.toDateTimeImpl = function (ctor) {
  return function (instant) {
    var dt = new Date(instant);
    return ctor (dt.getUTCFullYear())(dt.getUTCMonth() + 1)(dt.getUTCDate())(dt.getUTCHours())(dt.getUTCMinutes())(dt.getUTCSeconds())(dt.getUTCMilliseconds());
  };
};

exports.toLocalDateTimeImpl = function(ctor) {
  return function(instant) {
    var dt = new Date(instant);
    return ctor (dt.getFullYear())(dt.getMonth() + 1)(dt.getDate())(dt.getHours())(dt.getMinutes())(dt.getSeconds())(dt.getMilliseconds())(dt.getTimezoneOffset());
  };
};
