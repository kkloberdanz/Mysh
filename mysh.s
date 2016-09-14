	.file	"mysh.c"
	.text
	.globl	replace_tabs
	.type	replace_tabs, @function
replace_tabs:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	strlen
	movl	%eax, -8(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L2
.L4:
	call	__ctype_b_loc
	movq	(%rax), %rax
	movl	-4(%rbp), %edx
	movslq	%edx, %rcx
	movq	-24(%rbp), %rdx
	addq	%rcx, %rdx
	movzbl	(%rdx), %edx
	movsbq	%dl, %rdx
	addq	%rdx, %rdx
	addq	%rdx, %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	andl	$8192, %eax
	testl	%eax, %eax
	je	.L3
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movb	$32, (%rax)
.L3:
	addl	$1, -4(%rbp)
.L2:
	movl	-4(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jl	.L4
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	replace_tabs, .-replace_tabs
	.globl	trim
	.type	trim, @function
trim:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	cmpq	$0, -24(%rbp)
	je	.L14
	movq	-24(%rbp), %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	strlen
	movl	%eax, -12(%rbp)
	jmp	.L8
.L10:
	subl	$1, -12(%rbp)
	movl	-12(%rbp), %eax
	movslq	%eax, %rdx
	movq	-8(%rbp), %rax
	addq	%rdx, %rax
	movb	$0, (%rax)
.L8:
	movl	-12(%rbp), %eax
	subl	$1, %eax
	testl	%eax, %eax
	jle	.L11
	call	__ctype_b_loc
	movq	(%rax), %rax
	movl	-12(%rbp), %edx
	movslq	%edx, %rdx
	leaq	-1(%rdx), %rcx
	movq	-8(%rbp), %rdx
	addq	%rcx, %rdx
	movzbl	(%rdx), %edx
	movsbq	%dl, %rdx
	addq	%rdx, %rdx
	addq	%rdx, %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	andl	$8192, %eax
	testl	%eax, %eax
	jne	.L10
	jmp	.L11
.L13:
	addq	$1, -8(%rbp)
	subl	$1, -12(%rbp)
.L11:
	movq	-8(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	je	.L12
	call	__ctype_b_loc
	movq	(%rax), %rdx
	movq	-8(%rbp), %rax
	movzbl	(%rax), %eax
	movsbq	%al, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	andl	$8192, %eax
	testl	%eax, %eax
	jne	.L13
.L12:
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movslq	%eax, %rdx
	movq	-8(%rbp), %rcx
	movq	-24(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	memmove
	jmp	.L5
.L14:
	nop
.L5:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	trim, .-trim
	.globl	remove_extra_spaces
	.type	remove_extra_spaces, @function
remove_extra_spaces:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	strlen
	movl	%eax, -16(%rbp)
	cmpl	$3, -16(%rbp)
	jle	.L23
	movl	$1, -4(%rbp)
	movl	$1, -8(%rbp)
	movl	$1, -12(%rbp)
	jmp	.L18
.L22:
	movl	-12(%rbp), %eax
	cltq
	leaq	-1(%rax), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$32, %al
	jne	.L19
	movl	-12(%rbp), %eax
	movslq	%eax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$32, %al
	jne	.L19
	movl	$0, -4(%rbp)
.L19:
	movl	-12(%rbp), %eax
	movslq	%eax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$32, %al
	je	.L20
	movl	$1, -4(%rbp)
.L20:
	cmpl	$0, -4(%rbp)
	je	.L21
	movl	-8(%rbp), %eax
	movslq	%eax, %rdx
	movq	-24(%rbp), %rax
	addq	%rax, %rdx
	movl	-12(%rbp), %eax
	movslq	%eax, %rcx
	movq	-24(%rbp), %rax
	addq	%rcx, %rax
	movzbl	(%rax), %eax
	movb	%al, (%rdx)
	addl	$1, -8(%rbp)
.L21:
	addl	$1, -12(%rbp)
.L18:
	movl	-12(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jl	.L22
	movl	-8(%rbp), %eax
	movslq	%eax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movb	$0, (%rax)
	jmp	.L15
.L23:
	nop
.L15:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	remove_extra_spaces, .-remove_extra_spaces
	.section	.rodata
.LC0:
	.string	" "
.LC1:
	.string	"python "
.LC2:
	.string	".py"
	.text
	.globl	update_if_script
	.type	update_if_script, @function
update_if_script:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$560, %rsp
	movq	%rdi, -552(%rbp)
	movq	-552(%rbp), %rax
	movl	$.LC0, %esi
	movq	%rax, %rdi
	call	strcspn
	movl	%eax, -4(%rbp)
	movq	$.LC1, -16(%rbp)
	cmpl	$3, -4(%rbp)
	jle	.L26
	movl	-4(%rbp), %eax
	cltq
	leaq	-3(%rax), %rdx
	movq	-552(%rbp), %rax
	addq	%rdx, %rax
	movl	$3, %edx
	movl	$.LC2, %esi
	movq	%rax, %rdi
	call	strncmp
	testl	%eax, %eax
	jne	.L26
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	strlen
	movq	%rax, %rdx
	movq	-16(%rbp), %rcx
	movq	-552(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	strncmp
	testl	%eax, %eax
	je	.L26
	movq	-552(%rbp), %rdx
	leaq	-544(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcpy
	movq	-16(%rbp), %rdx
	movq	-552(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcpy
	movq	-552(%rbp), %rax
	movq	%rax, %rdi
	call	strlen
	movq	%rax, %rdx
	movq	-552(%rbp), %rax
	addq	%rax, %rdx
	leaq	-544(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	strcpy
.L26:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	update_if_script, .-update_if_script
	.globl	is_redirect
	.type	is_redirect, @function
is_redirect:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	strlen
	movl	%eax, -12(%rbp)
	movl	$-1, -4(%rbp)
	movl	$0, -8(%rbp)
	jmp	.L28
.L31:
	movl	-8(%rbp), %eax
	movslq	%eax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$62, %al
	jne	.L29
	movl	-8(%rbp), %eax
	movl	%eax, -4(%rbp)
	movl	-8(%rbp), %eax
	movslq	%eax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movb	$32, (%rax)
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	remove_extra_spaces
	jmp	.L30
.L29:
	addl	$1, -8(%rbp)
.L28:
	movl	-8(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jl	.L31
.L30:
	cmpl	$-1, -4(%rbp)
	setne	%al
	movzbl	%al, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	is_redirect, .-is_redirect
	.globl	parse_cli
	.type	parse_cli, @function
parse_cli:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movq	%rcx, -48(%rbp)
	movq	%r8, -56(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	strlen
	movl	%eax, -12(%rbp)
	cmpl	$1, -12(%rbp)
	jle	.L34
	movl	-12(%rbp), %eax
	cltq
	leaq	-1(%rax), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$38, %al
	jne	.L34
	movl	$1, %edx
	jmp	.L35
.L34:
	movl	$0, %edx
.L35:
	movq	-56(%rbp), %rax
	movl	%edx, (%rax)
	movq	-56(%rbp), %rax
	movl	(%rax), %eax
	testl	%eax, %eax
	je	.L36
	movl	-12(%rbp), %eax
	cltq
	leaq	-2(%rax), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	cmpb	$32, %al
	jne	.L37
	movl	-12(%rbp), %eax
	cltq
	leaq	-2(%rax), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movb	$0, (%rax)
	jmp	.L36
.L37:
	movl	-12(%rbp), %eax
	cltq
	leaq	-1(%rax), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movb	$0, (%rax)
.L36:
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	is_redirect
	movl	%eax, -16(%rbp)
	movq	-32(%rbp), %rax
	movl	$0, (%rax)
	movq	-24(%rbp), %rax
	movl	$.LC0, %esi
	movq	%rax, %rdi
	call	strtok
	movq	%rax, -8(%rbp)
	jmp	.L38
.L40:
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	leal	1(%rax), %ecx
	movq	-32(%rbp), %rdx
	movl	%ecx, (%rdx)
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-40(%rbp), %rax
	addq	%rax, %rdx
	movq	-8(%rbp), %rax
	movq	%rax, (%rdx)
	movl	$.LC0, %esi
	movl	$0, %edi
	call	strtok
	movq	%rax, -8(%rbp)
.L38:
	cmpq	$0, -8(%rbp)
	je	.L39
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	cmpl	$62, %eax
	jle	.L40
.L39:
	cmpl	$0, -16(%rbp)
	je	.L41
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	cltq
	salq	$3, %rax
	leaq	-8(%rax), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rdx
	movq	-48(%rbp), %rax
	movq	%rdx, (%rax)
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	leal	-1(%rax), %edx
	movq	-32(%rbp), %rax
	movl	%edx, (%rax)
.L41:
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movq	$0, (%rax)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	parse_cli, .-parse_cli
	.section	.rodata
.LC3:
	.string	"r"
.LC4:
	.string	"mysh> "
.LC5:
	.string	"%s"
.LC6:
	.string	"\n"
.LC7:
	.string	"exit"
.LC8:
	.string	"pwd"
.LC9:
	.string	"cd"
.LC10:
	.string	"wait"
	.text
	.globl	main
	.type	main, @function
main:
.LFB8:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$2160, %rsp
	movl	%edi, -2148(%rbp)
	movq	%rsi, -2160(%rbp)
	movabsq	$8245935278387129921, %rax
	movq	%rax, -576(%rbp)
	movabsq	$7161690017614620704, %rax
	movq	%rax, -568(%rbp)
	movabsq	$11426315006581, %rax
	movq	%rax, -560(%rbp)
	movl	$0, -552(%rbp)
	movw	$0, -548(%rbp)
	movq	$0, -8(%rbp)
	cmpl	$2, -2148(%rbp)
	jne	.L43
	movq	-2160(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movl	$.LC3, %esi
	movq	%rax, %rdi
	call	fopen
	movq	%rax, -8(%rbp)
	cmpq	$0, -8(%rbp)
	jne	.L43
	leaq	-576(%rbp), %rax
	movq	%rax, %rdi
	call	strlen
	movq	%rax, %rdx
	leaq	-576(%rbp), %rax
	movq	%rax, %rsi
	movl	$2, %edi
	call	write
	movl	$-1, %edi
	call	exit
.L43:
	movq	$0, -592(%rbp)
	movl	$0, -596(%rbp)
	cmpq	$0, -8(%rbp)
	jne	.L44
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movq	stdin(%rip), %rdx
	leaq	-544(%rbp), %rax
	movl	$512, %esi
	movq	%rax, %rdi
	call	fgets
	jmp	.L45
.L44:
	movq	-8(%rbp), %rdx
	leaq	-544(%rbp), %rax
	movl	$512, %esi
	movq	%rax, %rdi
	call	fgets
	testq	%rax, %rax
	jne	.L46
	movl	$0, %edi
	call	exit
.L46:
	leaq	-544(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC5, %edi
	movl	$0, %eax
	call	printf
.L45:
	leaq	-544(%rbp), %rax
	movl	$.LC6, %esi
	movq	%rax, %rdi
	call	strcspn
	movb	$0, -544(%rbp,%rax)
	leaq	-544(%rbp), %rax
	movq	%rax, %rdi
	call	replace_tabs
	leaq	-544(%rbp), %rax
	movq	%rax, %rdi
	call	trim
	leaq	-544(%rbp), %rax
	movq	%rax, %rdi
	call	remove_extra_spaces
	leaq	-544(%rbp), %rax
	movq	%rax, %rdi
	call	update_if_script
	leaq	-580(%rbp), %rdi
	leaq	-592(%rbp), %rcx
	leaq	-2144(%rbp), %rdx
	leaq	-596(%rbp), %rsi
	leaq	-544(%rbp), %rax
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	parse_cli
	movq	-592(%rbp), %rax
	testq	%rax, %rax
	je	.L47
	movq	-592(%rbp), %rax
	movl	$438, %edx
	movl	$578, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	open
	movl	%eax, -12(%rbp)
	cmpl	$-1, -12(%rbp)
	jne	.L48
	leaq	-576(%rbp), %rax
	movq	%rax, %rdi
	call	strlen
	movq	%rax, %rdx
	leaq	-576(%rbp), %rax
	movq	%rax, %rsi
	movl	$2, %edi
	call	write
	movq	$0, -592(%rbp)
	jmp	.L61
.L48:
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fileno
	movl	%eax, %edi
	call	dup
	movl	%eax, -16(%rbp)
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fileno
	movl	%eax, %edx
	movl	-12(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	dup2
	cmpl	$-1, %eax
	jne	.L47
	leaq	-576(%rbp), %rax
	movq	%rax, %rdi
	call	strlen
	movq	%rax, %rdx
	leaq	-576(%rbp), %rax
	movq	%rax, %rsi
	movl	$2, %edi
	call	write
	movq	$0, -592(%rbp)
	jmp	.L61
.L47:
	movl	-596(%rbp), %eax
	testl	%eax, %eax
	jle	.L50
	movq	-2144(%rbp), %rax
	movl	$.LC7, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L51
	movl	$0, %edi
	call	exit
.L51:
	movq	-2144(%rbp), %rax
	movl	$.LC8, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L52
	leaq	-1632(%rbp), %rax
	movl	$1024, %esi
	movq	%rax, %rdi
	call	getcwd
	testq	%rax, %rax
	je	.L53
	leaq	-1632(%rbp), %rax
	movq	%rax, %rdi
	call	puts
	jmp	.L50
.L53:
	leaq	-576(%rbp), %rax
	movq	%rax, %rdi
	call	strlen
	movq	%rax, %rdx
	leaq	-576(%rbp), %rax
	movq	%rax, %rsi
	movl	$2, %edi
	call	write
	jmp	.L50
.L52:
	movq	-2144(%rbp), %rax
	movl	$.LC9, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L55
	movl	-596(%rbp), %eax
	cmpl	$2, %eax
	jne	.L56
	movq	-2136(%rbp), %rax
	movq	%rax, %rdi
	call	chdir
	testl	%eax, %eax
	je	.L50
.L56:
	leaq	-576(%rbp), %rax
	movq	%rax, %rdi
	call	strlen
	movq	%rax, %rdx
	leaq	-576(%rbp), %rax
	movq	%rax, %rsi
	movl	$2, %edi
	call	write
	jmp	.L50
.L55:
	movq	-2144(%rbp), %rax
	movl	$.LC10, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L58
	movl	$0, %eax
	movq	%rax, %rdi
	call	wait
	jmp	.L50
.L58:
	call	fork
	movl	%eax, -20(%rbp)
	cmpl	$0, -20(%rbp)
	jne	.L59
	movq	-2144(%rbp), %rax
	leaq	-2144(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	execvp
	cmpl	$-1, %eax
	jne	.L50
	leaq	-576(%rbp), %rax
	movq	%rax, %rdi
	call	strlen
	movq	%rax, %rdx
	leaq	-576(%rbp), %rax
	movq	%rax, %rsi
	movl	$2, %edi
	call	write
	movl	$-1, %edi
	call	exit
.L59:
	movl	-580(%rbp), %eax
	testl	%eax, %eax
	jne	.L50
	movl	-20(%rbp), %eax
	movl	$0, %edx
	movl	$0, %esi
	movl	%eax, %edi
	call	waitpid
.L50:
	movq	-592(%rbp), %rax
	testq	%rax, %rax
	je	.L43
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush
	movl	-12(%rbp), %eax
	movl	%eax, %edi
	call	close
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fileno
	movl	%eax, %edx
	movl	-16(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	dup2
	movl	-16(%rbp), %eax
	movl	%eax, %edi
	call	close
	movq	$0, -592(%rbp)
.L61:
	jmp	.L43
	.cfi_endproc
.LFE8:
	.size	main, .-main
	.ident	"GCC: (GNU) 5.3.1 20160406 (Red Hat 5.3.1-6)"
	.section	.note.GNU-stack,"",@progbits
