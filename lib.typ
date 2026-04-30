#import "cube.typ": *
#import "render.typ": *

#let scramble(algo-string) = {
  let current_state = SOLVED_CUBE
  
  let moves = algo-string.split(" ").filter(m => m != "")

  for move in moves {
    current_state = apply_move(current_state, move)
  }

  draw_svg_cube(current_state)
}

#let f2l(algo-string) = {
  let current_state = F2L_CUBE
  let moves = algo-string.split(" ").filter(m => m != "")

  for move in moves {
    current_state = apply_move(current_state, move)
  }
  draw_svg_cube(current_state)
}