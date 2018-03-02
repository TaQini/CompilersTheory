extern malloc, fopen, getline, atoi, fclose, free, clock, exit, printf

global main

section .data
	fileName db "./raw.dat",0
	ar db "r",0
	afmt db "cost: %ldns\n",0
	aclock dq 1000000

section .text

Merge:
	push   ebp
	mov    ebp,esp
	sub    esp,0x10
	mov    DWORD [ebp-0xc],0x0
	mov    DWORD [ebp-0x8],0x0
	mov    DWORD [ebp-0x4],0x0
	jmp    Merge_a6
Merge_20:
	mov    eax,DWORD [ebp-0xc]
	lea    edx,[eax*4+0x0]
	mov    eax,DWORD [ebp+0xc]
	add    eax,edx
	mov    edx,DWORD [eax]
	mov    eax,DWORD [ebp-0x8]
	lea    ecx,[eax*4+0x0]
	mov    eax,DWORD [ebp+0x14]
	add    eax,ecx
	mov    eax,DWORD [eax]
	cmp    edx,eax
	jge    Merge_77
	mov    eax,DWORD [ebp-0x4]
	lea    edx,[eax+0x1]
	mov    DWORD [ebp-0x4],edx
	lea    edx,[eax*4+0x0]
	mov    eax,DWORD [ebp+0x8]
	lea    ecx,[edx+eax*1]
	mov    eax,DWORD [ebp-0xc]
	lea    edx,[eax+0x1]
	mov    DWORD [ebp-0xc],edx
	lea    edx,[eax*4+0x0]
	mov    eax,DWORD [ebp+0xc]
	add    eax,edx
	mov    eax,DWORD [eax]
	mov    DWORD [ecx],eax
	jmp    Merge_a6
Merge_77:
	mov    eax,DWORD [ebp-0x4]
	lea    edx,[eax+0x1]
	mov    DWORD [ebp-0x4],edx
	lea    edx,[eax*4+0x0]
	mov    eax,DWORD [ebp+0x8]
	lea    ecx,[edx+eax*1]
	mov    eax,DWORD [ebp-0x8]
	lea    edx,[eax+0x1]
	mov    DWORD [ebp-0x8],edx
	lea    edx,[eax*4+0x0]
	mov    eax,DWORD [ebp+0x14]
	add    eax,edx
	mov    eax,DWORD [eax]
	mov    DWORD [ecx],eax
Merge_a6:
	mov    eax,DWORD [ebp-0xc]
	cmp    eax,DWORD [ebp+0x10]
	jge    Merge_ba
	mov    eax,DWORD [ebp-0x8]
	cmp    eax,DWORD [ebp+0x18]
	jl     Merge_20
Merge_ba:
	jmp    Merge_eb
Merge_bc:
	mov    eax,DWORD [ebp-0x4]
	lea    edx,[eax+0x1]
	mov    DWORD [ebp-0x4],edx
	lea    edx,[eax*4+0x0]
	mov    eax,DWORD [ebp+0x8]
	lea    ecx,[edx+eax*1]
	mov    eax,DWORD [ebp-0xc]
	lea    edx,[eax+0x1]
	mov    DWORD [ebp-0xc],edx
	lea    edx,[eax*4+0x0]
	mov    eax,DWORD [ebp+0xc]
	add    eax,edx
	mov    eax,DWORD [eax]
	mov    DWORD [ecx],eax
Merge_eb:
	mov    eax,DWORD [ebp-0xc]
	cmp    eax,DWORD [ebp+0x10]
	jl     Merge_bc
	jmp    Merge_124
Merge_f5:
	mov    eax,DWORD [ebp-0x4]
	lea    edx,[eax+0x1]
	mov    DWORD [ebp-0x4],edx
	lea    edx,[eax*4+0x0]
	mov    eax,DWORD [ebp+0x8]
	lea    ecx,[edx+eax*1]
	mov    eax,DWORD [ebp-0x8]
	lea    edx,[eax+0x1]
	mov    DWORD [ebp-0x8],edx
	lea    edx,[eax*4+0x0]
	mov    eax,DWORD [ebp+0x14]
	add    eax,edx
	mov    eax,DWORD [eax]
	mov    DWORD [ecx],eax
Merge_124:
	mov    eax,DWORD [ebp-0x8]
	cmp    eax,DWORD [ebp+0x18]
	jl     Merge_f5
	leave  
	ret    

MergeSort:
	push   ebp
	mov    ebp,esp
	sub    esp,0x38
	cmp    DWORD [ebp+0xc],0x1
	jg     MergeSort_11
	jmp    MergeSort_12c
MergeSort_11:
	mov    eax,DWORD [ebp+0xc]
	mov    edx,eax
	shr    edx,0x1f
	add    eax,edx
	sar    eax,1
	mov    DWORD [ebp-0x14],eax
	mov    eax,DWORD [ebp-0x14]
	shl    eax,0x2
	mov    DWORD [esp],eax
	call   malloc
	mov    DWORD [ebp-0x10],eax
	mov    eax,DWORD [ebp-0x14]
	mov    edx,DWORD [ebp+0xc]
	sub    edx,eax
	mov    eax,edx
	shl    eax,0x2
	mov    DWORD [esp],eax
	call   malloc
	mov    DWORD [ebp-0xc],eax
	mov    DWORD [ebp-0x18],0x0
	jmp    MergeSort_78
