Here is a **detailed lab record write-up** for your subject **Multimedia Systems and Applications Lab** on **Text Compression Algorithms (Run Length Encoding and Huffman Coding)**.
The content is elaborated enough to comfortably fill **two long unruled notebook pages** when handwritten.

---

# **Experiment No: 4**

# **Title: Text Compression using Run Length Encoding and Huffman Coding**

---

## **Aim:**

To study and implement basic text compression techniques namely **Run Length Encoding (RLE)** and **Huffman Coding**, and to analyze their efficiency in reducing the size of textual data.

---

## **Objective:**

1. To understand the need for data compression in multimedia systems.
2. To implement Run Length Encoding for compressing repetitive text data.
3. To implement Huffman Coding for variable-length encoding based on character frequency.
4. To compare compression efficiency of both techniques.

---

## **Theory:**

Data compression is a technique used to reduce the storage space and transmission time of data. In multimedia systems, compression plays a vital role because text, images, audio, and video require large storage capacity. By compressing data, we can save memory and improve data transmission speed.

There are two types of compression:

* **Lossless Compression** – Original data can be perfectly reconstructed.
* **Lossy Compression** – Some data is lost permanently.

Both Run Length Encoding and Huffman Coding are **lossless compression techniques**.

---

### **1. Run Length Encoding (RLE):**

Run Length Encoding is one of the simplest compression algorithms. It works well when data contains many repeated characters.

Instead of storing repeated characters individually, RLE stores:

* The character
* The number of times it appears consecutively

**Example:**

Input:
`AAAABBBCCDAA`

Compressed Output:
`4A3B2C1D2A`

Thus, repeated characters are replaced by count and character.

**Advantages:**

* Simple to implement
* Efficient for highly repetitive data

**Disadvantages:**

* Not efficient if text has fewer repetitions
* May increase size for random data

---

### **2. Huffman Coding:**

Huffman Coding is an advanced compression technique based on frequency of characters. It assigns shorter binary codes to frequently occurring characters and longer codes to less frequent characters.

It uses a **binary tree structure called Huffman Tree**.

**Steps involved:**

1. Count frequency of each character.
2. Create nodes for each character.
3. Arrange nodes in ascending order of frequency.
4. Combine two lowest frequency nodes.
5. Repeat until only one node (root) remains.
6. Assign binary codes (0 for left, 1 for right).

**Example:**

Input String:
`AABBC`

Frequencies:
A = 2
B = 2
C = 1

After building Huffman Tree:

Possible Codes:
A = 0
B = 10
C = 11

Compressed output becomes binary sequence.

**Advantages:**

* High compression efficiency
* Optimal prefix coding

**Disadvantages:**

* More complex than RLE
* Requires additional memory for tree construction

---

## **Procedure:**

### **Part A: Run Length Encoding**

1. Start the program.
2. Input a string from the user.
3. Initialize count = 1.
4. Traverse through the string character by character.
5. If current character equals next character, increment count.
6. If not equal, print count and character.
7. Reset count to 1.
8. Repeat until end of string.
9. Display compressed string.
10. Stop the program.

---

### **Part B: Huffman Coding**

1. Start the program.
2. Input the text string.
3. Calculate frequency of each character.
4. Create a node for each character with frequency.
5. Insert nodes into a priority queue (min-heap).
6. Remove two nodes with lowest frequency.
7. Create a new node with sum of their frequencies.
8. Insert the new node back into queue.
9. Repeat until only one node remains.
10. Traverse the tree to assign binary codes.
11. Encode the original text using generated codes.
12. Display encoded output.
13. Stop the program.

---

## **Sample Input:**

```
AAAABBBCCDAA
```

---

## **Sample Output:**

### **Run Length Encoding Output:**

```
Compressed String: 4A3B2C1D2A
Original Size: 12 characters
Compressed Size: 10 characters
```

---

### **Huffman Coding Output:**

```
Character Codes:
A : 0
B : 10
C : 110
D : 111

Encoded String:
000010101011011100
Original Size: 96 bits (12 × 8 bits)
Compressed Size: 18 bits
```

---

## **Result:**

Thus, the text compression algorithms **Run Length Encoding** and **Huffman Coding** were successfully implemented and tested.

It is observed that:

* RLE works efficiently for data with repeated characters.
* Huffman Coding provides better compression for general text data.
* Huffman Coding achieves higher compression ratio compared to RLE for mixed data.

Hence, both techniques are useful in multimedia systems depending on the type of input data.

---

If you want, I can also provide:

* Python / C program code for both algorithms
* Compression ratio calculation formula section
* Viva questions and answers for this experiment 😊
