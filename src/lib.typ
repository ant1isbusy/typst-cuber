#import "cube.typ": apply-move, SOLVED-CUBE, FTL-CUBE
#import "render.typ": render-cube, render-PLL, render-OLL

#let _process-state(state, algo-string) = {
  let current_state = state
  let moves = algo-string.split(" ").filter(m => m != "")

  for move in moves {
    current_state = apply-move(current_state, move)
  }
  return current_state
}

#let scramble(algo) = {
  render-cube(_process-state(SOLVED-CUBE, algo))
}

#let f2l(algo) = {
  render-cube(_process-state(FTL-CUBE, algo))
}

#let oll(algo) = {
  // flip cube for yellow on top
  let state = _process-state(SOLVED-CUBE, "x2 y2 " + algo) 
  render-OLL(state)
}

#let pll(algo, arrows: ()) = {
  let state = _process-state(SOLVED-CUBE, "x2 y2 " + algo)
  render-PLL(state, arrows: arrows)
}
