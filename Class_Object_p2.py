class Shape:
    def __init__(self, name):
        self.name = name
    def get_name(self):
        return self.name
    def display_info(self):
        print(f"Shape Name: {self.name}")

class Rectangle(Shape):
    def __init__(self, name, length, width):
        super().__init__(name)  # Use super() to call the base class constructor
        self.length = length
        self.width = width
    def area(self):
        return self.length * self.width
    def perimeter(self):
        return 2 * (self.length + self.width)

shape = Shape("General Shape")
shape.display_info()

rectangle = Rectangle("Rectangle", 10, 5)
rectangle.display_info()
print(f"Area: {rectangle.area()}")
print(f"Perimeter: {rectangle.perimeter()}")
