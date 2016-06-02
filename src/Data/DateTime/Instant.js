"use strict";

exports.fromDateTimeImpl = function (y, mo, d, h, mi, s, ms) {
  return new Date(Date.UTC(y, mo - 1, d, h, mi, s, ms)).getTime();
};

exports.toDateTimeImpl = function (ctor) {
  return function (instant) {
    var dt = new Date(instant);
    return ctor
      (dt.getUTCFullYear())(dt.getUTCMonth() + 1)(dt.getUTCDate())
      (dt.getUTCHours())(dt.getUTCMinutes())(dt.getUTCSeconds())
      (dt.getUTCMilliseconds());
  };
};
