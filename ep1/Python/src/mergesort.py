#!/usr/bin/python
__author__ = 'TaQini'

def Merge(a,d):
	tmp = []
	pa = pd = 0
	while pa < len(a) and pd < len(d):
		if a[pa] < d[pd]:
			tmp.append(a[pa])
			pa += 1
		else:
			tmp.append(d[pd])
			pd += 1
	while pa < len(a):
			tmp.append(a[pa])
			pa += 1
	while pd < len(d):
			tmp.append(d[pd])
			pd += 1
	return tmp

def MergeSort(l):
	if len(l) < 2:
		return l
	else:
		m = len(l)/2
		a = MergeSort(l[:m])
		d = MergeSort(l[m:])
		return Merge(a,d)

# input data
f = open('./raw.dat','ro')
data = f.readlines()
f.close()
l = [int(i) for i in data]

from time import time
begin = time()
result = MergeSort(l)
end = time()
last = end - begin
print 'cost: ' + str(last) + 's'

''' 
# output to file
p = [str(i)+'\n' for i in result]
f = open('./result.py.dat','w+')
f.writelines(p)
f.close()
'''
