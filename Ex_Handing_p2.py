class SalaryNotInRange(Exception):
    pass

def validate_salary(salary):
    try:
        if salary < 5000 or salary > 50000:
            raise SalaryNotInRange("Salary is out of valid range (5000-50000).")
        else:
            print("Salary is valid.")
    except SalaryNotInRange as e:
        print(f"SalaryNotInRange: {e}")

validate_salary(4000)
validate_salary(25000)
validate_salary(60000)
