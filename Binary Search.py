def binarySearch (arr, start_index, end_index, search_element):
    if end_index >= start_index:
        mid = start_index + (end_index - start_index) // 2
        if arr[mid] == search_element:
            return mid
        elif arr[mid] > search_element:
            return binarySearch(arr, start_index, mid-1, search_element) 
        else:
            return binarySearch(arr, mid + 1, end_index, search_element)
    else:
        return -1
arr = [ 0, 1, 2, 3, 23 ]
search_element = 3

output = binarySearch(arr, 0, len(arr)-1, search_element)+1

if output != -1:
    print ("given element positionis % d" % output)
else:
    print ("Element does not exist in array")
    
