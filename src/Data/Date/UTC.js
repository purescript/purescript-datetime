/* global exports */
"use strict";

// module Data.Date.UTC

export.dateMethod = function(method, date) {
    return date[method]();
};

export.jsDateFromValues = function(y, mo, d, h, mi, s, ms) {
    return new Date(Date.UTC(y, mo, d, h, mi, s, ms));
};
