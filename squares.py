# Display the table of squares
#
# rjust() function helps to put some space between numbers
# rjust(2) creates 1 space before first number (check 1st column)
# rjust(3) creates 3 spaces between first and second numbers (basically it creates 2nd column)
# With rjust() you can place not only spaces but any symbol
# For example rjust(2, '*') will place * symbols before first number

for x in range(1, 10):
	print(repr(x).rjust(2), repr(x*x).rjust(3))
