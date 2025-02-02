FUNC @main:
	main.var a, b
	push 1
	pop a
	push 0
	pop b
_begIf_1:
	push a
	push 5
	cmplt
	jz _elIf_1
	print "a < 5"
	jmp _endIf_1
_elIf_1:
	print "a >= 5"
_endIf_1:
_begWhile_1:
	push a
	push 5
	cmplt
	jz _endWhile_1
	push a
	push 1
	add
	pop a
	push b
	push 2
	add
	pop b
	jmp _begWhile_1
_endWhile_1:
	push b
	print "b=%d"
	push 0
	ret ~
ENDFUNC@main

