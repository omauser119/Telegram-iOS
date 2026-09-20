
/tmp/wallet-x86.macho:	file format mach-o 64-bit x86-64

Disassembly of section __TEXT,__text:

0000000101fe00ea:
10415e791:     	pushq	%rbp
10415e792:     	movq	%rsp, %rbp
10415e795:     	pushq	%r15
10415e797:     	pushq	%r14
10415e799:     	pushq	%r13
10415e79b:     	pushq	%r12
10415e79d:     	pushq	%rbx
10415e79e:     	subq	$0x298, %rsp            ## imm = 0x298
10415e7a5:     	movq	%r8, %r15
10415e7a8:     	movq	%rcx, %r14
10415e7ab:     	movq	%rdx, %rdi
10415e7ae:     	movq	0x1c513e3(%rip), %rax   ## 0x105dafb98
10415e7b5:     	movq	(%rax), %rax
10415e7b8:     	movq	%rax, -0x30(%rbp)
10415e7bc:     	movq	0x1c513a5(%rip), %rbx   ## 0x105dafb68
10415e7c3:     	callq	*%rbx
10415e7c5:     	movq	%rax, %r13
10415e7c8:     	movq	%r14, %rdi
10415e7cb:     	callq	*%rbx
10415e7cd:     	movq	%rax, %r12
10415e7d0:     	movq	0x2127989(%rip), %rsi   ## 0x106286160
10415e7d7:     	movq	%r13, %rdi
10415e7da:     	callq	*0x1c51378(%rip)        ## 0x105dafb58
10415e7e0:     	testq	%rax, %rax
10415e7e3:     	je	0x10415e950
10415e7e9:     	movq	%r13, %rdi
10415e7ec:     	movq	0x212796d(%rip), %rsi   ## 0x106286160
10415e7f3:     	callq	*0x1c5135f(%rip)        ## 0x105dafb58
10415e7f9:     	cmpq	$0xffffff, %rax         ## imm = 0xFFFFFF
10415e7ff:     	ja	0x10415e950
10415e805:     	movq	0x2128c64(%rip), %rsi   ## 0x106287470
10415e80c:     	movq	%r12, %rdi
10415e80f:     	callq	*0x1c51343(%rip)        ## 0x105dafb58
10415e815:     	cmpq	$0x3, %rax
10415e819:     	jne	0x10415e950
10415e81f:     	movq	%r15, -0x170(%rbp)
10415e826:     	movq	%r13, -0xf8(%rbp)
10415e82d:     	xorps	%xmm0, %xmm0
10415e830:     	leaq	-0x2c0(%rbp), %r15
10415e837:     	movaps	%xmm0, 0x30(%r15)
10415e83c:     	movaps	%xmm0, 0x20(%r15)
10415e841:     	movaps	%xmm0, 0x10(%r15)
10415e846:     	movaps	%xmm0, (%r15)
10415e84a:     	movq	%r12, %rdi
10415e84d:     	callq	*0x1c51315(%rip)        ## 0x105dafb68
10415e853:     	movq	0x2128c1e(%rip), %rsi   ## 0x106287478
10415e85a:     	leaq	-0xb0(%rbp), %rcx
10415e861:     	movl	$0x10, %r8d
10415e867:     	movq	%rax, -0xe8(%rbp)
10415e86e:     	movq	%rax, %rdi
10415e871:     	movq	%r15, %rdx
10415e874:     	callq	*0x1c512de(%rip)        ## 0x105dafb58
10415e87a:     	movq	%rax, %r15
10415e87d:     	testq	%rax, %rax
10415e880:     	je	0x10415e909
10415e886:     	leaq	-0x2c0(%rbp), %rax
10415e88d:     	movq	0x10(%rax), %rax
10415e891:     	movq	(%rax), %r14
10415e894:     	movq	0x1c512bd(%rip), %r13   ## 0x105dafb58
10415e89b:     	xorl	%ebx, %ebx
10415e89d:     	movq	-0x2b0(%rbp), %rax
10415e8a4:     	cmpq	%r14, (%rax)
10415e8a7:     	je	0x10415e8b5
10415e8a9:     	movq	-0xe8(%rbp), %rdi
10415e8b0:     	callq	0x105323334
10415e8b5:     	movq	-0x2b8(%rbp), %rax
10415e8bc:     	movq	(%rax,%rbx,8), %rdi
10415e8c0:     	movq	0x2127899(%rip), %rsi   ## 0x106286160
10415e8c7:     	callq	*%r13
10415e8ca:     	cmpq	$0x20, %rax
10415e8ce:     	jne	0x10415e9a6
10415e8d4:     	incq	%rbx
10415e8d7:     	cmpq	%rbx, %r15
10415e8da:     	jne	0x10415e89d
10415e8dc:     	movl	$0x10, %r8d
10415e8e2:     	movq	-0xe8(%rbp), %rdi
10415e8e9:     	movq	0x2128b88(%rip), %rsi   ## 0x106287478
10415e8f0:     	leaq	-0x2c0(%rbp), %rdx
10415e8f7:     	leaq	-0xb0(%rbp), %rcx
10415e8fe:     	callq	*%r13
10415e901:     	movq	%rax, %r15
10415e904:     	testq	%rax, %rax
10415e907:     	jne	0x10415e89b
10415e909:     	movq	-0xe8(%rbp), %rdi
10415e910:     	callq	*0x1c5124a(%rip)        ## 0x105dafb60
10415e916:     	movq	-0xf8(%rbp), %r13
10415e91d:     	leaq	-0x110(%rbp), %rdi
10415e924:     	movq	%r13, %rsi
10415e927:     	movq	%r12, -0x120(%rbp)
10415e92e:     	callq	0x10415e68c
10415e933:     	movzbl	-0x110(%rbp), %esi
10415e93a:     	testb	$0x1, %sil
10415e93e:     	je	0x10415e9d4
10415e944:     	movq	-0x108(%rbp), %rsi
10415e94b:     	jmp	0x10415e9d6
10415e950:     	leaq	0x1f2cd99(%rip), %rdx   ## 0x10608b6f0
10415e957:     	movl	$0x1, %esi
10415e95c:     	movq	%r15, %rdi
10415e95f:     	callq	0x10415d815
10415e964:     	xorl	%r14d, %r14d
10415e967:     	movq	%r12, %rdi
10415e96a:     	callq	*0x1c511f0(%rip)        ## 0x105dafb60
10415e970:     	movq	%r13, %rdi
10415e973:     	callq	*0x1c511e7(%rip)        ## 0x105dafb60
10415e979:     	movq	0x1c51218(%rip), %rax   ## 0x105dafb98
10415e980:     	movq	(%rax), %rax
10415e983:     	cmpq	-0x30(%rbp), %rax
10415e987:     	jne	0x10415f1ea
10415e98d:     	movq	%r14, %rdi
10415e990:     	addq	$0x298, %rsp            ## imm = 0x298
10415e997:     	popq	%rbx
10415e998:     	popq	%r12
10415e99a:     	popq	%r13
10415e99c:     	popq	%r14
10415e99e:     	popq	%r15
10415e9a0:     	popq	%rbp
10415e9a1:     	jmp	0x10532330a
10415e9a6:     	leaq	0x1f2cd63(%rip), %rdx   ## 0x10608b710
10415e9ad:     	movl	$0x1, %esi
10415e9b2:     	movq	-0x170(%rbp), %rdi
10415e9b9:     	callq	0x10415d815
10415e9be:     	movq	-0xe8(%rbp), %rdi
10415e9c5:     	callq	*0x1c51195(%rip)        ## 0x105dafb60
10415e9cb:     	movq	-0xf8(%rbp), %r13
10415e9d2:     	jmp	0x10415e964
10415e9d4:     	shrl	%esi
10415e9d6:     	leaq	-0x1d0(%rbp), %rdi
10415e9dd:     	xorl	%edx, %edx
10415e9df:     	callq	0x10415f66a
10415e9e4:     	leaq	-0x1b8(%rbp), %r14
10415e9eb:     	movzbl	-0x110(%rbp), %esi
10415e9f2:     	testb	$0x1, %sil
10415e9f6:     	je	0x10415ea01
10415e9f8:     	movq	-0x108(%rbp), %rsi
10415e9ff:     	jmp	0x10415ea03
10415ea01:     	shrl	%esi
10415ea03:     	movq	%r14, %r15
10415ea06:     	movq	%r14, %rdi
10415ea09:     	xorl	%edx, %edx
10415ea0b:     	callq	0x10415f66a
10415ea10:     	leaq	-0x1a0(%rbp), %r15
10415ea17:     	movzbl	-0x110(%rbp), %esi
10415ea1e:     	testb	$0x1, %sil
10415ea22:     	je	0x10415ea2d
10415ea24:     	movq	-0x108(%rbp), %rsi
10415ea2b:     	jmp	0x10415ea2f
10415ea2d:     	shrl	%esi
10415ea2f:     	movq	%r15, %rdi
10415ea32:     	xorl	%edx, %edx
10415ea34:     	callq	0x10415f66a
10415ea39:     	leaq	-0x1d0(%rbp), %rdi
10415ea40:     	callq	0x10415f3a6
10415ea45:     	testb	%al, %al
10415ea47:     	je	0x10415ea6d
10415ea49:     	movq	%r14, %rdi
10415ea4c:     	callq	0x10415f3a6
10415ea51:     	testb	%al, %al
10415ea53:     	je	0x10415ea6d
10415ea55:     	movzbl	-0x110(%rbp), %eax
10415ea5c:     	testb	$0x1, %al
10415ea5e:     	sete	%r8b
10415ea62:     	je	0x10415ea8d
10415ea64:     	movq	-0x108(%rbp), %rax
10415ea6b:     	jmp	0x10415ea8f
10415ea6d:     	leaq	0x1f2ccbc(%rip), %rdx   ## 0x10608b730
10415ea74:     	movl	$0x4, %esi
10415ea79:     	movq	-0x170(%rbp), %rdi
10415ea80:     	callq	0x10415d815
10415ea85:     	xorl	%r14d, %r14d
10415ea88:     	jmp	0x10415f1a7
10415ea8d:     	shrl	%eax
10415ea8f:     	testq	%rax, %rax
10415ea92:     	je	0x10415eb35
10415ea98:     	leaq	-0x10f(%rbp), %rax
10415ea9f:     	leaq	-0x1cf(%rbp), %rcx
10415eaa6:     	leaq	-0x1b7(%rbp), %rdx
10415eaad:     	leaq	-0x19f(%rbp), %rsi
10415eab4:     	xorl	%edi, %edi
10415eab6:     	movq	%rax, %r9
10415eab9:     	testb	$0x1, %r8b
10415eabd:     	jne	0x10415eac6
10415eabf:     	movq	-0x100(%rbp), %r9
10415eac6:     	testb	$0x1, -0x1d0(%rbp)
10415eacd:     	movq	%rcx, %r8
10415ead0:     	je	0x10415ead9
10415ead2:     	movq	-0x1c0(%rbp), %r8
10415ead9:     	testb	$0x1, -0x1b8(%rbp)
10415eae0:     	movq	%rdx, %r10
10415eae3:     	je	0x10415eaec
10415eae5:     	movq	-0x1a8(%rbp), %r10
10415eaec:     	testb	$0x1, -0x1a0(%rbp)
10415eaf3:     	movq	%rsi, %r11
10415eaf6:     	je	0x10415eaff
10415eaf8:     	movq	-0x190(%rbp), %r11
10415eaff:     	movb	(%r8,%rdi), %r8b
10415eb03:     	xorb	(%r9,%rdi), %r8b
10415eb07:     	xorb	(%r10,%rdi), %r8b
10415eb0b:     	movb	%r8b, (%r11,%rdi)
10415eb0f:     	movzbl	-0x110(%rbp), %r9d
10415eb17:     	testb	$0x1, %r9b
10415eb1b:     	sete	%r8b
10415eb1f:     	je	0x10415eb2a
10415eb21:     	movq	-0x108(%rbp), %r9
10415eb28:     	jmp	0x10415eb2d
10415eb2a:     	shrl	%r9d
10415eb2d:     	incq	%rdi
10415eb30:     	cmpq	%r9, %rdi
10415eb33:     	jb	0x10415eab6
10415eb35:     	movq	0x2130e5c(%rip), %rdi   ## 0x10628f998
10415eb3c:     	callq	0x1053232ec
10415eb41:     	movq	0x2128e30(%rip), %rsi   ## 0x106287978
10415eb48:     	movl	$0x3, %edx
10415eb4d:     	movq	%rax, %rdi
10415eb50:     	callq	*0x1c51002(%rip)        ## 0x105dafb58
10415eb56:     	movq	%rax, -0x118(%rbp)
10415eb5d:     	movq	0x2128974(%rip), %rax   ## 0x1062874d8
10415eb64:     	movq	%rax, -0x1e0(%rbp)
10415eb6b:     	movq	0x2127d9e(%rip), %rax   ## 0x106286910
10415eb72:     	movq	%rax, -0x1d8(%rbp)
10415eb79:     	xorl	%r14d, %r14d
10415eb7c:     	xorl	%r15d, %r15d
10415eb7f:     	xorps	%xmm0, %xmm0
10415eb82:     	movaps	%xmm0, -0x140(%rbp)
10415eb89:     	movq	$0x0, -0x130(%rbp)
10415eb94:     	movq	-0xe8(%rbp), %rdi
10415eb9b:     	movq	0x21294be(%rip), %rsi   ## 0x106288060
10415eba2:     	movq	%r15, %rdx
10415eba5:     	callq	*0x1c50fad(%rip)        ## 0x105dafb58
10415ebab:     	movq	%rax, %rdi
10415ebae:     	callq	0x105323394
10415ebb3:     	movq	%rax, %rdi
10415ebb6:     	callq	*0x1c50fac(%rip)        ## 0x105dafb68
10415ebbc:     	movq	%rax, %rbx
10415ebbf:     	movq	%rax, %rdi
10415ebc2:     	movq	0x2127597(%rip), %rsi   ## 0x106286160
10415ebc9:     	callq	*0x1c50f89(%rip)        ## 0x105dafb58
10415ebcf:     	cmpq	$0x20, %rax
10415ebd3:     	jne	0x10415ec3f
10415ebd5:     	leaq	-0x230(%rbp), %rdi
10415ebdc:     	callq	0x10438b7b0
10415ebe1:     	cmpl	$0x0, -0x210(%rbp)
10415ebe8:     	jne	0x10415ec33
10415ebea:     	movq	-0x230(%rbp), %r12
10415ebf1:     	leaq	-0x208(%rbp), %rdi
10415ebf8:     	movq	%r12, %rsi
10415ebfb:     	callq	0x10438c460
10415ec00:     	cmpl	$0x0, -0x1e8(%rbp)
10415ec07:     	je	0x10415ec9b
10415ec0d:     	movq	%r12, %rsi
10415ec10:     	leaq	-0xe0(%rbp), %r12
10415ec17:     	movq	%r12, %rdi
10415ec1a:     	callq	0x10438c7b0
10415ec1f:     	movq	%r12, %rdi
10415ec22:     	callq	0x10415f40e
10415ec27:     	leaq	-0x208(%rbp), %rdi
10415ec2e:     	callq	0x10415f468
10415ec33:     	leaq	-0x230(%rbp), %rdi
10415ec3a:     	callq	0x10415f4d2
10415ec3f:     	movq	%rbx, %rdi
10415ec42:     	movq	0x1c50f17(%rip), %r12   ## 0x105dafb60
10415ec49:     	callq	*%r12
10415ec4c:     	movq	%rbx, %rdi
10415ec4f:     	callq	*%r12
10415ec52:     	movl	$0x4, %esi
10415ec57:     	movq	-0x170(%rbp), %rdi
10415ec5e:     	leaq	0x1f2caeb(%rip), %rdx   ## 0x10608b750
10415ec65:     	callq	0x10415d815
10415ec6a:     	xorl	%ebx, %ebx
10415ec6c:     	testb	$0x1, -0x140(%rbp)
10415ec73:     	je	0x10415ec81
10415ec75:     	movq	-0x130(%rbp), %rdi
10415ec7c:     	callq	0x105322c80
10415ec81:     	testb	%bl, %bl
10415ec83:     	je	0x10415f182
10415ec89:     	incq	%r15
10415ec8c:     	cmpq	$0x3, %r15
10415ec90:     	jne	0x10415eb7f
10415ec96:     	jmp	0x10415f18b
10415ec9b:     	leaq	-0x188(%rbp), %rdi
10415eca2:     	movq	%rbx, %rsi
10415eca5:     	callq	0x10415e68c
10415ecaa:     	movzbl	-0x188(%rbp), %edx
10415ecb1:     	testb	$0x1, %dl
10415ecb4:     	je	0x10415ecc6
10415ecb6:     	movq	-0x178(%rbp), %rsi
10415ecbd:     	movq	-0x180(%rbp), %rdx
10415ecc4:     	jmp	0x10415eccf
10415ecc6:     	shrl	%edx
10415ecc8:     	leaq	-0x187(%rbp), %rsi
10415eccf:     	leaq	-0x280(%rbp), %rdi
10415ecd6:     	callq	0x10438bb30
10415ecdb:     	cmpl	$0x0, -0x260(%rbp)
10415ece2:     	je	0x10415ed0d
10415ece4:     	movq	%r12, %rsi
10415ece7:     	leaq	-0xe0(%rbp), %r12
10415ecee:     	movq	%r12, %rdi
10415ecf1:     	callq	0x10438c7b0
10415ecf6:     	movq	%r12, %rdi
10415ecf9:     	callq	0x10415f40e
10415ecfe:     	movl	$0x0, -0xb8(%rbp)
10415ed08:     	jmp	0x10415f071
10415ed0d:     	movq	-0x280(%rbp), %rdx
10415ed14:     	leaq	-0x258(%rbp), %rdi
10415ed1b:     	movq	%r12, %rsi
10415ed1e:     	movq	%rdx, -0xb8(%rbp)
10415ed25:     	callq	0x10438be90
10415ed2a:     	cmpl	$0x0, -0x238(%rbp)
10415ed31:     	je	0x10415ed7c
10415ed33:     	leaq	-0xe0(%rbp), %rdi
10415ed3a:     	movq	-0xb8(%rbp), %rsi
10415ed41:     	callq	0x10438c7b0
10415ed46:     	leaq	-0xe0(%rbp), %rdi
10415ed4d:     	callq	0x10415f40e
10415ed52:     	leaq	-0xe0(%rbp), %rdi
10415ed59:     	movq	%r12, %rsi
10415ed5c:     	callq	0x10438c7b0
10415ed61:     	leaq	-0xe0(%rbp), %rdi
10415ed68:     	callq	0x10415f40e
10415ed6d:     	movl	$0x0, -0xb8(%rbp)
10415ed77:     	jmp	0x10415f065
10415ed7c:     	leaq	(%r15,%r15,2), %rax
10415ed80:     	leaq	-0x1d0(,%rax,8), %rcx
10415ed88:     	addq	%rbp, %rcx
10415ed8b:     	movq	-0x258(%rbp), %rax
10415ed92:     	xorps	%xmm0, %xmm0
10415ed95:     	movaps	%xmm0, -0xe0(%rbp)
10415ed9c:     	movq	$0x0, -0xd0(%rbp)
10415eda7:     	movzbl	(%rcx), %esi
10415edaa:     	testb	$0x1, %sil
10415edae:     	movq	%rcx, -0xf0(%rbp)
10415edb5:     	movq	%rax, -0x168(%rbp)
10415edbc:     	je	0x10415edc4
10415edbe:     	movq	0x8(%rcx), %rsi
10415edc2:     	jmp	0x10415edc6
10415edc4:     	shrl	%esi
10415edc6:     	addq	$0xc, %rsi
10415edca:     	leaq	-0xe0(%rbp), %rdi
10415edd1:     	callq	0x105322b00
10415edd6:     	leaq	-0xe0(%rbp), %rdi
10415eddd:     	movl	$0x8, %esi
10415ede2:     	callq	0x105322b06
10415ede7:     	leaq	-0xe0(%rbp), %rdi
10415edee:     	movl	$0xffffffdd, %esi       ## imm = 0xFFFFFFDD
10415edf3:     	callq	0x105322b06
10415edf8:     	leaq	-0xe0(%rbp), %rdi
10415edff:     	movl	$0xffffff90, %esi       ## imm = 0xFFFFFF90
10415ee04:     	callq	0x105322b06
10415ee09:     	leaq	-0xe0(%rbp), %rdi
10415ee10:     	movl	$0xffffff8b, %esi       ## imm = 0xFFFFFF8B
10415ee15:     	callq	0x105322b06
10415ee1a:     	movzbl	-0xe0(%rbp), %eax
10415ee21:     	testb	$0x1, %al
10415ee23:     	je	0x10415ee2e
10415ee25:     	movq	-0xd8(%rbp), %rcx
10415ee2c:     	jmp	0x10415ee32
10415ee2e:     	movl	%eax, %ecx
10415ee30:     	shrl	%ecx
10415ee32:     	testb	$0x3, %cl
10415ee35:     	je	0x10415ee5c
10415ee37:     	xorps	%xmm0, %xmm0
10415ee3a:     	movaps	%xmm0, -0x160(%rbp)
10415ee41:     	movq	$0x0, -0x150(%rbp)
10415ee4c:     	testb	$0x1, %al
10415ee4e:     	jne	0x10415ee94
10415ee50:     	movq	-0x168(%rbp), %rsi
10415ee57:     	jmp	0x10415efcd
10415ee5c:     	movq	-0xf0(%rbp), %rdx
10415ee63:     	movb	(%rdx), %cl
10415ee65:     	testb	$0x1, %cl
10415ee68:     	jne	0x10415eea5
10415ee6a:     	shrb	%cl
10415ee6c:     	movsbl	%cl, %esi
10415ee6f:     	leaq	-0xe0(%rbp), %rdi
10415ee76:     	callq	0x105322b06
10415ee7b:     	movq	-0xf0(%rbp), %rsi
10415ee82:     	movzbl	(%rsi), %edx
10415ee85:     	testb	$0x1, %dl
10415ee88:     	je	0x10415eee6
10415ee8a:     	movq	0x8(%rsi), %rdx
10415ee8e:     	movq	0x10(%rsi), %rsi
10415ee92:     	jmp	0x10415eeeb
10415ee94:     	movq	-0xd0(%rbp), %rdi
10415ee9b:     	callq	0x105322c80
10415eea0:     	jmp	0x10415ef3d
10415eea5:     	movq	0x8(%rdx), %rcx
10415eea9:     	cmpq	$0xffffff, %rcx         ## imm = 0xFFFFFF
10415eeb0:     	ja	0x10415ee37
10415eeb2:     	cmpq	$0xfd, %rcx
10415eeb9:     	jbe	0x10415ee6c
10415eebb:     	leaq	-0xe0(%rbp), %rdi
10415eec2:     	movl	$0xfffffffe, %esi       ## imm = 0xFFFFFFFE
10415eec7:     	callq	0x105322b06
10415eecc:     	movq	-0xf0(%rbp), %rcx
10415eed3:     	movzbl	(%rcx), %eax
10415eed6:     	testb	$0x1, %al
10415eed8:     	je	0x10415f135
10415eede:     	movl	0x8(%rcx), %eax
10415eee1:     	jmp	0x10415f137
10415eee6:     	incq	%rsi
10415eee9:     	shrl	%edx
10415eeeb:     	leaq	-0xe0(%rbp), %rdi
10415eef2:     	callq	0x105322ad6
10415eef7:     	movzbl	-0xe0(%rbp), %eax
10415eefe:     	testb	$0x1, %al
10415ef00:     	je	0x10415ef0b
10415ef02:     	movq	-0xd8(%rbp), %rax
10415ef09:     	jmp	0x10415ef0d
10415ef0b:     	shrl	%eax
10415ef0d:     	testb	$0x3, %al
10415ef0f:     	je	0x10415ef21
10415ef11:     	leaq	-0xe0(%rbp), %rdi
10415ef18:     	xorl	%esi, %esi
10415ef1a:     	callq	0x105322b06
10415ef1f:     	jmp	0x10415eef7
10415ef21:     	movq	-0xd0(%rbp), %rax
10415ef28:     	movq	%rax, -0x150(%rbp)
10415ef2f:     	movaps	-0xe0(%rbp), %xmm0
10415ef36:     	movaps	%xmm0, -0x160(%rbp)
10415ef3d:     	movzbl	-0x160(%rbp), %ecx
10415ef44:     	testb	$0x1, %cl
10415ef47:     	movq	-0x168(%rbp), %rsi
10415ef4e:     	jne	0x10415ef60
10415ef50:     	testq	%rcx, %rcx
10415ef53:     	je	0x10415efcd
10415ef55:     	shrl	%ecx
10415ef57:     	leaq	-0x15f(%rbp), %rdx
10415ef5e:     	jmp	0x10415ef73
10415ef60:     	movq	-0x158(%rbp), %rcx
10415ef67:     	testq	%rcx, %rcx
10415ef6a:     	je	0x10415efcd
10415ef6c:     	movq	-0x150(%rbp), %rdx
10415ef73:     	leaq	-0xe0(%rbp), %rdi
10415ef7a:     	callq	0x10438c880
10415ef7f:     	movq	-0x168(%rbp), %rdi
10415ef86:     	callq	0x10415d945
10415ef8b:     	movq	-0xb8(%rbp), %rdi
10415ef92:     	callq	0x10415d945
10415ef97:     	movq	%r12, %rdi
10415ef9a:     	callq	0x10415d945
10415ef9f:     	cmpl	$0x0, -0xc0(%rbp)
10415efa6:     	jne	0x10415f03a
10415efac:     	cmpl	$0x0, -0x1e8(%rbp)
10415efb3:     	jne	0x10415f1ef
10415efb9:     	movzbl	-0x208(%rbp), %eax
10415efc0:     	testb	$0x1, %al
10415efc2:     	je	0x10415eff5
10415efc4:     	movq	-0x200(%rbp), %rax
10415efcb:     	jmp	0x10415eff7
10415efcd:     	movq	%rsi, %rdi
10415efd0:     	callq	0x10415d945
10415efd5:     	movq	-0xb8(%rbp), %rdi
10415efdc:     	callq	0x10415d945
10415efe1:     	movq	%r12, %rdi
10415efe4:     	callq	0x10415d945
10415efe9:     	movl	$0x0, -0xb8(%rbp)
10415eff3:     	jmp	0x10415f050
10415eff5:     	shrl	%eax
10415eff7:     	cmpq	$0x20, %rax
10415effb:     	jne	0x10415f03a
10415effd:     	leaq	-0x140(%rbp), %rdi
10415f004:     	leaq	-0x208(%rbp), %rsi
10415f00b:     	callq	0x105322b12
10415f010:     	cmpl	$0x0, -0xc0(%rbp)
10415f017:     	jne	0x10415f1ef
10415f01d:     	movb	$0x1, %al
10415f01f:     	movl	%eax, -0xb8(%rbp)
10415f025:     	leaq	-0x140(%rbp), %rdi
10415f02c:     	leaq	-0xe0(%rbp), %rsi
10415f033:     	callq	0x10415f60c
10415f038:     	jmp	0x10415f044
10415f03a:     	movl	$0x0, -0xb8(%rbp)
10415f044:     	leaq	-0xe0(%rbp), %rdi
10415f04b:     	callq	0x10415f468
10415f050:     	testb	$0x1, -0x160(%rbp)
10415f057:     	je	0x10415f065
10415f059:     	movq	-0x150(%rbp), %rdi
10415f060:     	callq	0x105322c80
10415f065:     	leaq	-0x258(%rbp), %rdi
10415f06c:     	callq	0x10415f4d2
10415f071:     	leaq	-0x280(%rbp), %rdi
10415f078:     	callq	0x10415f4d2
10415f07d:     	testb	$0x1, -0x188(%rbp)
10415f084:     	je	0x10415f092
10415f086:     	movq	-0x178(%rbp), %rdi
10415f08d:     	callq	0x105322c80
10415f092:     	leaq	-0x208(%rbp), %rdi
10415f099:     	callq	0x10415f468
10415f09e:     	leaq	-0x230(%rbp), %rdi
10415f0a5:     	callq	0x10415f4d2
10415f0aa:     	movq	%rbx, %rdi
10415f0ad:     	movq	0x1c50aac(%rip), %r12   ## 0x105dafb60
10415f0b4:     	callq	*%r12
10415f0b7:     	movq	%rbx, %rdi
10415f0ba:     	callq	*%r12
10415f0bd:     	cmpb	$0x0, -0xb8(%rbp)
10415f0c4:     	je	0x10415ec52
10415f0ca:     	movzbl	-0x140(%rbp), %ecx
10415f0d1:     	testb	$0x1, %cl
10415f0d4:     	je	0x10415f0e6
10415f0d6:     	movq	-0x130(%rbp), %rdx
10415f0dd:     	movq	-0x138(%rbp), %rcx
10415f0e4:     	jmp	0x10415f0ef
10415f0e6:     	shrl	%ecx
10415f0e8:     	leaq	-0x13f(%rbp), %rdx
10415f0ef:     	movq	0x2130902(%rip), %rdi   ## 0x10628f9f8
10415f0f6:     	movq	-0x1e0(%rbp), %rsi
10415f0fd:     	callq	*0x1c50a55(%rip)        ## 0x105dafb58
10415f103:     	movq	%rax, %rdi
10415f106:     	callq	0x105323394
10415f10b:     	movq	%rax, %rbx
10415f10e:     	movq	-0x118(%rbp), %rdi
10415f115:     	movq	-0x1d8(%rbp), %rsi
10415f11c:     	movq	%rax, %rdx
10415f11f:     	callq	*0x1c50a33(%rip)        ## 0x105dafb58
10415f125:     	movq	%rbx, %rdi
10415f128:     	callq	*0x1c50a32(%rip)        ## 0x105dafb60
10415f12e:     	movb	$0x1, %bl
10415f130:     	jmp	0x10415ec6c
10415f135:     	shrl	%eax
10415f137:     	movsbl	%al, %esi
10415f13a:     	leaq	-0xe0(%rbp), %rdi
10415f141:     	movq	-0xf8(%rbp), %r13
10415f148:     	callq	0x105322b06
10415f14d:     	movq	-0xf0(%rbp), %rcx
10415f154:     	movb	(%rcx), %al
10415f156:     	andb	$0x1, %al
10415f158:     	negb	%al
10415f15a:     	andb	0x9(%rcx), %al
10415f15d:     	movsbl	%al, %esi
10415f160:     	leaq	-0xe0(%rbp), %rdi
10415f167:     	callq	0x105322b06
10415f16c:     	movq	-0xf0(%rbp), %rax
10415f173:     	movb	(%rax), %cl
10415f175:     	andb	$0x1, %cl
10415f178:     	negb	%cl
10415f17a:     	andb	0xa(%rax), %cl
10415f17d:     	jmp	0x10415ee6c
10415f182:     	movq	-0x118(%rbp), %rbx
10415f189:     	jmp	0x10415f19e
10415f18b:     	movq	-0x118(%rbp), %rbx
10415f192:     	movq	%rbx, %rdi
10415f195:     	callq	*0x1c509cd(%rip)        ## 0x105dafb68
10415f19b:     	movq	%rax, %r14
10415f19e:     	movq	%rbx, %rdi
10415f1a1:     	callq	*0x1c509b9(%rip)        ## 0x105dafb60
10415f1a7:     	movl	$0x48, %ebx
10415f1ac:     	testb	$0x1, -0x1e8(%rbp,%rbx)
10415f1b4:     	je	0x10415f1c3
10415f1b6:     	movq	-0x1d8(%rbp,%rbx), %rdi
10415f1be:     	callq	0x105322c80
10415f1c3:     	addq	$-0x18, %rbx
10415f1c7:     	jne	0x10415f1ac
10415f1c9:     	testb	$0x1, -0x110(%rbp)
10415f1d0:     	je	0x10415f1de
10415f1d2:     	movq	-0x100(%rbp), %rdi
10415f1d9:     	callq	0x105322c80
10415f1de:     	movq	-0x120(%rbp), %r12
10415f1e5:     	jmp	0x10415e967
10415f1ea:     	callq	0x105322d34
10415f1ef:     	callq	0x10415f62d
10415f1f4:     	ud2
10415f1f6:     	jmp	0x10415f1fa
10415f1f8:     	jmp	0x10415f20b
10415f1fa:     	movq	%rax, %r14
10415f1fd:     	leaq	-0xe0(%rbp), %rdi
10415f204:     	callq	0x10415f468
10415f209:     	jmp	0x10415f20e
10415f20b:     	movq	%rax, %r14
10415f20e:     	testb	$0x1, -0x160(%rbp)
10415f215:     	je	0x10415f257
10415f217:     	movq	-0x150(%rbp), %rdi
10415f21e:     	jmp	0x10415f252
10415f220:     	jmp	0x10415f238
10415f222:     	movq	%rax, %r14
10415f225:     	jmp	0x10415f257
10415f227:     	movq	%rax, %r14
10415f22a:     	movq	%rbx, %rdi
10415f22d:     	callq	*0x1c5092d(%rip)        ## 0x105dafb60
10415f233:     	jmp	0x10415f2fa
10415f238:     	movq	%rax, %r14
10415f23b:     	jmp	0x10415f263
10415f23d:     	jmp	0x10415f23f
10415f23f:     	movq	%rax, %r14
10415f242:     	testb	$0x1, -0xe0(%rbp)
10415f249:     	je	0x10415f257
10415f24b:     	movq	-0xd0(%rbp), %rdi
10415f252:     	callq	0x105322c80
10415f257:     	leaq	-0x258(%rbp), %rdi
10415f25e:     	callq	0x10415f4d2
10415f263:     	leaq	-0x280(%rbp), %rdi
10415f26a:     	callq	0x10415f4d2
10415f26f:     	jmp	0x10415f274
10415f271:     	movq	%rax, %r14
10415f274:     	testb	$0x1, -0x188(%rbp)
10415f27b:     	je	0x10415f290
10415f27d:     	movq	-0x178(%rbp), %rdi
10415f284:     	callq	0x105322c80
10415f289:     	jmp	0x10415f290
10415f28b:     	jmp	0x10415f28d
10415f28d:     	movq	%rax, %r14
10415f290:     	leaq	-0x208(%rbp), %rdi
10415f297:     	callq	0x10415f468
10415f29c:     	jmp	0x10415f2a3
10415f29e:     	jmp	0x10415f2d9
10415f2a0:     	movq	%rax, %r14
10415f2a3:     	leaq	-0x230(%rbp), %rdi
10415f2aa:     	callq	0x10415f4d2
10415f2af:     	jmp	0x10415f2e1
10415f2b1:     	movq	%rax, %r14
10415f2b4:     	jmp	0x10415f33e
10415f2b9:     	jmp	0x10415f363
10415f2be:     	jmp	0x10415f368
10415f2c3:     	movq	%rax, %r14
10415f2c6:     	leaq	-0x1d0(%rbp), %rsi
10415f2cd:     	movq	%r15, %rdi
10415f2d0:     	callq	0x10201c14d
10415f2d5:     	jmp	0x10415f33e
10415f2d7:     	jmp	0x10415f2de
10415f2d9:     	movq	%rax, %r14
10415f2dc:     	jmp	0x10415f31c
10415f2de:     	movq	%rax, %r14
10415f2e1:     	movq	%rbx, %rdi
10415f2e4:     	callq	*0x1c50876(%rip)        ## 0x105dafb60
10415f2ea:     	movq	%rbx, %rdi
10415f2ed:     	callq	*0x1c5086d(%rip)        ## 0x105dafb60
10415f2f3:     	jmp	0x10415f2fa
10415f2f5:     	jmp	0x10415f368
10415f2f7:     	movq	%rax, %r14
10415f2fa:     	testb	$0x1, -0x140(%rbp)
10415f301:     	je	0x10415f30f
10415f303:     	movq	-0x130(%rbp), %rdi
10415f30a:     	callq	0x105322c80
10415f30f:     	movq	-0x118(%rbp), %rdi
10415f316:     	callq	*0x1c50844(%rip)        ## 0x105dafb60
10415f31c:     	movl	$0x48, %ebx
10415f321:     	testb	$0x1, -0x1e8(%rbp,%rbx)
10415f329:     	je	0x10415f338
10415f32b:     	movq	-0x1d8(%rbp,%rbx), %rdi
10415f333:     	callq	0x105322c80
10415f338:     	addq	$-0x18, %rbx
10415f33c:     	jne	0x10415f321
10415f33e:     	testb	$0x1, -0x110(%rbp)
10415f345:     	je	0x10415f37f
10415f347:     	movq	-0x100(%rbp), %rdi
10415f34e:     	callq	0x105322c80
10415f353:     	jmp	0x10415f37f
10415f355:     	movq	%r12, -0x120(%rbp)
10415f35c:     	movq	%r13, -0xf8(%rbp)
10415f363:     	movq	%rax, %r14
10415f366:     	jmp	0x10415f37f
10415f368:     	movq	%rax, %r14
10415f36b:     	movq	-0xe8(%rbp), %rdi
10415f372:     	callq	*0x1c507e8(%rip)        ## 0x105dafb60
10415f378:     	movq	%r12, -0x120(%rbp)
10415f37f:     	movq	-0x120(%rbp), %rdi
10415f386:     	callq	*0x1c507d4(%rip)        ## 0x105dafb60
10415f38c:     	movq	-0xf8(%rbp), %rdi
10415f393:     	callq	*0x1c507c7(%rip)        ## 0x105dafb60
10415f399:     	jmp	0x10415f39e
10415f39b:     	movq	%rax, %r14
10415f39e:     	movq	%r14, %rdi
10415f3a1:     	callq	0x105322a16
10415f3a6:     	movq	%rdi, %rdx
10415f3a9:     	movzbl	(%rdi), %esi
10415f3ac:     	testb	$0x1, %sil
10415f3b0:     	jne	0x10415f3be
10415f3b2:     	testq	%rsi, %rsi
10415f3b5:     	je	0x10415f3e5
10415f3b7:     	shrl	%esi
10415f3b9:     	incq	%rdx
10415f3bc:     	jmp	0x10415f3cb
10415f3be:     	movq	0x8(%rdx), %rsi
10415f3c2:     	testq	%rsi, %rsi
10415f3c5:     	je	0x10415f3e5
10415f3c7:     	movq	0x10(%rdx), %rdx
10415f3cb:     	pushq	%rbp
10415f3cc:     	movq	%rsp, %rbp
10415f3cf:     	movq	0x1c4fe6a(%rip), %rax   ## 0x105daf240
10415f3d6:     	movq	(%rax), %rdi
10415f3d9:     	callq	0x105322932
10415f3de:     	testl	%eax, %eax
10415f3e0:     	sete	%al
10415f3e3:     	popq	%rbp
10415f3e4:     	retq
10415f3e5:     	movb	$0x1, %al
10415f3e7:     	retq
