local width, height = g.getHeight(), g.getHeight()

return {
  width = width,
  height = height,
  obstructions = {
    {
      geometry = {width / 4, height / 4, 50, 100}
    },
    {
      geometry = {width / 4, height / 4 * 3, 50, 100}
    },
    {
      geometry = {width / 4 * 3, height / 4 * 3, 50, 100}
    },
    {
      geometry = {width / 4 * 3, height / 4, 50, 100}
    },
  },
  traps = {
    {
      geometry = {width / 2, height / 4, 50, 50}
    },
    {
      geometry = {width / 2, height / 4 * 3, 50, 50}
    },
  },
  bounds = {
    {
      geometry = {0, 0, width, 0}
    },
    {
      geometry = {0, 0, 0, height}
    },
    {
      geometry = {width, 0, width, height}
    },
    {
      geometry = {0, height, width, height}
    },
  }
}