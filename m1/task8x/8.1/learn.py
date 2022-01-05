stud=[('ivan',181)]
stud.append(('petya',573))
stud.append(('Vasia',598))

print(all(rating > 1700 for _, rating in stud))

00:21:17