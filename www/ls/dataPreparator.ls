window.ig.getData = ->
  koalice =
    ['Strana zelených', 'Křesťanská a demokratická unie - Československá strana lidová', 29]
    ['STAROSTOVÉ A NEZÁVISLÍ', 'Strana zelených', 20]
    ['STAROSTOVÉ A NEZÁVISLÍ', 'Křesťanská a demokratická unie - Československá strana lidová', 9]
    ['TOP 09', 'STAROSTOVÉ A NEZÁVISLÍ', 9]
    ['TOP 09', 'Občanská demokratická strana', 8]
    ['TOP 09', 'Křesťanská a demokratická unie - Československá strana lidová', 7]
    ['Občanská demokratická strana', 'Křesťanská a demokratická unie - Československá strana lidová', 4]
    ['TOP 09', 'Strana zelených', 3]
    ['Komunistická strana Čech a Moravy', 'Česká strana sociálně demokratická', 2]
    ['Úsvit přímé demokracie', 'Občanská demokratická strana', 1]
    ['Strana svobodných občanů', 'Občanská demokratická strana', 1]
    ['TOP 09', 'Strana svobodných občanů', 1]
    ['Úsvit přímé demokracie', 'Věci veřejné', 1]
    ['Strana Práv Občanů', 'Česká strana sociálně demokratická', 1]
    ['Strana Práv Občanů', 'Komunistická strana Čech a Moravy', 1]
  zkratky =
    "Strana zelených"                                               : "SZ"
    "Křesťanská a demokratická unie - Československá strana lidová" : "KDU-ČSL"
    "STAROSTOVÉ A NEZÁVISLÍ"                                        : "STAN"
    "TOP 09"                                                        : "TOP 09"
    "Občanská demokratická strana"                                  : "ODS"
    "Komunistická strana Čech a Moravy"                             : ""
    "Česká strana sociálně demokratická"                            : ""
    "Úsvit přímé demokracie"                                        : ""
    "Strana svobodných občanů"                                      : ""
    "Věci veřejné"                                                  : ""
    "Strana Práv Občanů"                                            : ""
  indices = {}
  i = 0
  for [a, b] in koalice
    if indices[a] is void then indices[a] = i++
    if indices[b] is void then indices[b] = i++
  out = []
  for [aNazev, bNazev, pocet] in koalice
    a = indices[aNazev]
    b = indices[bNazev]
    out[a] ?= []
    out[b] ?= []
    out[a][b] = pocet
    out[b][a] = pocet
    out[a].strana = {nazev: aNazev, zkratka: zkratky[aNazev]}
    out[b].strana = {nazev: bNazev, zkratka: zkratky[bNazev]}
  out_arr = for strana, obj of out
    obj
  len = 0
  for arr in out_arr
    len = Math.max arr.length, len
  for arr in out_arr
    for i in [0 til len]
      if arr[i] is void then arr[i] = 0
  out_arr

