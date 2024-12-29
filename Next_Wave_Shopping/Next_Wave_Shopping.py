from abc import ABC, abstractmethod

# Base class for all products
class Product(ABC):
    def __init__(self, name, price, brand, warranty, available, quantity):
        self.__name = name
        self.__price = price
        self.__brand = brand
        self.__warranty = warranty
        self.__available = available
        self.__quantity = quantity

    def get_name(self):
        return self.__name

    def get_price(self):
        return self.__price

    def get_brand(self):
        return self.__brand

    def get_warranty(self):
        return self.__warranty

    def is_available(self):
        return self.__available

    def get_quantity(self):
        return self.__quantity

    def set_quantity(self, quantity):
        self.__quantity = quantity

    @abstractmethod
    def get_details(self):
        pass


# Class for physical products
class PhysicalProduct(Product):
    def __init__(self, name, price, brand, warranty, available, quantity, weight):
        super().__init__(name, price, brand, warranty, available, quantity)
        self.__weight = weight

    def get_details(self):
        availability_status = "Available" if self.is_available() else "Out of Stock"
        return (f"{self.get_name()} ({self.get_brand()}) - ${self.get_price()} - "
                f"{self.get_quantity()} units - {availability_status} - {self.__weight}kg - "
                f"Warranty: {self.get_warranty()}")


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

    def search_product(self, search_term):
        found_products = [product for product in self.__inventory
                          if search_term.lower() in product.get_name().lower() or
                          search_term.lower() in product.get_brand().lower()]

        if found_products:
            print("Found the following products:")
            for idx, product in enumerate(found_products, 1):
                print(f"{idx}. {product.get_details()}")
        else:
            print("No products found matching your search.")

    def add_to_cart(self, user_email, product_index):
        if product_index < 1 or product_index > len(self.__inventory):
            raise ValueError("Invalid product selection!")
        if user_email not in self.__cart:
            self.__cart[user_email] = []
        product = self.__inventory[product_index - 1]

        if product.get_quantity() > 0:
            self.__cart[user_email].append(product)
            product.set_quantity(product.get_quantity() - 1)
            print(f"Added to cart: {product.get_details()}")
        else:
            print(f"Sorry, {product.get_name()} is out of stock.")

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
            return

        total_price = sum([product.get_price() for product in self.__cart[user_email]])
        print(f"Your total amount is: ${total_price}")
        print("Select your payment method:")
        print("1. Online Payment (bKash, Nagad, Rocket)")
        print("2. Cash on Delivery")
        payment_choice = input("Enter your choice (1/2): ")

        if payment_choice == "1":
            print("You selected Online Payment.")
            print("Choose your online payment method:")
            print("1. bKash")
            print("2. Nagad")
            print("3. Rocket")
            online_payment_method = input("Enter your choice (1/2/3): ")

            if online_payment_method in ["1", "2", "3"]:
                print(f"Payment successful via {['bKash', 'Nagad', 'Rocket'][int(online_payment_method) - 1]}!")
            else:
                print("Invalid payment method! Please try again.")
                return

        elif payment_choice == "2":
            print("You selected Cash on Delivery. Your order will be delivered soon.")
        else:
            print("Invalid choice! Please try again.")
            return

        print("Checkout Complete! Here are your purchased items:")
        for product in self.__cart[user_email]:
            print(product.get_details())
        self.__cart[user_email] = []  # Clear cart after checkout


