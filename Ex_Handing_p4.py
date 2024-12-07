class InsufficientFunds(Exception):
    pass

def withdraw(balance, amount):
    try:
        if amount > balance:
            raise InsufficientFunds("Withdrawal amount exceeds balance.")
        else:
            print(f"Withdrawal of {amount} successful. Remaining balance: {balance - amount}")
    except InsufficientFunds as e:
        print(f"InsufficientFunds: {e}")

withdraw(1000, 1500) 
withdraw(1000, 500)
