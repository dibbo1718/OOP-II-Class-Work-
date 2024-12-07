# Step 1: Declare variables and concatenate them
a = "hello"
b = " b2b2b2 "
c = " 3g3g. "
d = a + b + c
print("Concatenated string d:", d)

# Step 2: Find the length of d and print it
length_of_d = len(d)
print("Length of d:", length_of_d)

# Step 3: Check if "a2" is present in d
is_a2_present = "a2" in d
print('"a2" is present in d:', is_a2_present)

# Step 4: Perform the specified operations on d
print("Uppercase:", d.upper())
print("Lowercase:", d.lower())
print("Titlecase:", d.title())
print("Stripped:", d.strip())
print("Is digit:", d.isdigit())
print("Find '3g':", d.find("3g"))
print("Capitalized:", d.capitalize())
print("Is alphanumeric:", d.isalnum())
print("Count of 'b2':", d.count("b2"))
print("Split:", d.split())
print("Swapcase:", d.swapcase())
print("Left stripped:", d.lstrip())
print("Replace 'hello' with 'python':", d.replace("hello", "python"))
