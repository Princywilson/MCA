

---

Experiment 1

Image Editing (Restoration, Color → Grayscale, Special Effects)

Aim

To perform image editing operations such as image restoration, grayscale conversion, and special effects.

Theory

Image editing is the process of modifying digital images to improve quality or create visual effects.


---

Procedure

A. Convert Color Image to Grayscale

1. Open image in GIMP/Photoshop.


2. Select:



Image → Mode → Grayscale

or

Colors → Desaturate

3. Save the image.



Output

Before:

Colored image


After:

Black and white image



---

B. Restore Damaged Image

1. Open damaged image.


2. Select Clone Tool.


3. Press Alt and sample nearby pixels.


4. Paint over scratches/noise.


5. Save image.



Output

Restored image without scratches.



---

C. Add Special Effects

1. Open image.


2. Apply:



Filters → Blur
Filters → Artistic
Filters → Oil Paint

3. Save output.



Output

Artistic effect image.



---

Viva Questions

What is Image Restoration?

Removing noise and defects from an image.

What is Grayscale?

Image represented using intensity values only.


---

Experiment 2

Video Editing using Premiere Pro

Aim

To create and edit video clips with effects.


---

Procedure

Import Video

File → Import

Select video clips.


---

Arrange Clips

Drag clips to Timeline.


---

Trim Video

Use Razor Tool.

Remove unwanted sections.


---

Add Transition

Effects → Video Transitions

Apply:

Fade

Dissolve

Wipe



---

Export Video

File → Export → Media

Format:

H.264

Click Export.


---

Output

Edited video with transitions.


---

Viva

What is Timeline?

Area where clips are arranged.

What is Rendering?

Process of generating final video.


---

Experiment 3

Audio Editing using Audacity

Aim

To create and edit audio files with effects.


---

Procedure

Import Audio

File → Import → Audio


---

Remove Noise

1. Select noisy portion.


2. Effect → Noise Reduction.


3. Get Noise Profile.


4. Apply.




---

Add Echo

Effect → Echo

Apply.


---

Adjust Volume

Effect → Amplify

Apply.


---

Export

File → Export

Save as MP3/WAV.


---

Output

Clean audio with effects.


---

Viva

What is Noise Reduction?

Removing unwanted sounds.

What is Sampling Rate?

Number of samples captured per second.


---

Experiment 4

3D Model Creation and Animation using Blender

This is the most important one.


---

Aim

To create a 3D model and animate it using Blender.


---

Part A: Create a 3D Cup

Step 1

Open Blender.

Delete default cube.

A → X → Delete


---

Step 2

Add Cylinder

Shift + A
Mesh → Cylinder


---

Step 3

Scale

Press:

S

Resize cylinder.


---

Step 4

Enter Edit Mode

Tab


---

Step 5

Select Top Face

3 (Face Select)


---

Step 6

Inset

I

Create inner rim.


---

Step 7

Extrude Down

E

Create cup cavity.


---

Output

3D Cup Model.


---

Part B: Animate the Cup

Frame 1

Select cup.

Press:

I → Location


---

Frame 100

Move cup.

Press:

G

Change position.

Again:

I → Location


---

Play Animation

Spacebar


---

Output

Cup moving from one location to another.


---

Viva

What is Mesh?

Collection of vertices, edges and faces.

What is Keyframe?

Stores object position at a frame.


---

Experiment 5

Run Length Encoding (RLE)

Aim

To compress text using RLE.


---

Input

AAAABBBCCDAA


---

Algorithm

1. Read string.


2. Count repeated characters.


3. Store count and character.


4. Continue until end.




---

Output

4A3B2C1D2A


---

Python Program

text = "AAAABBBCCDAA"

count = 1
result = ""

for i in range(len(text)-1):
    if text[i] == text[i+1]:
        count += 1
    else:
        result += str(count) + text[i]
        count = 1

result += str(count) + text[-1]

print(result)


---

Experiment 5(B)

Huffman Coding

Aim

To compress text using Huffman coding.


---

Theory

Characters with higher frequency get shorter codes.


---

Example

Input:

BANANA

Frequency:

A = 3
N = 2
B = 1

Possible Codes:

A = 0
N = 10
B = 11

Compressed:

11010010


---

Output

Reduced bit storage.


---

Viva

Why Huffman Coding?

Lossless compression.


---

Experiment 6

DCT and FFT Transformations


---

DCT

Aim

Transform image data into frequency components.

Applications

JPEG Compression

Image Processing


Procedure

1. Read image.


2. Apply DCT.


3. Store coefficients.



Output

Frequency representation of image.


---

FFT

Aim

Analyze frequency components of a signal.

Procedure

1. Read signal.


2. Apply FFT.


3. View frequency spectrum.



Output

Signal frequency graph.


---

Viva

Full Form of DCT?

Discrete Cosine Transform

Full Form of FFT?

Fast Fourier Transform


---

Experiment 7

Simple Multimedia Application

Since your syllabus allows any authoring tool, Blender can be used.

Aim

To create a simple multimedia application.


---

Blender Example

Create Interactive Solar System

1. Add Sun (Sphere).


2. Add Earth (Sphere).


3. Scale Earth smaller.


4. Parent Earth to Empty.


5. Rotate Empty.



Animation:

I → Rotation

at frame 1.

Move to frame 250.

Rotate 360°.

I → Rotation


---

Output

Earth revolving around Sun.


---

Most Scoring Blender Experiment (Exam)

If examiner asks you to perform one Blender experiment:

Create Bouncing Ball Animation

1. Open Blender.


2. Delete cube.


3. Shift+A → UV Sphere.


4. Frame 1 → Ball at top.


5. Press I → Location.


6. Frame 50 → Move ball down.


7. Press I → Location.


8. Frame 100 → Move ball up.


9. Press I → Location.


10. Play animation.



Output

Ball bounces continuously.

This experiment is quick (2–3 minutes), easy to explain, and usually gets full marks in multimedia practical exams.
