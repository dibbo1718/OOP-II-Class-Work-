#Define a recursive function that returns the factorial of a number:
def factorial(n):
    if n == 0 or n == 1:
        return 1
    else:
        return n * factorial(n - 1)

n = int(input("Enter a number to find its factorial: "))
result = factorial(n)
print(f"The factorial of {n} is: {result}")
