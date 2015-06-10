/* global exports */
"use strict";

// module Data.Date.Locale

exports.dateMethod = function(method, date) {
    return function () {
        return date[method]();
    };
};

exports.jsDateFromValues = function(y, mo, d, h, mi, s, ms) {
    return function () {
        return new Date(y, mo, d, h, mi, s, ms);
    };
};
