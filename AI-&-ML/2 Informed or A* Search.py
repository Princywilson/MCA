# This program finds the shortest navigable path through a grid maze from a start point to an end point using 
the A search algorithm*, considering obstacles and allowing 8-directional movement (including diagonals).

import heapq

class PriorityQueue:
    def __init__(self, priorityFunction):
        self.priorityFunction = priorityFunction
        self.heap = []

    def push(self, item):
        heapq.heappush(self.heap, (self.priorityFunction(item), item))

    def pop(self):
        (_, item) = heapq.heappop(self.heap)
        return item

    def empty(self):
        return len(self.heap) == 0

def astarGraphSearch(problem, heuristic):
    # A* uses path cost from startstate + heuristic estimate to a goal
    totalCost = lambda state: len(state[1]) + heuristic(state)
    return graphSearch(problem, PriorityQueue(totalCost))

# problem is an instance of PacmanProblem
# food is the position of the food pellet (r, c)
def pacmanPathFinder(problem, food):
    manhattanDistanceHeuristic = lambda state: abs(state[0][0] - food[0]) + abs(state[0][1] - food[1])
    return astarGraphSearch(problem, manhattanDistanceHeuristic)


class Node:
    """A node class for A* Pathfinding"""
    def __init__(self, parent=None, position=None):
        self.parent = parent
        self.position = position
        self.g = 0
        self.h = 0
        self.f = 0

    def __eq__(self, other):
        return self.position == other.position

def astar(maze, start, end):
    """ Returns a list of tuples as a path from the given start to the given end in the given maze"""
    # Create start and end node
    start_node = Node(None, start)
    start_node.g = start_node.h = start_node.f = 0
    end_node = Node(None, end)
    end_node.g = end_node.h = end_node.f = 0

    # Initialize both open and closed list
    open_list = []
    closed_list = []

    # Add the start node
    open_list.append(start_node)

    # Loop until you find the end
    while len(open_list) > 0:
        # Get the current node
        current_node = open_list[0]
        current_index = 0
        for index, item in enumerate(open_list):
            if item.f < current_node.f:
                current_node = item
                current_index = index

        # Pop current off open list, add to closed list
        open_list.pop(current_index)
        closed_list.append(current_node)

        # Found the goal
        if current_node == end_node:
            path = []
            current = current_node
            while current is not None:
                path.append(current.position)
                current = current.parent
            return path[::-1]  # Return reversed path

        # Generate children
        children = []
        for new_position in [(0, -1), (0, 1), (-1, 0), (1, 0),
                             (-1, -1), (-1, 1), (1, -1), (1, 1)]:  # Adjacent squares

            # Get node position
            node_position = (current_node.position[0] + new_position[0],
                             current_node.position[1] + new_position[1])

            # Make sure within range
            if (node_position[0] > (len(maze) - 1) or node_position[0] < 0 or
                node_position[1] > (len(maze[len(maze) - 1]) - 1) or node_position[1] < 0):
                continue

            # Make sure walkable terrain
            if maze[node_position[0]][node_position[1]] != 0:
                continue

            # Create new node
            new_node = Node(current_node, node_position)

            # Append
            children.append(new_node)

        # Loop through children
        for child in children:

            # Child is on the closed list
            if child in closed_list:
                continue

            # Create the f, g, and h values
            child.g = current_node.g + 1
            child.h = ((child.position[0] - end_node.position[0]) ** 2) + \
                      ((child.position[1] - end_node.position[1]) ** 2)
            child.f = child.g + child.h

            # Child is already in the open list
            if child in open_list:
                open_node = open_list[open_list.index(child)]
                if child.g > open_node.g:
                    continue

            # Add the child to the open list
            open_list.append(child)

def main():
    maze = [
        [0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    ]
    start = (0, 0)
    end = (7, 6)
    path = astar(maze, start, end)
    print(path)

if __name__ == '__main__':
    main()
