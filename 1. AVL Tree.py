import sys

class Treen(object):
    def __init__(s, k):
        s.k = k
        s.lhs = None
        s.rhs = None
        s.ht = 1
        
class AVLTree(object):
    def insert_n(s, startingvalue, k):
        if not startingvalue:
            return Treen(k)
        elif k < startingvalue.k:
            startingvalue.lhs = s.insert_n(startingvalue.lhs, k)
        else:
            startingvalue.rhs = s.insert_n(startingvalue.rhs, k)
        
        startingvalue.ht = 1 + max(s.getheight(startingvalue.lhs),s.getheight(startingvalue.rhs))
        
        bal = s.getbalance(startingvalue)

        if bal> 1:
            if k < startingvalue.lhs.k:
                return s.Rotaterhs(startingvalue)
            else:
                startingvalue.lhs = s.Rotatelhs(startingvalue.lhs)
                return s.Rotaterhs(startingvalue)
        if bal< -1:
            if k > startingvalue.rhs.k:
                return s.Rotatelhs(startingvalue)
            else:
                startingvalue.rhs = s.Rotaterhs(startingvalue.rhs)
                return s.Rotatelhs(startingvalue)
        return startingvalue

    def delete_n(s, startingvalue, k):
        if not startingvalue:
            return startingvalue
        elif k <startingvalue.k:
            startingvalue.lhs = s.delete_n(startingvalue.lhs, k)
        elif k >startingvalue.k:
            startingvalue.rhs = s.delete_n(startingvalue.rhs, k)
        else:
            if startingvalue.lhs is None:
                temp = startingvalue.rhs
                startingvalue = None
                return temp
            elif startingvalue.rhs is None:
                temp = startingvalue.lhs
                startingvalue = None
                return temp
            temp = s.getMinValue(startingvalue.rhs)
            startingvalue.k = temp.k
            startingvalue.rhs = s.delete_n(startingvalue.rhs,temp.k)
        
        if startingvalue is None:
            return startingvalue
        startingvalue.ht = 1 + max(s.getheight(startingvalue.lhs),s.getheight(startingvalue.rhs))
        bal = s.getbalance(startingvalue)
        
        if bal> 1:
            if s.getbalance(startingvalue.lhs) >= 0:
                return s.Rotaterhs(startingvalue)
            else:
                startingvalue.lhs = s.Rotatelhs(startingvalue.lhs)
                return s.Rotaterhs(startingvalue)
        if bal< -1:
            if s.getbalance(startingvalue.rhs) <= 0:
                return s.Rotatelhs(startingvalue)
            else:
                startingvalue.rhs = s.Rotaterhs(startingvalue.rhs)
                return s.Rotatelhs(startingvalue)
        return startingvalue

    def Rotatelhs(s, p):
        q = p.rhs
        tr2 = q.lhs
        q.lhs = p
        p.rhs = tr2
        p.ht = 1 + max(s.getheight(p.lhs), s.getheight(p.rhs))
        q.ht = 1 + max(s.getheight(q.lhs),s.getheight(q.rhs))
        return q

    def Rotaterhs(s, p):
        q = p.lhs
        tr3 = q.rhs
        q.rhs = p
        p.lhs = tr3
        p.ht = 1 + max(s.getheight(p.lhs),s.getheight(p.rhs))
        q.ht = 1 + max(s.getheight(q.lhs),s.getheight(q.rhs))
        return q
        
    def getheight(s, startingvalue):
        if not startingvalue:
            return 0
        return startingvalue.ht

    def getbalance(s, startingvalue):
        if not startingvalue:
            return 0
        return s.getheight(startingvalue.lhs) - s.getheight(startingvalue.rhs)

    def getMinValue(s, startingvalue):
        if startingvalue is None or startingvalue.lhs is None:
            return startingvalue
        return s.getMinValue(startingvalue.lhs)

    def preOrder(s, startingvalue):
        if not startingvalue:
            return
        print("{0} ".format(startingvalue.k), end="")
        s.preOrder(startingvalue.lhs)
        s.preOrder(startingvalue.rhs)

    def printHelper(s, currentpoint, starting, end):
        if currentpoint != None:
            sys.stdout.write(starting)
            if end:
                sys.stdout.write("R----")
                starting += " "
            else:
                sys.stdout.write("L----")
                starting += "| "
            print(currentpoint.k)
            s.printHelper(currentpoint.lhs, starting, False)
            s.printHelper(currentpoint.rhs, starting, True)
    
myTree = AVLTree()
startingvalue = None

nums = [10, 20, 30, 40, 21, 60, 45, 100]
for num in nums:
    startingvalue = myTree.insert_n(startingvalue, num)
    
myTree.printHelper(startingvalue, "", True)

k = 30
startingvalue = myTree.delete_n(startingvalue, k)
print("After Deletion: ")
myTree.printHelper(startingvalue, "", True)
