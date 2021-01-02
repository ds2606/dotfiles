""" buggy, for testing pdb (and .pdbrc imports) """
import IPython as ipy


def bubble_sort(arr):
    n = len(arr)
    for _ in range(n - 1):
        for j in range(n - 1):
            ipy.embed()
            if arr[j] > arr[j + 1]:
                arr[j], arr[j + 1] = arr[j + 1], arr[j]
    return arr


print(bubble_sort([4, 2, 1, 8, 7, 6]))
