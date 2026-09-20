
/tmp/wallet-x86.macho:	file format mach-o 64-bit x86-64

Disassembly of section __TEXT,__text:

000000010437a8f0:
10438be90:     	pushq	%rbp
10438be91:     	movq	%rsp, %rbp
10438be94:     	pushq	%r15
10438be96:     	pushq	%r14
10438be98:     	pushq	%rbx
10438be99:     	subq	$0x58, %rsp
10438be9d:     	movq	%rdx, %rcx
10438bea0:     	movq	%rsi, %rdx
10438bea3:     	movq	%rdi, %rbx
10438bea6:     	movzbl	0x24cb213(%rip), %eax   ## 0x1068570c0
10438bead:     	testb	%al, %al
10438beaf:     	je	0x10438bf7e
10438beb5:     	leaq	0x2392e74(%rip), %rsi   ## 0x10671ed30
10438bebc:     	leaq	-0x28(%rbp), %rdi
10438bec0:     	callq	0x10438bfa0
10438bec5:     	cmpq	$0x0, -0x28(%rbp)
10438beca:     	je	0x10438bef7
10438becc:     	leaq	-0x48(%rbp), %rdi
10438bed0:     	leaq	-0x28(%rbp), %rsi
10438bed4:     	callq	0x1043942e0
10438bed9:     	movl	-0x48(%rbp), %eax
10438bedc:     	movl	%eax, -0x70(%rbp)
10438bedf:     	movups	-0x40(%rbp), %xmm0
10438bee3:     	movups	%xmm0, -0x68(%rbp)
10438bee7:     	movq	-0x30(%rbp), %rax
10438beeb:     	movq	%rax, -0x58(%rbp)
10438beef:     	movl	$0x1, %r14d
10438bef5:     	jmp	0x10438bf0b
10438bef7:     	leaq	0x236ecf2(%rip), %rax   ## 0x1066fabf0
10438befe:     	movl	(%rax), %eax
10438bf00:     	movq	-0x20(%rbp), %rax
10438bf04:     	movq	%rax, -0x70(%rbp)
10438bf08:     	xorl	%r14d, %r14d
10438bf0b:     	movl	%r14d, -0x50(%rbp)
10438bf0f:     	movb	$0x0, (%rbx)
10438bf12:     	movl	$0xffffffff, 0x20(%rbx) ## imm = 0xFFFFFFFF
10438bf19:     	movq	%rbx, -0x48(%rbp)
10438bf1d:     	movl	%r14d, %eax
10438bf20:     	leaq	0x1c4ec49(%rip), %rcx   ## 0x105fdab70
10438bf27:     	leaq	-0x48(%rbp), %rdi
10438bf2b:     	leaq	-0x70(%rbp), %rsi
10438bf2f:     	callq	*(%rcx,%rax,8)
10438bf32:     	movl	%r14d, 0x20(%rbx)
10438bf36:     	movl	-0x50(%rbp), %eax
10438bf39:     	movl	$0xffffffff, %ecx       ## imm = 0xFFFFFFFF
10438bf3e:     	cmpq	%rcx, %rax
10438bf41:     	je	0x10438bf55
10438bf43:     	leaq	0x1c4ec16(%rip), %rcx   ## 0x105fdab60
10438bf4a:     	leaq	-0x48(%rbp), %rdi
10438bf4e:     	leaq	-0x70(%rbp), %rsi
10438bf52:     	callq	*(%rcx,%rax,8)
10438bf55:     	movq	-0x28(%rbp), %rdi
10438bf59:     	movq	$0x0, -0x28(%rbp)
10438bf61:     	testq	%rdi, %rdi
10438bf64:     	je	0x10438bf70
10438bf66:     	testb	$0x1, (%rdi)
10438bf69:     	jne	0x10438bf70
10438bf6b:     	callq	0x105322c7a
10438bf70:     	movq	%rbx, %rax
10438bf73:     	addq	$0x58, %rsp
10438bf77:     	popq	%rbx
10438bf78:     	popq	%r14
10438bf7a:     	popq	%r15
10438bf7c:     	popq	%rbp
10438bf7d:     	retq
10438bf7e:     	movq	%rcx, %r14
10438bf81:     	movq	%rdx, %r15
10438bf84:     	callq	0x1052f4870
10438bf89:     	movq	%r15, %rdx
10438bf8c:     	movq	%r14, %rcx
10438bf8f:     	jmp	0x10438beb5
10438bf94:     	nopw	%cs:(%rax,%rax)
10438bfa0:     	pushq	%rbp
10438bfa1:     	movq	%rsp, %rbp
10438bfa4:     	pushq	%r15
10438bfa6:     	pushq	%r14
10438bfa8:     	pushq	%r13
10438bfaa:     	pushq	%r12
10438bfac:     	pushq	%rbx
10438bfad:     	subq	$0x148, %rsp            ## imm = 0x148
10438bfb4:     	movq	%rdx, %r15
10438bfb7:     	movq	%rsi, %r14
10438bfba:     	movq	%rdi, %rbx
10438bfbd:     	movq	0x1a23bd4(%rip), %rax   ## 0x105dafb98
10438bfc4:     	movq	(%rax), %rax
10438bfc7:     	movq	%rax, -0x30(%rbp)
10438bfcb:     	leaq	-0xd0(%rbp), %r12
10438bfd2:     	movq	%r12, %rdi
10438bfd5:     	movq	%rcx, %rdx
10438bfd8:     	callq	0x1043918a0
10438bfdd:     	movq	-0xd0(%rbp), %r13
10438bfe4:     	testq	%r13, %r13
10438bfe7:     	je	0x10438c043
10438bfe9:     	leaq	0x1c4ea40(%rip), %rax   ## 0x105fdaa30
10438bff0:     	addq	$0x10, %rax
10438bff4:     	movq	%rax, -0xa0(%rbp)
10438bffb:     	leaq	-0x98(%rbp), %rdi
10438c002:     	movq	%r12, -0x98(%rbp)
10438c009:     	movb	$0x0, -0x90(%rbp)
10438c010:     	movq	$0x0, -0xd0(%rbp)
10438c01b:     	callq	0x104379550
10438c020:     	movq	%r13, (%rbx)
10438c023:     	movq	-0xd0(%rbp), %rdi
10438c02a:     	testq	%rdi, %rdi
10438c02d:     	je	0x10438c0da
10438c033:     	movq	$0x0, -0xd0(%rbp)
10438c03e:     	jmp	0x10438c120
10438c043:     	movups	-0xc8(%rbp), %xmm0
10438c04a:     	movaps	%xmm0, -0x110(%rbp)
10438c051:     	xorps	%xmm0, %xmm0
10438c054:     	movups	%xmm0, -0xc8(%rbp)
10438c05b:     	leaq	-0xb8(%rbp), %r12
10438c062:     	movq	%r12, %rdi
10438c065:     	movq	%r14, %rsi
10438c068:     	movq	%r15, %rdx
10438c06b:     	callq	0x104391150
10438c070:     	movq	-0xb8(%rbp), %r15
10438c077:     	testq	%r15, %r15
10438c07a:     	je	0x10438c153
10438c080:     	leaq	0x1c4e8b9(%rip), %rax   ## 0x105fda940
10438c087:     	addq	$0x10, %rax
10438c08b:     	movq	%rax, -0xa0(%rbp)
10438c092:     	leaq	-0x98(%rbp), %rdi
10438c099:     	movq	%r12, -0x98(%rbp)
10438c0a0:     	movb	$0x0, -0x90(%rbp)
10438c0a7:     	movq	$0x0, -0xb8(%rbp)
10438c0b2:     	callq	0x104379550
10438c0b7:     	movq	%r15, (%rbx)
10438c0ba:     	movq	-0xb8(%rbp), %rdi
10438c0c1:     	testq	%rdi, %rdi
10438c0c4:     	je	0x10438c3cc
10438c0ca:     	movq	$0x0, -0xb8(%rbp)
10438c0d5:     	jmp	0x10438c412
10438c0da:     	movq	-0xc0(%rbp), %r14
10438c0e1:     	testq	%r14, %r14
10438c0e4:     	je	0x10438c109
10438c0e6:     	movq	$-0x1, %rax
10438c0ed:     	lock
10438c0ee:     	xaddq	%rax, 0x8(%r14)
10438c0f3:     	testq	%rax, %rax
10438c0f6:     	jne	0x10438c109
10438c0f8:     	movq	(%r14), %rax
10438c0fb:     	movq	%r14, %rdi
10438c0fe:     	callq	*0x10(%rax)
10438c101:     	movq	%r14, %rdi
10438c104:     	callq	0x105322ba2
10438c109:     	movq	-0xd0(%rbp), %rdi
10438c110:     	movq	$0x0, -0xd0(%rbp)
10438c11b:     	testq	%rdi, %rdi
10438c11e:     	je	0x10438c12a
10438c120:     	testb	$0x1, (%rdi)
10438c123:     	jne	0x10438c12a
10438c125:     	callq	0x105322c7a
10438c12a:     	movq	0x1a23a67(%rip), %rax   ## 0x105dafb98
10438c131:     	movq	(%rax), %rax
10438c134:     	cmpq	-0x30(%rbp), %rax
10438c138:     	jne	0x10438c458
10438c13e:     	movq	%rbx, %rax
10438c141:     	addq	$0x148, %rsp            ## imm = 0x148
10438c148:     	popq	%rbx
10438c149:     	popq	%r12
10438c14b:     	popq	%r13
10438c14d:     	popq	%r14
10438c14f:     	popq	%r15
10438c151:     	popq	%rbp
10438c152:     	retq
10438c153:     	movups	-0xb0(%rbp), %xmm0
10438c15a:     	movaps	%xmm0, -0x100(%rbp)
10438c161:     	xorps	%xmm0, %xmm0
10438c164:     	movups	%xmm0, -0xb0(%rbp)
10438c16b:     	leaq	-0xa0(%rbp), %rdi
10438c172:     	leaq	-0x110(%rbp), %rsi
10438c179:     	callq	0x104394c10
10438c17e:     	movl	$0x28, %edi
10438c183:     	callq	0x105322c8c
10438c188:     	movq	%rax, -0x118(%rbp)
10438c18f:     	movq	$0x29, -0x128(%rbp)
10438c19a:     	movq	$0x20, -0x120(%rbp)
10438c1a5:     	movups	-0xa0(%rbp), %xmm0
10438c1ac:     	movups	-0x90(%rbp), %xmm1
10438c1b3:     	movups	%xmm1, 0x10(%rax)
10438c1b7:     	movups	%xmm0, (%rax)
10438c1ba:     	movb	$0x0, 0x20(%rax)
10438c1be:     	leaq	-0x148(%rbp), %r15
10438c1c5:     	leaq	-0x100(%rbp), %rsi
10438c1cc:     	movq	%r15, %rdi
10438c1cf:     	callq	0x104395e30
10438c1d4:     	leaq	-0x70(%rbp), %rdi
10438c1d8:     	movq	%r15, %rsi
10438c1db:     	callq	0x104394c10
10438c1e0:     	movl	$0x28, %edi
10438c1e5:     	callq	0x105322c8c
10438c1ea:     	movq	%rax, %r13
10438c1ed:     	movups	-0x70(%rbp), %xmm0
10438c1f1:     	movups	-0x60(%rbp), %xmm1
10438c1f5:     	movups	%xmm0, (%rax)
10438c1f8:     	movups	%xmm1, 0x10(%rax)
10438c1fc:     	movb	$0x0, 0x20(%rax)
10438c200:     	leaq	-0x128(%rbp), %rdi
10438c207:     	movl	$0x20, %edx
10438c20c:     	movq	%rax, %rsi
10438c20f:     	callq	0x105322ad6
10438c214:     	movq	0x10(%rax), %rcx
10438c218:     	movq	%rcx, -0xe0(%rbp)
10438c21f:     	movups	(%rax), %xmm0
10438c222:     	movaps	%xmm0, -0xf0(%rbp)
10438c229:     	xorps	%xmm0, %xmm0
10438c22c:     	movups	%xmm0, (%rax)
10438c22f:     	movq	$0x0, 0x10(%rax)
10438c237:     	movzbl	-0xf0(%rbp), %eax
10438c23e:     	movl	%eax, %r8d
10438c241:     	shrl	%r8d
10438c244:     	testb	$0x1, %al
10438c246:     	leaq	-0xef(%rbp), %rcx
10438c24d:     	cmovneq	-0xe0(%rbp), %rcx
10438c255:     	cmovneq	-0xe8(%rbp), %r8
10438c25d:     	leaq	0x113a4b2(%rip), %rsi   ## 0x1054c6716
10438c264:     	leaq	-0xd8(%rbp), %rdi
10438c26b:     	movl	$0x14, %edx
10438c270:     	callq	0x104396cf0
10438c275:     	movq	-0xd8(%rbp), %r12
10438c27c:     	testq	%r12, %r12
10438c27f:     	je	0x10438c2d1
10438c281:     	leaq	0x8(%r12), %rsi
10438c286:     	movl	$0x20, %edx
10438c28b:     	movq	(%r12), %r15
10438c28f:     	cmpq	$0x20, %r15
10438c293:     	cmovbq	%r15, %rdx
10438c297:     	leaq	-0x50(%rbp), %rdi
10438c29b:     	callq	0x10532329e
10438c2a0:     	movq	$0x0, -0xd8(%rbp)
10438c2ab:     	addq	$0x8, %r15
10438c2af:     	movq	%r12, -0x138(%rbp)
10438c2b6:     	movq	%r15, -0x130(%rbp)
10438c2bd:     	leaq	-0x138(%rbp), %rdi
10438c2c4:     	callq	0x10436a230
10438c2c9:     	movq	%r12, %rdi
10438c2cc:     	callq	0x105322c7a
10438c2d1:     	testb	$0x1, -0xf0(%rbp)
10438c2d8:     	je	0x10438c2e6
10438c2da:     	movq	-0xe0(%rbp), %rdi
10438c2e1:     	callq	0x105322c80
10438c2e6:     	movq	%r13, %rdi
10438c2e9:     	callq	0x105322c80
10438c2ee:     	movq	-0x140(%rbp), %r15
10438c2f5:     	testq	%r15, %r15
10438c2f8:     	je	0x10438c31d
10438c2fa:     	movq	$-0x1, %rax
10438c301:     	lock
10438c302:     	xaddq	%rax, 0x8(%r15)
10438c307:     	testq	%rax, %rax
10438c30a:     	jne	0x10438c31d
10438c30c:     	movq	(%r15), %rax
10438c30f:     	movq	%r15, %rdi
10438c312:     	callq	*0x10(%rax)
10438c315:     	movq	%r15, %rdi
10438c318:     	callq	0x105322ba2
10438c31d:     	testb	$0x1, -0x128(%rbp)
10438c324:     	je	0x10438c332
10438c326:     	movq	-0x118(%rbp), %rdi
10438c32d:     	callq	0x105322c80
10438c332:     	movups	-0x50(%rbp), %xmm0
10438c336:     	movups	-0x40(%rbp), %xmm1
10438c33a:     	movaps	%xmm1, -0x90(%rbp)
10438c341:     	movaps	%xmm0, -0xa0(%rbp)
10438c348:     	movb	$0x1, -0x80(%rbp)
10438c34c:     	leaq	-0x100(%rbp), %rax
10438c353:     	movq	%rax, -0x70(%rbp)
10438c357:     	leaq	-0x110(%rbp), %rax
10438c35e:     	movq	%rax, -0x68(%rbp)
10438c362:     	movzbl	-0x80(%rbp), %eax
10438c366:     	movb	%al, 0x20(%rsp)
10438c36a:     	movaps	-0xa0(%rbp), %xmm0
10438c371:     	movaps	-0x90(%rbp), %xmm1
10438c378:     	movups	%xmm1, 0x10(%rsp)
10438c37d:     	movups	%xmm0, (%rsp)
10438c381:     	leaq	-0x70(%rbp), %rdx
10438c385:     	movq	%rbx, %rdi
10438c388:     	movq	%r14, %rsi
10438c38b:     	callq	0x1043919d0
10438c390:     	movq	-0xf8(%rbp), %r14
10438c397:     	testq	%r14, %r14
10438c39a:     	je	0x10438c0ba
10438c3a0:     	movq	$-0x1, %rax
10438c3a7:     	lock
10438c3a8:     	xaddq	%rax, 0x8(%r14)
10438c3ad:     	testq	%rax, %rax
10438c3b0:     	jne	0x10438c0ba
10438c3b6:     	movq	(%r14), %rax
10438c3b9:     	movq	%r14, %rdi
10438c3bc:     	callq	*0x10(%rax)
10438c3bf:     	movq	%r14, %rdi
10438c3c2:     	callq	0x105322ba2
10438c3c7:     	jmp	0x10438c0ba
10438c3cc:     	movq	-0xa8(%rbp), %r14
10438c3d3:     	testq	%r14, %r14
10438c3d6:     	je	0x10438c3fb
10438c3d8:     	movq	$-0x1, %rax
10438c3df:     	lock
10438c3e0:     	xaddq	%rax, 0x8(%r14)
10438c3e5:     	testq	%rax, %rax
10438c3e8:     	jne	0x10438c3fb
10438c3ea:     	movq	(%r14), %rax
10438c3ed:     	movq	%r14, %rdi
10438c3f0:     	callq	*0x10(%rax)
10438c3f3:     	movq	%r14, %rdi
10438c3f6:     	callq	0x105322ba2
10438c3fb:     	movq	-0xb8(%rbp), %rdi
10438c402:     	movq	$0x0, -0xb8(%rbp)
10438c40d:     	testq	%rdi, %rdi
10438c410:     	je	0x10438c41c
10438c412:     	testb	$0x1, (%rdi)
10438c415:     	jne	0x10438c41c
10438c417:     	callq	0x105322c7a
10438c41c:     	movq	-0x108(%rbp), %r14
10438c423:     	testq	%r14, %r14
10438c426:     	je	0x10438c023
10438c42c:     	movq	$-0x1, %rax
10438c433:     	lock
10438c434:     	xaddq	%rax, 0x8(%r14)
10438c439:     	testq	%rax, %rax
10438c43c:     	jne	0x10438c023
10438c442:     	movq	(%r14), %rax
10438c445:     	movq	%r14, %rdi
10438c448:     	callq	*0x10(%rax)
10438c44b:     	movq	%r14, %rdi
10438c44e:     	callq	0x105322ba2
10438c453:     	jmp	0x10438c023
10438c458:     	callq	0x105322d34
10438c45d:     	nopl	(%rax)
