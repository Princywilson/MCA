
# Requirements
# Go to the AIMA Python GitHub repository. - https://github.com/aimacode/aima-python/blob/master/utils.py
# Download these files (or copy them to your project directory):
# agents.py
# logic.py
# utils.py
# Ensure all these files are in the same directory as Exercise-5.py.
# pip3 install numpy
# pip3 install ipythonblocks
# Also have some more to install

# −*− coding: utf−8 −*−
from utils import *
from logic import *
from notebook import psource

# Create a propositional KB for Wumpus World
wumpus_kb = PropKB()

# Create the required symbols to represent the world
P11, P12, P21, P22, P31, B11, B21 = expr('P11,P12,P21,P22,P31,B11,B21')

# TELL the KB the specifications in the Wumpus World description
# No pit in P(1,1)
wumpus_kb.tell(~P11)

# A square is breezy if and only if there is a pit in a neighboring square
wumpus_kb.tell(B11 | '<=>' | ((P12 | P21)))
wumpus_kb.tell(B21 | '<=>' | ((P11 | P22 | P31)))

# Include the breeze percepts for the first two squares
wumpus_kb.tell(~B11)
wumpus_kb.tell(B21)

# Check the clauses stored in a KB by accessing its clauses variable
print("Wumpus World KB:")
print(wumpus_kb.clauses)

# Given a percept, a KB Agent adds the percept to its knowledge base, asks the knowledge base for the best action and
# tells the KB that it has taken the action
def KB_AgentProgram(KB):
    steps = itertools.count()

    def program(percept):
        t = next(steps)
        KB.tell(make_percept_sentence(percept, t))
        action = KB.ask(make_action_query(t))
        KB.tell(make_action_sentence(action, t))
        return make_action_query

    def make_percept_sentence(percept, t):
        return Expr("Percept")(percept, t)

    def make_action_query(t):
        return expr("ShouldDo(action,{})".format(t))

    def make_action_sentence(action, t):
        return Expr("Did")(action[expr('action')], t)

    return program

# Checking whether KB => A
# Inference in Propositional Logic
def tt_check_all(kb, alpha, symbols, model):
    """Auxiliary routine to implement tt_entails."""
    if not symbols:
        if pl_true(kb, model):
            result = pl_true(alpha, model)
            assert result in (True, False)
            return result
        else:
            return True
    else:
        P, rest = symbols[0], symbols[1:]
        return (tt_check_all(kb, alpha, rest, extend(model, P, True)) and
                tt_check_all(kb, alpha, rest, extend(model, P, False)))

def tt_entails(kb, alpha):
    """Does kb entail the sentence alpha? Use truth tables. For propositional kb’s
    and sentences. Note that the ‘kb’ should be an Expr which is a conjunction of clauses.
    >>> tt_entails(expr('P & Q'), expr('Q'))
    True
    """
    assert not variables(alpha)
    symbols = list(prop_symbols(kb & alpha))
    return tt_check_all(kb, alpha, symbols, {})

print("Test_Query_Result for P&Q|Q:")
print(tt_entails(P & Q, Q))
print("IS ~P11 true?")
print(wumpus_kb.ask_if_true(~P11))
print("IS P11 true?")
print(wumpus_kb.ask_if_true(P11))
print("IS ~P22 true?")
print(wumpus_kb.ask_if_true(~P22))
print("IS P22 true?")
print(wumpus_kb.ask_if_true(P22))

# Proof by Resolution
# Conversion to Conjunctive Normal form
def to_cnf(s):
    """Convert a propositional logical sentence to conjunctive normal form. That
    is, to the form ((A | ~B | ...) & (B | C | ...) & ...) [p. 253]
    >>> to_cnf('~(B | C)') (~B & ~C)
    """
    s = expr(s)
    if isinstance(s, str):
        s = expr(s)
    s = eliminate_implications(s)  # Steps 1,2
    s = move_not_inwards(s)        # Step 3
    return distribute_and_over_or(s)  # Step 4

