class Product:
    def __init__(self, name, price):
        self.name = name
        self.price = price

    def display_detail(self):
        print(f"Product Name: {self.name}, Price: {self.price}")

class ElectronicProduct(Product):
    def __init__(self, name, price, warranty):
        super().__init__(name, price)  # Use super() to call the base class constructor
        self.warranty = warranty

    def display_detail(self):
        super().display_detail()  # Call the base class display_detail method
        print(f"Warranty: {self.warranty}")

product = Product("Table", 1500)
product.display_detail()

electronic = ElectronicProduct("Laptop", 50000, "2 years")
electronic.display_detail()
