#Use a lambda function to perform the above formula:
calculate_square_lambda = lambda a, b: a**2 + b**2 + 2 * a * b

a = int(input("Enter the value of a: "))
b = int(input("Enter the value of b: "))
result = calculate_square_lambda(a, b)
print(f"The result of (a + b)^2 using lambda is: {result}")
