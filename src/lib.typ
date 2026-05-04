#import "cube.typ": apply-move, SOLVED-CUBE, FTL-CUBE
#import "render.typ": render-cube, render-pll, render-oll

#let _inv(algo-string) = {
  let algo-string = algo-string.replace("(", "").replace(")", "")
  algo-string.split(" ")
    .filter(m => m != "")
    .rev()
    .map(m => {
      if m.ends-with("'") or m.ends-with("3") or m.ends-with("p") { m.slice(0, -1) } // R' -> R
      else if m.ends-with("2") { m }
      else { m + "'" }
    })
    .join(" ")
}

#let invert(algo-string) = {
  raw(_inv(algo-string))
}

#let _process-state(state, algo-string, raw: false) = {
  if algo-string.trim() == "" {
    return state
  }
  let algo-string = algo-string.replace("(", "").replace(")", "")
  let current_state = state
  
  let final-algo = if raw { algo-string } else { _inv(algo-string) }
  let moves = final-algo.split(" ").filter(m => m != "")

  for move in moves {
    current_state = apply-move(current_state, move)
  }
  return current_state
}

#let _labeled-layout(img, algo, show-algo, w) = {
  if not show-algo {
    return img
  }
  show raw: set text(size: 0.9em)
  block(width: w, {
    set align(center)
    stack(
      spacing: 0.5em,
      img,
      raw(algo)
    )
  })
}

#let scramble(algo, raw: false) = {
  render-cube(_process-state(SOLVED-CUBE, algo, raw: raw))
}

#let f2l(algo, raw: false, show-algo: false, w: 1in) = {
  let state = _process-state(FTL-CUBE, algo, raw: raw)
  let img = render-cube(state, w: w)
  _labeled-layout(img, algo, show-algo, w)
}

#let oll(algo, raw: false, show-algo: false, w: 1in) = {
  let setup-algo = if raw { "x2 y2 " + algo } else { algo + " x2 y2" } 
  let state = _process-state(SOLVED-CUBE, setup-algo, raw: raw)
  let img = render-oll(state, w: w)
  _labeled-layout(img, algo, show-algo, w)
}

#let pll(algo, arrows: (), raw: false, show-algo: false, w: 1in) = {
  let setup-algo = if raw { "x2 y2 " + algo } else { algo + " x2 y2" }
  let state = _process-state(SOLVED-CUBE, setup-algo, raw: raw)
  let img = render-pll(state, arrows: arrows, w: w)
  _labeled-layout(img, algo, show-algo, w)
}