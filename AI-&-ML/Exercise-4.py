# Keep the inputs in a input.txt file on the same folder

# -*- coding: utf-8 -*-
import time
import re
import itertools
import collections
import copy
import queue

start_time = time.time()

p = open("./input.txt", "r")
data1 = p.readlines()
n = int(data1[0])
queries = [data1[i].rstrip() for i in range(1, n + 1)]
k = int(data1[n + 1])
kbbefore = []

def CNF(sentence):
    temp = re.split("=>", sentence)
    temp1 = temp[0].split('&')
    for i in range(len(temp1)):
        if temp1[i][0] == '~':
            temp1[i] = temp1[i][1:]
        else:
            temp1[i] = '~' + temp1[i]
    return '|'.join(temp1) + '|' + temp[1]

variableArray = list("abcdefghijklmnopqrstuvwxyz")
variableArray2, variableArray3, variableArray5, variableArray6 = [], [], [], []

for each in itertools.permutations(variableArray, 2):
    variableArray2.append(''.join(each))
for each in itertools.permutations(variableArray, 3):
    variableArray3.append(''.join(each))
for each in itertools.permutations(variableArray, 4):
    variableArray5.append(''.join(each))
for each in itertools.permutations(variableArray, 5):
    variableArray6.append(''.join(each))

variableArray += variableArray2 + variableArray3 + variableArray5 + variableArray6
capitalVariables = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
number = 0

def standardizationnew(sentence):
    newsentence = list(sentence)
    global number
    variables = collections.OrderedDict()
    for i in range(len(sentence) - 1):
        if newsentence[i] in (',', '('):
            if newsentence[i + 1] not in capitalVariables:
                substitution = variables.get(newsentence[i + 1])
                if not substitution:
                    variables[newsentence[i + 1]] = variableArray[number]
                    newsentence[i + 1] = variableArray[number]
                    number += 1
                else:
                    newsentence[i + 1] = substitution
    return "".join(newsentence)

def insidestandardizationnew(sentence):
    newsentence = sentence
    variables = collections.OrderedDict()
    global number
    i = 0
    while i < len(newsentence):
        if newsentence[i] in (',', '('):
            if newsentence[i + 1] not in capitalVariables:
                j = i + 1
                while newsentence[j] not in (',', ')'):
                    j += 1
                substitution = variables.get(newsentence[i + 1:j])
                if not substitution:
                    variables[newsentence[i + 1:j]] = variableArray[number]
                    newsentence = newsentence[:i + 1] + variableArray[number] + newsentence[j:]
                    i += len(variableArray[number])
                    number += 1
                else:
                    newsentence = newsentence[:i + 1] + substitution + newsentence[j:]
                    i += len(substitution)
        i += 1
    return newsentence

def replace(sentence, theta):
    newsentence = sentence
    i = 0
    while i < len(newsentence):
        if newsentence[i] in (',', '('):
            if newsentence[i + 1] not in capitalVariables:
                j = i + 1
                while newsentence[j] not in (',', ')'):
                    j += 1
                nstemp = newsentence[i + 1:j]
                substitution = theta.get(nstemp)
                if substitution:
                    newsentence = newsentence[:i + 1] + substitution + newsentence[j:]
                    i += len(substitution)
        i += 1
    return newsentence

repeatedsentencecheck = collections.OrderedDict()

def insidekbcheck(sentence):
    newsentence = pattern.split(sentence)
    newsentence.sort()
    newsentence = "|".join(newsentence)
    global repeatedsentencecheck
    i = 0
    while i < len(newsentence):
        if newsentence[i] in (',', '('):
            if newsentence[i + 1] not in capitalVariables:
                j = i + 1
                while newsentence[j] not in (',', ')'):
                    j += 1
                newsentence = newsentence[:i + 1] + 'x' + newsentence[j:]
        i += 1
    if repeatedsentencecheck.get(newsentence):
        return True
    repeatedsentencecheck[newsentence] = 1
    return False

for i in range(n + 2, n + 2 + k):
    data1[i] = data1[i].replace(" ", "")
    if "=>" in data1[i]:
        sentencetemp = CNF(data1[i].rstrip())
        kbbefore.append(sentencetemp)
    else:
        kbbefore.append(data1[i].rstrip())

for i in range(k):
    kbbefore[i] = kbbefore[i].replace(" ", "")

kb = {}
pattern = re.compile(r"\||&|=>")
pattern1 = re.compile(r"[(,]")

for i in range(k):
    kbbefore[i] = standardizationnew(kbbefore[i])
    temp = pattern.split(kbbefore[i])
    for j, clause in enumerate(temp):
        clause = clause[:-1]
        predicate = pattern1.split(clause)
        argumentlist = predicate[1:]
        lengthofpredicate = len(predicate) - 1
        if predicate[0] in kb:
            if lengthofpredicate in kb[predicate[0]]:
                kb[predicate[0]][lengthofpredicate].append([kbbefore[i], temp, j, argumentlist])
            else:
                kb[predicate[0]][lengthofpredicate] = [[kbbefore[i], temp, j, argumentlist]]
        else:
            kb[predicate[0]] = {lengthofpredicate: [[kbbefore[i], temp, j, argumentlist]]}

for qi in range(n):
    queries[qi] = standardizationnew(queries[qi])

