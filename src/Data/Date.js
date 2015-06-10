/* global exports */
"use strict";

// module Data.Date

exports.nowEpochMilliseconds = function() {
    return Date.now();
};

exports.nowImpl = function(ctor) {
    return function(){
        return ctor(new Date());
    };
};

exports.jsDateConstructor = function(x) {
    return new Date(x);
};

exports.jsDateMethod = function(method, date) {
    return date[method]();
};

exports.strictJsDate = function(Just, Nothing, s) {
    var epoch = Date.parse(s);
    if (isNaN(epoch)) return Nothing;
    var date = new Date(epoch);
    var s2 = date.toISOString();
    var idx = s2.indexOf(s);
    if (idx < 0) return Nothing;
    else return Just(date);
};
