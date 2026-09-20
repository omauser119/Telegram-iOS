
/tmp/wallet-x86.macho:	file format mach-o 64-bit x86-64

Disassembly of section __TEXT,__text:

0000000100004000:
1012b6b70:     	pushq	%rbp
1012b6b71:     	movq	%rsp, %rbp
1012b6b74:     	pushq	%r15
1012b6b76:     	pushq	%r14
1012b6b78:     	pushq	%r13
1012b6b7a:     	pushq	%r12
1012b6b7c:     	pushq	%rbx
1012b6b7d:     	subq	$0xb8, %rsp
1012b6b84:     	movq	%rdx, %rbx
1012b6b87:     	movq	%rdi, %r13
1012b6b8a:     	movq	0x4af9007(%rip), %rax   ## 0x105dafb98
1012b6b91:     	movq	(%rax), %rax
1012b6b94:     	movq	%rax, -0x30(%rbp)
1012b6b98:     	testb	$0x1, %sil
1012b6b9c:     	je	0x1012b6bb3
1012b6b9e:     	movl	$0xa281cb31, -0x48(%rbp) ## imm = 0xA281CB31
1012b6ba5:     	leaq	-0x48(%rbp), %rdi
1012b6ba9:     	movl	$0x4, %esi
1012b6bae:     	callq	0x1014f5020
1012b6bb3:     	leaq	0x10(%rbx), %r14
1012b6bb7:     	leaq	-0x48(%rbp), %rsi
1012b6bbb:     	movq	%r14, %rdi
1012b6bbe:     	xorl	%edx, %edx
1012b6bc0:     	xorl	%ecx, %ecx
1012b6bc2:     	callq	0x105323730
1012b6bc7:     	movl	0x10(%rbx), %eax
1012b6bca:     	movl	%eax, -0x60(%rbp)
1012b6bcd:     	leaq	-0x60(%rbp), %rdi
1012b6bd1:     	movl	$0x4, %esi
1012b6bd6:     	callq	0x1014f5020
1012b6bdb:     	leaq	0x18(%rbx), %rdi
1012b6bdf:     	leaq	-0x60(%rbp), %rsi
1012b6be3:     	xorl	%edx, %edx
1012b6be5:     	xorl	%ecx, %ecx
1012b6be7:     	callq	0x105323730
1012b6bec:     	movq	0x18(%rbx), %rax
1012b6bf0:     	movq	%rax, -0x78(%rbp)
1012b6bf4:     	leaq	-0x78(%rbp), %rdi
1012b6bf8:     	movl	$0x8, %esi
1012b6bfd:     	callq	0x1014f5020
1012b6c02:     	leaq	0x20(%rbx), %rdi
1012b6c06:     	leaq	-0x78(%rbp), %rsi
1012b6c0a:     	xorl	%edx, %edx
1012b6c0c:     	xorl	%ecx, %ecx
1012b6c0e:     	callq	0x105323730
1012b6c13:     	movq	0x20(%rbx), %rax
1012b6c17:     	movq	%rax, -0x90(%rbp)
1012b6c1e:     	leaq	-0x90(%rbp), %rdi
1012b6c25:     	movl	$0x8, %esi
1012b6c2a:     	callq	0x1014f5020
1012b6c2f:     	leaq	0x28(%rbx), %rdi
1012b6c33:     	leaq	-0x90(%rbp), %rsi
1012b6c3a:     	xorl	%edx, %edx
1012b6c3c:     	xorl	%ecx, %ecx
1012b6c3e:     	callq	0x105323730
1012b6c43:     	movq	0x28(%rbx), %r15
1012b6c47:     	movq	%r15, %rdi
1012b6c4a:     	callq	0x105323910
1012b6c4f:     	movq	%r15, %rdi
1012b6c52:     	movq	%r13, %rsi
1012b6c55:     	xorl	%edx, %edx
1012b6c57:     	callq	0x1014f44a0
1012b6c5c:     	movq	%r15, %rdi
1012b6c5f:     	callq	0x105323904
1012b6c64:     	leaq	0x30(%rbx), %rdi
1012b6c68:     	leaq	-0xa8(%rbp), %rsi
1012b6c6f:     	xorl	%edx, %edx
1012b6c71:     	xorl	%ecx, %ecx
1012b6c73:     	callq	0x105323730
1012b6c78:     	movl	0x30(%rbx), %eax
1012b6c7b:     	movl	%eax, -0xc0(%rbp)
1012b6c81:     	leaq	-0xc0(%rbp), %rdi
1012b6c88:     	movl	$0x4, %esi
1012b6c8d:     	callq	0x1014f5020
1012b6c92:     	movl	0x10(%rbx), %eax
1012b6c95:     	testb	$0x1, %al
1012b6c97:     	je	0x1012b6ce4
1012b6c99:     	leaq	0x38(%rbx), %r12
1012b6c9d:     	leaq	-0xc0(%rbp), %rsi
1012b6ca4:     	movq	%r12, %rdi
1012b6ca7:     	xorl	%edx, %edx
1012b6ca9:     	xorl	%ecx, %ecx
1012b6cab:     	callq	0x105323730
1012b6cb0:     	movq	0x40(%rbx), %r15
1012b6cb4:     	testq	%r15, %r15
1012b6cb7:     	je	0x1012b6d52
1012b6cbd:     	movq	(%r12), %r12
1012b6cc1:     	movq	%r15, %rdi
1012b6cc4:     	callq	0x105323742
1012b6cc9:     	movq	%r12, %rdi
1012b6ccc:     	movq	%r15, %rsi
1012b6ccf:     	movq	%r13, %rdx
1012b6cd2:     	xorl	%ecx, %ecx
1012b6cd4:     	callq	0x1014f4320
1012b6cd9:     	movq	%r15, %rdi
1012b6cdc:     	callq	0x105323736
1012b6ce1:     	movl	(%r14), %eax
1012b6ce4:     	testb	$0x2, %al
1012b6ce6:     	je	0x1012b6d2b
1012b6ce8:     	leaq	0x48(%rbx), %r14
1012b6cec:     	leaq	-0xd8(%rbp), %rsi
1012b6cf3:     	movq	%r14, %rdi
1012b6cf6:     	xorl	%edx, %edx
1012b6cf8:     	xorl	%ecx, %ecx
1012b6cfa:     	callq	0x105323730
1012b6cff:     	movq	0x50(%rbx), %rbx
1012b6d03:     	testq	%rbx, %rbx
1012b6d06:     	je	0x1012b6d54
1012b6d08:     	movq	(%r14), %r14
1012b6d0b:     	movq	%rbx, %rdi
1012b6d0e:     	callq	0x105323742
1012b6d13:     	movq	%r14, %rdi
1012b6d16:     	movq	%rbx, %rsi
1012b6d19:     	movq	%r13, %rdx
1012b6d1c:     	xorl	%ecx, %ecx
1012b6d1e:     	callq	0x1014f4320
1012b6d23:     	movq	%rbx, %rdi
1012b6d26:     	callq	0x105323736
1012b6d2b:     	movq	0x4af8e66(%rip), %rax   ## 0x105dafb98
1012b6d32:     	movq	(%rax), %rax
1012b6d35:     	cmpq	-0x30(%rbp), %rax
1012b6d39:     	jne	0x1012b6d4d
1012b6d3b:     	addq	$0xb8, %rsp
1012b6d42:     	popq	%rbx
1012b6d43:     	popq	%r12
1012b6d45:     	popq	%r13
1012b6d47:     	popq	%r14
1012b6d49:     	popq	%r15
1012b6d4b:     	popq	%rbp
1012b6d4c:     	retq
1012b6d4d:     	callq	0x105322d34
1012b6d52:     	ud2
1012b6d54:     	ud2
1012b6d56:     	nopw	%cs:(%rax,%rax)
1012b6d60:     	pushq	%rbp
1012b6d61:     	movq	%rsp, %rbp
1012b6d64:     	pushq	%r15
1012b6d66:     	pushq	%r14
1012b6d68:     	pushq	%r13
1012b6d6a:     	pushq	%r12
1012b6d6c:     	pushq	%rbx
1012b6d6d:     	subq	$0x128, %rsp            ## imm = 0x128
1012b6d74:     	movq	%rdx, %rbx
1012b6d77:     	movq	%rdi, %r13
1012b6d7a:     	movq	0x4af8e17(%rip), %rax   ## 0x105dafb98
1012b6d81:     	movq	(%rax), %rax
1012b6d84:     	movq	%rax, -0x30(%rbp)
1012b6d88:     	testb	$0x1, %sil
1012b6d8c:     	je	0x1012b6da3
1012b6d8e:     	movl	$0x126556c6, -0x48(%rbp) ## imm = 0x126556C6
1012b6d95:     	leaq	-0x48(%rbp), %rdi
1012b6d99:     	movl	$0x4, %esi
1012b6d9e:     	callq	0x1014f5020
1012b6da3:     	leaq	0x10(%rbx), %r14
1012b6da7:     	leaq	-0x48(%rbp), %rsi
1012b6dab:     	movq	%r14, %rdi
1012b6dae:     	xorl	%edx, %edx
1012b6db0:     	xorl	%ecx, %ecx
1012b6db2:     	callq	0x105323730
1012b6db7:     	movl	0x10(%rbx), %eax
1012b6dba:     	movl	%eax, -0x60(%rbp)
1012b6dbd:     	leaq	-0x60(%rbp), %rdi
1012b6dc1:     	movl	$0x4, %esi
1012b6dc6:     	callq	0x1014f5020
1012b6dcb:     	leaq	0x18(%rbx), %rdi
1012b6dcf:     	leaq	-0x60(%rbp), %rsi
1012b6dd3:     	xorl	%edx, %edx
1012b6dd5:     	xorl	%ecx, %ecx
1012b6dd7:     	callq	0x105323730
1012b6ddc:     	movq	0x18(%rbx), %rax
1012b6de0:     	movq	%rax, -0x78(%rbp)
1012b6de4:     	leaq	-0x78(%rbp), %rdi
1012b6de8:     	movl	$0x8, %esi
1012b6ded:     	callq	0x1014f5020
1012b6df2:     	leaq	0x20(%rbx), %rdi
1012b6df6:     	leaq	-0x78(%rbp), %rsi
1012b6dfa:     	xorl	%edx, %edx
1012b6dfc:     	xorl	%ecx, %ecx
1012b6dfe:     	callq	0x105323730
1012b6e03:     	movq	0x20(%rbx), %r15
1012b6e07:     	movq	0x28(%rbx), %r12
1012b6e0b:     	movq	%r12, %rdi
1012b6e0e:     	callq	0x105323742
1012b6e13:     	movq	%r15, %rdi
1012b6e16:     	movq	%r12, %rsi
1012b6e19:     	movq	%r13, %rdx
1012b6e1c:     	xorl	%ecx, %ecx
1012b6e1e:     	callq	0x1014f4320
1012b6e23:     	movq	%r12, %rdi
1012b6e26:     	callq	0x105323736
1012b6e2b:     	testb	$0x8, 0x10(%rbx)
1012b6e2f:     	je	0x1012b6e79
1012b6e31:     	leaq	0x30(%rbx), %r12
1012b6e35:     	leaq	-0x90(%rbp), %rsi
1012b6e3c:     	movq	%r12, %rdi
1012b6e3f:     	xorl	%edx, %edx
1012b6e41:     	xorl	%ecx, %ecx
1012b6e43:     	callq	0x105323730
1012b6e48:     	movq	0x38(%rbx), %r15
1012b6e4c:     	testq	%r15, %r15
1012b6e4f:     	je	0x1012b7059
1012b6e55:     	movq	(%r12), %r12
1012b6e59:     	movq	%r15, %rdi
1012b6e5c:     	callq	0x105323742
1012b6e61:     	movq	%r12, %rdi
1012b6e64:     	movq	%r15, %rsi
1012b6e67:     	movq	%r13, %rdx
1012b6e6a:     	xorl	%ecx, %ecx
1012b6e6c:     	callq	0x1014f4320
1012b6e71:     	movq	%r15, %rdi
1012b6e74:     	callq	0x105323736
1012b6e79:     	leaq	0x40(%rbx), %rdi
1012b6e7d:     	leaq	-0xa8(%rbp), %rsi
1012b6e84:     	xorl	%edx, %edx
1012b6e86:     	xorl	%ecx, %ecx
1012b6e88:     	callq	0x105323730
1012b6e8d:     	movq	0x40(%rbx), %r15
1012b6e91:     	movq	%r15, %rdi
1012b6e94:     	callq	0x105323910
1012b6e99:     	movq	%r15, %rdi
1012b6e9c:     	movq	%r13, %rsi
1012b6e9f:     	xorl	%edx, %edx
1012b6ea1:     	callq	0x1014f44a0
1012b6ea6:     	movq	%r15, %rdi
1012b6ea9:     	callq	0x105323904
1012b6eae:     	movl	0x10(%rbx), %eax
1012b6eb1:     	testb	$0x10, %al
1012b6eb3:     	je	0x1012b6fc9
1012b6eb9:     	movq	%r14, -0x148(%rbp)
1012b6ec0:     	leaq	0x48(%rbx), %rdi
1012b6ec4:     	leaq	-0xc0(%rbp), %rsi
1012b6ecb:     	xorl	%edx, %edx
1012b6ecd:     	xorl	%ecx, %ecx
1012b6ecf:     	callq	0x105323730
1012b6ed4:     	movq	0x48(%rbx), %r15
1012b6ed8:     	testq	%r15, %r15
1012b6edb:     	je	0x1012b705b
1012b6ee1:     	movl	$0xd0f263bc, -0xd8(%rbp) ## imm = 0xD0F263BC
1012b6eeb:     	movq	%r15, %rdi
1012b6eee:     	callq	0x105323910
1012b6ef3:     	leaq	-0xd8(%rbp), %rdi
1012b6efa:     	movl	$0x4, %esi
1012b6eff:     	callq	0x1014f5020
1012b6f04:     	leaq	0x10(%r15), %rdi
1012b6f08:     	leaq	-0xd8(%rbp), %rsi
1012b6f0f:     	xorl	%edx, %edx
1012b6f11:     	xorl	%ecx, %ecx
1012b6f13:     	callq	0x105323730
1012b6f18:     	movq	0x10(%r15), %r12
1012b6f1c:     	movq	0x18(%r15), %r14
1012b6f20:     	movq	%r14, %rdi
1012b6f23:     	callq	0x105323742
1012b6f28:     	movq	%r12, %rdi
1012b6f2b:     	movq	%r14, %rsi
1012b6f2e:     	movq	%r13, %rdx
1012b6f31:     	xorl	%ecx, %ecx
1012b6f33:     	callq	0x1014f4320
1012b6f38:     	movq	%r14, %rdi
1012b6f3b:     	callq	0x105323736
1012b6f40:     	leaq	0x20(%r15), %rdi
1012b6f44:     	leaq	-0xf0(%rbp), %rsi
1012b6f4b:     	xorl	%edx, %edx
1012b6f4d:     	xorl	%ecx, %ecx
1012b6f4f:     	callq	0x105323730
1012b6f54:     	movq	0x20(%r15), %r14
1012b6f58:     	movq	0x28(%r15), %r12
1012b6f5c:     	movq	%r12, %rdi
1012b6f5f:     	callq	0x105323742
1012b6f64:     	movq	%r14, %rdi
1012b6f67:     	movq	%r12, %rsi
1012b6f6a:     	movq	%r13, %rdx
1012b6f6d:     	xorl	%ecx, %ecx
1012b6f6f:     	callq	0x1014f4320
1012b6f74:     	movq	%r12, %rdi
1012b6f77:     	callq	0x105323736
1012b6f7c:     	leaq	0x30(%r15), %rdi
1012b6f80:     	leaq	-0x108(%rbp), %rsi
1012b6f87:     	xorl	%edx, %edx
1012b6f89:     	xorl	%ecx, %ecx
1012b6f8b:     	callq	0x105323730
1012b6f90:     	movq	0x30(%r15), %r14
1012b6f94:     	movq	0x38(%r15), %r12
1012b6f98:     	movq	%r12, %rdi
1012b6f9b:     	callq	0x105323742
1012b6fa0:     	movq	%r14, %rdi
1012b6fa3:     	movq	%r12, %rsi
1012b6fa6:     	movq	%r13, %rdx
1012b6fa9:     	xorl	%ecx, %ecx
1012b6fab:     	callq	0x1014f4320
1012b6fb0:     	movq	%r15, %rdi
1012b6fb3:     	callq	0x105323904
1012b6fb8:     	movq	%r12, %rdi
1012b6fbb:     	callq	0x105323736
1012b6fc0:     	movq	-0x148(%rbp), %rax
1012b6fc7:     	movl	(%rax), %eax
1012b6fc9:     	testb	$0x20, %al
1012b6fcb:     	je	0x1012b7004
1012b6fcd:     	leaq	0x50(%rbx), %r14
1012b6fd1:     	leaq	-0x120(%rbp), %rsi
1012b6fd8:     	movq	%r14, %rdi
1012b6fdb:     	xorl	%edx, %edx
1012b6fdd:     	xorl	%ecx, %ecx
1012b6fdf:     	callq	0x105323730
1012b6fe4:     	cmpb	$0x0, 0x54(%rbx)
1012b6fe8:     	jne	0x1012b705d
1012b6fea:     	movl	(%r14), %eax
1012b6fed:     	movl	%eax, -0x138(%rbp)
1012b6ff3:     	leaq	-0x138(%rbp), %rdi
1012b6ffa:     	movl	$0x4, %esi
1012b6fff:     	callq	0x1014f5020
1012b7004:     	leaq	0x58(%rbx), %rdi
1012b7008:     	leaq	-0x138(%rbp), %rsi
1012b700f:     	xorl	%edx, %edx
1012b7011:     	xorl	%ecx, %ecx
1012b7013:     	callq	0x105323730
1012b7018:     	movl	0x58(%rbx), %eax
1012b701b:     	movl	%eax, -0x13c(%rbp)
1012b7021:     	leaq	-0x13c(%rbp), %rdi
1012b7028:     	movl	$0x4, %esi
1012b702d:     	callq	0x1014f5020
1012b7032:     	movq	0x4af8b5f(%rip), %rax   ## 0x105dafb98
1012b7039:     	movq	(%rax), %rax
1012b703c:     	cmpq	-0x30(%rbp), %rax
1012b7040:     	jne	0x1012b7054
1012b7042:     	addq	$0x128, %rsp            ## imm = 0x128
1012b7049:     	popq	%rbx
1012b704a:     	popq	%r12
1012b704c:     	popq	%r13
1012b704e:     	popq	%r14
