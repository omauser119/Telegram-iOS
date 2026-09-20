
/tmp/wallet-x86.macho:	file format mach-o 64-bit x86-64

Disassembly of section __TEXT,__text:

00000001043947c0:
104396880:     	pushq	%rbp
104396881:     	movq	%rsp, %rbp
104396884:     	pushq	%r15
104396886:     	pushq	%r14
104396888:     	pushq	%r13
10439688a:     	pushq	%r12
10439688c:     	pushq	%rbx
10439688d:     	subq	$0x88, %rsp
104396894:     	movq	%r9, -0x60(%rbp)
104396898:     	movq	%rdx, %r13
10439689b:     	movq	%rsi, -0x80(%rbp)
10439689f:     	movq	%rdi, -0x78(%rbp)
1043968a3:     	testb	$0xf, %r13b
1043968a7:     	jne	0x104396c87
1043968ad:     	movq	%r8, %rbx
1043968b0:     	movq	%rcx, %r14
1043968b3:     	movl	$0x48, %edi
1043968b8:     	callq	0x105322c86
1043968bd:     	movq	%rax, %r15
1043968c0:     	leaq	0x8(%rax), %r12
1043968c4:     	xorps	%xmm0, %xmm0
1043968c7:     	movups	%xmm0, 0x8(%rax)
1043968cb:     	movups	%xmm0, 0x18(%rax)
1043968cf:     	movups	%xmm0, 0x28(%rax)
1043968d3:     	movups	%xmm0, 0x38(%rax)
1043968d7:     	movq	$0x40, (%rax)
1043968de:     	movq	%r12, -0x48(%rbp)
1043968e2:     	movq	$0x40, -0x40(%rbp)
1043968ea:     	leaq	-0x48(%rbp), %rdi
1043968ee:     	xorl	%esi, %esi
1043968f0:     	callq	0x10436a1f0
1043968f5:     	movq	(%r15), %r9
1043968f8:     	leaq	0x11300bd(%rip), %rdx   ## 0x1054c69bc
1043968ff:     	movl	$0x12, %ecx
104396904:     	movq	%r14, %rdi
104396907:     	movq	%rbx, %rsi
10439690a:     	movq	%r12, -0xa8(%rbp)
104396911:     	movq	%r12, %r8
104396914:     	callq	0x104367a70
104396919:     	movq	%r15, -0x70(%rbp)
10439691d:     	movq	(%r15), %rax
104396920:     	movl	$0x20, %edx
104396925:     	movl	$0x20, %ecx
10439692a:     	cmpq	$0x20, %rax
10439692e:     	cmovbq	%rax, %rcx
104396932:     	movq	%rcx, -0xa0(%rbp)
104396939:     	jb	0x104396c9f
10439693f:     	addq	$-0x20, %rax
104396943:     	cmpq	$0x20, %rax
104396947:     	cmovbq	%rax, %rdx
10439694b:     	movq	%rdx, -0x50(%rbp)
10439694f:     	leaq	0x10(%rbp), %rax
104396953:     	movq	0x8(%rax), %rbx
104396957:     	movq	%r13, -0x58(%rbp)
10439695b:     	movq	-0x58(%rbp), %rax
10439695f:     	leaq	0x4(%rbx,%rax), %r13
104396964:     	movq	-0x58(%rbp), %rax
104396968:     	leaq	(%rbx,%rax), %r14
10439696c:     	addq	$0xc, %r14
104396970:     	movq	%r14, %rdi
104396973:     	callq	0x105322c86
104396978:     	movq	%rax, %r12
10439697b:     	movq	%rax, %rdi
10439697e:     	movq	%r14, %rsi
104396981:     	callq	0x105322c9e
104396986:     	movq	%r13, (%r12)
10439698a:     	leaq	0x8(%r12), %r15
10439698f:     	movq	%r15, -0x48(%rbp)
104396993:     	movq	%r13, -0x40(%rbp)
104396997:     	movq	-0x58(%rbp), %r13
10439699b:     	leaq	-0x48(%rbp), %rdi
10439699f:     	xorl	%esi, %esi
1043969a1:     	callq	0x10436a1f0
1043969a6:     	movq	%r12, -0x68(%rbp)
1043969aa:     	movq	(%r12), %r14
1043969ae:     	subq	%r13, %r14
1043969b1:     	jb	0x104396c6f
1043969b7:     	movq	%r15, %rdi
1043969ba:     	movq	-0x80(%rbp), %rsi
1043969be:     	movq	%r13, %rdx
1043969c1:     	callq	0x10532329e
1043969c6:     	subq	%rbx, %r14
1043969c9:     	jb	0x104396c6f
1043969cf:     	leaq	0x10(%rbp), %rax
1043969d3:     	movq	(%rax), %rsi
1043969d6:     	leaq	(%r15,%r13), %r12
1043969da:     	movq	%r12, %rdi
1043969dd:     	movq	%rbx, %rdx
1043969e0:     	callq	0x10532329e
1043969e5:     	cmpq	$0x4, %r14
1043969e9:     	jne	0x104396cb7
1043969ef:     	movq	-0x70(%rbp), %rax
1043969f3:     	addq	$0x28, %rax
1043969f7:     	movq	%rax, -0x98(%rbp)
1043969fe:     	leaq	0x112ff05(%rip), %rax   ## 0x1054c690a
104396a05:     	movq	%rax, -0x48(%rbp)
104396a09:     	movl	$0x45, -0x40(%rbp)
104396a10:     	movq	%rbx, -0x90(%rbp)
104396a17:     	leaq	-0x48(%rbp), %rdi
104396a1b:     	leaq	-0x90(%rbp), %rsi
104396a22:     	callq	0x104365c30
104396a27:     	movl	%eax, (%r12,%rbx)
104396a2b:     	movq	-0x68(%rbp), %rax
104396a2f:     	movq	(%rax), %rbx
104396a32:     	movl	$0x28, %edi
104396a37:     	callq	0x105322c86
104396a3c:     	movq	%rax, %r12
104396a3f:     	leaq	0x8(%rax), %r14
104396a43:     	xorps	%xmm0, %xmm0
104396a46:     	movups	%xmm0, 0x8(%rax)
104396a4a:     	movups	%xmm0, 0x18(%rax)
104396a4e:     	movq	$0x20, (%rax)
104396a55:     	movq	%r14, -0x48(%rbp)
104396a59:     	movq	$0x20, -0x40(%rbp)
104396a61:     	leaq	-0x48(%rbp), %rdi
104396a65:     	xorl	%esi, %esi
104396a67:     	callq	0x10436a1f0
104396a6c:     	movq	(%r12), %r9
104396a70:     	movq	-0x98(%rbp), %rdi
104396a77:     	movq	-0x50(%rbp), %rsi
104396a7b:     	movq	%r15, %rdx
104396a7e:     	movq	%rbx, %rcx
104396a81:     	movq	%r14, -0x50(%rbp)
104396a85:     	movq	%r14, %r8
104396a88:     	callq	0x104367920
104396a8d:     	movq	(%r12), %rbx
104396a91:     	movq	-0x60(%rbp), %rdi
104396a95:     	testq	%rdi, %rdi
104396a98:     	je	0x104396ab0
104396a9a:     	cmpq	$0x21, %rbx
104396a9e:     	jae	0x104396c6f
104396aa4:     	movq	-0x50(%rbp), %rsi
104396aa8:     	movq	%rbx, %rdx
104396aab:     	callq	0x10532329e
104396ab0:     	movq	%r12, -0x60(%rbp)
104396ab4:     	cmpq	$0x10, %rbx
104396ab8:     	movl	$0x10, %r14d
104396abe:     	cmovbq	%rbx, %r14
104396ac2:     	leaq	0x10(%r13), %r12
104396ac6:     	leaq	0x18(%r13), %rbx
104396aca:     	movq	%rbx, %rdi
104396acd:     	callq	0x105322c86
104396ad2:     	movq	%rax, %r15
104396ad5:     	movq	%rax, %rdi
104396ad8:     	movq	%rbx, %rsi
104396adb:     	callq	0x105322c9e
104396ae0:     	movq	%r12, (%r15)
104396ae3:     	movq	-0x78(%rbp), %rax
104396ae7:     	movq	%r15, (%rax)
104396aea:     	leaq	0x8(%r15), %rbx
104396aee:     	movq	%rbx, -0x48(%rbp)
104396af2:     	movq	%r12, -0x40(%rbp)
104396af6:     	leaq	-0x48(%rbp), %rdi
104396afa:     	xorl	%esi, %esi
104396afc:     	callq	0x10436a1f0
104396b01:     	movq	(%r15), %r13
104396b04:     	cmpq	%r14, %r13
104396b07:     	jb	0x104396c6f
104396b0d:     	movq	%rbx, %rdi
104396b10:     	movq	-0x50(%rbp), %rsi
104396b14:     	movq	%r14, %rdx
104396b17:     	callq	0x10532329e
104396b1c:     	movl	$0x48, %edi
104396b21:     	callq	0x105322c86
104396b26:     	movq	%rax, %r12
104396b29:     	leaq	0x8(%rax), %rbx
104396b2d:     	xorps	%xmm0, %xmm0
104396b30:     	movups	%xmm0, 0x8(%rax)
104396b34:     	movups	%xmm0, 0x18(%rax)
104396b38:     	movups	%xmm0, 0x28(%rax)
104396b3c:     	movups	%xmm0, 0x38(%rax)
104396b40:     	movq	$0x40, (%rax)
104396b47:     	movq	%rbx, -0x48(%rbp)
104396b4b:     	movq	$0x40, -0x40(%rbp)
104396b53:     	leaq	-0x48(%rbp), %rdi
104396b57:     	xorl	%esi, %esi
104396b59:     	callq	0x10436a1f0
104396b5e:     	movq	(%r12), %r9
104396b62:     	movq	-0xa8(%rbp), %rdi
104396b69:     	movq	-0xa0(%rbp), %rsi
104396b70:     	movq	-0x50(%rbp), %rdx
104396b74:     	movq	%r14, %rcx
104396b77:     	movq	%rbx, %r8
104396b7a:     	callq	0x104367a70
104396b7f:     	movq	(%r12), %rdx
104396b83:     	leaq	-0x48(%rbp), %rdi
104396b87:     	movq	%rbx, %rsi
104396b8a:     	callq	0x1043963f0
104396b8f:     	movq	(%r12), %rax
104396b93:     	addq	$0x8, %rax
104396b97:     	movq	%r12, -0x90(%rbp)
104396b9e:     	movq	%rax, -0x88(%rbp)
104396ba5:     	leaq	-0x90(%rbp), %rdi
104396bac:     	callq	0x10436a230
104396bb1:     	movq	%r12, %rdi
104396bb4:     	callq	0x105322c7a
104396bb9:     	cmpq	$0xf, %r13
104396bbd:     	jbe	0x104396ccf
104396bc3:     	addq	$0x18, %r15
104396bc7:     	addq	$-0x10, %r13
104396bcb:     	leaq	-0x48(%rbp), %rbx
104396bcf:     	movq	%rbx, %rdi
104396bd2:     	movq	-0x80(%rbp), %rsi
104396bd6:     	movq	-0x58(%rbp), %rdx
104396bda:     	movq	%r15, %rcx
104396bdd:     	movq	%r13, %r8
104396be0:     	callq	0x104366f80
104396be5:     	movq	%rbx, %rdi
104396be8:     	callq	0x104366f70
104396bed:     	movq	-0x60(%rbp), %rbx
104396bf1:     	movq	(%rbx), %rax
104396bf4:     	addq	$0x8, %rax
104396bf8:     	movq	%rbx, -0x48(%rbp)
104396bfc:     	movq	%rax, -0x40(%rbp)
104396c00:     	leaq	-0x48(%rbp), %rdi
104396c04:     	callq	0x10436a230
104396c09:     	movq	%rbx, %rdi
104396c0c:     	callq	0x105322c7a
104396c11:     	movq	-0x68(%rbp), %rbx
104396c15:     	movq	(%rbx), %rax
104396c18:     	addq	$0x8, %rax
104396c1c:     	movq	%rbx, -0x48(%rbp)
104396c20:     	movq	%rax, -0x40(%rbp)
104396c24:     	leaq	-0x48(%rbp), %rdi
104396c28:     	callq	0x10436a230
104396c2d:     	movq	%rbx, %rdi
104396c30:     	callq	0x105322c7a
104396c35:     	movq	-0x70(%rbp), %rbx
104396c39:     	movq	(%rbx), %rax
104396c3c:     	addq	$0x8, %rax
104396c40:     	movq	%rbx, -0x48(%rbp)
104396c44:     	movq	%rax, -0x40(%rbp)
104396c48:     	leaq	-0x48(%rbp), %rdi
104396c4c:     	callq	0x10436a230
104396c51:     	movq	%rbx, %rdi
104396c54:     	callq	0x105322c7a
104396c59:     	movq	-0x78(%rbp), %rax
104396c5d:     	addq	$0x88, %rsp
104396c64:     	popq	%rbx
104396c65:     	popq	%r12
104396c67:     	popq	%r13
104396c69:     	popq	%r14
104396c6b:     	popq	%r15
104396c6d:     	popq	%rbp
104396c6e:     	retq
104396c6f:     	leaq	0x112ad69(%rip), %rdi   ## 0x1054c19df
104396c76:     	leaq	0x112a795(%rip), %rsi   ## 0x1054c1412
104396c7d:     	movl	$0x7e, %edx
104396c82:     	callq	0x104366700
104396c87:     	leaq	0x112fd18(%rip), %rdi   ## 0x1054c69a6
104396c8e:     	leaq	0x112fc75(%rip), %rsi   ## 0x1054c690a
104396c95:     	movl	$0x39, %edx
104396c9a:     	callq	0x104366700
104396c9f:     	leaq	0x112aeef(%rip), %rdi   ## 0x1054c1b95
104396ca6:     	leaq	0x112a765(%rip), %rsi   ## 0x1054c1412
104396cad:     	movl	$0x67, %edx
104396cb2:     	callq	0x104366700
104396cb7:     	leaq	0x112fd11(%rip), %rdi   ## 0x1054c69cf
104396cbe:     	leaq	0x112fc45(%rip), %rsi   ## 0x1054c690a
104396cc5:     	movl	$0x44, %edx
104396cca:     	callq	0x104366700
104396ccf:     	leaq	0x112aebf(%rip), %rdi   ## 0x1054c1b95
104396cd6:     	leaq	0x112a735(%rip), %rsi   ## 0x1054c1412
104396cdd:     	movl	$0x63, %edx
104396ce2:     	callq	0x104366700
104396ce7:     	nopw	(%rax,%rax)
104396cf0:     	pushq	%rbp
104396cf1:     	movq	%rsp, %rbp
104396cf4:     	pushq	%r15
104396cf6:     	pushq	%r14
104396cf8:     	pushq	%r13
104396cfa:     	pushq	%r12
104396cfc:     	pushq	%rbx
104396cfd:     	subq	$0x28, %rsp
104396d01:     	movq	%r8, -0x38(%rbp)
104396d05:     	movq	%rcx, -0x30(%rbp)
104396d09:     	movq	%rdx, %r12
104396d0c:     	movq	%rsi, %r13
104396d0f:     	movq	%rdi, %rbx
104396d12:     	movl	$0x48, %edi
104396d17:     	callq	0x105322c86
104396d1c:     	movq	%rax, %r14
104396d1f:     	leaq	0x8(%rax), %r15
104396d23:     	xorps	%xmm0, %xmm0
104396d26:     	movups	%xmm0, 0x8(%rax)
104396d2a:     	movups	%xmm0, 0x18(%rax)
104396d2e:     	movups	%xmm0, 0x28(%rax)
104396d32:     	movups	%xmm0, 0x38(%rax)
104396d36:     	movq	$0x40, (%rax)
104396d3d:     	movq	%rax, (%rbx)
104396d40:     	movq	%r15, -0x48(%rbp)
104396d44:     	movq	$0x40, -0x40(%rbp)
104396d4c:     	leaq	-0x48(%rbp), %rdi
104396d50:     	xorl	%esi, %esi
104396d52:     	callq	0x10436a1f0
104396d57:     	movq	(%r14), %r9
104396d5a:     	movq	%r13, %rdi
104396d5d:     	movq	%r12, %rsi
104396d60:     	movq	-0x30(%rbp), %rdx
104396d64:     	movq	-0x38(%rbp), %rcx
104396d68:     	movq	%r15, %r8
104396d6b:     	callq	0x104367a70
104396d70:     	movq	%rbx, %rax
104396d73:     	addq	$0x28, %rsp
104396d77:     	popq	%rbx
104396d78:     	popq	%r12
104396d7a:     	popq	%r13
104396d7c:     	popq	%r14
104396d7e:     	popq	%r15
104396d80:     	popq	%rbp
104396d81:     	retq
104396d82:     	nopw	%cs:(%rax,%rax)
104396d90:     	pushq	%rbp
104396d91:     	movq	%rsp, %rbp
104396d94:     	pushq	%r15
104396d96:     	pushq	%r14
104396d98:     	pushq	%r13
104396d9a:     	pushq	%r12
104396d9c:     	pushq	%rbx
104396d9d:     	subq	$0x58, %rsp
104396da1:     	movq	%r9, -0x60(%rbp)
104396da5:     	movq	%r8, -0x58(%rbp)
104396da9:     	movq	%rcx, -0x50(%rbp)
104396dad:     	movq	%rdx, %r15
104396db0:     	movq	%rsi, -0x48(%rbp)
104396db4:     	movq	%rdi, %rbx
104396db7:     	leaq	-0x70(%rbp), %rdi
104396dbb:     	movl	$0x10, %edx
104396dc0:     	movq	%r15, %rsi
104396dc3:     	callq	0x104396500
104396dc8:     	movq	-0x70(%rbp), %r14
104396dcc:     	testq	%r14, %r14
104396dcf:     	movq	%rbx, -0x68(%rbp)
104396dd3:     	je	0x104396dda
104396dd5:     	movq	(%r14), %r12
104396dd8:     	jmp	0x104396ddd
104396dda:     	xorl	%r12d, %r12d
104396ddd:     	leaq	(%r12,%r15), %rbx
104396de1:     	addq	$0x8, %rbx
104396de5:     	addq	%r15, %r12
104396de8:     	movq	%rbx, %rdi
104396deb:     	callq	0x105322c86
104396df0:     	movq	%rax, %r13
104396df3:     	movq	%rax, %rdi
104396df6:     	movq	%rbx, %rsi
104396df9:     	callq	0x105322c9e
104396dfe:     	leaq	0x8(%r13), %rax
104396e02:     	movq	%rax, -0x30(%rbp)
104396e06:     	movq	%r12, (%r13)
104396e0a:     	testq	%r14, %r14
104396e0d:     	je	0x104396ed3
104396e13:     	movq	(%r14), %rbx
104396e16:     	cmpq	%rbx, %r12
104396e19:     	jb	0x104396ee1
104396e1f:     	leaq	0x8(%r14), %rsi
104396e23:     	movq	-0x30(%rbp), %rdi
104396e27:     	movq	%rbx, %rdx
104396e2a:     	callq	0x10532329e
104396e2f:     	subq	%rbx, %r12
104396e32:     	cmpq	%r15, %r12
104396e35:     	jb	0x104396ee1
104396e3b:     	movq	-0x30(%rbp), %r12
104396e3f:     	addq	%r12, %rbx
104396e42:     	movq	%rbx, %rdi
104396e45:     	movq	-0x48(%rbp), %rsi
104396e49:     	movq	%r15, %rdx
104396e4c:     	callq	0x10532329e
104396e51:     	movq	(%r13), %rdx
104396e55:     	leaq	0x10(%rbp), %rax
104396e59:     	movups	(%rax), %xmm0
104396e5c:     	movups	%xmm0, (%rsp)
104396e60:     	movq	-0x68(%rbp), %rbx
104396e64:     	movq	%rbx, %rdi
104396e67:     	movq	%r12, %rsi
104396e6a:     	movq	-0x50(%rbp), %rcx
104396e6e:     	movq	-0x58(%rbp), %r8
104396e72:     	movq	-0x60(%rbp), %r9
104396e76:     	callq	0x104396880
104396e7b:     	movq	(%r13), %rax
104396e7f:     	addq	$0x8, %rax
104396e83:     	movq	%r13, -0x40(%rbp)
104396e87:     	movq	%rax, -0x38(%rbp)
104396e8b:     	leaq	-0x40(%rbp), %rdi
104396e8f:     	callq	0x10436a230
104396e94:     	movq	%r13, %rdi
104396e97:     	callq	0x105322c7a
104396e9c:     	testq	%r14, %r14
104396e9f:     	je	0x104396ec1
104396ea1:     	movq	(%r14), %rax
104396ea4:     	addq	$0x8, %rax
104396ea8:     	movq	%r14, -0x40(%rbp)
104396eac:     	movq	%rax, -0x38(%rbp)
104396eb0:     	leaq	-0x40(%rbp), %rdi
104396eb4:     	callq	0x10436a230
104396eb9:     	movq	%r14, %rdi
104396ebc:     	callq	0x105322c7a
104396ec1:     	movq	%rbx, %rax
104396ec4:     	addq	$0x58, %rsp
104396ec8:     	popq	%rbx
104396ec9:     	popq	%r12
104396ecb:     	popq	%r13
104396ecd:     	popq	%r14
104396ecf:     	popq	%r15
104396ed1:     	popq	%rbp
104396ed2:     	retq
104396ed3:     	xorl	%ebx, %ebx
104396ed5:     	subq	%rbx, %r12
104396ed8:     	cmpq	%r15, %r12
104396edb:     	jae	0x104396e3b
104396ee1:     	leaq	0x112aaf7(%rip), %rdi   ## 0x1054c19df
104396ee8:     	leaq	0x112a523(%rip), %rsi   ## 0x1054c1412
104396eef:     	movl	$0x7e, %edx
