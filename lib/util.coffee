# Looks like perl, don't it?
# A host of common string processing functions for the parsers

remove_count = (arr) -> str.replace(/\([0-9,]+\)|:/, '').trim() for str in arr
flatten = (arr) -> if arr?.length is 1 then arr[0] else arr

util = module.exports =
  arrify: (str) -> str.split /\r\n/
  remove_empty: (arr) -> arr.filter (e) -> e.length
  process: (str) -> flatten @remove_empty remove_count @arrify str
  trim: (arr) -> str.trim() for str in arr when str?
  exists: (item, cb) -> cb item?
  a_to_id: (el) -> +(el.attr('href')?.match(/\d+/)?[0])
