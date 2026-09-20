
/tmp/wallet-x86.macho:	file format mach-o 64-bit x86-64

Disassembly of section __TEXT,__text:

000000010437a8f0:
10438c880:     	pushq	%rbp
10438c881:     	movq	%rsp, %rbp
10438c884:     	pushq	%r15
10438c886:     	pushq	%r14
10438c888:     	pushq	%r12
10438c88a:     	pushq	%rbx
10438c88b:     	subq	$0x70, %rsp
10438c88f:     	movq	%rcx, %r14
10438c892:     	movq	%rdx, %r15
10438c895:     	movq	%rsi, %r12
10438c898:     	movq	%rdi, %rbx
10438c89b:     	movzbl	0x24ca81e(%rip), %eax   ## 0x1068570c0
10438c8a2:     	testb	%al, %al
10438c8a4:     	je	0x10438c8c8
10438c8a6:     	testq	%r14, %r14
10438c8a9:     	je	0x10438c8d2
10438c8ab:     	testq	%r15, %r15
10438c8ae:     	jne	0x10438c8d9
10438c8b0:     	leaq	0x1134b4d(%rip), %rdi   ## 0x1054c1404
10438c8b7:     	leaq	0x1134b54(%rip), %rsi   ## 0x1054c1412
10438c8be:     	movl	$0x92, %edx
10438c8c3:     	callq	0x104366700
10438c8c8:     	callq	0x1052f4870
10438c8cd:     	testq	%r14, %r14
10438c8d0:     	jne	0x10438c8ab
10438c8d2:     	leaq	0xfa2637(%rip), %r15    ## 0x10532ef10
10438c8d9:     	leaq	0x2392450(%rip), %rsi   ## 0x10671ed30
10438c8e0:     	leaq	-0x40(%rbp), %rdi
10438c8e4:     	movq	%r12, %rdx
10438c8e7:     	movq	%r15, %rcx
10438c8ea:     	movq	%r14, %r8
10438c8ed:     	callq	0x10438ca00
10438c8f2:     	cmpq	$0x0, -0x40(%rbp)
10438c8f7:     	je	0x10438c92a
10438c8f9:     	leaq	-0x88(%rbp), %rdi
10438c900:     	leaq	-0x40(%rbp), %rsi
10438c904:     	callq	0x1043942e0
10438c909:     	movl	-0x88(%rbp), %eax
10438c90f:     	movl	%eax, -0x68(%rbp)
10438c912:     	movups	-0x80(%rbp), %xmm0
10438c916:     	movups	%xmm0, -0x60(%rbp)
10438c91a:     	movq	-0x70(%rbp), %rax
10438c91e:     	movq	%rax, -0x50(%rbp)
10438c922:     	movl	$0x1, %r14d
10438c928:     	jmp	0x10438c95c
10438c92a:     	leaq	0x236e2bf(%rip), %rax   ## 0x1066fabf0
10438c931:     	movl	(%rax), %eax
10438c933:     	movzbl	-0x38(%rbp), %eax
10438c937:     	movq	-0x37(%rbp), %rcx
10438c93b:     	movq	%rcx, -0x67(%rbp)
10438c93f:     	movups	-0x30(%rbp), %xmm0
10438c943:     	movups	%xmm0, -0x60(%rbp)
10438c947:     	xorps	%xmm0, %xmm0
10438c94a:     	movups	%xmm0, -0x38(%rbp)
10438c94e:     	movq	$0x0, -0x28(%rbp)
10438c956:     	movb	%al, -0x68(%rbp)
10438c959:     	xorl	%r14d, %r14d
10438c95c:     	movl	%r14d, -0x48(%rbp)
10438c960:     	movb	$0x0, (%rbx)
10438c963:     	movl	$0xffffffff, 0x20(%rbx) ## imm = 0xFFFFFFFF
10438c96a:     	movq	%rbx, -0x88(%rbp)
10438c971:     	movl	%r14d, %eax
10438c974:     	leaq	0x1c4e1d5(%rip), %rcx   ## 0x105fdab50
10438c97b:     	leaq	-0x88(%rbp), %rdi
10438c982:     	leaq	-0x68(%rbp), %rsi
10438c986:     	callq	*(%rcx,%rax,8)
10438c989:     	movl	%r14d, 0x20(%rbx)
10438c98d:     	movl	-0x48(%rbp), %eax
10438c990:     	movl	$0xffffffff, %ecx       ## imm = 0xFFFFFFFF
10438c995:     	cmpq	%rcx, %rax
10438c998:     	je	0x10438c9af
10438c99a:     	leaq	0x1c4e19f(%rip), %rcx   ## 0x105fdab40
10438c9a1:     	leaq	-0x88(%rbp), %rdi
10438c9a8:     	leaq	-0x68(%rbp), %rsi
10438c9ac:     	callq	*(%rcx,%rax,8)
10438c9af:     	movq	-0x40(%rbp), %rdi
10438c9b3:     	testq	%rdi, %rdi
10438c9b6:     	je	0x10438c9cc
10438c9b8:     	movq	$0x0, -0x40(%rbp)
10438c9c0:     	testb	$0x1, (%rdi)
10438c9c3:     	jne	0x10438c9ec
10438c9c5:     	callq	0x105322c7a
10438c9ca:     	jmp	0x10438c9ec
10438c9cc:     	testb	$0x1, -0x38(%rbp)
10438c9d0:     	je	0x10438c9ec
10438c9d2:     	movq	-0x28(%rbp), %rdi
10438c9d6:     	callq	0x105322c80
10438c9db:     	movq	-0x40(%rbp), %rdi
10438c9df:     	movq	$0x0, -0x40(%rbp)
10438c9e7:     	testq	%rdi, %rdi
10438c9ea:     	jne	0x10438c9c0
10438c9ec:     	movq	%rbx, %rax
10438c9ef:     	addq	$0x70, %rsp
10438c9f3:     	popq	%rbx
10438c9f4:     	popq	%r12
10438c9f6:     	popq	%r14
10438c9f8:     	popq	%r15
10438c9fa:     	popq	%rbp
10438c9fb:     	retq
10438c9fc:     	nopl	(%rax)
10438ca00:     	pushq	%rbp
10438ca01:     	movq	%rsp, %rbp
10438ca04:     	pushq	%r15
10438ca06:     	pushq	%r14
10438ca08:     	pushq	%r13
10438ca0a:     	pushq	%r12
10438ca0c:     	pushq	%rbx
10438ca0d:     	subq	$0x58, %rsp
10438ca11:     	movq	%r8, %r15
10438ca14:     	movq	%rcx, %r12
10438ca17:     	movq	%rdi, %rbx
10438ca1a:     	leaq	-0x60(%rbp), %r14
10438ca1e:     	movq	%r14, %rdi
10438ca21:     	callq	0x104391590
10438ca26:     	movq	-0x60(%rbp), %r13
10438ca2a:     	testq	%r13, %r13
10438ca2d:     	je	0x10438ca6d
10438ca2f:     	leaq	0x1c4dfd2(%rip), %rax   ## 0x105fdaa08
10438ca36:     	addq	$0x10, %rax
10438ca3a:     	movq	%rax, -0x40(%rbp)
10438ca3e:     	leaq	-0x38(%rbp), %rdi
10438ca42:     	movq	%r14, -0x38(%rbp)
10438ca46:     	movb	$0x0, -0x30(%rbp)
10438ca4a:     	movq	$0x0, -0x60(%rbp)
10438ca52:     	callq	0x104379550
10438ca57:     	movq	%r13, (%rbx)
10438ca5a:     	movq	-0x60(%rbp), %rdi
10438ca5e:     	testq	%rdi, %rdi
10438ca61:     	je	0x10438ca94
10438ca63:     	movq	$0x0, -0x60(%rbp)
10438ca6b:     	jmp	0x10438cad1
10438ca6d:     	movq	-0x58(%rbp), %rax
10438ca71:     	movq	-0x50(%rbp), %r14
10438ca75:     	xorps	%xmm0, %xmm0
10438ca78:     	movups	%xmm0, -0x58(%rbp)
10438ca7c:     	movq	(%rax), %rcx
10438ca7f:     	leaq	0xfa248a(%rip), %rax    ## 0x10532ef10
10438ca86:     	testq	%rcx, %rcx
10438ca89:     	je	0x10438caed
10438ca8b:     	movq	(%rcx), %r8
10438ca8e:     	addq	$0x8, %rcx
10438ca92:     	jmp	0x10438caf3
10438ca94:     	movq	-0x50(%rbp), %r14
10438ca98:     	testq	%r14, %r14
10438ca9b:     	je	0x10438cac0
10438ca9d:     	movq	$-0x1, %rax
10438caa4:     	lock
10438caa5:     	xaddq	%rax, 0x8(%r14)
10438caaa:     	testq	%rax, %rax
10438caad:     	jne	0x10438cac0
10438caaf:     	movq	(%r14), %rax
10438cab2:     	movq	%r14, %rdi
10438cab5:     	callq	*0x10(%rax)
10438cab8:     	movq	%r14, %rdi
10438cabb:     	callq	0x105322ba2
10438cac0:     	movq	-0x60(%rbp), %rdi
10438cac4:     	movq	$0x0, -0x60(%rbp)
10438cacc:     	testq	%rdi, %rdi
10438cacf:     	je	0x10438cadb
10438cad1:     	testb	$0x1, (%rdi)
10438cad4:     	jne	0x10438cadb
10438cad6:     	callq	0x105322c7a
10438cadb:     	movq	%rbx, %rax
10438cade:     	addq	$0x58, %rsp
10438cae2:     	popq	%rbx
10438cae3:     	popq	%r12
10438cae5:     	popq	%r13
10438cae7:     	popq	%r14
10438cae9:     	popq	%r15
10438caeb:     	popq	%rbp
10438caec:     	retq
10438caed:     	xorl	%r8d, %r8d
10438caf0:     	movq	%rax, %rcx
10438caf3:     	movq	%rax, -0x40(%rbp)
10438caf7:     	movq	$0x0, -0x38(%rbp)
10438caff:     	movups	-0x40(%rbp), %xmm0
10438cb03:     	movups	%xmm0, (%rsp)
10438cb07:     	leaq	-0x48(%rbp), %rdi
10438cb0b:     	movq	%r12, %rsi
10438cb0e:     	movq	%r15, %rdx
10438cb11:     	xorl	%r9d, %r9d
10438cb14:     	callq	0x104396d90
10438cb19:     	movq	-0x48(%rbp), %r12
10438cb1d:     	testq	%r12, %r12
10438cb20:     	je	0x10438cb48
10438cb22:     	movq	(%r12), %r15
10438cb26:     	cmpq	$-0x8, %r15
10438cb2a:     	jae	0x10438cc41
10438cb30:     	cmpq	$0x17, %r15
10438cb34:     	jae	0x10438cb55
10438cb36:     	leal	(%r15,%r15), %eax
10438cb3a:     	movb	%al, -0x40(%rbp)
10438cb3d:     	leaq	-0x3f(%rbp), %r13
10438cb41:     	testq	%r15, %r15
10438cb44:     	jne	0x10438cb90
10438cb46:     	jmp	0x10438cb50
10438cb48:     	movb	$0x0, -0x40(%rbp)
10438cb4c:     	leaq	-0x3f(%rbp), %r13
10438cb50:     	xorl	%r15d, %r15d
10438cb53:     	jmp	0x10438cba2
10438cb55:     	movq	%r15, %rax
10438cb58:     	orq	$0x7, %rax
10438cb5c:     	leaq	0x1(%rax), %rcx
10438cb60:     	cmpq	$0x17, %rax
10438cb64:     	movq	%r14, -0x68(%rbp)
10438cb68:     	movl	$0x1a, %r14d
10438cb6e:     	cmovneq	%rcx, %r14
10438cb72:     	movq	%r14, %rdi
10438cb75:     	callq	0x105322c8c
10438cb7a:     	movq	%rax, %r13
10438cb7d:     	movq	%rax, -0x30(%rbp)
10438cb81:     	incq	%r14
10438cb84:     	movq	%r14, -0x40(%rbp)
10438cb88:     	movq	-0x68(%rbp), %r14
10438cb8c:     	movq	%r15, -0x38(%rbp)
10438cb90:     	addq	$0x8, %r12
10438cb94:     	movq	%r13, %rdi
10438cb97:     	movq	%r12, %rsi
10438cb9a:     	movq	%r15, %rdx
10438cb9d:     	callq	0x1053232a4
10438cba2:     	movb	$0x0, (%r13,%r15)
10438cba8:     	movq	$0x0, (%rbx)
10438cbaf:     	movq	-0x30(%rbp), %rax
10438cbb3:     	movq	%rax, 0x18(%rbx)
10438cbb7:     	movzbl	-0x40(%rbp), %eax
10438cbbb:     	movb	%al, 0x8(%rbx)
10438cbbe:     	movq	-0x3f(%rbp), %rax
10438cbc2:     	movq	%rax, 0x9(%rbx)
10438cbc6:     	movl	-0x37(%rbp), %eax
10438cbc9:     	movl	%eax, 0x11(%rbx)
10438cbcc:     	movzwl	-0x33(%rbp), %eax
10438cbd0:     	movw	%ax, 0x15(%rbx)
10438cbd4:     	movzbl	-0x31(%rbp), %eax
10438cbd8:     	movb	%al, 0x17(%rbx)
10438cbdb:     	movq	-0x48(%rbp), %r15
10438cbdf:     	movq	$0x0, -0x48(%rbp)
10438cbe7:     	testq	%r15, %r15
10438cbea:     	je	0x10438cc0c
10438cbec:     	movq	(%r15), %rax
10438cbef:     	addq	$0x8, %rax
10438cbf3:     	movq	%r15, -0x40(%rbp)
10438cbf7:     	movq	%rax, -0x38(%rbp)
10438cbfb:     	leaq	-0x40(%rbp), %rdi
10438cbff:     	callq	0x10436a230
10438cc04:     	movq	%r15, %rdi
10438cc07:     	callq	0x105322c7a
10438cc0c:     	testq	%r14, %r14
10438cc0f:     	je	0x10438ca5a
10438cc15:     	movq	$-0x1, %rax
10438cc1c:     	lock
10438cc1d:     	xaddq	%rax, 0x8(%r14)
10438cc22:     	testq	%rax, %rax
10438cc25:     	jne	0x10438ca5a
10438cc2b:     	movq	(%r14), %rax
10438cc2e:     	movq	%r14, %rdi
10438cc31:     	callq	*0x10(%rax)
10438cc34:     	movq	%r14, %rdi
10438cc37:     	callq	0x105322ba2
10438cc3c:     	jmp	0x10438ca5a
10438cc41:     	callq	0x1052f3290
10438cc46:     	nopw	%cs:(%rax,%rax)
