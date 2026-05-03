
#let CUBE-TEMPLATE = read("assets/cube.svg")
#let LL-TEMPLATE = read("assets/LL.svg")

#let colors = (
  W: "#FFFFFF",
  Y: "#FFD500",
  G: "#009E60",
  B: "#0051BA",
  R: "#C41E3A",
  O: "#FF5800",
  X: "#444444"
)

// only need the 3 visible faces for cube
#let flat-to-cube(flat-state) = {
  (
    u: flat-state.slice(0, 9),
    r: flat-state.slice(9, 18),
    f: flat-state.slice(18, 27),
  )
}

// Only upper face and 3 on each side for LL
#let flat-to-LL(flat-state) = {
  (
    u: flat-state.slice(0, 9),
    r: flat-state.slice(9, 12),
    f: flat-state.slice(18, 21),
    l: flat-state.slice(36, 39),
    b: flat-state.slice(45, 48)
  )
}

#let render-cube(state, w: 3cm, h: auto) = {
  let state = flat-to-cube(state)
  let svg-data = CUBE-TEMPLATE
  
  for (face-name, pieces) in state {
    for (i, color-key) in pieces.enumerate() {
      let placeholder = "#COLOR" + face-name + str(i + 1)
      let actual-hex = colors.at(color-key)
      svg-data = svg-data.replace(placeholder, actual-hex)
    }
  }
  
  image(bytes(svg-data), format: "svg", width: w, height: h) 
}

#let all-possible-arrows = (
    "0_2", "6_8", "0_6", "2_8", // adjacent corners
    "0_8", "2_6",               // diagonal corners
    "1_7", "3_5",               // opposite edges
    "1_5", "5_7", "3_7", "1_3"  // adjacent edges
  )

#let render-pll(state, arrows: (), w: 3cm, h: auto) = {
  let state = flat-to-LL(state)
  let svg-data = LL-TEMPLATE

  for (face-name, pieces) in state {
    if face-name == "d" { continue }
    for (i, color-key) in pieces.enumerate() {
      let placeholder = "#COLOR" + face-name + str(i)
      let hex = colors.at(color-key)
      svg-data = svg-data.replace(placeholder, hex) 
    }
  }

  for arrow-id in all-possible-arrows {
    let placeholder = "VIS_" + arrow-id
    let display-mode = if arrow-id in arrows { "inline" } else { "none" }
    svg-data = svg-data.replace(placeholder, display-mode)
  }

  image(bytes(svg-data), format: "svg", width: w, height: h)
}

#let render-oll(state, w: 3cm, h: auto) = {
  let state = flat-to-LL(state)
  let svg-data = LL-TEMPLATE

  for (face-name, pieces) in state {
    if face-name == "d" { continue }
    for (i, color-key) in pieces.enumerate() {
      let placeholder = "#COLOR" + face-name + str(i)
      let hex = if color-key == "Y" { colors.at(color-key) } else { colors.at("X") }
      svg-data = svg-data.replace(placeholder, hex) 
    }
  }

  for arrow-id in all-possible-arrows {
    svg-data = svg-data.replace("VIS_" + arrow-id, "none")
  }

  image(bytes(svg-data), format: "svg", width: w, height: h)
}