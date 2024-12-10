from abc import ABC, abstractmethod

# Base class for all products
class Product(ABC):
    def __init__(self, name, price):
        self.__name = name
        self.__price = price

    def get_name(self):
        return self.__name

    def get_price(self):
        return self.__price

    @abstractmethod
    def get_details(self):
        pass

# Class for physical products
class PhysicalProduct(Product):
    def __init__(self, name, price, weight):
        super().__init__(name, price)
        self.__weight = weight

    def get_details(self):
        return f"{self.get_name()} - ${self.get_price()} - {self.__weight}kg"

# Class for the shopping system
class NextWaveShopping:
    def __init__(self):
        self.__inventory = []
        self.__cart = {}

    def add_product(self, product):
        self.__inventory.append(product)

    def show_inventory(self):
        if not self.__inventory:
            print("No products available!")
        else:
            for idx, product in enumerate(self.__inventory, 1):
                print(f"{idx}. {product.get_details()}")

    def add_to_cart(self, user_email, product_index):
        if product_index < 1 or product_index > len(self.__inventory):
            raise ValueError("Invalid product selection!")
        if user_email not in self.__cart:
            self.__cart[user_email] = []
        product = self.__inventory[product_index - 1]
        self.__cart[user_email].append(product)
        print(f"Added to cart: {product.get_details()}")

    def view_cart(self, user_email):
        if user_email not in self.__cart or not self.__cart[user_email]:
            print("Your cart is empty!")
        else:
            print("Your Cart:")
            for idx, product in enumerate(self.__cart[user_email], 1):
                print(f"{idx}. {product.get_details()}")

    def checkout(self, user_email):
        if user_email not in self.__cart or not self.__cart[user_email]:
            print("Your cart is empty! Nothing to checkout.")
        else:
            print("Checkout Complete! Here are your purchased items:")
            for product in self.__cart[user_email]:
                print(product.get_details())
            self.__cart[user_email] = []

# Class for user authentication
class Authentication:
    def __init__(self):
        self.__users = {}
        self.__security_questions = {}

    def register(self, email, password, security_question, security_answer):
        if email in self.__users:
            raise ValueError("Email is already registered!")
        if len(password) < 6:
            raise ValueError("Password must be at least 6 characters long!")
        self.__users[email] = password
        self.__security_questions[email] = (security_question, security_answer.lower())
        print("Registration successful!")

    def login(self, email, password):
        return email in self.__users and self.__users[email] == password

    def recover_password(self, email):
        if email in self.__security_questions:
            question, answer = self.__security_questions[email]
            print(f"Security Question: {question}")
            response = input("Answer: ").lower()
            if response == answer:
                new_password = input("Enter new password: ")
                self.__users[email] = new_password
                print("Password updated successfully!")
            else:
                print("Incorrect answer to the security question!")
        else:
            print("Email not found!")

# Main application
if __name__ == "__main__":
    auth = Authentication()
    shop = NextWaveShopping()

    # Adding products to the inventory
    products = [
        PhysicalProduct("Laptop", 1200, 2.5),
        PhysicalProduct("Smartphone", 700, 0.3),
        PhysicalProduct("Headphones", 100, 0.5),
        PhysicalProduct("Smartwatch", 250, 0.2),
        PhysicalProduct("Bluetooth Speaker", 80, 1.2),
        PhysicalProduct("Gaming Console", 500, 3.0),
        PhysicalProduct("Refrigerator", 1500, 80),
        PhysicalProduct("Microwave Oven", 300, 25),
        PhysicalProduct("Dishwasher", 900, 60),
        PhysicalProduct("Air Conditioner", 1200, 45),
        PhysicalProduct("LED TV", 1000, 20),
        PhysicalProduct("Vacuum Cleaner", 200, 8),
        PhysicalProduct("Leather Jacket", 150, 1.5),
        PhysicalProduct("Sneakers", 120, 1),
        PhysicalProduct("Backpack", 50, 0.8),
        PhysicalProduct("Wristband", 30, 0.1),
        PhysicalProduct("Office Chair", 250, 15),
        PhysicalProduct("Table Lamp", 40, 3),
        PhysicalProduct("Coffee Maker", 100, 5),
        PhysicalProduct("Bookshelf", 180, 25),
    ]
    for product in products:
        shop.add_product(product)

    print("Welcome to Next Wave Shopping!")

    while True:
        print("\n1. Register")
        print("2. Login")
        print("3. Forget Password")
        print("4. Exit")
        choice = input("Enter your choice: ")

        if choice == "1":
            email = input("Enter email ID: ")
            password = input("Enter password: ")
            question = input("Enter a security question (e.g., What is your favorite color?): ")
            answer = input("Enter the answer: ")
            try:
                auth.register(email, password, question, answer)
            except ValueError as e:
                print(e)

        elif choice == "2":
            email = input("Enter email ID: ")
            password = input("Enter password: ")
            if auth.login(email, password):
                print("Login successful!")
                while True:
                    print("\n1. View Products")
                    print("2. Add to Cart")
                    print("3. View Cart")
                    print("4. Checkout")
                    print("5. Logout")
                    user_choice = input("Enter your choice: ")

                    if user_choice == "1":
                        shop.show_inventory()

                    elif user_choice == "2":
                        shop.show_inventory()
                        try:
                            prod_choice = int(input("Enter product number to add to cart: "))
                            shop.add_to_cart(email, prod_choice)
                        except ValueError:
                            print("Invalid input. Please enter a valid product number.")

                    elif user_choice == "3":
                        shop.view_cart(email)

                    elif user_choice == "4":
                        shop.checkout(email)

                    elif user_choice == "5":
                        print("Logged out!")
                        break

                    else:
                        print("Invalid choice, try again.")

            else:
                print("Invalid email or password. Please try again.")

        elif choice == "3":
            email = input("Enter your registered email ID: ")
            auth.recover_password(email)

        elif choice == "4":
            print("Goodbye!")
            break

        else:
            print("Invalid choice, please try again.")
