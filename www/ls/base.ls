init = ->
  data = ig.getData!
  container = d3.select ig.containers.base
  new Tooltip!watchElements!
  chord = d3.layout.chord!
    ..matrix data
    ..padding 0.05
  width = 610
  height = 610
  innerRadius = 550 * 0.48
  outerRadius = 550 * 0.5
  colors =
    \#0FB103
    \#FEE300
    \#8E8E8E
    \#5434A3
    \#1C76F0
    \#e3001a
    \#f29400
    \#66E2D8
    \#B1C484
    \#000000
    \#FB9A99
  arcFill = (d, i) ->
    colors[i]

  chordFill = d3.scale.category20c!

  svg = container.append \svg
    ..attr \width width
    ..attr \height height
  defs = svg.append \defs

  drawing = svg.append \g
    ..attr \transform "translate(#{width / 2}, #{height / 2})"
  def = d3.svg.arc!innerRadius innerRadius .outerRadius outerRadius + 5
  def2 = d3.svg.arc!innerRadius innerRadius .outerRadius outerRadius
  drawing.selectAll \path.radius .data chord.groups .enter!append \path
    ..attr \class \radius
    ..style \fill arcFill
    ..attr \d def2
  defs.selectAll \path .data chord.groups .enter!append \path
    ..attr \id (d, i) -> "textPath-#i"
    ..attr \d def
  drawing.selectAll \text .data chord.groups .enter!append \text
    ..append \textPath
      ..attr \xlink:href (d, i) -> '#textPath-' + i
      ..text (d, i) -> data[i].strana.zkratka

  def = d3.svg.chord!radius innerRadius

  drawing.selectAll \path.chord .data chord.chords .enter!append \path
    ..attr \class \chord
    ..attr \d def
    ..style \fill (d, i) -> chordFill i
    ..style \stroke (d, i) -> chordFill i
    ..attr \data-tooltip ({source, target}:d) ->
      "<b>#{data[source.index].strana.nazev}</b> a <b>#{data[target.index].strana.nazev}</b> jsou v koalici na <b>#{source.value}</b> kandidátkách"

if d3?
  init!
else
  $ window .bind \load ->
    if d3?
      init!
