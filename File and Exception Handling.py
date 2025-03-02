from tkinter import *

r = Tk()

mb = Menu(r)

def newfile():
    print("creating new file")

def openfile():
    name = askopenfilename()
    print(name)

def createmenu1():
    f1 = Menu(mb)
    f1.add_command(label="New", command=newfile)
    f1.add_separator()
    f1.add_command(label="Open", command=openfile)
    f1.add_separator()
    f1.add_command(label="Exit")
    mb.add_cascade(label="File", menu=f1)

def createmenu2():
    f2 = Menu(mb)
    f2.add_command(label="Copy")
    f2.add_separator()
    f2.add_command(label="Paste")
    mb.add_cascade(label="Edit", menu=f2)

createmenu1()
createmenu2()

r.config(menu=mb)
r.title("Python MenuBar Example")
r.geometry("310x350")
r.mainloop()
