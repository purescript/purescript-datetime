{ name = "datetime"
, dependencies =
  [ "console"
  , "effect"
  , "psci-support"
  , "bifunctors"
  , "control"
  , "either"
  , "enums"
  , "foldable-traversable"
  , "functions"
  , "gen"
  , "integers"
  , "lists"
  , "math"
  , "maybe"
  , "newtype"
  , "ordered-collections"
  , "partial"
  , "prelude"
  , "tuples"
  , "proxy"
  , "assert"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
