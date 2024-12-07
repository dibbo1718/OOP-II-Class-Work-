# Data
scores = [65, 75, 80, 90, 85]

# a) Convert data into a text file
with open("scores.txt", "w") as file:
    file.write("\n".join(map(str, scores)))

# b) Create a dict with student names and scores
students = ["Alice", "Bob", "Charlie", "Diana", "Eve"]
score_dict = dict(zip(students, scores))
print("Student Scores:", score_dict)

# c) Find the index, min, max, sum, average
min_score = min(scores)
max_score = max(scores)
total_sum = sum(scores)
average_score = total_sum / len(scores)

print("Min Score:", min_score)
print("Max Score:", max_score)
print("Sum:", total_sum)
print("Average:", average_score)

# d) Slicing the list
print("First 3 scores:", scores[:3])
print("Last 2 scores:", scores[-2:])
