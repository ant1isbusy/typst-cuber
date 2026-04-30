
#let colors = (
  W: "#FFFFFF",
  Y: "#FFD500",
  G: "#009E60",
  B: "#0051BA",
  R: "#C41E3A",
  O: "#FF5800",
  X: "#333333"
)

// only need the 3 visible faces for rendering
#let flat_to_render(flat_state) = {
  (
    u: flat_state.slice(0, 9),
    r: flat_state.slice(9, 18),
    f: flat_state.slice(18, 27),
  )
}

#let draw_svg_cube(state, w: 3cm, h: auto) = {
  let state = flat_to_render(state)
  let svg-data = read("cube.svg")
  
  for (face-name, pieces) in state {
    for (i, color-key) in pieces.enumerate() {
      let placeholder = "#COLOR" + face-name + str(i + 1)
      let actual-hex = colors.at(color-key)
      svg-data = svg-data.replace(placeholder, actual-hex)
    }
  }
  
  image(bytes(svg-data), format: "svg", width: w, height: h) 
}
