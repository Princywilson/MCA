class Nod:
    def __init__(s, dt):
        s.dt = dt
        s.parent = None
        s.lhs = None
        s.rhs = None


class Splaystree:
    def __init__(s):
        s.root = None

    def maxi(s, p):
        while p.rhs != None:
            p = p.rhs
        return p

    def lhsrotate(s, p):
        q = p.rhs
        p.rhs = q.lhs
        if q.lhs != None:
            q.lhs.parent = p
        q.parent = p.parent
        if p.parent == None:
            s.root = q
        elif p == p.parent.lhs:
            p.parent.lhs = q
        else:  # p is rhs child
            p.parent.rhs = q
        q.lhs = p
        p.parent = q

    def rhsrotate(s, p):
        q = p.lhs
        p.lhs = q.rhs
        if q.rhs != None:
            q.rhs.parent = p
        q.parent = p.parent
        if p.parent == None:
            s.root = q
        elif p == p.parent.rhs:
            p.parent.rhs = q
        else:
            p.parent.lhs = q
        q.rhs = p
        p.parent = q

    def splay(s, nod):
        while nod.parent != None:
            if nod.parent == s.root:
                if nod == nod.parent.lhs:
                    s.rhsrotate(nod.parent)
                else:
                    s.lhsrotate(nod.parent)
            else:
                h = nod.parent
                g = h.parent
                if nod.parent.lhs == nod and h.parent.lhs == h:  # both are lhs children
                    s.rhsrotate(g)
                    s.rhsrotate(h)
                elif nod.parent.rhs == nod and h.parent.rhs == h:  # both are rhs children
                    s.lhsrotate(g)
                    s.lhsrotate(h)
                elif nod.parent.rhs == nod and h.parent.lhs == h:
                    s.lhsrotate(h)
                    s.rhsrotate(g)
                elif nod.parent.lhs == nod and h.parent.rhs == h:
                    s.rhsrotate(h)
                    s.lhsrotate(g)

    def insert(s, nod):
        q = None
        temp = s.root
        while temp != None:
            q = temp
            if nod.dt < temp.dt:
                temp = temp.lhs
            else:
                temp = temp.rhs
        nod.parent = q
        if q == None:  # newly added nod is root
            s.root = nod
        elif nod.dt < q.dt:
            q.lhs = nod
        else:
            q.rhs = nod
        s.splay(nod)

    def search(s, nod, p):
        if p == nod.dt:
            s.splay(nod)
            return nod
        elif p < nod.dt:
            return s.search(nod.lhs, p)
        elif p > nod.dt:
            return s.search(nod.rhs, p)
        else:
            return None

    def delete(s, nod):
        s.splay(nod)
        lhs_subtree = Splaystree()
        lhs_subtree.root = s.root.lhs
        if lhs_subtree.root != None:
            lhs_subtree.root.parent = None
        rhs_subtree = Splaystree()
        rhs_subtree.root = s.root.rhs
        if rhs_subtree.root != None:
            rhs_subtree.root.parent = None
        if lhs_subtree.root != None:
            m = lhs_subtree.maxi(lhs_subtree.root)
            lhs_subtree.splay(m)
            lhs_subtree.root.rhs = rhs_subtree.root
            s.root = lhs_subtree.root
        else:
            s.root = rhs_subtree.root

    def inorder(s, nod):
        if nod != None:
            s.inorder(nod.lhs)
            print(nod.dt)
            s.inorder(nod.rhs)


if __name__ == '__main__':
    spl = Splaystree()
    P1 = Nod(10)
    P2 = Nod(20)
    P3 = Nod(30)
    P4 = Nod(40)
    P5 = Nod(21)
    P6 = Nod(60)
    P7 = Nod(45)
    P8 = Nod(100)
    spl.insert(P1)
    spl.insert(P2)
    spl.insert(P3)
    spl.insert(P4)
    spl.insert(P5)
    spl.insert(P6)
    spl.insert(P7)
    spl.insert(P8)
    spl.inorder(spl.root)
