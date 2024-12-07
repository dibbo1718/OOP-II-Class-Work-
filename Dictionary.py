# Given dictionary
employee = {
    "name": "A",
    "age": 40,
    "type": {"developer": ["ios", "android"]},
    "permanent": True,
    "salary": 30000,
    100: (1, 2, 3),
    4.5: {5, 6, "Tone", 7, 1}
}

# 1) Print length and type of employee
print("Length of the dictionary:", len(employee))
print("Type of the dictionary:", type(employee))

# 2) Access the key `type` -> `developer`
developer_types = employee["type"]["developer"]
print("Developer types:", developer_types)

# 3) Change the value of `permanent` to False
employee["permanent"] = False
print("Updated 'permanent' value:", employee["permanent"])

# 4) Add a new key `gender` with value `"male"`
employee["gender"] = "male"
print("Updated dictionary after adding 'gender':", employee)

# 5) Remove the key `age` from the dictionary
employee.pop("age", None)  # Using `pop` to remove safely, avoiding KeyError
print("Updated dictionary after removing 'age':", employee)

# 6) Use keys(), values(), items()
print("Keys in the dictionary:", list(employee.keys()))
print("Values in the dictionary:", list(employee.values()))
print("Items in the dictionary:", list(employee.items()))

# 7) Iterate the dictionary using a loop
print("Iterating through the dictionary:")
for key, value in employee.items():
    print(f"{key}: {value}")
