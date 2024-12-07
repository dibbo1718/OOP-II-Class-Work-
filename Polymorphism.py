class Department:
    def __init__(self, name):
        self.name = name

    def display_name(self):
        print(f"Department Name: {self.name}")

class Teacher(Department):
    def __init__(self, department_name, subject):
        super().__init__(department_name)
        self.subject = subject

    def schedule_class(self):
        print(f"Scheduling a class in {self.subject}.")

    def grade_students(self):
        print(f"Grading students in {self.subject}.")

    def display_name(self):
        print(f"Teacher Department: {self.name}, Subject: {self.subject}")

class Author(Department):
    def __init__(self, department_name, genre):
        super().__init__(department_name)
        self.genre = genre

    def write_article(self):
        print(f"Writing an article in {self.genre} genre.")

    def publish_blog(self):
        print(f"Publishing a blog in {self.genre} genre.")

    def display_name(self):
        print(f"Author Department: {self.name}, Genre: {self.genre}")

class TeacherAuthor(Teacher, Author):
    def __init__(self, department_name, subject, genre):
        Teacher.__init__(self, department_name, subject)
        Author.__init__(self, department_name, genre)

    def display_name(self):
        print("TeacherAuthor has multiple roles:")
        Teacher.display_name(self)
        Author.display_name(self)

print("1. Runtime Polymorphism Example:")
objects = [
    Department("General"),
    Teacher("Science", "Mathematics"),
    Author("Literature", "Fiction"),
    TeacherAuthor("Interdisciplinary", "Physics", "Sci-Fi"),
]
for obj in objects:
    obj.display_name()
    print()

print("2. Create an instance of TeacherAuthor and access methods:")
teacher_author = TeacherAuthor("Interdisciplinary", "Physics", "Sci-Fi")
teacher_author.schedule_class()
teacher_author.grade_students()
teacher_author.write_article()
teacher_author.publish_blog()
teacher_author.display_name()
print()

print("3. Handling Duplicate Methods:")
# If both Teacher and Author have a method named `profile`
class Teacher:
    def profile(self):
        return "Teacher Profile"

class Author:
    def profile(self):
        return "Author Profile"

class TeacherAuthor(Teacher, Author):
    pass

teacher_author = TeacherAuthor()
print(f"Calling profile(): {teacher_author.profile()}")
