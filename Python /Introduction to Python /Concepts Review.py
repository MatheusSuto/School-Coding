# Declaring the first variable

a = 31
print(a) #31

a+2 #Doesn't work

print(a) #31

a = a+2
print(a) #33

d=2*a #2 times a
print(d) #66

a = d/a #d divided by a
print(a) #2

b = 28/a #28 divided by a
print(b) #14

c = b*25 #b time 25
print(c+3) #353

f = c+3 #c plus 3
print(f) #353 (c+3, same as the code above)
 
g = f #g receives f
print(g**2) #123609 (g to hte power of 2)
print(g**3) #43986977 (g to the power of 3)

h, g = g, f #h receives g and g receives f
print(h) #353
print(g) #353
