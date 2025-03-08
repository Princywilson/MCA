# from tkinter import *
#
# r = Tk()
#
# mb = Menu(r)
#
# def newfile():
#     print("creating new file")
#
# def openfile():
#     name = askopenfilename()
#     print(name)
#
# def createmenu1():
#     f1 = Menu(mb)
#     f1.add_command(label="New", command=newfile)
#     f1.add_separator()
#     f1.add_command(label="Open", command=openfile)
#     f1.add_separator()
#     f1.add_command(label="Exit")
#     mb.add_cascade(label="File", menu=f1)
#
# def createmenu2():
#     f2 = Menu(mb)
#     f2.add_command(label="Copy")
#     f2.add_separator()
#     f2.add_command(label="Paste")
#     mb.add_cascade(label="Edit", menu=f2)
#
# createmenu1()
# createmenu2()
#
# r.config(menu=mb)
# r.title("Python MenuBar Example")
# r.geometry("310x350")
# r.mainloop()

from tkinter import *
from tkinter.filedialog import askopenfilename
from tkinter.simpledialog import askstring

r = Tk()

mb = Menu(r)

def count_word_in_file():
    # Ask for the word to search for
    word = askstring("Input", "Enter the word to count:")
    if word:
        # Open the file
        filename = askopenfilename(filetypes=[("Text files", "*.txt")])
        if filename:
            try:
                # Read the file and count occurrences of the word
                with open(filename, 'r') as file:
                    text = file.read()
                    word_count = text.lower().split().count(word.lower())
                    print(f"The word '{word}' appeared {word_count} times in the file.")
            except Exception as e:
                print(f"Error reading file: {e}")
        else:
            print("No file selected.")
    else:
        print("No word entered.")

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
    f2.add_command(label="Count Word", command=count_word_in_file)
    f2.add_separator()
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


