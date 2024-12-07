'''Create a function that takes two inputs and performs the formula
(𝑎+𝑏)^2=𝑎^2+𝑏^2+2𝑎𝑏:'''
def calculate_square(a, b):
    return a**2 + b**2 + 2 * a * b
    
a = int(input("Enter the value of a: "))
b = int(input("Enter the value of b: "))
result = calculate_square(a, b)
print(f"The result of (a + b)^2 is: {result}")
