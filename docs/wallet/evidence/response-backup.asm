
/tmp/wallet-x86.macho:	file format mach-o 64-bit x86-64

Disassembly of section __TEXT,__text:

0000000100004000:
1013f75e0:     	pushq	%rbp
1013f75e1:     	movq	%rsp, %rbp
1013f75e4:     	pushq	%r13
1013f75e6:     	pushq	%rbx
1013f75e7:     	subq	$0x40, %rsp
1013f75eb:     	movq	%rdx, %rbx
1013f75ee:     	movq	%rdi, %r13
1013f75f1:     	movq	0x49b85a0(%rip), %rax   ## 0x105dafb98
1013f75f8:     	movq	(%rax), %rax
1013f75fb:     	movq	%rax, -0x18(%rbp)
1013f75ff:     	testb	$0x1, %sil
1013f7603:     	je	0x1013f761a
1013f7605:     	movl	$0xf9d612ef, -0x30(%rbp) ## imm = 0xF9D612EF
1013f760c:     	leaq	-0x30(%rbp), %rdi
1013f7610:     	movl	$0x4, %esi
1013f7615:     	callq	0x1014f5020
1013f761a:     	leaq	0x10(%rbx), %rdi
1013f761e:     	leaq	-0x30(%rbp), %rsi
1013f7622:     	xorl	%edx, %edx
1013f7624:     	xorl	%ecx, %ecx
1013f7626:     	callq	0x105323730
1013f762b:     	movl	0x10(%rbx), %eax
1013f762e:     	movl	%eax, -0x48(%rbp)
1013f7631:     	leaq	-0x48(%rbp), %rdi
1013f7635:     	movl	$0x4, %esi
1013f763a:     	callq	0x1014f5020
1013f763f:     	leaq	0x18(%rbx), %rdi
1013f7643:     	leaq	-0x48(%rbp), %rsi
1013f7647:     	xorl	%edx, %edx
1013f7649:     	xorl	%ecx, %ecx
1013f764b:     	callq	0x105323730
1013f7650:     	movq	0x18(%rbx), %rbx
1013f7654:     	movq	%rbx, %rdi
1013f7657:     	callq	0x105323910
1013f765c:     	movq	%rbx, %rdi
1013f765f:     	movq	%r13, %rsi
1013f7662:     	xorl	%edx, %edx
1013f7664:     	callq	0x1014f44a0
1013f7669:     	movq	%rbx, %rdi
1013f766c:     	callq	0x105323904
1013f7671:     	movq	0x49b8520(%rip), %rax   ## 0x105dafb98
1013f7678:     	movq	(%rax), %rax
1013f767b:     	cmpq	-0x18(%rbp), %rax
1013f767f:     	jne	0x1013f768a
1013f7681:     	addq	$0x40, %rsp
1013f7685:     	popq	%rbx
1013f7686:     	popq	%r13
1013f7688:     	popq	%rbp
1013f7689:     	retq
1013f768a:     	callq	0x105322d34
1013f768f:     	nop
1013f7690:     	pushq	%rbp
1013f7691:     	movq	%rsp, %rbp
1013f7694:     	pushq	%r15
1013f7696:     	pushq	%r14
1013f7698:     	pushq	%r13
1013f769a:     	pushq	%rbx
1013f769b:     	subq	$0x50, %rsp
1013f769f:     	movq	%rdx, %rbx
1013f76a2:     	movq	%rdi, %r13
1013f76a5:     	movq	0x49b84ec(%rip), %rax   ## 0x105dafb98
1013f76ac:     	movq	(%rax), %rax
1013f76af:     	movq	%rax, -0x28(%rbp)
1013f76b3:     	testb	$0x1, %sil
1013f76b7:     	je	0x1013f76ce
1013f76b9:     	movl	$0x99e41707, -0x40(%rbp) ## imm = 0x99E41707
1013f76c0:     	leaq	-0x40(%rbp), %rdi
1013f76c4:     	movl	$0x4, %esi
1013f76c9:     	callq	0x1014f5020
1013f76ce:     	leaq	0x10(%rbx), %rdi
1013f76d2:     	leaq	-0x40(%rbp), %rsi
1013f76d6:     	xorl	%edx, %edx
1013f76d8:     	xorl	%ecx, %ecx
1013f76da:     	callq	0x105323730
1013f76df:     	movq	0x10(%rbx), %r14
1013f76e3:     	movq	0x18(%rbx), %r15
1013f76e7:     	movq	%r15, %rdi
1013f76ea:     	callq	0x105323742
1013f76ef:     	movq	%r14, %rdi
1013f76f2:     	movq	%r15, %rsi
1013f76f5:     	movq	%r13, %rdx
1013f76f8:     	xorl	%ecx, %ecx
1013f76fa:     	callq	0x1014f4320
1013f76ff:     	movq	%r15, %rdi
1013f7702:     	callq	0x105323736
1013f7707:     	leaq	0x20(%rbx), %rdi
1013f770b:     	leaq	-0x58(%rbp), %rsi
1013f770f:     	xorl	%edx, %edx
1013f7711:     	xorl	%ecx, %ecx
1013f7713:     	callq	0x105323730
1013f7718:     	movl	0x20(%rbx), %eax
1013f771b:     	movl	%eax, -0x70(%rbp)
1013f771e:     	leaq	-0x70(%rbp), %rdi
1013f7722:     	movl	$0x4, %esi
1013f7727:     	callq	0x1014f5020
1013f772c:     	leaq	0x28(%rbx), %rdi
1013f7730:     	leaq	-0x70(%rbp), %rsi
1013f7734:     	xorl	%edx, %edx
1013f7736:     	xorl	%ecx, %ecx
1013f7738:     	callq	0x105323730
1013f773d:     	movq	0x28(%rbx), %r14
1013f7741:     	movq	0x30(%rbx), %rbx
1013f7745:     	movq	%rbx, %rdi
1013f7748:     	callq	0x105323742
1013f774d:     	movq	%r14, %rdi
1013f7750:     	movq	%rbx, %rsi
1013f7753:     	movq	%r13, %rdx
1013f7756:     	xorl	%ecx, %ecx
1013f7758:     	callq	0x1014f4320
1013f775d:     	movq	%rbx, %rdi
1013f7760:     	callq	0x105323736
1013f7765:     	movq	0x49b842c(%rip), %rax   ## 0x105dafb98
1013f776c:     	movq	(%rax), %rax
1013f776f:     	cmpq	-0x28(%rbp), %rax
1013f7773:     	jne	0x1013f7782
1013f7775:     	addq	$0x50, %rsp
1013f7779:     	popq	%rbx
1013f777a:     	popq	%r13
1013f777c:     	popq	%r14
1013f777e:     	popq	%r15
1013f7780:     	popq	%rbp
1013f7781:     	retq
1013f7782:     	callq	0x105322d34
1013f7787:     	nopw	(%rax,%rax)
1013f7790:     	pushq	%rbp
1013f7791:     	movq	%rsp, %rbp
1013f7794:     	pushq	%r15
1013f7796:     	pushq	%r14
1013f7798:     	pushq	%r13
1013f779a:     	pushq	%r12
1013f779c:     	pushq	%rbx
1013f779d:     	subq	$0x88, %rsp
1013f77a4:     	movq	%rdx, %rbx
1013f77a7:     	movq	%rdi, %r13
1013f77aa:     	movq	0x49b83e7(%rip), %rax   ## 0x105dafb98
1013f77b1:     	movq	(%rax), %rax
1013f77b4:     	movq	%rax, -0x30(%rbp)
1013f77b8:     	testb	$0x1, %sil
1013f77bc:     	je	0x1013f77d3
1013f77be:     	movl	$0xe6d0ef01, -0x48(%rbp) ## imm = 0xE6D0EF01
1013f77c5:     	leaq	-0x48(%rbp), %rdi
1013f77c9:     	movl	$0x4, %esi
1013f77ce:     	callq	0x1014f5020
1013f77d3:     	leaq	0x10(%rbx), %rdi
1013f77d7:     	leaq	-0x48(%rbp), %rsi
1013f77db:     	xorl	%edx, %edx
1013f77dd:     	xorl	%ecx, %ecx
1013f77df:     	callq	0x105323730
1013f77e4:     	movq	0x10(%rbx), %r14
1013f77e8:     	movq	0x18(%rbx), %r15
1013f77ec:     	movq	%r15, %rdi
1013f77ef:     	callq	0x105323742
1013f77f4:     	movq	%r14, %rdi
1013f77f7:     	movq	%r15, %rsi
1013f77fa:     	movq	%r13, %rdx
1013f77fd:     	xorl	%ecx, %ecx
1013f77ff:     	callq	0x1014f4320
1013f7804:     	movq	%r15, %rdi
1013f7807:     	callq	0x105323736
1013f780c:     	movl	$0x1cb5c415, -0x60(%rbp) ## imm = 0x1CB5C415
1013f7813:     	leaq	-0x60(%rbp), %rdi
1013f7817:     	movl	$0x4, %esi
1013f781c:     	callq	0x1014f5020
1013f7821:     	leaq	0x20(%rbx), %r14
1013f7825:     	leaq	-0x60(%rbp), %rsi
1013f7829:     	movq	%r14, %rdi
1013f782c:     	xorl	%edx, %edx
1013f782e:     	xorl	%ecx, %ecx
1013f7830:     	callq	0x105323730
1013f7835:     	movq	0x20(%rbx), %rax
1013f7839:     	movq	0x10(%rax), %rax
1013f783d:     	cmpq	$0x7fffffff, %rax       ## imm = 0x7FFFFFFF
1013f7843:     	ja	0x1013f79c4
1013f7849:     	movl	%eax, -0x78(%rbp)
1013f784c:     	leaq	-0x78(%rbp), %rdi
1013f7850:     	movl	$0x4, %esi
1013f7855:     	callq	0x1014f5020
1013f785a:     	movq	(%r14), %rbx
1013f785d:     	movq	0x10(%rbx), %rax
1013f7861:     	movq	%rax, -0xb0(%rbp)
1013f7868:     	testq	%rax, %rax
1013f786b:     	je	0x1013f7996
1013f7871:     	leaq	0x18(%r13), %r15
1013f7875:     	movq	%r15, -0xa8(%rbp)
1013f787c:     	leaq	0x10(%r13), %r14
1013f7880:     	movq	%rbx, %rdi
1013f7883:     	callq	0x105323742
1013f7888:     	xorl	%r12d, %r12d
1013f788b:     	leaq	-0x78(%rbp), %rsi
1013f788f:     	movl	$0x1, %edx
1013f7894:     	movq	%r15, %rdi
1013f7897:     	xorl	%ecx, %ecx
1013f7899:     	callq	0x105323730
1013f789e:     	leaq	-0x90(%rbp), %rsi
1013f78a5:     	movl	$0x1, %edx
1013f78aa:     	movq	%r14, -0x98(%rbp)
1013f78b1:     	movq	%r14, %rdi
1013f78b4:     	xorl	%ecx, %ecx
1013f78b6:     	callq	0x105323730
1013f78bb:     	movq	0x18(%r13), %r15
1013f78bf:     	movq	%r13, %rcx
1013f78c2:     	movq	-0xa8(%rbp), %r13
1013f78c9:     	movq	%rcx, -0xa0(%rbp)
1013f78d0:     	movq	%r15, %rsi
1013f78d3:     	addq	$0x4, %rsi
1013f78d7:     	jb	0x1013f79b8
1013f78dd:     	movq	%rbx, %r14
1013f78e0:     	movl	0x20(%rbx,%r12,4), %ebx
1013f78e5:     	cmpq	%rsi, 0x20(%rcx)
1013f78e9:     	jae	0x1013f7930
1013f78eb:     	addq	$0x80, %rsi
1013f78f2:     	jb	0x1013f79be
1013f78f8:     	movq	%rsi, 0x20(%rcx)
1013f78fc:     	movq	0x10(%rcx), %rdi
1013f7900:     	testq	%rdi, %rdi
1013f7903:     	je	0x1013f7941
1013f7905:     	testq	%rsi, %rsi
1013f7908:     	js	0x1013f79c0
1013f790e:     	callq	0x105323568
1013f7913:     	testq	%rax, %rax
1013f7916:     	je	0x1013f79c6
1013f791c:     	movq	-0x98(%rbp), %rcx
1013f7923:     	movq	%rax, (%rcx)
1013f7926:     	movq	(%r13), %r15
1013f792a:     	jmp	0x1013f795d
1013f792c:     	nopl	(%rax)
1013f7930:     	movq	-0x98(%rbp), %rax
1013f7937:     	movq	(%rax), %rax
1013f793a:     	testq	%r15, %r15
1013f793d:     	jns	0x1013f7969
1013f793f:     	jmp	0x1013f79ba
1013f7941:     	testq	%rsi, %rsi
1013f7944:     	js	0x1013f79c2
1013f7946:     	movq	%rsi, %rdi
1013f7949:     	callq	0x105323250
1013f794e:     	testq	%rax, %rax
1013f7951:     	je	0x1013f79c8
1013f7953:     	movq	-0x98(%rbp), %rcx
1013f795a:     	movq	%rax, (%rcx)
1013f795d:     	movq	-0xa0(%rbp), %rcx
1013f7964:     	testq	%r15, %r15
1013f7967:     	js	0x1013f79ba
1013f7969:     	movl	%ebx, (%r15,%rax)
1013f796d:     	movq	(%r13), %r15
1013f7971:     	addq	$0x4, %r15
1013f7975:     	jb	0x1013f79bc
1013f7977:     	incq	%r12
1013f797a:     	movq	%r15, (%r13)
1013f797e:     	cmpq	%r12, -0xb0(%rbp)
1013f7985:     	movq	%r14, %rbx
1013f7988:     	jne	0x1013f78d0
1013f798e:     	movq	%rbx, %rdi
1013f7991:     	callq	0x105323736
1013f7996:     	movq	0x49b81fb(%rip), %rax   ## 0x105dafb98
1013f799d:     	movq	(%rax), %rax
1013f79a0:     	cmpq	-0x30(%rbp), %rax
1013f79a4:     	jne	0x1013f79ca
1013f79a6:     	addq	$0x88, %rsp
1013f79ad:     	popq	%rbx
1013f79ae:     	popq	%r12
1013f79b0:     	popq	%r13
1013f79b2:     	popq	%r14
1013f79b4:     	popq	%r15
1013f79b6:     	popq	%rbp
1013f79b7:     	retq
1013f79b8:     	ud2
1013f79ba:     	ud2
1013f79bc:     	ud2
1013f79be:     	ud2
1013f79c0:     	ud2
1013f79c2:     	ud2
1013f79c4:     	ud2
1013f79c6:     	ud2
1013f79c8:     	ud2
1013f79ca:     	callq	0x105322d34
1013f79cf:     	nop
1013f79d0:     	pushq	%rbp
1013f79d1:     	movq	%rsp, %rbp
1013f79d4:     	pushq	%r14
1013f79d6:     	pushq	%r13
1013f79d8:     	pushq	%rbx
1013f79d9:     	subq	$0x48, %rsp
1013f79dd:     	movq	%rdx, %rbx
1013f79e0:     	movq	%rdi, %r13
1013f79e3:     	movq	0x49b81ae(%rip), %rax   ## 0x105dafb98
1013f79ea:     	movq	(%rax), %rax
1013f79ed:     	movq	%rax, -0x20(%rbp)
1013f79f1:     	testb	$0x1, %sil
1013f79f5:     	je	0x1013f7a0c
1013f79f7:     	movl	$0x4bc89693, -0x38(%rbp) ## imm = 0x4BC89693
1013f79fe:     	leaq	-0x38(%rbp), %rdi
1013f7a02:     	movl	$0x4, %esi
1013f7a07:     	callq	0x1014f5020
1013f7a0c:     	leaq	0x10(%rbx), %rdi
1013f7a10:     	leaq	-0x38(%rbp), %rsi
1013f7a14:     	xorl	%edx, %edx
1013f7a16:     	xorl	%ecx, %ecx
1013f7a18:     	callq	0x105323730
1013f7a1d:     	movq	0x10(%rbx), %r14
1013f7a21:     	movq	%r14, %rdi
1013f7a24:     	callq	0x105323910
1013f7a29:     	movq	%r14, %rdi
1013f7a2c:     	movq	%r13, %rsi
1013f7a2f:     	xorl	%edx, %edx
1013f7a31:     	callq	0x1014f44a0
1013f7a36:     	movq	%r14, %rdi
1013f7a39:     	callq	0x105323904
1013f7a3e:     	leaq	0x18(%rbx), %rdi
1013f7a42:     	leaq	-0x50(%rbp), %rsi
1013f7a46:     	xorl	%edx, %edx
1013f7a48:     	xorl	%ecx, %ecx
1013f7a4a:     	callq	0x105323730
1013f7a4f:     	movq	0x18(%rbx), %rax
1013f7a53:     	movq	%rax, -0x58(%rbp)
1013f7a57:     	leaq	-0x58(%rbp), %rdi
1013f7a5b:     	movl	$0x8, %esi
1013f7a60:     	callq	0x1014f5020
1013f7a65:     	movq	0x49b812c(%rip), %rax   ## 0x105dafb98
1013f7a6c:     	movq	(%rax), %rax
1013f7a6f:     	cmpq	-0x20(%rbp), %rax
1013f7a73:     	jne	0x1013f7a80
1013f7a75:     	addq	$0x48, %rsp
1013f7a79:     	popq	%rbx
1013f7a7a:     	popq	%r13
1013f7a7c:     	popq	%r14
1013f7a7e:     	popq	%rbp
1013f7a7f:     	retq
1013f7a80:     	callq	0x105322d34
1013f7a85:     	nopw	%cs:(%rax,%rax)
