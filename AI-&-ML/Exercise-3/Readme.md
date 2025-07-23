# 💡 What Do These Programs Do?

# Listing 7 (Agent)
# Implements a simple Mine Field Agent that can move within a 4x4 grid.
# Some cells have hidden mines ('M').
# The agent:
# Starts at [1,1] and must avoid mines.
# Can sense how many adjacent rooms contain mines (=0, =1, >1).
# Keeps track of whether it is alive or dead, and whether it has exited safely.

# Listing 8 (mine_field.py)
# Builds a logical reasoning layer on top of the agent using SAT logic (via pysat).
# Uses percept data to infer safe or unsafe cells logically.
# Guides the agent to safely explore the minefield, using:
# Logical clause generation from percepts.
# Depth-first search for path planning.
# SAT solver (Glucose3) to deduce safe cells.

# Install pysat before running Mine_field.py file
# pip install "python-sat[pblib,aiger]"

Output:
curLoc [1, 1]
Percept =0
Action Taken: Right, Current Location [2, 1]
Percept >1
Action Taken: Left, Current Location [1, 1]
Percept =0
Action Taken: Up, Current Location [1, 2]
Percept =1
Action Taken: Up, Current Location [1, 3]
Percept =0
Action Taken: Up, Current Location [1, 4]
Percept =0
Action Taken: Right, Current Location [2, 4]
Percept =0
Action Taken: Right, Current Location [3, 4]
Percept =0
Action Taken: Right, Current Location [4, 4]
Agent cannot perceive. Agent has exited the Mine field World.
Percept None
