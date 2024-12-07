def safe_division(a, b):
    try:
        result = a / b
        print(f"Result: {result}")
    except ZeroDivisionError:
        print("Error: Cannot divide by zero.")
    except ValueError:
        print("Error: Invalid input type.")
    except TypeError:
        print("Error: Unsupported data type.")
    except Exception as e:
        print(f"Error: {e}")
    finally:
        print("Execution finished.")

safe_division(10, 2)
safe_division(10, 0)
safe_division(10, "5")
