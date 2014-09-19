window.ig.getData = ->
  koalice = ig.data.koalice.split "\n" .map (.split "\t")
  strany = []
  ig.data.strany_kody.split "\n"
    ..shift!
    ..forEach ->
      [id, nazev, zkratka] = it.split "\t"
      id = parseInt id
      valid = id in [1 3 7 47 53 679]
      strany[id] = {nazev, zkratka, valid}

  headers = koalice.shift!
  maxLen = 6
  headers.shift!
  headers .= map ->
    id = parseInt it, 10
    strany[id]
  koalice.length = maxLen
  koalice .= map (line, li) ->
    line.shift!
    line.length = maxLen
    strana = headers[li]
    sum = 0
    nullPassed = false
    line .= map (record, ri) ->
      value = (parseInt record, 10) || 0
      sum += value
      value
    line.strana = strana
    line
  koalice