MergeSort_52:
	mov    eax,DWORD [ebp-0x18]
	lea    edx,[eax*4+0x0]
	mov    eax,DWORD [ebp-0x10]
	add    edx,eax
	mov    eax,DWORD [ebp-0x18]
	lea    ecx,[eax*4+0x0]
	mov    eax,DWORD [ebp+0x8]
	add    eax,ecx
	mov    eax,DWORD [eax]
	mov    DWORD [edx],eax
	add    DWORD [ebp-0x18],0x1
MergeSort_78:
	mov    eax,DWORD [ebp-0x18]
	cmp    eax,DWORD [ebp-0x14]
	jl     MergeSort_52
	mov    eax,DWORD [ebp-0x14]
	mov    DWORD [ebp-0x18],eax
	jmp    MergeSort_b5
MergeSort_88:
	mov    eax,DWORD [ebp-0x14]
	mov    edx,DWORD [ebp-0x18]
	sub    edx,eax
	mov    eax,edx
	lea    edx,[eax*4+0x0]
	mov    eax,DWORD [ebp-0xc]
	add    edx,eax
	mov    eax,DWORD [ebp-0x18]
	lea    ecx,[eax*4+0x0]
	mov    eax,DWORD [ebp+0x8]
	add    eax,ecx
	mov    eax,DWORD [eax]
	mov    DWORD [edx],eax
	add    DWORD [ebp-0x18],0x1
MergeSort_b5:
	mov    eax,DWORD [ebp-0x18]
	cmp    eax,DWORD [ebp+0xc]
	jl     MergeSort_88
	mov    eax,DWORD [ebp-0x14]
	mov    DWORD [esp+0x4],eax
	mov    eax,DWORD [ebp-0x10]
	mov    DWORD [esp],eax
	call   MergeSort
	mov    eax,DWORD [ebp-0x14]
	mov    edx,DWORD [ebp+0xc]
	sub    edx,eax
	mov    eax,edx
	mov    DWORD [esp+0x4],eax
	mov    eax,DWORD [ebp-0xc]
	mov    DWORD [esp],eax
	call   MergeSort
	mov    eax,DWORD [ebp-0x14]
	mov    edx,DWORD [ebp+0xc]
	sub    edx,eax
	mov    eax,edx
	mov    DWORD [esp+0x10],eax
	mov    eax,DWORD [ebp-0xc]
	mov    DWORD [esp+0xc],eax
	mov    eax,DWORD [ebp-0x14]
	mov    DWORD [esp+0x8],eax
	mov    eax,DWORD [ebp-0x10]
	mov    DWORD [esp+0x4],eax
	mov    eax,DWORD [ebp+0x8]
	mov    DWORD [esp],eax
	call   Merge
	mov    eax,DWORD [ebp-0x10]
	mov    DWORD [esp],eax
	call   free
	mov    eax,DWORD [ebp-0xc]
	mov    DWORD [esp],eax
	call   free
MergeSort_12c:
	leave  
	ret    

main:
	push   ebp
	mov    ebp,esp
	push   ebx
	and    esp,0xfffffff0
	sub    esp,0x40
	mov    DWORD [esp+0x18],0x0
	mov    DWORD [esp+0x20],0x0
	mov    DWORD [esp+0x24],0xf4240
	mov    eax,DWORD [esp+0x24]
	shl    eax,0x2
	mov    DWORD [esp],eax
	call   malloc
	mov    DWORD [esp+0x28],eax
	mov    DWORD [esp+0x4], ar
	mov    DWORD [esp],fileName
	call   fopen
	mov    DWORD [esp+0x2c],eax
	cmp    DWORD [esp+0x2c],0x0
	jne    main_60
	mov    DWORD [esp],0x0
	call   exit
main_60:	mov    DWORD [esp+0x20],0x0
	jmp    main_8f
main_6a:	mov    eax,DWORD [esp+0x20]
	lea    edx,[eax*4+0x0]
	mov    eax,DWORD [esp+0x28]
	lea    ebx,[edx+eax*1]
	mov    eax,DWORD [esp+0x18]
	mov    DWORD [esp],eax
	call   atoi
	mov    DWORD [ebx],eax
	add    DWORD [esp+0x20],0x1
main_8f:	mov    eax,DWORD [esp+0x2c]
	mov    DWORD [esp+0x8],eax
	lea    eax,[esp+0x1c]
	mov    DWORD [esp+0x4],eax
	lea    eax,[esp+0x18]
	mov    DWORD [esp],eax
	call   getline
	cmp    eax,0xffffffff
	jne    main_6a
	mov    eax,DWORD [esp+0x2c]
	mov    DWORD [esp],eax
	call   fclose
	mov    eax,DWORD [esp+0x18]
	test   eax,eax
	je     main_d0
	mov    eax,DWORD [esp+0x18]
	mov    DWORD [esp],eax
	call   free
main_d0:	
	call   clock
	mov    DWORD [esp+0x30],eax
	mov    eax,DWORD [esp+0x24]
	mov    DWORD [esp+0x4],eax
	mov    eax,DWORD [esp+0x28]
	mov    DWORD [esp],eax
	call   MergeSort
	call   clock
	mov    DWORD [esp+0x34],eax
	mov    eax,DWORD [esp+0x30]
	mov    edx,DWORD [esp+0x34]
	sub    edx,eax
	mov    eax,edx
	mov    DWORD [esp+0x4],eax
	mov    DWORD [esp],afmt
	call   printf
	mov    eax,0x0
	mov    ebx,DWORD [ebp-0x4]
	leave  
	ret