### question 1

# Ruby reuses same ID for same objects
# Object modified inside block stays modified outside it
# Object initialized inside block loses it meaning outside it

### question 2

# Variables inside the method are not the same as the ones outside
# but they do have the same ID as they point to the same object

### question 3

# the diference is in the way ruby executes the operations,
# not in the way it treates arrays and strings.
# in this case,  the caller's array variable and the method's array 
# variable are still pointing at the same object

### question 4

# ruby may or may not create a new object inside the method
# it depends if operations inside the method mutates or not the caller

### question 5

def color_valid(color)
  color == "blue" || color == "green"
end
