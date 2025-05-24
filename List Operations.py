# Simple List Operations Program for Exam

# Create a list
my_list = ['apple', 'banana']

# Function to display the list
def display_list():
    print("Current list:", my_list)

# Function to add an item
def add_item():
    item = input("Enter item to add: ")
    my_list.append(item)
    print(f"Added '{item}' to the list")

# Function to delete an item
def delete_item():
    item = input("Enter item to delete: ")
    if item in my_list:
        my_list.remove(item)
        print(f"Deleted '{item}' from the list")
    else:
        print("Item not found")

# Main program
print("=== List Operations Demo ===")

# Display initial list
display_list()

# Add an item
add_item()
display_list()

# Delete an item
delete_item()
display_list()
