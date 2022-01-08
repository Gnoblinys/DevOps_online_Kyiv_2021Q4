
def validate_param():
    count = 0
    while count <= 2:
        try:
            a = int(input("Enter a:"))
            b = int(input("Enter b:"))
            c = int(input("Enter c:"))
        except ValueError:
            print("Enter only numbers!")
            count += 1
            continue
        else:
            return a, b, c


validate_param()

print(a + b + c)