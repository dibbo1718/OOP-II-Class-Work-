from abc import ABC, abstractmethod

class Vehicle:
    def start(self):
        print("Vehicle is starting.")

    def stop(self):
        print("Vehicle is stopping.")

class Car(Vehicle):
    def start(self):
        print("Car is starting.")

    def stop(self):
        print("Car is stopping.")

class Motorcycle(Vehicle):
    def start(self):
        print("Motorcycle is starting.")

    def stop(self):
        print("Motorcycle is stopping.")

class AbstractVehicle(ABC):
    def __init__(self, brand):
        self.brand = brand

    @abstractmethod
    def startEngine(self):
        pass

    def description(self):
        return f"This is a {self.brand} vehicle."

class Car(AbstractVehicle):
    def __init__(self, brand, model):
        super().__init__(brand)
        self.model = model

    def startEngine(self):
        print(f"The {self.model} car's engine is starting.")

print("Task 01:")
car = Car()
car.start()
car.stop()

motorcycle = Motorcycle()
motorcycle.start()
motorcycle.stop()

print("\nTask 02:")
my_car = Car("Toyota", "Camry")
print(my_car.description())
my_car.startEngine()

try:
    vehicle = AbstractVehicle("Generic")
except TypeError as e:
    print(f"Error: {e}")
