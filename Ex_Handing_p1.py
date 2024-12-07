class InvalidAgeException(Exception):
    pass

def validate_age(age):
    try:
        if age < 18:
            raise InvalidAgeException("Age is too low!")
        elif age > 60:
            raise InvalidAgeException("Age is too high!")
        else:
            print("Age is valid.")
    except InvalidAgeException as e:
        print(f"InvalidAgeException: {e}")

validate_age(15)
validate_age(25)
validate_age(65)
