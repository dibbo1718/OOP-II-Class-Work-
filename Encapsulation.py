class Vehicle:
    def __init__(self, color):
        self.color = color

    def vehicle_info(self):
        print(f"Vehicle Color: {self.color}")

class Taxi(Vehicle):
    def __init__(self, color, model, capacity, variant):
        super().__init__(color)
        self.__model = model
        self.__capacity = capacity
        self.__variant = variant

    # Getter methods
    def get_model(self):
        return self.__model

    def get_capacity(self):
        return self.__capacity

    def get_variant(self):
        return self.__variant

    def set_model(self, model):
        self.__model = model

    def set_capacity(self, capacity):
        self.__capacity = capacity

    def set_variant(self, variant):
        self.__variant = variant

    def vehicle_info(self):
        super().vehicle_info()  # Call the base class method
        print(f"Model: {self.__model}, Capacity: {self.__capacity}, Variant: {self.__variant}")

t1 = Taxi("Yellow", "Sedan", 4, "Diesel")
t2 = Taxi("White", "SUV", 7, "Petrol")

print("Details of t1:")
t1.vehicle_info()

print("\nDetails of t2:")
t2.vehicle_info()

t1.set_model("Hatchback")
t1.set_capacity(5)
t1.set_variant("Electric")

print("\nUpdated details of t1:")
t1.vehicle_info()
