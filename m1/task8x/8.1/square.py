import math

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

def discriminant(a, b, c):
    discr = b ** 2 - 4 * a * c
    return discr



def roots(discr, a, b, c):
    if discr > 0:
        x1 = (-b + math.sqrt(discr)) / (2 * a)
        x2 = (-b - math.sqrt(discr)) / (2 * a)
        print("x1 = %.2f \nx2 = %.2f" % (x1, x2))
        return discr, x1, x2
    elif discr == 0:
        x = -b / (2 * a)
        print("x = %.2f" % x)
        return discr, x
    else:
        print("Without decision")

def square_print(a, b, c, root):
    print("================\nPrint results:\nEntered parameters:")
    print("a:", str(a), "\nb:", str(b), "\nc:", str(c))
    x = root[0]
    x1 = root[1]
    x2 = root[2]
    print(root)
    print(x, x1, x2)


def solv_square(a, b, c):
    discr = discriminant(a, b, c)
    root = roots (discr, a, b, c)
    square_print(a, b, c, root)



def main():
    valid_param = validate_param()
    a = valid_param[0]
    b = valid_param[1]
    c = valid_param[2]
    solv_square(a, b, c)




main()


