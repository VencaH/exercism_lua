local rules = {}

-- returns if Pac-Man was able to eat the ghost or not
function rules.eat_ghost(power_pellet_active, touching_ghost)
  -- eat_ghost body
  -- and write a story about it
  -- more test comments
  return power_pellet_active and touching_ghost
end

-- returns if Pac-Man ate a power pellet or a dot
function rules.score(touching_power_pellet, touching_dot)
  -- score body
  return touching_power_pellet or touching_dot
end

-- returns if Pac-Man lost by touching a ghost without a power pellet
function rules.lose(power_pellet_active, touching_ghost)
  -- lose body
  return not power_pellet_active and touching_ghost
end

-- returns if Pac-Man won by eating all dots and has not touched a ghost without a power pellet
function rules.win(has_eaten_all_dots, power_pellet_active, touching_ghost)
  -- win body
  return has_eaten_all_dots and not rules.lose(power_pellet_active, touching_ghost)
end

return rules
