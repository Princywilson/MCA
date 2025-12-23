import networkx as nx
import matplotlib.pyplot as plt

def dfs(graph, start, visited=None, traversal_order=None):
    if visited is None:
        visited = set()
    if traversal_order is None:
        traversal_order = []

    visited.add(start)
    traversal_order.append(start)
    
    for neighbor in graph.neighbors(start):
        if neighbor not in visited:
            dfs(graph, neighbor, visited, traversal_order)
    return traversal_order

# Create a sample graph
G = nx.Graph()
edges = [
    ('A', 'B'), ('A', 'C'), ('B', 'D'), ('B', 'E'),
    ('C', 'F'), ('E', 'F'), ('F', 'G')
]
G.add_edges_from(edges)

# Run DFS starting from node 'A'
order = dfs(G, 'A')
print("DFS traversal order:", order)

# Visualization
pos = nx.spring_layout(G)  # positions for all nodes

plt.figure(figsize=(8, 6))
nx.draw(G, pos, with_labels=True, node_color='lightblue', node_size=500, font_size=14, font_weight='bold')

# Highlight the traversal order by numbering nodes in order
for i, node in enumerate(order):
    x, y = pos[node]
    plt.text(x, y+0.07, str(i+1), fontsize=12, fontweight='bold', color='red', horizontalalignment='center')

plt.title("DFS Traversal Order (Numbers indicate order visited)")
plt.show()
