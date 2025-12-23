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

# -*- coding: utf-8 -*-
class Agent:
    def __init__(self):
        self._mineFieldWorld = [
            ['', '', '', ''],  # Rooms [1,4] to [4,4]
            ['', '', '', ''],  # Rooms [1,3] to [4,3]
            ['', 'M', '', ''],  # Rooms [1,2] to [4,2]
            ['', '', 'M', ''],  # Rooms [1,1] to [4,1]
        ]
        self._curLoc = [1, 1]
        self._isAlive = True
        self._hasExited = False

    def _FindIndicesForLocation(self, loc):
        x, y = loc
        i, j = 4 - y, x - 1
        return i, j

    def _CheckForMine(self):
        mf = self._mineFieldWorld
        i, j = self._FindIndicesForLocation(self._curLoc)
        if 'M' in mf[i][j]:
            print(mf[i][j])
            self._isAlive = False
            print('Agent is DEAD.')
        return self._isAlive

    def TakeAction(self, action):
        validActions = ['Up', 'Down', 'Left', 'Right']
        assert action in validActions, 'Invalid Action.'
        if not self._isAlive:
            print(f'Action cannot be performed. Agent is DEAD. Location: {self._curLoc}')
            return False
        if self._hasExited:
            print(f'Action cannot be performed. Agent has exited the Mine field world.')
            return False

        index = validActions.index(action)
        validMoves = [[0, 1], [0, -1], [-1, 0], [1, 0]]
        move = validMoves[index]
        newLoc = []
        for v, inc in zip(self._curLoc, move):
            z = v + inc
            z = 4 if z > 4 else 1 if z < 1 else z
            newLoc.append(z)
        self._curLoc = newLoc
        print(f'Action Taken: {action}, Current Location {self._curLoc}')

        if self._curLoc == [4, 4]:
            self._hasExited = True

        return self._CheckForMine()

    def _FindAdjacentRooms(self):
        cLoc = self._curLoc
        validMoves = [[0, 1], [0, -1], [-1, 0], [1, 0]]
        adjRooms = []
        for vM in validMoves:
            room = []
            valid = True
            for v, inc in zip(cLoc, vM):
                z = v + inc
                if z < 1 or z > 4:
                    valid = False
                    break
                else:
                    room.append(z)
            if valid:
                adjRooms.append(room)
        return adjRooms

    def PerceiveCurrentLocation(self):
        percept = None
        mf = self._mineFieldWorld
        if not self._isAlive:
            print(f'Agent cannot perceive. Agent is DEAD. Location: {self._curLoc}')
            return None
        if self._hasExited:
            print(f'Agent cannot perceive. Agent has exited the Mine field World.')
            return None
        adjRooms = self._FindAdjacentRooms()
        count = 0
        for room in adjRooms:
            i, j = self._FindIndicesForLocation(room)
            if 'M' in mf[i][j]:
                count += 1
        percept = '=0' if count == 0 else '=1' if count == 1 else '>1'
        return percept

    def FindCurrentLocation(self):
        return self._curLoc

def main():
    ag = Agent()
    print('curLoc', ag.FindCurrentLocation())
    print('Percept', ag.PerceiveCurrentLocation())
    ag.TakeAction('Right')
    print('Percept', ag.PerceiveCurrentLocation())
    ag.TakeAction('Left')
    print('Percept', ag.PerceiveCurrentLocation())
    ag.TakeAction('Up')
    print('Percept', ag.PerceiveCurrentLocation())
    ag.TakeAction('Up')
    print('Percept', ag.PerceiveCurrentLocation())
    ag.TakeAction('Up')
    print('Percept', ag.PerceiveCurrentLocation())
    ag.TakeAction('Right')
    print('Percept', ag.PerceiveCurrentLocation())
    ag.TakeAction('Right')
    print('Percept', ag.PerceiveCurrentLocation())
    ag.TakeAction('Right')
    print('Percept', ag.PerceiveCurrentLocation())

if __name__ == '__main__':
    main()
