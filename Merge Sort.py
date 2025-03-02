def mergesort(arr, lhs, rhs):
    if lhs>= rhs:
        return
    mid = (lhs + rhs)//2
    mergesort(arr, lhs, mid)
    mergesort(arr, mid + 1, rhs)
    merge(arr, lhs, rhs, mid)

def merge(arr, lhs, rhs, mid):
    lhscopy = arr[lhs:mid + 1]
    rhscopy = arr[mid+1:rhs+1]
    lhscopyindex = 0
    rhscopyindex = 0
    sorted_index = lhs
    
    while lhscopyindex<len(lhscopy) and rhscopyindex<len(rhscopy):
        if lhscopy[lhscopyindex] <= rhscopy[rhscopyindex]:
            arr[sorted_index] = lhscopy[lhscopyindex]
            lhscopyindex += 1
        else:
            arr[sorted_index] = rhscopy[rhscopyindex]
            rhscopyindex += 1
        sorted_index += 1
        
    while lhscopyindex<len(lhscopy):
        arr[sorted_index] = lhscopy[lhscopyindex]
        lhscopyindex += 1
        sorted_index += 1
        
    while rhscopyindex<len(rhscopy):
        arr[sorted_index] = rhscopy[rhscopyindex]
        rhscopyindex += 1
        sorted_index += 1
        
arr = [33, 42, 9, 8, 47, 29, 16]
print("Initial array",arr)
mergesort(arr, 0, len(arr) -1)
print("Sorted array",arr)
