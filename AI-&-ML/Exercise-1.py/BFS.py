# pip install networkx --> NetworkX is a Python library for the creation, manipulation, and study of the structure, dynamics, and functions of complex networks (graphs).
# pip install matplotlib --> to visualize the graph

import networkx as nx
import matplotlib.pyplot as plt
from collections import deque

def bfs(graph, start):
    visited = set()
    queue = deque([start])
    order = []

    while queue:
        vertex = queue.popleft()
        if vertex not in visited:
            visited.add(vertex)
            order.append(vertex)
            # Add neighbors to the queue
            queue.extend([n for n in graph[vertex] if n not in visited])
    return order

# Create a sample graph using adjacency list
graph = {
    'A': ['B', 'C'],
    'B': ['D', 'E'],
    'C': ['F'],
    'D': [],
    'E': ['F'],
    'F': []
}

# Run BFS starting from node 'A'
bfs_order = bfs(graph, 'A')
print("BFS Order:", bfs_order)

# Visualize the graph
G = nx.DiGraph()

# Add edges
for node, neighbors in graph.items():
    for neighbor in neighbors:
        G.add_edge(node, neighbor)

pos = nx.spring_layout(G)  # positions for all nodes

# Draw nodes
nx.draw_networkx_nodes(G, pos, node_color='lightblue', node_size=700)

# Draw edges
nx.draw_networkx_edges(G, pos, arrowstyle='->', arrowsize=20)

# Draw labels
nx.draw_networkx_labels(G, pos, font_size=20, font_family='sans-serif')

plt.title("Graph Visualization")
plt.axis('off')
plt.show()
