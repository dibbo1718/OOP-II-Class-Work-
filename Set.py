# Given sets
a = {1, 3, 5, 8, 3, 7}  
b = {0, False, 1, 5}

# 1) Print sets a and b
print("Set a:", a)
print("Set b:", b)

# 2) Print lengths and their types
print("Length of set a:", len(a))
print("Type of a:", type(a))
print("Length of set b:", len(b))
print("Type of b:", type(b))

# 3) Add a new element (10) to set a
a.add(10)
print("Set a after adding 10:", a)

# 4) Remove 8 from set a
a.discard(8)
print("Set a after removing 8:", a)

# 5) Perform union, intersection, difference, symmetric difference, and subset operation
union_set = a.union(b)
intersection_set = a.intersection(b)
difference_set = a.difference(b)
symmetric_difference_set = a.symmetric_difference(b)
is_subset = a.issubset(b)

print("Union of a and b:", union_set)
print("Intersection of a and b:", intersection_set)
print("Difference of a and b (a - b):", difference_set)
print("Symmetric difference of a and b:", symmetric_difference_set)
print("Is set a a subset of set b?:", is_subset)

# 6) Join a new list [2, 3, 4] with set a
new_list = [2, 3, 4]
a.update(new_list)
print("Set a after joining with [2, 3, 4]:", a)
