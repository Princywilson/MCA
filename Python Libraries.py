
# List Creation:
print("-----------------------------------------------------")
print("\tIndex Based Storage & Retrieval-List")
print("-----------------------------------------------------")
# empty list creation
ls=[]
# insert the elements to list using insert() with index position
ls.insert(3,19)
ls.insert(0,"Chennai")
ls.insert(2,True)
ls.insert(4,97.45)
# count the list
c=len(ls)
# show the contents of list
for i in range(0,c):
  print(i,"-> ",ls[i])
# show items in a line
print("-----------------------------------------------------")
print(ls)

# Set Creation:
print("-----------------------------------------")
print("\tPython Set Updation")
print("-----------------------------------------")
# python set creation
s={10,23,33,57,75}
print("Before Updation, Set Contents")
print(s)
print("-----------------------------------------")
# list creation
ls=[12,44,55]
# add list object to the argument of update()
s.update(ls)
print("After Updation, Set Contents")
print(s)
print("-----------------------------------------")

# Dictionary Creation:
print("------------------------------------------------")
print("\tPython Retrieval")
print("------------------------------------------------")
# dictionary creation
db={7:"salem",1:"chennai",3:"trichy",4:"mumbai"}
# print contents of dictionary using for loop
print("Contents of Python Dictionary:")
for i,j in db.items():
 print(i,"->",j)
# show keys of dictionary using for loop
print("------------------------------------------------")
print("Keys of Dictionary:")
for k in db.keys():
 print(k)
print("------------------------------------------------")
# show all values of dictionary using for loop
print("Values of Dictionary:")
for v in db.values():
 print(v)
print("------------------------------------------------")
# show the total length of dictionary
print("Total Elements of Dictionary: ",len(db))