def eliminate_implications(s):
    """Change implications into equivalent form with only &,|,and ~ as logical operators."""
    s = expr(s)
    if not s.args or is_symbol(s.op):
        return s  # Atoms are unchanged.
    args = list(map(eliminate_implications, s.args))
    a, b = args[0], args[-1]
    if s.op == '==>':
        return b | ~a
    elif s.op == '<==':
        return a | ~b
    elif s.op == '<=>':
        return (a | ~b) & (b | ~a)
    elif s.op == '^':
        assert len(args) == 2
        return (a & ~b) | (~a & b)
    else:
        assert s.op in ('&', '|', '~')
        return Expr(s.op, *args)

def move_not_inwards(s):
    """Rewrite sentence s by moving negation sign inward.
    >>> move_not_inwards(~(A | B)) (~A & ~B)
    """
    s = expr(s)
    if s.op == '~':
        def NOT(b):
            return move_not_inwards(~b)
        a = s.args[0]
        if a.op == '~':
            return move_not_inwards(a.args[0])  # ~~A ==> A
        if a.op == '&':
            return associate('|', list(map(NOT, a.args)))
        if a.op == '|':
            return associate('&', list(map(NOT, a.args)))
        return s
    elif is_symbol(s.op) or not s.args:
        return s
    else:
        return Expr(s.op, *list(map(move_not_inwards, s.args)))

def distribute_and_over_or(s):
    """Given a sentence s consisting of conjunctions and disjunctions of literals,
    return an equivalent sentence in CNF.
    >>> distribute_and_over_or((A & B) | C) ((A | C) & (B | C))
    """
    s = expr(s)
    if s.op == '|':
        s = associate('|', s.args)
        if s.op != '|':
            return distribute_and_over_or(s)
        if len(s.args) == 0:
            return False
        if len(s.args) == 1:
            return distribute_and_over_or(s.args[0])
        conj = first(arg for arg in s.args if arg.op == '&')
        if not conj:
            return s
        others = [a for a in s.args if a is not conj]
        rest = associate('|', others)
        return associate('&', [distribute_and_over_or(c | rest) for c in conj.args])
    elif s.op == '&':
        return associate('&', list(map(distribute_and_over_or, s.args)))
    else:
        return s

# Test some queries to check the working
print("Testing CNF conversion for some sentences:")
A, B, C, D = expr('A,B,C,D')
print("Convert A <=> B to CNF")
print(to_cnf(A | '<=>' | B))
print("Convert A <=> (B & C) to CNF")
print(to_cnf(A | '<=>' | (B & C)))

# Resolution of Problems
def pl_resolution(KB, alpha):
    """Propositional-logic resolution: say if alpha follows from KB. [Figure 7.12]"""
    clauses = KB.clauses + conjuncts(to_cnf(~alpha))
    new = set()
    while True:
        n = len(clauses)
        pairs = [(clauses[i], clauses[j]) for i in range(n) for j in range(i+1, n)]
        for (ci, cj) in pairs:
            resolvents = pl_resolve(ci, cj)
            if False in resolvents:
                return True
            new = new.union(set(resolvents))
        if new.issubset(set(clauses)):
            return False
        for c in new:
            if c not in clauses:
                clauses.append(c)

# Check a few Wumpus World queries for Resolution
print("Query: Given the Wumpus World Knowledge base, there is no pit in P11")
print(pl_resolution(wumpus_kb, ~P11))
print("Query: Given the Wumpus World Knowledge base, there is a pit in P11")
print(pl_resolution(wumpus_kb, P11))
print("Query: Given the Wumpus World Knowledge base, there is no pit in P22")
print(pl_resolution(wumpus_kb, ~P22))
print("Query: Given the Wumpus World Knowledge base, there is a pit in P22")
print(pl_resolution(wumpus_kb, P22))
