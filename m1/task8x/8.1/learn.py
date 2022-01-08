
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


def main():
    valid_param = validate_param()
    a = valid_param[0]
    b = valid_param[1]
    c = valid_param[2]
    print((a), (b), (c))




main()