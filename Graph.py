class graph:
    def __init__(s, nod):
        s.id = nod
        s.adjacent = {}

    def __str__(s):
        return str(s.id) + ' adjacent: ' + str([x.id for x in s.adjacent])

    def add_adj(s, adj, weight=0):
        s.adjacent[adj] = weight  # adding weight to the edge

    def getconnections(s):
        return s.adjacent.keys()

    def getid(s):
        return s.id

    def getweight(s, adj):
        return s.adjacent[adj]

class Graph:
    def __init__(s):
        s.vertdict = {}
        s.numvertices = 0

    def __iter__(s):
        return iter(s.vertdict.values())

    # creating vertices
    def addvertices(s, nod):
        s.numvertices = s.numvertices + 1
        newvertex = graph(nod)
        s.vertdict[nod] = newvertex
        return newvertex

    def getvertex(s, n):
        if n in s.vertdict:
            return s.vertdict[n]
        else:
            return None

    # adding edges
    def addedges(s, frm, to, cost=0):
        # check if frm vertex is present else add the vertex
        if frm not in s.vertdict:
            s.addvertices(frm)
        # check if to vertex is present else add the vertex
        if to not in s.vertdict:
            s.addvertices(to)
        s.vertdict[frm].add_adj(s.vertdict[to], cost)  # adding cost of travel between frm-to
        s.vertdict[to].add_adj(s.vertdict[frm], cost)  # adding cost of travel between to-frm

    def getvertices(s):
        return s.vertdict.keys()

if __name__ == '__main__':
    g = Graph()
    g.addvertices('p')
    g.addvertices('q')
    g.addvertices('r')
    g.addvertices('s')
    g.addvertices('g')
    g.addvertices('h')
    g.addedges('p', 'q', 7)
    g.addedges('p', 'r', 9)
    g.addedges('p', 'h', 14)
    g.addedges('q', 'r', 10)
    g.addedges('q', 's', 15)
    g.addedges('r', 's', 11)
    g.addedges('s', 'h', 2)
    g.addedges('g', 'g', 6)
    g.addedges('h', 'h', 9)
    
    print('Edges')
    for a in g:
        for b in a.getconnections():
            vid = a.getid()
            wid = b.getid()
            print('( %s , %s, %3d)' % (vid, wid, a.getweight(b)))
    
    print("Adjacents of each nod")
    for a in g:
        print(a)
