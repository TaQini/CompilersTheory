#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void Merge(int *tmp, int *a, int lena, int *d, int lend) {
	int pa,pd,pt;
	pa = 0; pd = 0; pt = 0;
	while( pa < lena && pd < lend) {
		if( a[pa] < d[pd]) tmp[pt++] = a[pa++];
		else tmp[pt++] = d[pd++];
	}
	while(pa < lena) tmp[pt++] = a[pa++];
	while(pd < lend) tmp[pt++] = d[pd++];
}

void MergeSort(int *l,int n) {
	int m, i, *a, *d;
	if(n < 2) return;
	m = n/2;
	a = (int*)malloc(m*sizeof(int));
	d = (int*)malloc((n - m)*sizeof(int));
	for(i = 0; i < m; i++) a[i] = l[i]; 
	for(i = m; i < n; i++) d[i-m] = l[i]; 
	MergeSort(a, m);
	MergeSort(d, n-m);
	Merge(l, a, m, d, n-m);
    free(a);
    free(d);
}

int main() {
	// input data
	FILE *fp;
	char *line = NULL;
	size_t len;
	int *l, n;
	int i = 0;
	n = 1000000;
	l = (int*)malloc(n*sizeof(int));
	fp = fopen("./raw.dat", "r");
	if (fp == NULL) exit(0);
	for(i = 0; getline(&line, &len, fp) != EOF; i++){
		l[i] = atoi(line);
	}
	fclose(fp);
	if(line) free(line);

	// get time
	clock_t begin, end;
	double last;
	begin = clock();

	MergeSort(l, n);

	end = clock();
	last = end - begin;
	last /= CLOCKS_PER_SEC;
	printf("cost: %fs\n", last);

	/*
	// output to file
	fp = fopen("./result.c.dat", "w+");
	if (fp == NULL) exit(0);
	char buf[4];
	for(i = 0; i < n; i++) {
		sprintf(buf, "%d\n", l[i]);
		fputs(buf, fp);
	}
	fclose(fp);
	*/
	return 0;
}
