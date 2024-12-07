# Initial tuple
a = (1, 3, 5, 7, 4)

# a) Find the sum of all odd numbers in the tuple
sum_of_odds = sum(num for num in a if num % 2 != 0)
print("Sum of all odd numbers:", sum_of_odds)

# b) Find the index of the element 7 in the tuple
index_of_7 = a.index(7)
print("Index of 7 in the tuple:", index_of_7)

# c) Count the number of odd and even numbers separately
odd_count = sum(1 for num in a if num % 2 != 0)
even_count = sum(1 for num in a if num % 2 == 0)
print("Number of odd numbers:", odd_count)
print("Number of even numbers:", even_count)

# d) Extend the tuple with (2, 4, 6)
extended_tuple = a + (2, 4, 6)
print("Extended tuple:", extended_tuple)

# e) Add a new item (400) at index 2
modified_tuple = a[:2] + (400,) + a[2:]
print("Tuple after adding 400 at index 2:", modified_tuple)

# f) Remove the last element
tuple_without_last = a[:-1]
print("Tuple after removing the last element:", tuple_without_last)

# g) Perform slicing [-4:-1]
sliced_tuple = a[-4:-1]
print("Sliced tuple [-4:-1]:", sliced_tuple)

# h) Print the tuple using a loop and use 'continue' if the value is 5
print("Tuple elements (skipping 5):")
for num in a:
    if num == 5:
        continue
    print(num)
