class Person:
    def __init__(self, first_name, last_name):
        self.first_name = first_name
        self.last_name = last_name

    def display(self):
        print(f"Name: {self.first_name} {self.last_name}")

class Student(Person):
    def __init__(self, first_name, last_name, graduation_year):
        super().__init__(first_name, last_name)
        self.graduation_year = graduation_year

    def display(self):
        super().display()
        print(f"Graduation Year: {self.graduation_year}")

class Alumni(Student):
    def __init__(self, first_name, last_name, graduation_year, passing_year):
        super().__init__(first_name, last_name, graduation_year)
        self.passing_year = passing_year

    def display(self):
        super().display()
        print(f"Passing Year: {self.passing_year}")


class CurrentStudent(Student):
    def __init__(self, first_name, last_name, graduation_year, current_semester):
        super().__init__(first_name, last_name, graduation_year)
        self.current_semester = current_semester

    def display(self):
        super().display()
        print(f"Current Semester: {self.current_semester}")


class Employee(Person):
    def __init__(self, first_name, last_name, emp_id):
        super().__init__(first_name, last_name)
        self.emp_id = emp_id

    def display(self):
        super().display()
        print(f"Employee ID: {self.emp_id}")


class Teacher(Employee):
    def __init__(self, first_name, last_name, emp_id, joining_year):
        super().__init__(first_name, last_name, emp_id)
        self.joining_year = joining_year

    def display(self):
        super().display()
        print(f"Joining Year: {self.joining_year}")

class Admin(Employee):
    def __init__(self, first_name, last_name, emp_id, joining_year):
        super().__init__(first_name, last_name, emp_id)
        self.joining_year = joining_year

    def display(self):
        super().display()
        print(f"Joining Year: {self.joining_year}")

person = Person("Jonaki", "Diya")
student = Student("Alicia", "Smith", 2024)
alumni = Alumni("Bob", "Marley", 2020, 2022)
current_student = CurrentStudent("Eva", "Madam", 2024, "4th Semester")
employee = Employee("Charlie", "Caplin", "E123")
teacher = Teacher("Daisy", "Adams", "T456", 2018)
admin = Admin("Frank", "Clark", "A789", 2015)

# Display details
print("Person:")
person.display()

print("\nStudent:")
student.display()

print("\nAlumni:")
alumni.display()

print("\nCurrent Student:")
current_student.display()

print("\nEmployee:")
employee.display()

print("\nTeacher:")
teacher.display()

print("\nAdmin:")
admin.display()
