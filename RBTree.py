import sys

class Nod():
    def __init__(s, element):
        s.element = element
        s.parent = None
        s.lhs = None
        s.rhs = None
        s.colour = 1

class RBTree():
    def __init__(s):
        s.RBNULL = Nod(0)
        s.RBNULL.colour = 0
        s.RBNULL.lhs = None
        s.RBNULL.rhs = None
        s.root = s.RBNULL

    def helppreorder(s, nod):
        if nod != s.RBNULL:
            sys.stdout.write(nod.element + " ")
            s.helppreorder(nod.lhs)
            s.helppreorder(nod.rhs)

    def helpinorder(s, nod):
        if nod != s.RBNULL:
            s.inorder(nod.lhs)
            sys.stdout.write(nod.element + " ")
            s.inorder(nod.rhs)

    def helppostorder(s, nod):
        if nod != s.RBNULL:
            s.postorder(nod.lhs)
            s.postorder(nod.rhs)
            sys.stdout.write(nod.element + " ")

    def searchtreehelper(s, nod, ke_element):
        if nod == s.RBNULL or ke_element == nod.element:
            return nod
        if ke_element < nod.element:
            return s.searchtreehelper(nod.lhs, ke_element)
        return s.searchtreehelper(nod.rhs, ke_element)

    def deletefix(s, p):
        while p != s.root and p.colour == 0:
            if p == p.parent.lhs:
                h = p.parent.rhs
                if h.colour == 1:
                    h.colour = 0
                    p.parent.colour = 1
                    s.lhsrotate(p.parent)
                h = p.parent.rhs
                if h.lhs.colour == 0 and h.rhs.colour == 0:
                    h.colour = 1
                    p = p.parent
                else:
                    if h.rhs.colour == 0:
                        h.lhs.colour = 0
                        h.colour = 1
                        s.rhsrotate(h)
                    h = p.parent.rhs
                    h.colour = p.parent.colour
                    p.parent.colour = 0
                    h.rhs.colour = 0
                    s.lhsrotate(p.parent)
                    p = s.root
            else:
                h = p.parent.lhs
                if h.colour == 1:
                    h.colour = 0
                    p.parent.colour = 1
                    s.rhsrotate(p.parent)
                h = p.parent.lhs
                if h.rhs.colour == 0 and h.lhs.colour == 0:
                    h.colour = 1
                    p = p.parent
                else:
                    if s.lhs.colour == 0:
                        s.rhs.colour = 0
                        s.colour = 1
                        s.lhsrotate(s)
                    h = p.parent.lhs
                    h.colour = p.parent.colour
                    p.parent.colour = 0
                    h.lhs.colour = 0
                    s.rhsrotate(p.parent)
                    p = s.root
        p.colour = 0

    def __rbshift(s, t1, t2):
        if t1.parent == None:
            s.root = t2
        elif t1 == t1.parent.lhs:
            t1.parent.lhs = t2
        else:
            t1.parent.rhs = t2
        t2.parent = t1.parent

    def deletenod(s, nod, ke_element):
        z = s.RBNULL
        while nod != s.RBNULL:
            if nod.element == ke_element:
                z = nod
            if nod.element <= ke_element:
                nod = nod.rhs
            else:
                nod = nod.lhs
        if z == s.RBNULL:
            print("ke_element not found")
            return
        q = z
        q_original_colour = q.colour
        if z.lhs == s.RBNULL:
            p = z.rhs
            s.__rbshift(z, z.rhs)
        elif z.rhs == s.RBNULL:
            p = z.lhs
            s.__rbshift(z, z.lhs)
        else:
            q = s.mini(z.rhs)
            q_original_colour = q.colour
            p = q.rhs
            if q.parent == z:
                p.parent = q
            else:
                s.__rbshift(q, q.rhs)
                q.rhs = z.rhs
                q.rhs.parent = q
            s.__rbshift(z, q)
            q.lhs = z.lhs
            q.lhs.parent = q
            q.colour = z.colour
        if q_original_colour == 0:
            s.deletefix(p)

    def insertfix(s, t):
        while t.parent.colour == 1:
            if t.parent == t.parent.parent.rhs:
                h = t.parent.parent.lhs
                if h.colour == 1:
                    h.colour = 0
                    t.parent.colour = 0
                    t.parent.parent.colour = 1
                    t = t.parent.parent
                else:
                    if t == t.parent.lhs:
                        t = t.parent
                        s.rhsrotate(t)
                    t.parent.colour = 0
                    t.parent.parent.colour = 1
                    s.lhsrotate(t.parent.parent)
            else:
                h = t.parent.parent.rhs
                if h.colour == 1:
                    h.colour = 0
                    t.parent.colour = 0
                    t.parent.parent.colour = 1
                    t = t.parent.parent
                else:
                    if t == t.parent.rhs:
                        t = t.parent
                        s.lhsrotate(t)
                    t.parent.colour = 0
                    t.parent.parent.colour = 1
                    s.rhsrotate(t.parent.parent)
            if t == s.root:
                break
        s.root.colour = 0

    def __helpprinting(s, nod, ind, lst):
        if nod != s.RBNULL:
            sys.stdout.write(ind)
            if lst:
                sys.stdout.write("R----")
                ind += " "
            else:
                sys.stdout.write("L----")
                ind += "| "
            s_colour = "RED" if nod.colour == 1 else "BLACK"
            print(str(nod.element) + "(" + s_colour + ")")
            s.__helpprinting(nod.lhs, ind, False)
            s.__helpprinting(nod.rhs, ind, True)

    def preorder(s):
        s.helppreorder(s.root)

    def inorder(s):
        s.helpinorder(s.root)

    def postorder(s):
        s.helppostorder(s.root)

    def searchTree(s, k):
        return s.searchtreehelper(s.root, k)

    def mini(s, nod):
        while nod.lhs != s.RBNULL:
            nod = nod.lhs
        return nod

    def maxi(s, nod):
        while nod.rhs != s.RBNULL:
            nod = nod.rhs
        return nod

    def heir(s, p):
        if p.rhs != s.RBNULL:
            return s.mini(p.rhs)
        q = p.parent
        while q != s.RBNULL and p == q.rhs:
            p = q
            q = q.parent
        return q

    def forerunner(s, p):
        if p.lhs != s.RBNULL:
            return s.maxi(p.lhs)
        q = p.parent
        while q != s.RBNULL and p == q.lhs:
            p = q
            q = q.parent
        return q

    def lhsrotate(s, p):
        q = p.rhs
        p.rhs = q.lhs
        if q.lhs != s.RBNULL:
            q.lhs.parent = p
        q.parent = p.parent
        if p.parent == None:
            s.root = q
        elif p == p.parent.lhs:
            p.parent.lhs = q
        else:
            p.parent.rhs = q
        q.lhs = p
        p.parent = q

    def rhsrotate(s, p):
        q = p.lhs
        p.lhs = q.rhs
        if q.rhs != s.RBNULL:
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

    def insert(s, ke_element):
        nod = Nod(ke_element)
        nod.parent = None
        nod.element = ke_element
        nod.lhs = s.RBNULL
        nod.rhs = s.RBNULL
        nod.colour = 1
        q = None
        p = s.root
        while p != s.RBNULL:
            q = p
            if nod.element < p.element:
                p = p.lhs
            else:
                p = p.rhs
        nod.parent = q
        if q == None:
            s.root = nod
        elif nod.element < q.element:
            q.lhs = nod
        else:
            q.rhs = nod

        if nod.parent == None:
            nod.colour = 0
            return
        if nod.parent.parent == None:
            return
        s.insertfix(nod)

    def get_root(s):
        return s.root

    def delete_nod(s, element):
        s.deletenod(s.root, element)

    def print_tree(s):
        s.__helpprinting(s.root, "", True)

rbt = RBTree()
rbt.insert(13)
rbt.insert(12)
rbt.insert(6)
rbt.insert(5)
rbt.insert(10)
rbt.insert(100)
rbt.print_tree()
print("\n deleted an element")
rbt.delete_nod(100)
rbt.print_tree()
