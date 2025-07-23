
# Install pysat
# pip install "python-sat[pblib,aiger]"


# -*- coding: utf-8 -*-
from pysat.solvers import Glucose3
from Agent import *

# [Left, Right, Up, Down] where 65 is a dummy node (always false)
neighbour = {
    1: [65, 2, 5, 65], 2: [1, 3, 6, 65], 3: [2, 4, 7, 65], 4: [3, 65, 8, 65],
    5: [65, 1, 6, 9], 6: [5, 7, 2, 10], 7: [6, 8, 3, 11], 8: [4, 7, 12, 65],
    9: [65, 5, 10, 13], 10: [9, 11, 6, 14], 11: [10, 12, 7, 15], 12: [8, 11, 16, 65],
    13: [65, 9, 65, 14], 14: [13, 15, 65, 10], 15: [14, 16, 65, 11], 16: [15, 65, 65, 12]
}

g = Glucose3()

# Define logical clauses based on percepts
def percept0(l, r, u, d, p0):
    clauses = []
    g.add_clause([-d, -p0]); clauses.append([-d, -p0])
    g.add_clause([d, l, p0, r, u]); clauses.append([d, l, p0, r, u])
    g.add_clause([-l, -p0]); clauses.append([-l, -p0])
    g.add_clause([-r, -p0]); clauses.append([-r, -p0])
    g.add_clause([-u, -p0]); clauses.append([-u, -p0])
    return clauses

def percept1(l, r, u, d, p1):
    clauses = []
    g.add_clause([-l, -p1, -r]); clauses.append([-l, -p1, -r])
    g.add_clause([-l, -p1, -u]); clauses.append([-l, -p1, -u])
    g.add_clause([-u, -p1, -r]); clauses.append([-u, -p1, -r])
    return clauses

def percept2(l, r, u, d, p2):
    clauses = []
    g.add_clause([-d, -l, p2]); clauses.append([-d, -l, p2])
    g.add_clause([-d, -r, p2]); clauses.append([-d, -r, p2])
    g.add_clause([-d, -u, p2]); clauses.append([-d, -u, p2])
    g.add_clause([d, l, -p2, r]); clauses.append([d, l, -p2, r])
    g.add_clause([d, l, -p2, u]); clauses.append([d, l, -p2, u])
    g.add_clause([d, -p2, r, u]); clauses.append([d, -p2, r, u])
    g.add_clause([-l, p2, -r]); clauses.append([-l, p2, -r])
    g.add_clause([-l, p2, -u]); clauses.append([-l, p2, -u])
    g.add_clause([l, -p2, r, u]); clauses.append([l, -p2, r, u])
    g.add_clause([p2, -r, -u]); clauses.append([p2, -r, -u])
    return clauses

def Explore_rooms(ag, visited, goalLoc, dfsVisited, path):
    curr_pos = ag.FindCurrentLocation()
    curLoc = 4 * (curr_pos[1] - 1) + curr_pos[0]
    if curLoc == goalLoc or curLoc == 16:
        return True
    dfsVisited[curLoc] = True

    directions = [
        ('Up', [0, 1], 4),
        ('Right', [1, 0], 1),
        ('Down', [0, -1], -4),
        ('Left', [-1, 0], -1),
    ]

    for action, _, offset in directions:
        newLoc = curLoc + offset
        if 1 <= newLoc <= 16 and visited[newLoc] and not dfsVisited[newLoc]:
            ag.TakeAction(action)
            cell = ag.FindCurrentLocation()
            path.append(cell)
            if Explore_rooms(ag, visited, goalLoc, dfsVisited, path):
                return True
            path.pop()
            opposite = {'Up': 'Down', 'Down': 'Up', 'Left': 'Right', 'Right': 'Left'}
            ag.TakeAction(opposite[action])
    return False

def ExitMineField(ag, clauses):
    clauses += [[-65], [-16], [-1]]
    path = []
    visited = [False] * 17
    visited[1] = True

    while ag.FindCurrentLocation() != [4, 4]:
        percept = ag.PerceiveCurrentLocation()
        curr_pos = ag.FindCurrentLocation()
        curLocIndex = 4 * (curr_pos[1] - 1) + curr_pos[0]
        visited[curLocIndex] = True

        if percept == '=0':
            g.add_clause([16 + curLocIndex])
            g.add_clause([-1 * (32 + curLocIndex)])
            g.add_clause([-1 * (48 + curLocIndex)])
        elif percept == '=1':
            g.add_clause([32 + curLocIndex])
            g.add_clause([-1 * (48 + curLocIndex)])
            g.add_clause([-1 * (16 + curLocIndex)])
        else:
            g.add_clause([48 + curLocIndex])
            g.add_clause([-1 * (16 + curLocIndex)])
            g.add_clause([-1 * (32 + curLocIndex)])

        for newLoc in range(1, 17):
            if not visited[newLoc]:
                tempclauses = list(clauses)
                tempclauses.append([newLoc])
                g1 = Glucose3()
                g1.append_formula(tempclauses)
                if not g1.solve():
                    clauses.append([-1 * newLoc])
                    dfsVisited = [False] * 17
                    visited[newLoc] = True
                    if Explore_rooms(ag, visited, newLoc, dfsVisited, path):
                        break
    return path

def initialise_knowledge():
    mega_clause = []
    for i in range(1, 17):
        mega_clause.extend(percept0(*neighbour[i], i + 16))
        mega_clause.extend(percept1(*neighbour[i], i + 32))
        mega_clause.extend(percept2(*neighbour[i], i + 48))
    return mega_clause

def main():
    cl = initialise_knowledge()
    ag = Agent()
    print(f'Start Location: {ag.FindCurrentLocation()}')
    path = ExitMineField(ag, cl)
    print(f'{ag.FindCurrentLocation()} reached. Exiting the Mine Field.')

main()
