import math

def validate_param():
    count = 0
    while count <= 2:
        try:
            a = float(input("Enter a:"))
            b = float(input("Enter b:"))
            c = float(input("Enter c:"))
        except ValueError:
            print("Enter only numbers with \".\" ")
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
        return discr, x1, x2
    elif discr == 0:
        x = -b / (2 * a)
        return discr, x

def square_print(a, b, c, root):
    try:
        i = root[0]
    except TypeError:
        print("TypeError")
   




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


