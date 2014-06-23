# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

class TwitterCldr.CharacterSet extends TwitterCldr.Component
  constructor : (text) ->
    name_parts = text.split("=")
    if name_parts.length == 2
      @property = name_parts[0].toLowerCase()
      @property_value = name_parts[1]

    else
      @property_value = text
      @property = null

  to_regexp_str : ->
    @set_to_regex(@to_set())

  to_set : ->
    codepoints().subtract(TwitterCldr.UnicodeRegex.invalid_regexp_chars)

  codepoints : ->
    if @property?
      method = "code_points_for_" + property

      if (typeof(TwitterCldr.CodePoint[method]) == typeof(Function))
        ranges = TwitterCldr.CodePoint[method](property_value)

        if ranges?
          new TwitterCldr.Utils.RangeSet(ranges)

        else
          throw "Couldn't find property " + property + " containing property value " + property_value

      else
        throw "Couldn't find property " + property
    else
      new TwitterCldr.Utils.RangeSet (TwitterCldr.CodePoint.code_points_for_property_value(property_value))