def substituevalue(paramArray, x, y):
    for index, eachVal in enumerate(paramArray):
        if eachVal == x:
            paramArray[index] = y
    return paramArray

def unificiation(arglist1, arglist2):
    theta = collections.OrderedDict()
    for i in range(len(arglist1)):
        if arglist1[i] != arglist2[i] and arglist1[i][0] in capitalVariables and arglist2[i][0] in capitalVariables:
            return []
        elif arglist1[i] == arglist2[i] and arglist1[i][0] in capitalVariables and arglist2[i][0] in capitalVariables:
            if arglist1[i] not in theta:
                theta[arglist1[i]] = arglist2[i]
        elif arglist1[i][0] in capitalVariables and not arglist2[i][0] in capitalVariables:
            if arglist2[i] not in theta:
                theta[arglist2[i]] = arglist1[i]
            arglist2 = substituevalue(arglist2, arglist2[i], arglist1[i])
        elif not arglist1[i][0] in capitalVariables and arglist2[i][0] in capitalVariables:
            if arglist1[i] not in theta:
                theta[arglist1[i]] = arglist2[i]
            arglist1 = substituevalue(arglist1, arglist1[i], arglist2[i])
        elif not arglist1[i][0] in capitalVariables and not arglist2[i][0] in capitalVariables:
            if arglist1[i] not in theta:
                theta[arglist1[i]] = arglist2[i]
            arglist1 = substituevalue(arglist1, arglist1[i], arglist2[i])
        else:
            argval = theta[arglist1[i]]
            theta[arglist2[i]] = argval
            arglist2 = substituevalue(arglist2, arglist2[i], argval)
    return [arglist1, arglist2, theta]

def resolution():
    global repeatedsentencecheck
    answer = []
    qrno = 0
    for qr in queries:
        qrno += 1
        repeatedsentencecheck.clear()
        q = queue.Queue()
        query_start = time.time()
        kbquery = copy.deepcopy(kb)
        ans = qr
        if qr[0] == '~':
            ans = qr[1:]
        else:
            ans = '~' + qr
        q.put(ans)
        currentanswer = "FALSE"
        counter = 0
        while True:
            counter += 1
            if q.empty():
                break
            ans = q.get()
            ansclauses = pattern.split(ans)
            flagmatchedwithkb = 0
            for ac in range(len(ansclauses)):
                ansclause = ansclauses[ac][:-1]
                ansclausespredicate = pattern1.split(ansclause)
                lenansclausespredicate = len(ansclausespredicate) - 1
                if ansclausespredicate[0][0] == '~':
                    anspredicatenegated = ansclausespredicate[0][1:]
                else:
                    anspredicatenegated = '~' + ansclausespredicate[0]

                x = kbquery.get(anspredicatenegated, {}).get(lenansclausespredicate)
                if not x:
                    continue

                for sentenceselected in x:
                    thetalist = unificiation(copy.deepcopy(sentenceselected[3]), copy.deepcopy(ansclausespredicate[1:]))
                    if thetalist:
                        for key in thetalist[2]:
                            tl = thetalist[2][key]
                            tl2 = thetalist[2].get(tl)
                            if tl2:
                                thetalist[2][key] = tl2

                        flagmatchedwithkb = 1
                        notincludedindex = sentenceselected[2]
                        senclause = copy.deepcopy(sentenceselected[1])
                        del senclause[notincludedindex]
                        ansclauseleft = copy.deepcopy(ansclauses)
                        del ansclauseleft[ac]

                        mergepart1 = ""
                        for am in range(len(senclause)):
                            senclause[am] = replace(senclause[am], thetalist[2])
                            mergepart1 += senclause[am] + '|'
                        for remain in range(len(ansclauseleft)):
                            listansclauseleft = ansclauseleft[remain]
                            ansclauseleft[remain] = replace(listansclauseleft, thetalist[2])
                            if ansclauseleft[remain] not in senclause:
                                mergepart1 += ansclauseleft[remain] + '|'

                        mergepart1 = mergepart1[:-1]
                        if mergepart1 == "":
                            currentanswer = "TRUE"
                            break
                        if not insidekbcheck(mergepart1):
                            mergepart1 = insidestandardizationnew(mergepart1)
                            ans = mergepart1
                            temp = pattern.split(ans)
                            for j in range(len(temp)):
                                clause = temp[j][:-1]
                                predicate = pattern1.split(clause)
                                argumentlist = predicate[1:]
                                lengthofpredicate = len(predicate) - 1
                                if predicate[0] in kbquery:
                                    if lengthofpredicate in kbquery[predicate[0]]:
                                        kbquery[predicate[0]][lengthofpredicate].append([mergepart1, temp, j, argumentlist])
                                    else:
                                        kbquery[predicate[0]][lengthofpredicate] = [[mergepart1, temp, j, argumentlist]]
                                else:
                                    kbquery[predicate[0]] = {lengthofpredicate: [[mergepart1, temp, j, argumentlist]]}
                            q.put(ans)
            if currentanswer == "TRUE":
                break
            if counter == 2000 or (time.time() - query_start) > 20:
                break
        answer.append(currentanswer)
    return answer

if __name__ == "__main__":
    finalanswer = resolution()
    o = open("output.txt", "w+")
    for wc in range(n - 1):
        o.write(finalanswer[wc] + "\n")
        print(finalanswer[wc])
    o.write(finalanswer[n - 1])
    o.close()
