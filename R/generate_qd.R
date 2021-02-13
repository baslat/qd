#' Generate a QD workout
#' 
#' Based on the workout type this funciton randomises the parameters for a Quick
#' and the Dead workout.
#'
#' @param type (character) one of "snatch" or "swing"
#'
#' @return
#' @export
#'
#' @examples
generate_qd <- function(type) {
  
  
  (d1 <- sample(1:6, 1))
  (d2 <- sample(1:6, 1))
  (d3 <- sample(1:6, 1))
  (d4 <- sample(1:6, 1))
  
  
  #
  # d1=2
  # d2=3
  # d1 determines total reps, ie session volume ----
  
  # if 3 or 5, start with non dominant side
  
  volume <- purrr::when(
    d1,
    d1 == 1 ~ list(reps = 40, rounds = 2),
    d1 %in% c(2, 3) ~ list(reps = 60, rounds = 3),
    d1 %in% c(4, 5) ~ list(reps = 80, rounds = 4),
    d1 == 6 ~ list(reps = 100, rounds = 5)
  )
  
  #d2 determines reps and sets within each rounds ----
  
  
  small <- tibble::tibble(sets = 4, reps = 5, rest = 30)
  big <- tibble::tibble(sets = 2, reps = 10, rest = 60)
  mids <- bind_rows(small, small, big, big, small, small)
  
  sets_and_reps <- purrr::when(
    d2,
    d2 %in% c(1, 2) ~ head(small, volume$rounds), 
    d2 %in% c(3, 4) ~ head(mids, volume$rounds),
    d2 %in% c(5, 6) ~ head(big, volume$rounds)
  )
  
  
  # Always start with left
  # use only one arm in each round
  # each round is always 20 reps
  
  # d3 (for non snatches) determines swing type ----
  swing <- purrr::when(
    d3,
    d3 %in% c(1,2,3) ~ "two-arm",
    d3 %in% c(4,5,6) ~ "one-arm"
  )
  
  # d4 (for non snatches) determines pushup type ----
  pushup <- purrr::when(
    d4,
    d4 %in% c(1,2,3) ~ "palm",
    d4 %in% c(4,5,6) ~ "fist"
  )
  
  
  # workout ----
  advice <- if (type == "snatch") {
    glue("Always start with your left side. Use only one arm in each round, and each round is always 20 reps.")
  }
  
  vr <- glue("You will do a total of {volume$reps} reps, spread over {volume$rounds} rounds.")
  details <- glue("Round {seq_along(1:volume$rounds)}: {sets_and_reps$sets} sets of {sets_and_reps$reps} reps, one set every {sets_and_reps$rest} seconds")
  types <- if (type != "snatch") {
    glue("You will be doing {swing} swings and {pushup} push-ups.")
  }
  
  workout <- c(advice, vr, details, types)
  return(workout)
}
