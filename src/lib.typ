#import "cube.typ": apply-move, SOLVED-CUBE, FTL-CUBE
#import "render.typ": render-cube, render-pll, render-oll

#let _invert-algo(algo-string) = {
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

#let _process-state(state, algo-string, raw: false) = {
  if algo-string.trim() == "" {
    return state
  }

  let current_state = state
  
  let final-algo = if raw { algo-string } else { _invert-algo(algo-string) }
  let moves = final-algo.split(" ").filter(m => m != "")

  for move in moves {
    current_state = apply-move(current_state, move)
  }
  return current_state
}

#let scramble(algo, raw: false) = {
  render-cube(_process-state(SOLVED-CUBE, algo, raw: raw))
}

#let f2l(algo, raw: false) = {
  render-cube(_process-state(FTL-CUBE, algo, raw: raw))
}

#let oll(algo, raw: false) = {
  let algo = if raw { "x2 y2 " + algo } else { algo + " x2 y2" } // YELLOW on top for LL
  let state = _process-state(SOLVED-CUBE, algo, raw: raw)
  render-oll(state)
}

#let pll(algo, arrows: (), raw: false) = {
  let algo = if raw { "x2 y2 " + algo } else { algo + " x2 y2" }
  let state = _process-state(SOLVED-CUBE, algo, raw: raw)
  render-pll(state, arrows: arrows)
}