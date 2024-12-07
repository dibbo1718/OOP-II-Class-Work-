# Task 01: List Operations
a = [1, 3, 5, 7, 4]

# 1. Access a[-2], a[2] and find length and type of 'a'
print("a[-2]:", a[-2])  # Access second last element
print("a[2]:", a[2])    # Access element at index 2
print("Length of a:", len(a))  # Length of list
print("Type of a:", type(a))   # Type of a

# 2. Change a[3] to 50 and slice a[2:4]
a[3] = 50
print("Modified a:", a)  # Updated list
print("a[2:4]:", a[2:4])  # Slicing

# 3. Add 100 to the last index and 200 at index 2
a.append(100)   # Add 100 at the end
a.insert(2, 200)  # Insert 200 at index 2
print("After additions:", a)

# 4. Remove last element and element at index 1
a.pop()  # Remove last element
a.pop(1)  # Remove element at index 1
print("After removals:", a)

# 5. Join a new list [2, 4, 6] with 'a'
new_list = [2, 4, 6]
a.extend(new_list)  # Extend 'a' with new_list
print("After joining:", a)

# 6. Copy all values in a new list 'b'
b = a.copy()
print("List b (copy of a):", b)

# 7. Sort the elements of 'b'
b.sort()
print("Sorted b:", b)

# 8. Print all elements using a loop and break if 5 is found
print("Looping through b:")
for element in b:
    print(element)
    if element == 5:
        print("Found 5, breaking the loop.")
        break

# 9. Find the largest number in 'a'
largest = max(a)
print("Largest number in a:", largest)
