"use strict";

function dateTime(rec) {
  var ts = Date.UTC(
    rec.year,
    rec.month - 1,
    rec.day,
    rec.hour,
    rec.minute,
    rec.second,
    rec.millisecond
  );

  var date = new Date(ts);

  if (rec.year >= 0 && rec.year < 100) {
    date.setUTCFullYear(rec.year);
  }

  return date;
}

function timestamp(rec) {
  return dateTime(rec).getTime();
}

function toRecord(d) {
  return {
    year: d.getUTCFullYear(),
    month: d.getUTCMonth() + 1,
    day: d.getUTCDate(),
    hour: d.getUTCHours(),
    minute: d.getUTCMinutes(),
    second: d.getUTCSeconds(),
    millisecond: d.getUTCMilliseconds()
  };
}

exports.normalize = function (rec) {
  return toRecord(dateTime(rec));
};

exports.weekday = function (rec) {
  return dateTime(rec).getUTCDay();
};

exports.adjustImpl = function (just) {
  return function (nothing) {
    return function (offset) {
      return function (rec) {
        var ms = timestamp(rec);
        var dt = new Date(ms + offset);
        return isNaN(dt.getTime()) ? nothing : just(toRecord(dt));
      };
    };
  };
};

exports.diff = function (rec0) {
  return function (rec1) {
    var ts0 = timestamp(rec0);
    var ts1 = timestamp(rec1);
    return ts0 - ts1;
  };
};
