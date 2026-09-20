
/tmp/wallet-x86.macho:	file format mach-o 64-bit x86-64

Disassembly of section __TEXT,__text:

0000000101fe00ea:
10415da4a:     	pushq	%rbp
10415da4b:     	movq	%rsp, %rbp
10415da4e:     	pushq	%r15
10415da50:     	pushq	%r14
10415da52:     	pushq	%r13
10415da54:     	pushq	%r12
10415da56:     	pushq	%rbx
10415da57:     	subq	$0x238, %rsp            ## imm = 0x238
10415da5e:     	movq	%rcx, -0x30(%rbp)
10415da62:     	movq	%rdi, %rbx
10415da65:     	movq	%rdx, %rdi
10415da68:     	callq	*0x1c520fa(%rip)        ## 0x105dafb68
10415da6e:     	movq	0x21299fb(%rip), %rsi   ## 0x106287470
10415da75:     	movq	%rax, -0xc0(%rbp)
10415da7c:     	movq	%rax, %rdi
10415da7f:     	callq	*0x1c520d3(%rip)        ## 0x105dafb58
10415da85:     	cmpq	$0x3, %rax
10415da89:     	jne	0x10415ded4
10415da8f:     	cmpq	$0x0, 0x8(%rbx)
10415da94:     	je	0x10415ded4
10415da9a:     	movq	%rbx, -0xb8(%rbp)
10415daa1:     	movl	$0x4c, %eax
10415daa6:     	xorps	%xmm0, %xmm0
10415daa9:     	movq	$0x0, -0x258(%rbp,%rax)
10415dab5:     	movl	$0x0, -0x250(%rbp,%rax)
10415dac0:     	movups	%xmm0, -0x29c(%rbp,%rax)
10415dac8:     	movups	%xmm0, -0x28c(%rbp,%rax)
10415dad0:     	movups	%xmm0, -0x27c(%rbp,%rax)
10415dad8:     	movups	%xmm0, -0x26c(%rbp,%rax)
10415dae0:     	movb	$0x0, -0x25c(%rbp,%rax)
10415dae8:     	addq	$0x50, %rax
10415daec:     	cmpq	$0x13c, %rax            ## imm = 0x13C
10415daf2:     	jne	0x10415daa9
10415daf4:     	movups	0x15daac5(%rip), %xmm0  ## 0x1057385c0
10415dafb:     	movaps	%xmm0, -0x160(%rbp)
10415db02:     	movq	$0x2, -0x150(%rbp)
10415db0d:     	movq	0x212af0c(%rip), %rax   ## 0x106288a20
10415db14:     	movq	%rax, -0x118(%rbp)
10415db1b:     	leaq	-0x60(%rbp), %r15
10415db1f:     	xorl	%r14d, %r14d
10415db22:     	movq	$0x0, -0x38(%rbp)
10415db2a:     	xorl	%ebx, %ebx
10415db2c:     	movq	-0xc0(%rbp), %rdi
10415db33:     	movq	0x212a526(%rip), %rsi   ## 0x106288060
10415db3a:     	movq	%rbx, %rdx
10415db3d:     	callq	*0x1c52015(%rip)        ## 0x105dafb58
10415db43:     	movq	%rax, %rdi
10415db46:     	callq	0x105323394
10415db4b:     	movq	%rax, %r12
10415db4e:     	movq	%r15, %rdi
10415db51:     	movq	%rax, %rsi
10415db54:     	callq	0x10415e68c
10415db59:     	leaq	(%rbx,%rbx,4), %rax
10415db5d:     	shlq	$0x4, %rax
10415db61:     	leaq	(%rax,%rbp), %r13
10415db65:     	addq	$-0x250, %r13           ## imm = 0xFDB0
10415db6c:     	xorps	%xmm0, %xmm0
10415db6f:     	movaps	%xmm0, -0xb0(%rbp)
10415db76:     	movq	$0x0, -0xa0(%rbp)
10415db81:     	movzbl	-0x60(%rbp), %eax
10415db85:     	testb	$0x1, %al
10415db87:     	jne	0x10415dba3
10415db89:     	cmpb	$0x7, %al
10415db8b:     	jb	0x10415dbf0
10415db8d:     	cmpl	$0x1ea87158, -0x5f(%rbp) ## imm = 0x1EA87158
10415db94:     	jne	0x10415dbf0
10415db96:     	leaq	-0x5f(%rbp), %rcx
10415db9a:     	cmpb	$0x22, %al
10415db9c:     	jae	0x10415dbc3
10415db9e:     	jmp	0x10415ddcc
10415dba3:     	movq	-0x58(%rbp), %rdx
10415dba7:     	cmpq	$0x4, %rdx
10415dbab:     	jb	0x10415dbf0
10415dbad:     	movq	-0x50(%rbp), %rcx
10415dbb1:     	cmpl	$0x1ea87158, (%rcx)     ## imm = 0x1EA87158
10415dbb7:     	jne	0x10415dbf0
10415dbb9:     	cmpq	$0x11, %rdx
10415dbbd:     	jb	0x10415ddcc
10415dbc3:     	movzbl	0x10(%rcx), %edx
10415dbc7:     	cmpq	$0xfd, %rdx
10415dbce:     	ja	0x10415dd2d
10415dbd4:     	movl	$0x1, %esi
10415dbd9:     	leaq	0x10(%rsi), %rdi
10415dbdd:     	testb	$0x1, %al
10415dbdf:     	jne	0x10415dd43
10415dbe5:     	movl	%eax, %r9d
10415dbe8:     	shrl	%r9d
10415dbeb:     	jmp	0x10415dd47
10415dbf0:     	leaq	-0xb0(%rbp), %rdi
10415dbf7:     	movq	%r15, %rsi
10415dbfa:     	callq	0x105322b12
10415dbff:     	movq	$0x0, 0x30(%r13)
10415dc07:     	movzbl	-0xb0(%rbp), %eax
10415dc0e:     	testb	$0x1, %al
10415dc10:     	jne	0x10415dc2b
10415dc12:     	cmpb	$0x42, %al
10415dc14:     	setae	%cl
10415dc17:     	testb	$0x1e, %al
10415dc19:     	sete	%dl
10415dc1c:     	testb	%dl, %cl
10415dc1e:     	je	0x10415dd14
10415dc24:     	shrl	%eax
10415dc26:     	movq	%rax, %rcx
10415dc29:     	jmp	0x10415dc49
10415dc2b:     	movq	-0xa8(%rbp), %rcx
10415dc32:     	cmpq	$0x21, %rcx
10415dc36:     	setae	%dl
10415dc39:     	testb	$0xf, %cl
10415dc3c:     	sete	%sil
10415dc40:     	testb	%sil, %dl
10415dc43:     	je	0x10415dd14
10415dc49:     	movq	%rcx, 0x38(%r13)
10415dc4d:     	movl	$0x20, %ecx
10415dc52:     	leaq	-0x110(%rbp), %rdi
10415dc59:     	leaq	-0xb0(%rbp), %rsi
10415dc60:     	xorl	%edx, %edx
10415dc62:     	leaq	-0x148(%rbp), %r8
10415dc69:     	callq	0x105322b0c
10415dc6e:     	testb	$0x1, (%r13)
10415dc73:     	je	0x10415dc7e
10415dc75:     	movq	0x10(%r13), %rdi
10415dc79:     	callq	0x105322c80
10415dc7e:     	movq	-0x100(%rbp), %rax
10415dc85:     	movq	%rax, 0x10(%r13)
10415dc89:     	movups	-0x110(%rbp), %xmm0
10415dc90:     	movups	%xmm0, (%r13)
10415dc95:     	movl	$0x20, %edx
10415dc9a:     	leaq	-0x110(%rbp), %rdi
10415dca1:     	leaq	-0xb0(%rbp), %rsi
10415dca8:     	movq	$-0x1, %rcx
10415dcaf:     	leaq	-0x148(%rbp), %r8
10415dcb6:     	callq	0x105322b0c
10415dcbb:     	testb	$0x1, 0x18(%r13)
10415dcc0:     	je	0x10415dccb
10415dcc2:     	movq	0x28(%r13), %rdi
10415dcc6:     	callq	0x105322c80
10415dccb:     	leaq	0x18(%r13), %rax
10415dccf:     	movq	-0x100(%rbp), %rcx
10415dcd6:     	movq	%rcx, 0x10(%rax)
10415dcda:     	movups	-0x110(%rbp), %xmm0
10415dce1:     	movups	%xmm0, (%rax)
10415dce4:     	testb	$0x1, -0xb0(%rbp)
10415dceb:     	je	0x10415dcf9
10415dced:     	movq	-0xa0(%rbp), %rdi
10415dcf4:     	callq	0x105322c80
10415dcf9:     	movb	0x40(%r13), %al
10415dcfd:     	orb	%al, %r14b
10415dd00:     	xorb	$0x1, %al
10415dd02:     	movq	-0x38(%rbp), %rcx
10415dd06:     	orb	%al, %cl
10415dd08:     	movq	%rcx, -0x38(%rbp)
10415dd0c:     	movb	$0x1, %r13b
10415dd0f:     	jmp	0x10415de28
10415dd14:     	testb	$0x1, %al
10415dd16:     	je	0x10415ddcc
10415dd1c:     	movq	-0xa0(%rbp), %rdi
10415dd23:     	callq	0x105322c80
10415dd28:     	jmp	0x10415ddcc
10415dd2d:     	cmpl	$0xfe, %edx
10415dd33:     	jne	0x10415ddcc
10415dd39:     	testb	$0x1, %al
10415dd3b:     	je	0x10415dd9e
10415dd3d:     	movq	-0x58(%rbp), %rdx
10415dd41:     	jmp	0x10415dda2
10415dd43:     	movq	-0x58(%rbp), %r9
10415dd47:     	movq	%r9, %r8
10415dd4a:     	subq	%rdi, %r8
10415dd4d:     	cmpq	%r8, %rdx
10415dd50:     	ja	0x10415ddcc
10415dd52:     	leaq	(%rdi,%rdx), %r8
10415dd56:     	addl	%edx, %esi
10415dd58:     	negl	%esi
10415dd5a:     	andl	$0x3, %esi
10415dd5d:     	movq	%r9, %r10
10415dd60:     	subq	%r8, %r10
10415dd63:     	cmpq	%r10, %rsi
10415dd66:     	ja	0x10415ddcc
10415dd68:     	addq	%r8, %rsi
10415dd6b:     	cmpq	%r9, %rsi
10415dd6e:     	jne	0x10415ddcc
10415dd70:     	movq	-0x58(%rbp), %rsi
10415dd74:     	movl	%eax, %r9d
10415dd77:     	shrl	%r9d
10415dd7a:     	testb	$0x1, %al
10415dd7c:     	jne	0x10415dd88
10415dd7e:     	cmpq	%r9, %r8
10415dd81:     	jb	0x10415dd91
10415dd83:     	jmp	0x10415de61
10415dd88:     	cmpq	%rsi, %r8
10415dd8b:     	jae	0x10415de5b
10415dd91:     	cmpb	$0x0, (%rcx,%r8)
10415dd96:     	leaq	0x1(%r8), %r8
10415dd9a:     	je	0x10415dd7a
10415dd9c:     	jmp	0x10415ddcc
10415dd9e:     	movl	%eax, %edx
10415dda0:     	shrl	%edx
10415dda2:     	andq	$-0x4, %rdx
10415dda6:     	cmpq	$0x10, %rdx
10415ddaa:     	je	0x10415ddcc
10415ddac:     	movzwl	0x11(%rcx), %esi
10415ddb0:     	movzbl	0x13(%rcx), %edx
10415ddb4:     	shll	$0x10, %edx
10415ddb7:     	orq	%rsi, %rdx
10415ddba:     	movl	$0x4, %esi
10415ddbf:     	cmpq	$0xfe, %rdx
10415ddc6:     	jae	0x10415dbd9
10415ddcc:     	movq	0x213195d(%rip), %rdi   ## 0x10628f730
10415ddd3:     	movzbl	-0x60(%rbp), %r8d
10415ddd8:     	testb	$0x1, %r8b
10415dddc:     	je	0x10415dde4
10415ddde:     	movq	-0x58(%rbp), %r8
10415dde2:     	jmp	0x10415dde7
10415dde4:     	shrl	%r8d
10415dde7:     	movq	-0x118(%rbp), %rsi
10415ddee:     	leaq	0x1f2d7fb(%rip), %rdx   ## 0x10608b5f0
10415ddf5:     	movq	%rbx, %rcx
10415ddf8:     	xorl	%eax, %eax
10415ddfa:     	callq	*0x1c51d58(%rip)        ## 0x105dafb58
10415de00:     	movq	%rax, %rdi
10415de03:     	callq	0x105323394
10415de08:     	movq	%rax, %r13
10415de0b:     	movl	$0x1, %esi
10415de10:     	movq	-0x30(%rbp), %rdi
10415de14:     	movq	%rax, %rdx
10415de17:     	callq	0x10415d815
10415de1c:     	movq	%r13, %rdi
10415de1f:     	callq	*0x1c51d3b(%rip)        ## 0x105dafb60
10415de25:     	xorl	%r13d, %r13d
10415de28:     	testb	$0x1, -0x60(%rbp)
10415de2c:     	je	0x10415de37
10415de2e:     	movq	-0x50(%rbp), %rdi
10415de32:     	callq	0x105322c80
10415de37:     	movq	%r12, %rdi
10415de3a:     	callq	*0x1c51d20(%rip)        ## 0x105dafb60
10415de40:     	testb	%r13b, %r13b
10415de43:     	je	0x10415e255
10415de49:     	incq	%rbx
10415de4c:     	cmpq	$0x3, %rbx
10415de50:     	jne	0x10415db2c
10415de56:     	jmp	0x10415def1
10415de5b:     	movq	-0x50(%rbp), %rsi
10415de5f:     	jmp	0x10415de65
10415de61:     	leaq	-0x5f(%rbp), %rsi
10415de65:     	addq	%rdi, %rsi
10415de68:     	leaq	-0xb0(%rbp), %rdi
10415de6f:     	callq	0x105322ae2
10415de74:     	movzbl	-0x60(%rbp), %eax
10415de78:     	testb	$0x1, %al
10415de7a:     	je	0x10415de82
10415de7c:     	movq	-0x58(%rbp), %rcx
10415de80:     	jmp	0x10415de86
10415de82:     	movl	%eax, %ecx
10415de84:     	shrl	%ecx
10415de86:     	movq	%rcx, 0x30(%r13)
10415de8a:     	movb	$0x1, 0x40(%r13)
10415de8f:     	movq	-0x50(%rbp), %rcx
10415de93:     	leaq	0xc(%rcx), %rdx
10415de97:     	testb	$0x1, %al
10415de99:     	leaq	-0x53(%rbp), %rsi
10415de9d:     	cmoveq	%rsi, %rdx
10415dea1:     	leaq	0x8(%rcx), %rsi
10415dea5:     	testb	$0x1, %al
10415dea7:     	leaq	-0x57(%rbp), %rdi
10415deab:     	cmoveq	%rdi, %rsi
10415deaf:     	addq	$0x4, %rcx
10415deb3:     	testb	$0x1, %al
10415deb5:     	leaq	-0x5b(%rbp), %rax
10415deb9:     	cmoveq	%rax, %rcx
10415debd:     	movl	(%rcx), %eax
10415debf:     	movl	%eax, 0x44(%r13)
10415dec3:     	movl	(%rsi), %eax
10415dec5:     	movl	%eax, 0x48(%r13)
10415dec9:     	movl	(%rdx), %eax
10415decb:     	movl	%eax, 0x4c(%r13)
10415decf:     	jmp	0x10415dc07
10415ded4:     	leaq	0x1f2d6f5(%rip), %rdx   ## 0x10608b5d0
10415dedb:     	movl	$0x1, %esi
10415dee0:     	movq	-0x30(%rbp), %rdi
10415dee4:     	callq	0x10415d815
10415dee9:     	xorl	%r14d, %r14d
10415deec:     	jmp	0x10415e295
10415def1:     	testb	$0x1, %r14b
10415def5:     	je	0x10415df80
10415defb:     	testb	$0x1, -0x38(%rbp)
10415deff:     	je	0x10415df1b
10415df01:     	leaq	0x1f2d708(%rip), %rdx   ## 0x10608b610
10415df08:     	movl	$0x1, %esi
10415df0d:     	movq	-0x30(%rbp), %rdi
10415df11:     	callq	0x10415d815
10415df16:     	jmp	0x10415e255
10415df1b:     	movb	$0x0, -0xae(%rbp)
10415df22:     	movw	$0x0, -0xb0(%rbp)
10415df2b:     	leaq	-0x204(%rbp), %rax
10415df32:     	movl	(%rax), %ecx
10415df34:     	xorl	%edx, %edx
10415df36:     	cmpl	$0x3, -0x4(%rax)
10415df3a:     	jne	0x10415e240
10415df40:     	movl	-0x8(%rax), %esi
10415df43:     	cmpq	$0x2, %rsi
10415df47:     	ja	0x10415e240
10415df4d:     	cmpl	%ecx, (%rax)
10415df4f:     	jne	0x10415e240
10415df55:     	cmpb	$0x1, -0xb0(%rbp,%rsi)
10415df5d:     	je	0x10415e240
10415df63:     	movb	$0x1, -0xb0(%rbp,%rsi)
10415df6b:     	movq	%rdx, -0x160(%rbp,%rsi,8)
10415df73:     	incq	%rdx
10415df76:     	addq	$0x50, %rax
10415df7a:     	cmpq	$0x3, %rdx
10415df7e:     	jne	0x10415df36
10415df80:     	xorps	%xmm0, %xmm0
10415df83:     	movaps	%xmm0, -0x80(%rbp)
10415df87:     	movaps	%xmm0, -0x90(%rbp)
10415df8e:     	movaps	%xmm0, -0xa0(%rbp)
10415df95:     	movaps	%xmm0, -0xb0(%rbp)
10415df9c:     	movq	$0x0, -0x70(%rbp)
10415dfa4:     	xorl	%ebx, %ebx
10415dfa6:     	leaq	-0x60(%rbp), %r14
10415dfaa:     	leaq	-0x110(%rbp), %r12
10415dfb1:     	movq	-0x160(%rbp,%rbx,8), %rax
10415dfb9:     	leaq	(%rax,%rax,4), %rax
10415dfbd:     	shlq	$0x4, %rax
10415dfc1:     	leaq	(%rax,%rbp), %r15
10415dfc5:     	addq	$-0x250, %r15           ## imm = 0xFDB0
10415dfcc:     	movzbl	(%r15), %edx
10415dfd0:     	testb	$0x1, %dl
10415dfd3:     	jne	0x10415dfdd
10415dfd5:     	leaq	0x1(%r15), %rsi
10415dfd9:     	shrl	%edx
10415dfdb:     	jmp	0x10415dfe5
10415dfdd:     	movq	0x8(%r15), %rdx
10415dfe1:     	movq	0x10(%r15), %rsi
10415dfe5:     	movq	%r14, %rdi
10415dfe8:     	callq	0x10438bb30
10415dfed:     	cmpl	$0x0, -0x40(%rbp)
10415dff1:     	jne	0x10415e2bb
10415dff7:     	movq	-0x60(%rbp), %r13
10415dffb:     	movq	-0xb8(%rbp), %rax
10415e002:     	movq	0x8(%rax), %rsi
10415e006:     	leaq	-0x148(%rbp), %rdi
10415e00d:     	movq	%r13, %rdx
10415e010:     	callq	0x10438be90
10415e015:     	movq	%r12, %rdi
10415e018:     	movq	%r13, %rsi
10415e01b:     	callq	0x10438c7b0
10415e020:     	movq	%r12, %rdi
10415e023:     	callq	0x10415f40e
10415e028:     	cmpl	$0x0, -0x128(%rbp)
10415e02f:     	jne	0x10415e2d5
10415e035:     	movzbl	0x18(%r15), %ecx
10415e03a:     	testb	$0x1, %cl
10415e03d:     	jne	0x10415e047
10415e03f:     	leaq	0x19(%r15), %rdx
10415e043:     	shrl	%ecx
10415e045:     	jmp	0x10415e04f
10415e047:     	movq	0x20(%r15), %rcx
10415e04b:     	movq	0x28(%r15), %rdx
10415e04f:     	movq	-0x148(%rbp), %r13
10415e056:     	leaq	-0xe8(%rbp), %rdi
10415e05d:     	movq	%r13, %rsi
10415e060:     	callq	0x10438cc50
10415e065:     	movq	%r12, %rdi
10415e068:     	movq	%r13, %rsi
10415e06b:     	callq	0x10438c7b0
10415e070:     	movq	%r12, %rdi
10415e073:     	callq	0x10415f40e
10415e078:     	movl	-0xc8(%rbp), %eax
10415e07e:     	testl	%eax, %eax
10415e080:     	jne	0x10415e2ef
10415e086:     	movzbl	-0xe8(%rbp), %eax
10415e08d:     	testb	$0x1, %al
10415e08f:     	jne	0x10415e0b1
10415e091:     	cmpb	$0xf, %al
10415e093:     	jb	0x10415e1e3
10415e099:     	cmpl	$0x8b90dd08, -0xe7(%rbp) ## imm = 0x8B90DD08
10415e0a3:     	leaq	-0xe7(%rbp), %rcx
10415e0aa:     	je	0x10415e0d2
10415e0ac:     	jmp	0x10415e1e3
10415e0b1:     	cmpq	$0x8, -0xe0(%rbp)
10415e0b9:     	jb	0x10415e1e3
10415e0bf:     	movq	-0xd8(%rbp), %rcx
10415e0c6:     	cmpl	$0x8b90dd08, (%rcx)     ## imm = 0x8B90DD08
10415e0cc:     	jne	0x10415e1e3
10415e0d2:     	movzbl	0x4(%rcx), %edx
10415e0d6:     	cmpq	$0xfd, %rdx
10415e0dd:     	ja	0x10415e0e7
10415e0df:     	movl	$0x5, %r8d
10415e0e5:     	jmp	0x10415e122
10415e0e7:     	cmpl	$0xfe, %edx
10415e0ed:     	jne	0x10415e1e3
10415e0f3:     	testb	$0x1, %al
10415e0f5:     	je	0x10415e100
10415e0f7:     	movq	-0xe0(%rbp), %rdx
10415e0fe:     	jmp	0x10415e104
10415e100:     	movl	%eax, %edx
10415e102:     	shrl	%edx
10415e104:     	cmpq	$0x8, %rdx
10415e108:     	jb	0x10415e1e3
10415e10e:     	movzwl	0x5(%rcx), %esi
10415e112:     	movzbl	0x7(%rcx), %edx
10415e116:     	shll	$0x10, %edx
10415e119:     	orq	%rsi, %rdx
10415e11c:     	movl	$0x8, %r8d
10415e122:     	testq	%rdx, %rdx
10415e125:     	je	0x10415e1e3
10415e12b:     	testb	$0x1, %al
10415e12d:     	jne	0x10415e135
10415e12f:     	movl	%eax, %esi
10415e131:     	shrl	%esi
10415e133:     	jmp	0x10415e13c
10415e135:     	movq	-0xe0(%rbp), %rsi
10415e13c:     	movq	%rsi, %rdi
10415e13f:     	subq	%r8, %rdi
10415e142:     	cmpq	%rdi, %rdx
10415e145:     	ja	0x10415e1e3
10415e14b:     	leaq	(%rdx,%r8), %rdi
10415e14f:     	leal	0x3(%rdi), %r9d
10415e153:     	andl	$-0x4, %r9d
10415e157:     	cmpq	%rsi, %r9
10415e15a:     	jne	0x10415e1e3
10415e160:     	cmpq	%rsi, %rdi
10415e163:     	jae	0x10415e170
10415e165:     	cmpb	$0x0, (%rcx,%rdi)
10415e169:     	jne	0x10415e1e3
10415e16b:     	incq	%rdi
10415e16e:     	jmp	0x10415e160
10415e170:     	leaq	-0xe7(%rbp), %rsi
10415e177:     	testb	$0x1, %al
10415e179:     	je	0x10415e182
10415e17b:     	movq	-0xd8(%rbp), %rsi
10415e182:     	leaq	(%rbx,%rbx,2), %rax
10415e186:     	leaq	-0xb0(,%rax,8), %rdi
10415e18e:     	addq	%rbp, %rdi
10415e191:     	addq	%r8, %rsi
10415e194:     	callq	0x105322ae2
10415e199:     	leaq	-0xe8(%rbp), %rdi
10415e1a0:     	callq	0x10415f468
10415e1a5:     	leaq	-0x148(%rbp), %rdi
10415e1ac:     	callq	0x10415f4d2
10415e1b1:     	movq	%r14, %rdi
10415e1b4:     	callq	0x10415f4d2
10415e1b9:     	incq	%rbx
10415e1bc:     	cmpq	$0x3, %rbx
10415e1c0:     	jne	0x10415dfb1
10415e1c6:     	movzbl	-0xb0(%rbp), %esi
10415e1cd:     	testb	$0x1, %sil
10415e1d1:     	je	0x10415e41d
10415e1d7:     	movq	-0xa8(%rbp), %rsi
10415e1de:     	jmp	0x10415e41f
10415e1e3:     	leaq	0x1f2d4c6(%rip), %rdx   ## 0x10608b6b0
10415e1ea:     	movl	$0x6, %esi
10415e1ef:     	movq	-0x30(%rbp), %rdi
10415e1f3:     	callq	0x10415d815
10415e1f8:     	leaq	-0xe8(%rbp), %rdi
10415e1ff:     	callq	0x10415f468
10415e204:     	leaq	-0x148(%rbp), %rdi
10415e20b:     	callq	0x10415f4d2
10415e210:     	leaq	-0x60(%rbp), %rdi
10415e214:     	callq	0x10415f4d2
10415e219:     	xorl	%r14d, %r14d
10415e21c:     	movl	$0x48, %ebx
10415e221:     	testb	$0x1, -0xc8(%rbp,%rbx)
10415e229:     	je	0x10415e238
10415e22b:     	movq	-0xb8(%rbp,%rbx), %rdi
10415e233:     	callq	0x105322c80
10415e238:     	addq	$-0x18, %rbx
10415e23c:     	jne	0x10415e221
10415e23e:     	jmp	0x10415e258
10415e240:     	leaq	0x1f2d3e9(%rip), %rdx   ## 0x10608b630
10415e247:     	movl	$0x1, %esi
10415e24c:     	movq	-0x30(%rbp), %rdi
10415e250:     	callq	0x10415d815
10415e255:     	xorl	%r14d, %r14d
10415e258:     	movl	$0xa0, %ebx
10415e25d:     	testb	$0x1, -0x238(%rbp,%rbx)
10415e265:     	je	0x10415e274
10415e267:     	movq	-0x228(%rbp,%rbx), %rdi
10415e26f:     	callq	0x105322c80
10415e274:     	testb	$0x1, -0x250(%rbp,%rbx)
10415e27c:     	je	0x10415e28b
10415e27e:     	movq	-0x240(%rbp,%rbx), %rdi
10415e286:     	callq	0x105322c80
10415e28b:     	addq	$-0x50, %rbx
10415e28f:     	cmpq	$-0x50, %rbx
10415e293:     	jne	0x10415e25d
10415e295:     	movq	-0xc0(%rbp), %rdi
10415e29c:     	callq	*0x1c518be(%rip)        ## 0x105dafb60
10415e2a2:     	movq	%r14, %rdi
10415e2a5:     	addq	$0x238, %rsp            ## imm = 0x238
10415e2ac:     	popq	%rbx
10415e2ad:     	popq	%r12
10415e2af:     	popq	%r13
10415e2b1:     	popq	%r14
10415e2b3:     	popq	%r15
10415e2b5:     	popq	%rbp
10415e2b6:     	jmp	0x10532330a
10415e2bb:     	leaq	0x1f2d38e(%rip), %rdx   ## 0x10608b650
10415e2c2:     	movl	$0x3, %esi
10415e2c7:     	movq	-0x30(%rbp), %rdi
10415e2cb:     	callq	0x10415d815
10415e2d0:     	jmp	0x10415e210
10415e2d5:     	leaq	0x1f2d394(%rip), %rdx   ## 0x10608b670
10415e2dc:     	movl	$0x3, %esi
10415e2e1:     	movq	-0x30(%rbp), %rdi
10415e2e5:     	callq	0x10415d815
10415e2ea:     	jmp	0x10415e204
10415e2ef:     	movzbl	0x18(%r15), %r12d
10415e2f4:     	testb	$0x1, %r12b
10415e2f8:     	jne	0x10415e2ff
10415e2fa:     	shrl	%r12d
10415e2fd:     	jmp	0x10415e303
10415e2ff:     	movq	0x20(%r15), %r12
10415e303:     	cmpl	$0x1, %eax
10415e306:     	jne	0x10415e561
10415e30c:     	movq	0x213141d(%rip), %r13   ## 0x10628f730
10415e313:     	movq	0x30(%r15), %r14
10415e317:     	movq	0x38(%r15), %r15
10415e31b:     	movq	%r13, %rdi
10415e31e:     	callq	0x1053232ec
10415e323:     	movzbl	-0xe0(%rbp), %ecx
10415e32a:     	testb	$0x1, %cl
10415e32d:     	je	0x10415e33f
10415e32f:     	movq	-0xd0(%rbp), %rdx
10415e336:     	movq	-0xd8(%rbp), %rcx
10415e33d:     	jmp	0x10415e348
10415e33f:     	shrl	%ecx
10415e341:     	leaq	-0xdf(%rbp), %rdx
10415e348:     	movq	0x212b101(%rip), %rsi   ## 0x106289450
10415e34f:     	movl	$0x4, %r8d
10415e355:     	movq	%rax, %rdi
10415e358:     	callq	*0x1c517fa(%rip)        ## 0x105dafb58
10415e35e:     	movq	%r13, -0x120(%rbp)
10415e365:     	movq	%r15, -0xb8(%rbp)
10415e36c:     	movq	%r14, -0x38(%rbp)
10415e370:     	testq	%rax, %rax
10415e373:     	leaq	0x1f2d3f6(%rip), %r14   ## 0x10608b770
10415e37a:     	cmovneq	%rax, %r14
10415e37e:     	movq	0x21313ab(%rip), %rdi   ## 0x10628f730
10415e385:     	movl	-0xe8(%rbp), %ecx
10415e38b:     	leaq	0x1f2d3fe(%rip), %rdx   ## 0x10608b790
10415e392:     	movq	-0x118(%rbp), %r15
10415e399:     	movq	%r15, %rsi
10415e39c:     	movq	%r14, %r8
10415e39f:     	xorl	%eax, %eax
10415e3a1:     	callq	*0x1c517b1(%rip)        ## 0x105dafb58
10415e3a7:     	movq	%rax, %rdi
10415e3aa:     	callq	0x105323394
10415e3af:     	movq	%rax, %r13
10415e3b2:     	movq	%r14, %rdi
10415e3b5:     	callq	*0x1c517a5(%rip)        ## 0x105dafb60
10415e3bb:     	movq	%r13, 0x8(%rsp)
10415e3c0:     	movq	%r12, (%rsp)
10415e3c4:     	leaq	0x1f2d2c5(%rip), %rdx   ## 0x10608b690
10415e3cb:     	movq	-0x120(%rbp), %rdi
10415e3d2:     	movq	%r15, %rsi
10415e3d5:     	movq	%rbx, %rcx
10415e3d8:     	movq	-0x38(%rbp), %r8
10415e3dc:     	movq	-0xb8(%rbp), %r9
10415e3e3:     	xorl	%eax, %eax
10415e3e5:     	callq	*0x1c5176d(%rip)        ## 0x105dafb58
10415e3eb:     	movq	%rax, %rdi
10415e3ee:     	callq	0x105323394
10415e3f3:     	movq	%rax, %r14
10415e3f6:     	movl	$0x5, %esi
10415e3fb:     	movq	-0x30(%rbp), %rdi
10415e3ff:     	movq	%rax, %rdx
10415e402:     	callq	0x10415d815
10415e407:     	movq	%r14, %rdi
10415e40a:     	movq	0x1c5174f(%rip), %rbx   ## 0x105dafb60
10415e411:     	callq	*%rbx
10415e413:     	movq	%r13, %rdi
10415e416:     	callq	*%rbx
10415e418:     	jmp	0x10415e1f8
10415e41d:     	shrl	%esi
10415e41f:     	movzbl	-0x98(%rbp), %eax
10415e426:     	testb	$0x1, %al
10415e428:     	je	0x10415e433
10415e42a:     	movq	-0x90(%rbp), %rax
10415e431:     	jmp	0x10415e435
10415e433:     	shrl	%eax
10415e435:     	cmpq	%rax, %rsi
10415e438:     	jne	0x10415e475
10415e43a:     	movzbl	-0x80(%rbp), %eax
10415e43e:     	testb	$0x1, %al
10415e440:     	je	0x10415e448
10415e442:     	movq	-0x78(%rbp), %rax
10415e446:     	jmp	0x10415e44a
10415e448:     	shrl	%eax
10415e44a:     	cmpq	%rax, %rsi
10415e44d:     	jne	0x10415e475
10415e44f:     	leaq	-0x110(%rbp), %rdi
10415e456:     	xorl	%edx, %edx
10415e458:     	callq	0x10415f66a
10415e45d:     	movzbl	-0x110(%rbp), %ecx
10415e464:     	testb	$0x1, %cl
10415e467:     	sete	%al
10415e46a:     	je	0x10415e48f
10415e46c:     	movq	-0x108(%rbp), %rcx
10415e473:     	jmp	0x10415e491
10415e475:     	leaq	0x1f2d254(%rip), %rdx   ## 0x10608b6d0
10415e47c:     	movl	$0x6, %esi
10415e481:     	movq	-0x30(%rbp), %rdi
10415e485:     	callq	0x10415d815
10415e48a:     	jmp	0x10415e219
10415e48f:     	shrl	%ecx
10415e491:     	testq	%rcx, %rcx
10415e494:     	je	0x10415e52c
10415e49a:     	leaq	-0xaf(%rbp), %rcx
10415e4a1:     	leaq	-0x97(%rbp), %rdx
10415e4a8:     	leaq	-0x7f(%rbp), %rsi
10415e4ac:     	leaq	-0x10f(%rbp), %rdi
10415e4b3:     	xorl	%r8d, %r8d
10415e4b6:     	testb	$0x1, -0xb0(%rbp)
10415e4bd:     	movq	%rcx, %r9
10415e4c0:     	je	0x10415e4c9
10415e4c2:     	movq	-0xa0(%rbp), %r9
10415e4c9:     	testb	$0x1, -0x98(%rbp)
10415e4d0:     	movq	%rdx, %r10
10415e4d3:     	je	0x10415e4dc
10415e4d5:     	movq	-0x88(%rbp), %r10
10415e4dc:     	testb	$0x1, -0x80(%rbp)
10415e4e0:     	movq	%rsi, %r11
10415e4e3:     	je	0x10415e4e9
10415e4e5:     	movq	-0x70(%rbp), %r11
10415e4e9:     	movq	%rdi, %rbx
10415e4ec:     	testb	$0x1, %al
10415e4ee:     	jne	0x10415e4f7
10415e4f0:     	movq	-0x100(%rbp), %rbx
10415e4f7:     	movb	(%r10,%r8), %al
10415e4fb:     	xorb	(%r9,%r8), %al
10415e4ff:     	xorb	(%r11,%r8), %al
10415e503:     	movb	%al, (%rbx,%r8)
10415e507:     	movzbl	-0x110(%rbp), %r9d
10415e50f:     	testb	$0x1, %r9b
10415e513:     	sete	%al
10415e516:     	je	0x10415e521
10415e518:     	movq	-0x108(%rbp), %r9
10415e51f:     	jmp	0x10415e524
10415e521:     	shrl	%r9d
10415e524:     	incq	%r8
10415e527:     	cmpq	%r9, %r8
10415e52a:     	jb	0x10415e4b6
10415e52c:     	leaq	-0x110(%rbp), %rdi
10415e533:     	callq	0x10415d96c
10415e538:     	movq	%rax, %rdi
10415e53b:     	callq	0x105323394
10415e540:     	movq	%rax, %r14
10415e543:     	testb	$0x1, -0x110(%rbp)
10415e54a:     	je	0x10415e21c
10415e550:     	movq	-0x100(%rbp), %rdi
10415e557:     	callq	0x105322c80
10415e55c:     	jmp	0x10415e21c
10415e561:     	callq	0x10415f62d
10415e566:     	ud2
10415e568:     	movq	%rax, %rbx
10415e56b:     	testb	$0x1, -0x110(%rbp)
10415e572:     	je	0x10415e5ef
10415e574:     	movq	-0x100(%rbp), %rdi
10415e57b:     	callq	0x105322c80
10415e580:     	jmp	0x10415e5ef
10415e582:     	jmp	0x10415e5c6
10415e584:     	jmp	0x10415e5c6
10415e586:     	movq	%rax, %rbx
10415e589:     	movq	%r14, %rdi
10415e58c:     	callq	*0x1c515ce(%rip)        ## 0x105dafb60
10415e592:     	jmp	0x10415e597
10415e594:     	movq	%rax, %rbx
10415e597:     	movq	%r13, %rdi
10415e59a:     	jmp	0x10415e5a2
10415e59c:     	movq	%rax, %rbx
10415e59f:     	movq	%r14, %rdi
10415e5a2:     	callq	*0x1c515b8(%rip)        ## 0x105dafb60
10415e5a8:     	jmp	0x10415e5ce
10415e5aa:     	jmp	0x10415e5bc
10415e5ac:     	jmp	0x10415e5c1
10415e5ae:     	jmp	0x10415e668
10415e5b3:     	jmp	0x10415e668
10415e5b8:     	jmp	0x10415e5cb
10415e5ba:     	jmp	0x10415e5bc
10415e5bc:     	movq	%rax, %rbx
10415e5bf:     	jmp	0x10415e5da
10415e5c1:     	movq	%rax, %rbx
10415e5c4:     	jmp	0x10415e5e6
10415e5c6:     	movq	%rax, %rbx
10415e5c9:     	jmp	0x10415e5ef
10415e5cb:     	movq	%rax, %rbx
10415e5ce:     	leaq	-0xe8(%rbp), %rdi
10415e5d5:     	callq	0x10415f468
10415e5da:     	leaq	-0x148(%rbp), %rdi
10415e5e1:     	callq	0x10415f4d2
10415e5e6:     	leaq	-0x60(%rbp), %rdi
10415e5ea:     	callq	0x10415f4d2
10415e5ef:     	movl	$0x48, %r14d
10415e5f5:     	testb	$0x1, -0xc8(%rbp,%r14)
10415e5fe:     	je	0x10415e60d
10415e600:     	movq	-0xb8(%rbp,%r14), %rdi
10415e608:     	callq	0x105322c80
10415e60d:     	addq	$-0x18, %r14
10415e611:     	jne	0x10415e5f5
10415e613:     	jmp	0x10415e66b
10415e615:     	jmp	0x10415e61e
10415e617:     	jmp	0x10415e61e
10415e619:     	movq	%rax, %rbx
10415e61c:     	jmp	0x10415e677
10415e61e:     	movq	%rax, %rbx
10415e621:     	testb	$0x1, -0xb0(%rbp)
10415e628:     	je	0x10415e649
10415e62a:     	movq	-0xa0(%rbp), %rdi
10415e631:     	callq	0x105322c80
10415e636:     	jmp	0x10415e649
10415e638:     	movq	%rax, %rbx
10415e63b:     	jmp	0x10415e649
10415e63d:     	movq	%rax, %rbx
10415e640:     	movq	%r13, %rdi
10415e643:     	callq	*0x1c51517(%rip)        ## 0x105dafb60
10415e649:     	testb	$0x1, -0x60(%rbp)
10415e64d:     	je	0x10415e65d
10415e64f:     	movq	-0x50(%rbp), %rdi
10415e653:     	callq	0x105322c80
10415e658:     	jmp	0x10415e65d
10415e65a:     	movq	%rax, %rbx
10415e65d:     	movq	%r12, %rdi
10415e660:     	callq	*0x1c514fa(%rip)        ## 0x105dafb60
10415e666:     	jmp	0x10415e66b
10415e668:     	movq	%rax, %rbx
10415e66b:     	leaq	-0x250(%rbp), %rdi
10415e672:     	callq	0x10415e70a
10415e677:     	movq	-0xc0(%rbp), %rdi
10415e67e:     	callq	*0x1c514dc(%rip)        ## 0x105dafb60
10415e684:     	movq	%rbx, %rdi
10415e687:     	callq	0x105322a16
