# This script is for functions training
#
# Define add function
def add(x, y):
# Print arguments
	print("X is {} and Y is {}".format(x, y))
# Make calculations and return them
	return x + y

# Calling function add inside print statement to display the results
print(add(5, 6))

# Another function call
# repr() is used to transform numeric result of add function to string so print() can print it
result = "The result is " + repr(add(6, 7))
print(result)
