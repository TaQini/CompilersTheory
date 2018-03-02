mergesort: mergesort.s
	nasm -g -s mergesort.s -o mergesort.o -f elf32
	gcc -g -m32 mergesort.o -o mergesort
clean:
	rm -f *.o
	rm -f mergesort