# Class for user authentication
class Authentication:
    def __init__(self):
        self.__users = {}
        self.__security_questions = {}
        self.__admins = {
            "dibbo1718@gmail.com": "dibbo1718",
            "lamiya1840@gmail.com": "lamiya1840"
        }

    def register(self, email, password, security_question, security_answer):
        if email in self.__users or email in self.__admins:
            raise ValueError("Email is already registered!")
        if len(password) < 6:
            raise ValueError("Password must be at least 6 characters long!")
        self.__users[email] = password
        self.__security_questions[email] = (security_question, security_answer.lower())
        print("Registration successful!")

    def login(self, email, password):
        if email in self.__admins and self.__admins[email] == password:
            return "admin"
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
        PhysicalProduct("Laptop", 1200, "Dell", "2 years", True, 10, 2.5),
        PhysicalProduct("Smartphone", 700, "Apple", "1 year", True, 5, 0.3),
        PhysicalProduct("Headphones", 100, "Sony", "1 year", True, 8, 0.5),
        PhysicalProduct("Smartwatch", 250, "Samsung", "1 year", True, 15, 0.2),
        PhysicalProduct("Bluetooth Speaker", 80, "Bose", "6 months", True, 20, 1.2),
        PhysicalProduct("Gaming Console", 500, "PlayStation", "2 years", True, 3, 3.0),
        PhysicalProduct("Refrigerator", 1500, "LG", "5 years", True, 2, 80),
        PhysicalProduct("Microwave Oven", 300, "Samsung", "1 year", True, 0, 25),  # Out of stock
        PhysicalProduct("Dishwasher", 900, "Bosch", "2 years", False, 0, 60),  # Out of stock
        PhysicalProduct("Air Conditioner", 1200, "Daikin", "3 years", True, 10, 45),
        PhysicalProduct("LED TV", 1000, "LG", "2 years", True, 8, 20),
        PhysicalProduct("Vacuum Cleaner", 200, "Dyson", "2 years", True, 25, 8),
        PhysicalProduct("Leather Jacket", 150, "Zara", "1 year", True, 30, 1.5),
        PhysicalProduct("Sneakers", 120, "Nike", "6 months", True, 50, 1),
        PhysicalProduct("Backpack", 50, "Adidas", "1 year", True, 40, 0.8),
        PhysicalProduct("Wristband", 30, "Fitbit", "6 months", True, 100, 0.1),
        PhysicalProduct("Office Chair", 250, "Herman Miller", "5 years", True, 7, 15),
        PhysicalProduct("Table Lamp", 40, "Ikea", "1 year", True, 60, 3),
        PhysicalProduct("Coffee Maker", 100, "Keurig", "2 years", True, 12, 5),
        PhysicalProduct("Bookshelf", 180, "Ikea", "1 year", True, 3, 25),
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
            login_result = auth.login(email, password)

            if login_result == "admin":
                print("Admin login successful!")
                while True:
                    print("\nAdmin Menu:")
                    print("1. View All Products")
                    print("2. Add a New Product")
                    print("3. Logout")
                    admin_choice = input("Enter your choice: ")

                    if admin_choice == "1":
                        shop.show_inventory()

                    elif admin_choice == "2":
                        name = input("Enter product name: ")
                        price = float(input("Enter product price: "))
                        brand = input("Enter product brand: ")
                        warranty = input("Enter product warranty: ")
                        available = input("Is the product available? (yes/no): ").strip().lower() == 'yes'
                        quantity = int(input("Enter product quantity: "))
                        weight = float(input("Enter product weight (in kg): "))
                        new_product = PhysicalProduct(name, price, brand, warranty, available, quantity, weight)
                        shop.add_product(new_product)
                        print(f"Product '{name}' added successfully!")

                    elif admin_choice == "3":
                        print("Admin logged out.")
                        break

                    else:
                        print("Invalid choice, try again.")

            elif login_result:
                print("Login successful!")
                while True:
                    print("\n1. View Products")
                    print("2. Search Products")
                    print("3. Add to Cart")
                    print("4. View Cart")
                    print("5. Checkout")
                    print("6. Logout")
                    user_choice = input("Enter your choice: ")

                    if user_choice == "1":
                        shop.show_inventory()

                    elif user_choice == "2":
                        search_term = input("Enter product name or brand to search: ")
                        shop.search_product(search_term)

                    elif user_choice == "3":
                        shop.show_inventory()
                        try:
                            prod_choice = int(input("Enter product number to add to cart: "))
                            shop.add_to_cart(email, prod_choice)
                        except ValueError as e:
                            print(e)

                    elif user_choice == "4":
                        shop.view_cart(email)

                    elif user_choice == "5":
                        shop.checkout(email)

                    elif user_choice == "6":
                        print("Logged out successfully.")
                        break

                    else:
                        print("Invalid choice, try again.")

            else:
                print("Login failed! Invalid email or password.")

        elif choice == "3":
            email = input("Enter your registered email ID: ")
            auth.recover_password(email)

        elif choice == "4":
            print("Thank you for visiting Next Wave Shopping!")
            break

        else:
            print("Invalid choice, please try again.")
