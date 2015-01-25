local Stick = {
  Up = {lefty=-1, leftx=0, name="u"},
  Down = {lefty=1, leftx=0, name="d"},
  Right = {lefty=0, leftx=1, name="r"},
  Left = {lefty=0, leftx=-1, name="l"},
  None = {lefty=0, leftx=0, name="None"},
}

local Button = {
  A = 'a',
  B = 'b',
  X = 'x',
  Y = 'y',
  None = '.'
}

return {Stick = Stick, Button = Button}
