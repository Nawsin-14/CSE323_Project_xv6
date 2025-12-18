
_benchmark:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "user.h"

int main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 38             	sub    $0x38,%esp
    if (argc != 2)
  14:	83 39 02             	cmpl   $0x2,(%ecx)
{
  17:	8b 41 04             	mov    0x4(%ecx),%eax
    if (argc != 2)
  1a:	0f 85 1c 01 00 00    	jne    13c <main+0x13c>
    int wtime;
    int sums[3][2];
    for (i = 0; i < 3; i++)
        for (j = 0; j < 2; j++)
            sums[i][j] = 0;
    n = atoi(argv[1]);
  20:	83 ec 0c             	sub    $0xc,%esp
  23:	ff 70 04             	push   0x4(%eax)
            sums[i][j] = 0;
  26:	31 d2                	xor    %edx,%edx
    i = n; //unimportant
    int pid;
    for (i = 0; i < 3 * n; i++)
  28:	31 db                	xor    %ebx,%ebx
            sums[i][j] = 0;
  2a:	89 55 d0             	mov    %edx,-0x30(%ebp)
  2d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  30:	89 55 d8             	mov    %edx,-0x28(%ebp)
  33:	89 55 dc             	mov    %edx,-0x24(%ebp)
  36:	89 55 e0             	mov    %edx,-0x20(%ebp)
  39:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    n = atoi(argv[1]);
  3c:	e8 6f 03 00 00       	call   3b0 <atoi>
    for (i = 0; i < 3 * n; i++)
  41:	83 c4 10             	add    $0x10,%esp
  44:	8d 34 40             	lea    (%eax,%eax,2),%esi
    n = atoi(argv[1]);
  47:	89 c7                	mov    %eax,%edi
    for (i = 0; i < 3 * n; i++)
  49:	85 f6                	test   %esi,%esi
  4b:	0f 8e 01 01 00 00    	jle    152 <main+0x152>
    {
        j = i % 3;
        double x = 0;
        pid = fork();
  51:	e8 37 04 00 00       	call   48d <fork>
        if (pid == 0)
  56:	85 c0                	test   %eax,%eax
  58:	75 3d                	jne    97 <main+0x97>
        {                           //child
            j = (getpid() - 4) % 3; // ensures independence from the first son's pid when gathering the results in the second part of the program
  5a:	e8 b6 04 00 00       	call   515 <getpid>
  5f:	b9 03 00 00 00       	mov    $0x3,%ecx
  64:	83 e8 04             	sub    $0x4,%eax
  67:	99                   	cltd
  68:	f7 f9                	idiv   %ecx
            switch (j)
  6a:	85 d2                	test   %edx,%edx
  6c:	0f 84 3c 01 00 00    	je     1ae <main+0x1ae>
  72:	83 fa 02             	cmp    $0x2,%edx
  75:	75 1b                	jne    92 <main+0x92>
  77:	bb 64 00 00 00       	mov    $0x64,%ebx
  7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                // }
                break;
            case 2: // simulate I/O bound process (IO)
                for (k = 0; k < 100; k++)
                {
                    sleep(1);
  80:	83 ec 0c             	sub    $0xc,%esp
  83:	6a 01                	push   $0x1
  85:	e8 9b 04 00 00       	call   525 <sleep>
                for (k = 0; k < 100; k++)
  8a:	83 c4 10             	add    $0x10,%esp
  8d:	83 eb 01             	sub    $0x1,%ebx
  90:	75 ee                	jne    80 <main+0x80>
        for (j = 0; j < 2; j++)
            sums[i][j] /= n;
    printf(1, "\n\nCPU bound:\nAverage running time: %d\nAverage sleeping time: %d\nAverage turnaround time: %d\n\n\n", sums[0][0], sums[0][1], sums[0][0] + sums[0][1]);
    // printf(1, "CPU-S bound:\nAverage running time: %d\nAverage sleeping time: %d\nAverage turnaround time: %d\n\n\n", sums[1][0], sums[1][1], sums[1][0] + sums[1][1]);
    printf(1, "I/O bound:\nAverage running time: %d\nAverage sleeping time: %d\nAverage turnaround time: %d\n\n\n", sums[2][0], sums[2][1], sums[2][0] + sums[2][1]);
    exit();
  92:	e8 fe 03 00 00       	call   495 <exit>
    for (i = 0; i < 3 * n; i++)
  97:	83 c3 01             	add    $0x1,%ebx
  9a:	39 f3                	cmp    %esi,%ebx
  9c:	75 b3                	jne    51 <main+0x51>
  9e:	89 7d bc             	mov    %edi,-0x44(%ebp)
    for (i = 0; i < 3 * n; i++)
  a1:	31 db                	xor    %ebx,%ebx
  a3:	89 75 c0             	mov    %esi,-0x40(%ebp)
  a6:	eb 32                	jmp    da <main+0xda>
        switch (res)
  a8:	83 fa 02             	cmp    $0x2,%edx
  ab:	75 2a                	jne    d7 <main+0xd7>
            printf(1, "I/O bound, pid: %d, running: %d, waiting: %d, turnaround: %d\n", pid, rtime, wtime, rtime + wtime);
  ad:	8b 45 c8             	mov    -0x38(%ebp),%eax
  b0:	8b 55 cc             	mov    -0x34(%ebp),%edx
  b3:	56                   	push   %esi
  b4:	56                   	push   %esi
  b5:	8d 34 10             	lea    (%eax,%edx,1),%esi
  b8:	56                   	push   %esi
  b9:	52                   	push   %edx
  ba:	50                   	push   %eax
  bb:	51                   	push   %ecx
  bc:	68 68 09 00 00       	push   $0x968
  c1:	6a 01                	push   $0x1
  c3:	e8 38 05 00 00       	call   600 <printf>
            sums[2][0] += rtime;
  c8:	8b 45 c8             	mov    -0x38(%ebp),%eax
  cb:	01 45 e0             	add    %eax,-0x20(%ebp)
            break;
  ce:	83 c4 20             	add    $0x20,%esp
            sums[2][1] += wtime;
  d1:	8b 45 cc             	mov    -0x34(%ebp),%eax
  d4:	01 45 e4             	add    %eax,-0x1c(%ebp)
    for (i = 0; i < 3 * n; i++)
  d7:	83 c3 01             	add    $0x1,%ebx
            sums[0][1] += wtime;
  da:	8b 45 d4             	mov    -0x2c(%ebp),%eax
            sums[0][0] += rtime;
  dd:	8b 75 d0             	mov    -0x30(%ebp),%esi
            sums[0][1] += wtime;
  e0:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    for (i = 0; i < 3 * n; i++)
  e3:	8b 45 c0             	mov    -0x40(%ebp),%eax
  e6:	39 c3                	cmp    %eax,%ebx
  e8:	7d 65                	jge    14f <main+0x14f>
        pid = waitx(&wtime, &rtime);
  ea:	50                   	push   %eax
        int res = (pid - 4) % 3; // correlates to j in the dispatching loop
  eb:	bf 03 00 00 00       	mov    $0x3,%edi
        pid = waitx(&wtime, &rtime);
  f0:	50                   	push   %eax
  f1:	8d 45 c8             	lea    -0x38(%ebp),%eax
  f4:	50                   	push   %eax
  f5:	8d 45 cc             	lea    -0x34(%ebp),%eax
  f8:	50                   	push   %eax
  f9:	e8 47 04 00 00       	call   545 <waitx>
        switch (res)
  fe:	83 c4 10             	add    $0x10,%esp
        pid = waitx(&wtime, &rtime);
 101:	89 c1                	mov    %eax,%ecx
        int res = (pid - 4) % 3; // correlates to j in the dispatching loop
 103:	8d 40 fc             	lea    -0x4(%eax),%eax
 106:	99                   	cltd
 107:	f7 ff                	idiv   %edi
        switch (res)
 109:	85 d2                	test   %edx,%edx
 10b:	75 9b                	jne    a8 <main+0xa8>
            printf(1, "CPU-bound, pid: %d, running: %d, waiting: %d, turnaround: %d\n", pid, rtime, wtime, rtime + wtime);
 10d:	8b 45 c8             	mov    -0x38(%ebp),%eax
 110:	8b 55 cc             	mov    -0x34(%ebp),%edx
 113:	57                   	push   %edi
 114:	57                   	push   %edi
 115:	8d 3c 10             	lea    (%eax,%edx,1),%edi
 118:	57                   	push   %edi
 119:	52                   	push   %edx
 11a:	50                   	push   %eax
 11b:	51                   	push   %ecx
 11c:	68 28 09 00 00       	push   $0x928
 121:	6a 01                	push   $0x1
 123:	e8 d8 04 00 00       	call   600 <printf>
            sums[0][1] += wtime;
 128:	8b 45 c4             	mov    -0x3c(%ebp),%eax
            sums[0][0] += rtime;
 12b:	03 75 c8             	add    -0x38(%ebp),%esi
            break;
 12e:	83 c4 20             	add    $0x20,%esp
            sums[0][1] += wtime;
 131:	03 45 cc             	add    -0x34(%ebp),%eax
            sums[0][0] += rtime;
 134:	89 75 d0             	mov    %esi,-0x30(%ebp)
            sums[0][1] += wtime;
 137:	89 45 d4             	mov    %eax,-0x2c(%ebp)
            break;
 13a:	eb 9b                	jmp    d7 <main+0xd7>
        printf(1, "Usage: benchmark <n>\n");
 13c:	50                   	push   %eax
 13d:	50                   	push   %eax
 13e:	68 08 09 00 00       	push   $0x908
 143:	6a 01                	push   $0x1
 145:	e8 b6 04 00 00       	call   600 <printf>
        exit();
 14a:	e8 46 03 00 00       	call   495 <exit>
 14f:	8b 7d bc             	mov    -0x44(%ebp),%edi
 152:	8d 4d d0             	lea    -0x30(%ebp),%ecx
 155:	8d 5d e8             	lea    -0x18(%ebp),%ebx
            sums[i][j] /= n;
 158:	8b 01                	mov    (%ecx),%eax
    for (i = 0; i < 3; i++)
 15a:	83 c1 08             	add    $0x8,%ecx
            sums[i][j] /= n;
 15d:	99                   	cltd
 15e:	f7 ff                	idiv   %edi
 160:	89 41 f8             	mov    %eax,-0x8(%ecx)
 163:	8b 41 fc             	mov    -0x4(%ecx),%eax
 166:	99                   	cltd
 167:	f7 ff                	idiv   %edi
 169:	89 41 fc             	mov    %eax,-0x4(%ecx)
    for (i = 0; i < 3; i++)
 16c:	39 cb                	cmp    %ecx,%ebx
 16e:	75 e8                	jne    158 <main+0x158>
    printf(1, "\n\nCPU bound:\nAverage running time: %d\nAverage sleeping time: %d\nAverage turnaround time: %d\n\n\n", sums[0][0], sums[0][1], sums[0][0] + sums[0][1]);
 170:	8b 45 d0             	mov    -0x30(%ebp),%eax
 173:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 176:	83 ec 0c             	sub    $0xc,%esp
 179:	8d 0c 10             	lea    (%eax,%edx,1),%ecx
 17c:	51                   	push   %ecx
 17d:	52                   	push   %edx
 17e:	50                   	push   %eax
 17f:	68 a8 09 00 00       	push   $0x9a8
 184:	6a 01                	push   $0x1
 186:	e8 75 04 00 00       	call   600 <printf>
    printf(1, "I/O bound:\nAverage running time: %d\nAverage sleeping time: %d\nAverage turnaround time: %d\n\n\n", sums[2][0], sums[2][1], sums[2][0] + sums[2][1]);
 18b:	8b 45 e0             	mov    -0x20(%ebp),%eax
 18e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 191:	83 c4 14             	add    $0x14,%esp
 194:	8d 0c 10             	lea    (%eax,%edx,1),%ecx
 197:	51                   	push   %ecx
 198:	52                   	push   %edx
 199:	50                   	push   %eax
 19a:	68 08 0a 00 00       	push   $0xa08
 19f:	6a 01                	push   $0x1
 1a1:	e8 5a 04 00 00       	call   600 <printf>
    exit();
 1a6:	83 c4 20             	add    $0x20,%esp
 1a9:	e9 e4 fe ff ff       	jmp    92 <main+0x92>
            switch (j)
 1ae:	d9 ee                	fldz
                for (double z = 0; z < 800.0; z += 0.01)
 1b0:	dd 05 68 0a 00 00    	fldl   0xa68
 1b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1bd:	00 
 1be:	66 90                	xchg   %ax,%ax
 1c0:	dc c1                	fadd   %st,%st(1)
 1c2:	d9 05 70 0a 00 00    	flds   0xa70
 1c8:	df f2                	fcomip %st(2),%st
 1ca:	77 f4                	ja     1c0 <main+0x1c0>
 1cc:	dd d8                	fstp   %st(0)
 1ce:	dd d8                	fstp   %st(0)
 1d0:	e9 bd fe ff ff       	jmp    92 <main+0x92>
 1d5:	66 90                	xchg   %ax,%ax
 1d7:	66 90                	xchg   %ax,%ax
 1d9:	66 90                	xchg   %ax,%ax
 1db:	66 90                	xchg   %ax,%ax
 1dd:	66 90                	xchg   %ax,%ax
 1df:	90                   	nop

000001e0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 1e0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1e1:	31 c0                	xor    %eax,%eax
{
 1e3:	89 e5                	mov    %esp,%ebp
 1e5:	53                   	push   %ebx
 1e6:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1e9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 1ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 1f0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 1f4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 1f7:	83 c0 01             	add    $0x1,%eax
 1fa:	84 d2                	test   %dl,%dl
 1fc:	75 f2                	jne    1f0 <strcpy+0x10>
    ;
  return os;
}
 1fe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 201:	89 c8                	mov    %ecx,%eax
 203:	c9                   	leave
 204:	c3                   	ret
 205:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 20c:	00 
 20d:	8d 76 00             	lea    0x0(%esi),%esi

00000210 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	53                   	push   %ebx
 214:	8b 55 08             	mov    0x8(%ebp),%edx
 217:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 21a:	0f b6 02             	movzbl (%edx),%eax
 21d:	84 c0                	test   %al,%al
 21f:	75 17                	jne    238 <strcmp+0x28>
 221:	eb 3a                	jmp    25d <strcmp+0x4d>
 223:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 228:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 22c:	83 c2 01             	add    $0x1,%edx
 22f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 232:	84 c0                	test   %al,%al
 234:	74 1a                	je     250 <strcmp+0x40>
 236:	89 d9                	mov    %ebx,%ecx
 238:	0f b6 19             	movzbl (%ecx),%ebx
 23b:	38 c3                	cmp    %al,%bl
 23d:	74 e9                	je     228 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 23f:	29 d8                	sub    %ebx,%eax
}
 241:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 244:	c9                   	leave
 245:	c3                   	ret
 246:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 24d:	00 
 24e:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 250:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 254:	31 c0                	xor    %eax,%eax
 256:	29 d8                	sub    %ebx,%eax
}
 258:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 25b:	c9                   	leave
 25c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 25d:	0f b6 19             	movzbl (%ecx),%ebx
 260:	31 c0                	xor    %eax,%eax
 262:	eb db                	jmp    23f <strcmp+0x2f>
 264:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 26b:	00 
 26c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000270 <strlen>:

uint
strlen(const char *s)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 276:	80 3a 00             	cmpb   $0x0,(%edx)
 279:	74 15                	je     290 <strlen+0x20>
 27b:	31 c0                	xor    %eax,%eax
 27d:	8d 76 00             	lea    0x0(%esi),%esi
 280:	83 c0 01             	add    $0x1,%eax
 283:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 287:	89 c1                	mov    %eax,%ecx
 289:	75 f5                	jne    280 <strlen+0x10>
    ;
  return n;
}
 28b:	89 c8                	mov    %ecx,%eax
 28d:	5d                   	pop    %ebp
 28e:	c3                   	ret
 28f:	90                   	nop
  for(n = 0; s[n]; n++)
 290:	31 c9                	xor    %ecx,%ecx
}
 292:	5d                   	pop    %ebp
 293:	89 c8                	mov    %ecx,%eax
 295:	c3                   	ret
 296:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 29d:	00 
 29e:	66 90                	xchg   %ax,%ax

000002a0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	57                   	push   %edi
 2a4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 2a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 2aa:	8b 45 0c             	mov    0xc(%ebp),%eax
 2ad:	89 d7                	mov    %edx,%edi
 2af:	fc                   	cld
 2b0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 2b2:	8b 7d fc             	mov    -0x4(%ebp),%edi
 2b5:	89 d0                	mov    %edx,%eax
 2b7:	c9                   	leave
 2b8:	c3                   	ret
 2b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002c0 <strchr>:

char*
strchr(const char *s, char c)
{
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	8b 45 08             	mov    0x8(%ebp),%eax
 2c6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 2ca:	0f b6 10             	movzbl (%eax),%edx
 2cd:	84 d2                	test   %dl,%dl
 2cf:	75 12                	jne    2e3 <strchr+0x23>
 2d1:	eb 1d                	jmp    2f0 <strchr+0x30>
 2d3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 2d8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 2dc:	83 c0 01             	add    $0x1,%eax
 2df:	84 d2                	test   %dl,%dl
 2e1:	74 0d                	je     2f0 <strchr+0x30>
    if(*s == c)
 2e3:	38 d1                	cmp    %dl,%cl
 2e5:	75 f1                	jne    2d8 <strchr+0x18>
      return (char*)s;
  return 0;
}
 2e7:	5d                   	pop    %ebp
 2e8:	c3                   	ret
 2e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 2f0:	31 c0                	xor    %eax,%eax
}
 2f2:	5d                   	pop    %ebp
 2f3:	c3                   	ret
 2f4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2fb:	00 
 2fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000300 <gets>:

char*
gets(char *buf, int max)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	57                   	push   %edi
 304:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 305:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 308:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 309:	31 db                	xor    %ebx,%ebx
{
 30b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 30e:	eb 27                	jmp    337 <gets+0x37>
    cc = read(0, &c, 1);
 310:	83 ec 04             	sub    $0x4,%esp
 313:	6a 01                	push   $0x1
 315:	56                   	push   %esi
 316:	6a 00                	push   $0x0
 318:	e8 90 01 00 00       	call   4ad <read>
    if(cc < 1)
 31d:	83 c4 10             	add    $0x10,%esp
 320:	85 c0                	test   %eax,%eax
 322:	7e 1d                	jle    341 <gets+0x41>
      break;
    buf[i++] = c;
 324:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 328:	8b 55 08             	mov    0x8(%ebp),%edx
 32b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 32f:	3c 0a                	cmp    $0xa,%al
 331:	74 10                	je     343 <gets+0x43>
 333:	3c 0d                	cmp    $0xd,%al
 335:	74 0c                	je     343 <gets+0x43>
  for(i=0; i+1 < max; ){
 337:	89 df                	mov    %ebx,%edi
 339:	83 c3 01             	add    $0x1,%ebx
 33c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 33f:	7c cf                	jl     310 <gets+0x10>
 341:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 343:	8b 45 08             	mov    0x8(%ebp),%eax
 346:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 34a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 34d:	5b                   	pop    %ebx
 34e:	5e                   	pop    %esi
 34f:	5f                   	pop    %edi
 350:	5d                   	pop    %ebp
 351:	c3                   	ret
 352:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 359:	00 
 35a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000360 <stat>:

int
stat(const char *n, struct stat *st)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	56                   	push   %esi
 364:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 365:	83 ec 08             	sub    $0x8,%esp
 368:	6a 00                	push   $0x0
 36a:	ff 75 08             	push   0x8(%ebp)
 36d:	e8 63 01 00 00       	call   4d5 <open>
  if(fd < 0)
 372:	83 c4 10             	add    $0x10,%esp
 375:	85 c0                	test   %eax,%eax
 377:	78 27                	js     3a0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 379:	83 ec 08             	sub    $0x8,%esp
 37c:	ff 75 0c             	push   0xc(%ebp)
 37f:	89 c3                	mov    %eax,%ebx
 381:	50                   	push   %eax
 382:	e8 66 01 00 00       	call   4ed <fstat>
  close(fd);
 387:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 38a:	89 c6                	mov    %eax,%esi
  close(fd);
 38c:	e8 2c 01 00 00       	call   4bd <close>
  return r;
 391:	83 c4 10             	add    $0x10,%esp
}
 394:	8d 65 f8             	lea    -0x8(%ebp),%esp
 397:	89 f0                	mov    %esi,%eax
 399:	5b                   	pop    %ebx
 39a:	5e                   	pop    %esi
 39b:	5d                   	pop    %ebp
 39c:	c3                   	ret
 39d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 3a0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 3a5:	eb ed                	jmp    394 <stat+0x34>
 3a7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3ae:	00 
 3af:	90                   	nop

000003b0 <atoi>:

int
atoi(const char *s)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	53                   	push   %ebx
 3b4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3b7:	0f be 02             	movsbl (%edx),%eax
 3ba:	8d 48 d0             	lea    -0x30(%eax),%ecx
 3bd:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 3c0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 3c5:	77 1e                	ja     3e5 <atoi+0x35>
 3c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3ce:	00 
 3cf:	90                   	nop
    n = n*10 + *s++ - '0';
 3d0:	83 c2 01             	add    $0x1,%edx
 3d3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 3d6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 3da:	0f be 02             	movsbl (%edx),%eax
 3dd:	8d 58 d0             	lea    -0x30(%eax),%ebx
 3e0:	80 fb 09             	cmp    $0x9,%bl
 3e3:	76 eb                	jbe    3d0 <atoi+0x20>
  return n;
}
 3e5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3e8:	89 c8                	mov    %ecx,%eax
 3ea:	c9                   	leave
 3eb:	c3                   	ret
 3ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000003f0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	57                   	push   %edi
 3f4:	8b 45 10             	mov    0x10(%ebp),%eax
 3f7:	8b 55 08             	mov    0x8(%ebp),%edx
 3fa:	56                   	push   %esi
 3fb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3fe:	85 c0                	test   %eax,%eax
 400:	7e 13                	jle    415 <memmove+0x25>
 402:	01 d0                	add    %edx,%eax
  dst = vdst;
 404:	89 d7                	mov    %edx,%edi
 406:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 40d:	00 
 40e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 410:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 411:	39 f8                	cmp    %edi,%eax
 413:	75 fb                	jne    410 <memmove+0x20>
  return vdst;
}
 415:	5e                   	pop    %esi
 416:	89 d0                	mov    %edx,%eax
 418:	5f                   	pop    %edi
 419:	5d                   	pop    %ebp
 41a:	c3                   	ret
 41b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00000420 <copyfd>:

int copyfd(int srcfd, int dstfd) {
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	57                   	push   %edi
 424:	56                   	push   %esi
 425:	53                   	push   %ebx
 426:	8d 9d e8 fd ff ff    	lea    -0x218(%ebp),%ebx
 42c:	81 ec 0c 02 00 00    	sub    $0x20c,%esp
 432:	8b 75 08             	mov    0x8(%ebp),%esi
    char buf[512];
    int n;

    while((n = read(srcfd, buf, sizeof(buf))) > 0) {
 435:	eb 1d                	jmp    454 <copyfd+0x34>
 437:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 43e:	00 
 43f:	90                   	nop
        if(write(dstfd, buf, n) != n) {
 440:	83 ec 04             	sub    $0x4,%esp
 443:	57                   	push   %edi
 444:	53                   	push   %ebx
 445:	ff 75 0c             	push   0xc(%ebp)
 448:	e8 68 00 00 00       	call   4b5 <write>
 44d:	83 c4 10             	add    $0x10,%esp
 450:	39 f8                	cmp    %edi,%eax
 452:	75 2c                	jne    480 <copyfd+0x60>
    while((n = read(srcfd, buf, sizeof(buf))) > 0) {
 454:	83 ec 04             	sub    $0x4,%esp
 457:	68 00 02 00 00       	push   $0x200
 45c:	53                   	push   %ebx
 45d:	56                   	push   %esi
 45e:	e8 4a 00 00 00       	call   4ad <read>
 463:	83 c4 10             	add    $0x10,%esp
 466:	89 c7                	mov    %eax,%edi
 468:	85 c0                	test   %eax,%eax
 46a:	7f d4                	jg     440 <copyfd+0x20>
            return -1;   // write error
        }
    }
    if(n < 0) return -1;   // read error
 46c:	0f 95 c0             	setne  %al
    return 0;              // success
}
 46f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(n < 0) return -1;   // read error
 472:	0f b6 c0             	movzbl %al,%eax
}
 475:	5b                   	pop    %ebx
 476:	5e                   	pop    %esi
    if(n < 0) return -1;   // read error
 477:	f7 d8                	neg    %eax
}
 479:	5f                   	pop    %edi
 47a:	5d                   	pop    %ebp
 47b:	c3                   	ret
 47c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 480:	8d 65 f4             	lea    -0xc(%ebp),%esp
            return -1;   // write error
 483:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 488:	5b                   	pop    %ebx
 489:	5e                   	pop    %esi
 48a:	5f                   	pop    %edi
 48b:	5d                   	pop    %ebp
 48c:	c3                   	ret

0000048d <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 48d:	b8 01 00 00 00       	mov    $0x1,%eax
 492:	cd 40                	int    $0x40
 494:	c3                   	ret

00000495 <exit>:
SYSCALL(exit)
 495:	b8 02 00 00 00       	mov    $0x2,%eax
 49a:	cd 40                	int    $0x40
 49c:	c3                   	ret

0000049d <wait>:
SYSCALL(wait)
 49d:	b8 03 00 00 00       	mov    $0x3,%eax
 4a2:	cd 40                	int    $0x40
 4a4:	c3                   	ret

000004a5 <pipe>:
SYSCALL(pipe)
 4a5:	b8 04 00 00 00       	mov    $0x4,%eax
 4aa:	cd 40                	int    $0x40
 4ac:	c3                   	ret

000004ad <read>:
SYSCALL(read)
 4ad:	b8 05 00 00 00       	mov    $0x5,%eax
 4b2:	cd 40                	int    $0x40
 4b4:	c3                   	ret

000004b5 <write>:
SYSCALL(write)
 4b5:	b8 10 00 00 00       	mov    $0x10,%eax
 4ba:	cd 40                	int    $0x40
 4bc:	c3                   	ret

000004bd <close>:
SYSCALL(close)
 4bd:	b8 15 00 00 00       	mov    $0x15,%eax
 4c2:	cd 40                	int    $0x40
 4c4:	c3                   	ret

000004c5 <kill>:
SYSCALL(kill)
 4c5:	b8 06 00 00 00       	mov    $0x6,%eax
 4ca:	cd 40                	int    $0x40
 4cc:	c3                   	ret

000004cd <exec>:
SYSCALL(exec)
 4cd:	b8 07 00 00 00       	mov    $0x7,%eax
 4d2:	cd 40                	int    $0x40
 4d4:	c3                   	ret

000004d5 <open>:
SYSCALL(open)
 4d5:	b8 0f 00 00 00       	mov    $0xf,%eax
 4da:	cd 40                	int    $0x40
 4dc:	c3                   	ret

000004dd <mknod>:
SYSCALL(mknod)
 4dd:	b8 11 00 00 00       	mov    $0x11,%eax
 4e2:	cd 40                	int    $0x40
 4e4:	c3                   	ret

000004e5 <unlink>:
SYSCALL(unlink)
 4e5:	b8 12 00 00 00       	mov    $0x12,%eax
 4ea:	cd 40                	int    $0x40
 4ec:	c3                   	ret

000004ed <fstat>:
SYSCALL(fstat)
 4ed:	b8 08 00 00 00       	mov    $0x8,%eax
 4f2:	cd 40                	int    $0x40
 4f4:	c3                   	ret

000004f5 <link>:
SYSCALL(link)
 4f5:	b8 13 00 00 00       	mov    $0x13,%eax
 4fa:	cd 40                	int    $0x40
 4fc:	c3                   	ret

000004fd <mkdir>:
SYSCALL(mkdir)
 4fd:	b8 14 00 00 00       	mov    $0x14,%eax
 502:	cd 40                	int    $0x40
 504:	c3                   	ret

00000505 <chdir>:
SYSCALL(chdir)
 505:	b8 09 00 00 00       	mov    $0x9,%eax
 50a:	cd 40                	int    $0x40
 50c:	c3                   	ret

0000050d <dup>:
SYSCALL(dup)
 50d:	b8 0a 00 00 00       	mov    $0xa,%eax
 512:	cd 40                	int    $0x40
 514:	c3                   	ret

00000515 <getpid>:
SYSCALL(getpid)
 515:	b8 0b 00 00 00       	mov    $0xb,%eax
 51a:	cd 40                	int    $0x40
 51c:	c3                   	ret

0000051d <sbrk>:
SYSCALL(sbrk)
 51d:	b8 0c 00 00 00       	mov    $0xc,%eax
 522:	cd 40                	int    $0x40
 524:	c3                   	ret

00000525 <sleep>:
SYSCALL(sleep)
 525:	b8 0d 00 00 00       	mov    $0xd,%eax
 52a:	cd 40                	int    $0x40
 52c:	c3                   	ret

0000052d <uptime>:
SYSCALL(uptime)
 52d:	b8 0e 00 00 00       	mov    $0xe,%eax
 532:	cd 40                	int    $0x40
 534:	c3                   	ret

00000535 <chprty>:
SYSCALL(chprty)
 535:	b8 16 00 00 00       	mov    $0x16,%eax
 53a:	cd 40                	int    $0x40
 53c:	c3                   	ret

0000053d <cps>:
SYSCALL(cps)
 53d:	b8 17 00 00 00       	mov    $0x17,%eax
 542:	cd 40                	int    $0x40
 544:	c3                   	ret

00000545 <waitx>:
SYSCALL(waitx)
 545:	b8 19 00 00 00       	mov    $0x19,%eax
 54a:	cd 40                	int    $0x40
 54c:	c3                   	ret

0000054d <getpinfo>:
 54d:	b8 18 00 00 00       	mov    $0x18,%eax
 552:	cd 40                	int    $0x40
 554:	c3                   	ret
 555:	66 90                	xchg   %ax,%ax
 557:	66 90                	xchg   %ax,%ax
 559:	66 90                	xchg   %ax,%ax
 55b:	66 90                	xchg   %ax,%ax
 55d:	66 90                	xchg   %ax,%ax
 55f:	90                   	nop

00000560 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 560:	55                   	push   %ebp
 561:	89 e5                	mov    %esp,%ebp
 563:	57                   	push   %edi
 564:	56                   	push   %esi
 565:	53                   	push   %ebx
 566:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 568:	89 d1                	mov    %edx,%ecx
{
 56a:	83 ec 3c             	sub    $0x3c,%esp
 56d:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
 570:	85 d2                	test   %edx,%edx
 572:	0f 89 80 00 00 00    	jns    5f8 <printint+0x98>
 578:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 57c:	74 7a                	je     5f8 <printint+0x98>
    x = -xx;
 57e:	f7 d9                	neg    %ecx
    neg = 1;
 580:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 585:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 588:	31 f6                	xor    %esi,%esi
 58a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 590:	89 c8                	mov    %ecx,%eax
 592:	31 d2                	xor    %edx,%edx
 594:	89 f7                	mov    %esi,%edi
 596:	f7 f3                	div    %ebx
 598:	8d 76 01             	lea    0x1(%esi),%esi
 59b:	0f b6 92 cc 0a 00 00 	movzbl 0xacc(%edx),%edx
 5a2:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 5a6:	89 ca                	mov    %ecx,%edx
 5a8:	89 c1                	mov    %eax,%ecx
 5aa:	39 da                	cmp    %ebx,%edx
 5ac:	73 e2                	jae    590 <printint+0x30>
  if(neg)
 5ae:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 5b1:	85 c0                	test   %eax,%eax
 5b3:	74 07                	je     5bc <printint+0x5c>
    buf[i++] = '-';
 5b5:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)

  while(--i >= 0)
 5ba:	89 f7                	mov    %esi,%edi
 5bc:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 5bf:	8b 75 c0             	mov    -0x40(%ebp),%esi
 5c2:	01 df                	add    %ebx,%edi
 5c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 5c8:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 5cb:	83 ec 04             	sub    $0x4,%esp
 5ce:	88 45 d7             	mov    %al,-0x29(%ebp)
 5d1:	8d 45 d7             	lea    -0x29(%ebp),%eax
 5d4:	6a 01                	push   $0x1
 5d6:	50                   	push   %eax
 5d7:	56                   	push   %esi
 5d8:	e8 d8 fe ff ff       	call   4b5 <write>
  while(--i >= 0)
 5dd:	89 f8                	mov    %edi,%eax
 5df:	83 c4 10             	add    $0x10,%esp
 5e2:	83 ef 01             	sub    $0x1,%edi
 5e5:	39 c3                	cmp    %eax,%ebx
 5e7:	75 df                	jne    5c8 <printint+0x68>
}
 5e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5ec:	5b                   	pop    %ebx
 5ed:	5e                   	pop    %esi
 5ee:	5f                   	pop    %edi
 5ef:	5d                   	pop    %ebp
 5f0:	c3                   	ret
 5f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 5f8:	31 c0                	xor    %eax,%eax
 5fa:	eb 89                	jmp    585 <printint+0x25>
 5fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000600 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 600:	55                   	push   %ebp
 601:	89 e5                	mov    %esp,%ebp
 603:	57                   	push   %edi
 604:	56                   	push   %esi
 605:	53                   	push   %ebx
 606:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 609:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 60c:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 60f:	0f b6 1e             	movzbl (%esi),%ebx
 612:	83 c6 01             	add    $0x1,%esi
 615:	84 db                	test   %bl,%bl
 617:	74 67                	je     680 <printf+0x80>
 619:	8d 4d 10             	lea    0x10(%ebp),%ecx
 61c:	31 d2                	xor    %edx,%edx
 61e:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 621:	eb 34                	jmp    657 <printf+0x57>
 623:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 628:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 62b:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 630:	83 f8 25             	cmp    $0x25,%eax
 633:	74 18                	je     64d <printf+0x4d>
  write(fd, &c, 1);
 635:	83 ec 04             	sub    $0x4,%esp
 638:	8d 45 e7             	lea    -0x19(%ebp),%eax
 63b:	88 5d e7             	mov    %bl,-0x19(%ebp)
 63e:	6a 01                	push   $0x1
 640:	50                   	push   %eax
 641:	57                   	push   %edi
 642:	e8 6e fe ff ff       	call   4b5 <write>
 647:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 64a:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 64d:	0f b6 1e             	movzbl (%esi),%ebx
 650:	83 c6 01             	add    $0x1,%esi
 653:	84 db                	test   %bl,%bl
 655:	74 29                	je     680 <printf+0x80>
    c = fmt[i] & 0xff;
 657:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 65a:	85 d2                	test   %edx,%edx
 65c:	74 ca                	je     628 <printf+0x28>
      }
    } else if(state == '%'){
 65e:	83 fa 25             	cmp    $0x25,%edx
 661:	75 ea                	jne    64d <printf+0x4d>
      if(c == 'd'){
 663:	83 f8 25             	cmp    $0x25,%eax
 666:	0f 84 04 01 00 00    	je     770 <printf+0x170>
 66c:	83 e8 63             	sub    $0x63,%eax
 66f:	83 f8 15             	cmp    $0x15,%eax
 672:	77 1c                	ja     690 <printf+0x90>
 674:	ff 24 85 74 0a 00 00 	jmp    *0xa74(,%eax,4)
 67b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 680:	8d 65 f4             	lea    -0xc(%ebp),%esp
 683:	5b                   	pop    %ebx
 684:	5e                   	pop    %esi
 685:	5f                   	pop    %edi
 686:	5d                   	pop    %ebp
 687:	c3                   	ret
 688:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 68f:	00 
  write(fd, &c, 1);
 690:	83 ec 04             	sub    $0x4,%esp
 693:	8d 55 e7             	lea    -0x19(%ebp),%edx
 696:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 69a:	6a 01                	push   $0x1
 69c:	52                   	push   %edx
 69d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 6a0:	57                   	push   %edi
 6a1:	e8 0f fe ff ff       	call   4b5 <write>
 6a6:	83 c4 0c             	add    $0xc,%esp
 6a9:	88 5d e7             	mov    %bl,-0x19(%ebp)
 6ac:	6a 01                	push   $0x1
 6ae:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 6b1:	52                   	push   %edx
 6b2:	57                   	push   %edi
 6b3:	e8 fd fd ff ff       	call   4b5 <write>
        putc(fd, c);
 6b8:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6bb:	31 d2                	xor    %edx,%edx
 6bd:	eb 8e                	jmp    64d <printf+0x4d>
 6bf:	90                   	nop
        printint(fd, *ap, 16, 0);
 6c0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 6c3:	83 ec 0c             	sub    $0xc,%esp
 6c6:	b9 10 00 00 00       	mov    $0x10,%ecx
 6cb:	8b 13                	mov    (%ebx),%edx
 6cd:	6a 00                	push   $0x0
 6cf:	89 f8                	mov    %edi,%eax
        ap++;
 6d1:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
 6d4:	e8 87 fe ff ff       	call   560 <printint>
        ap++;
 6d9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 6dc:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6df:	31 d2                	xor    %edx,%edx
 6e1:	e9 67 ff ff ff       	jmp    64d <printf+0x4d>
        s = (char*)*ap;
 6e6:	8b 45 d0             	mov    -0x30(%ebp),%eax
 6e9:	8b 18                	mov    (%eax),%ebx
        ap++;
 6eb:	83 c0 04             	add    $0x4,%eax
 6ee:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 6f1:	85 db                	test   %ebx,%ebx
 6f3:	0f 84 87 00 00 00    	je     780 <printf+0x180>
        while(*s != 0){
 6f9:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 6fc:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 6fe:	84 c0                	test   %al,%al
 700:	0f 84 47 ff ff ff    	je     64d <printf+0x4d>
 706:	8d 55 e7             	lea    -0x19(%ebp),%edx
 709:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 70c:	89 de                	mov    %ebx,%esi
 70e:	89 d3                	mov    %edx,%ebx
  write(fd, &c, 1);
 710:	83 ec 04             	sub    $0x4,%esp
 713:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 716:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 719:	6a 01                	push   $0x1
 71b:	53                   	push   %ebx
 71c:	57                   	push   %edi
 71d:	e8 93 fd ff ff       	call   4b5 <write>
        while(*s != 0){
 722:	0f b6 06             	movzbl (%esi),%eax
 725:	83 c4 10             	add    $0x10,%esp
 728:	84 c0                	test   %al,%al
 72a:	75 e4                	jne    710 <printf+0x110>
      state = 0;
 72c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 72f:	31 d2                	xor    %edx,%edx
 731:	e9 17 ff ff ff       	jmp    64d <printf+0x4d>
        printint(fd, *ap, 10, 1);
 736:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 739:	83 ec 0c             	sub    $0xc,%esp
 73c:	b9 0a 00 00 00       	mov    $0xa,%ecx
 741:	8b 13                	mov    (%ebx),%edx
 743:	6a 01                	push   $0x1
 745:	eb 88                	jmp    6cf <printf+0xcf>
        putc(fd, *ap);
 747:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 74a:	83 ec 04             	sub    $0x4,%esp
 74d:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
 750:	8b 03                	mov    (%ebx),%eax
        ap++;
 752:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
 755:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 758:	6a 01                	push   $0x1
 75a:	52                   	push   %edx
 75b:	57                   	push   %edi
 75c:	e8 54 fd ff ff       	call   4b5 <write>
        ap++;
 761:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 764:	83 c4 10             	add    $0x10,%esp
      state = 0;
 767:	31 d2                	xor    %edx,%edx
 769:	e9 df fe ff ff       	jmp    64d <printf+0x4d>
 76e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 770:	83 ec 04             	sub    $0x4,%esp
 773:	88 5d e7             	mov    %bl,-0x19(%ebp)
 776:	8d 55 e7             	lea    -0x19(%ebp),%edx
 779:	6a 01                	push   $0x1
 77b:	e9 31 ff ff ff       	jmp    6b1 <printf+0xb1>
 780:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 785:	bb 1e 09 00 00       	mov    $0x91e,%ebx
 78a:	e9 77 ff ff ff       	jmp    706 <printf+0x106>
 78f:	90                   	nop

00000790 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 790:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 791:	a1 b0 0d 00 00       	mov    0xdb0,%eax
{
 796:	89 e5                	mov    %esp,%ebp
 798:	57                   	push   %edi
 799:	56                   	push   %esi
 79a:	53                   	push   %ebx
 79b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 79e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7a8:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7aa:	39 c8                	cmp    %ecx,%eax
 7ac:	73 32                	jae    7e0 <free+0x50>
 7ae:	39 d1                	cmp    %edx,%ecx
 7b0:	72 04                	jb     7b6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7b2:	39 d0                	cmp    %edx,%eax
 7b4:	72 32                	jb     7e8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7b6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7b9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 7bc:	39 fa                	cmp    %edi,%edx
 7be:	74 30                	je     7f0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 7c0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 7c3:	8b 50 04             	mov    0x4(%eax),%edx
 7c6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7c9:	39 f1                	cmp    %esi,%ecx
 7cb:	74 3a                	je     807 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 7cd:	89 08                	mov    %ecx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 7cf:	5b                   	pop    %ebx
  freep = p;
 7d0:	a3 b0 0d 00 00       	mov    %eax,0xdb0
}
 7d5:	5e                   	pop    %esi
 7d6:	5f                   	pop    %edi
 7d7:	5d                   	pop    %ebp
 7d8:	c3                   	ret
 7d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7e0:	39 d0                	cmp    %edx,%eax
 7e2:	72 04                	jb     7e8 <free+0x58>
 7e4:	39 d1                	cmp    %edx,%ecx
 7e6:	72 ce                	jb     7b6 <free+0x26>
{
 7e8:	89 d0                	mov    %edx,%eax
 7ea:	eb bc                	jmp    7a8 <free+0x18>
 7ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 7f0:	03 72 04             	add    0x4(%edx),%esi
 7f3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7f6:	8b 10                	mov    (%eax),%edx
 7f8:	8b 12                	mov    (%edx),%edx
 7fa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7fd:	8b 50 04             	mov    0x4(%eax),%edx
 800:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 803:	39 f1                	cmp    %esi,%ecx
 805:	75 c6                	jne    7cd <free+0x3d>
    p->s.size += bp->s.size;
 807:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 80a:	a3 b0 0d 00 00       	mov    %eax,0xdb0
    p->s.size += bp->s.size;
 80f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 812:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 815:	89 08                	mov    %ecx,(%eax)
}
 817:	5b                   	pop    %ebx
 818:	5e                   	pop    %esi
 819:	5f                   	pop    %edi
 81a:	5d                   	pop    %ebp
 81b:	c3                   	ret
 81c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000820 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 820:	55                   	push   %ebp
 821:	89 e5                	mov    %esp,%ebp
 823:	57                   	push   %edi
 824:	56                   	push   %esi
 825:	53                   	push   %ebx
 826:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 829:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 82c:	8b 15 b0 0d 00 00    	mov    0xdb0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 832:	8d 78 07             	lea    0x7(%eax),%edi
 835:	c1 ef 03             	shr    $0x3,%edi
 838:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 83b:	85 d2                	test   %edx,%edx
 83d:	0f 84 8d 00 00 00    	je     8d0 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 843:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 845:	8b 48 04             	mov    0x4(%eax),%ecx
 848:	39 f9                	cmp    %edi,%ecx
 84a:	73 64                	jae    8b0 <malloc+0x90>
  if(nu < 4096)
 84c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 851:	39 df                	cmp    %ebx,%edi
 853:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 856:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 85d:	eb 0a                	jmp    869 <malloc+0x49>
 85f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 860:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 862:	8b 48 04             	mov    0x4(%eax),%ecx
 865:	39 f9                	cmp    %edi,%ecx
 867:	73 47                	jae    8b0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 869:	89 c2                	mov    %eax,%edx
 86b:	3b 05 b0 0d 00 00    	cmp    0xdb0,%eax
 871:	75 ed                	jne    860 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 873:	83 ec 0c             	sub    $0xc,%esp
 876:	56                   	push   %esi
 877:	e8 a1 fc ff ff       	call   51d <sbrk>
  if(p == (char*)-1)
 87c:	83 c4 10             	add    $0x10,%esp
 87f:	83 f8 ff             	cmp    $0xffffffff,%eax
 882:	74 1c                	je     8a0 <malloc+0x80>
  hp->s.size = nu;
 884:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 887:	83 ec 0c             	sub    $0xc,%esp
 88a:	83 c0 08             	add    $0x8,%eax
 88d:	50                   	push   %eax
 88e:	e8 fd fe ff ff       	call   790 <free>
  return freep;
 893:	8b 15 b0 0d 00 00    	mov    0xdb0,%edx
      if((p = morecore(nunits)) == 0)
 899:	83 c4 10             	add    $0x10,%esp
 89c:	85 d2                	test   %edx,%edx
 89e:	75 c0                	jne    860 <malloc+0x40>
        return 0;
  }
}
 8a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 8a3:	31 c0                	xor    %eax,%eax
}
 8a5:	5b                   	pop    %ebx
 8a6:	5e                   	pop    %esi
 8a7:	5f                   	pop    %edi
 8a8:	5d                   	pop    %ebp
 8a9:	c3                   	ret
 8aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 8b0:	39 cf                	cmp    %ecx,%edi
 8b2:	74 4c                	je     900 <malloc+0xe0>
        p->s.size -= nunits;
 8b4:	29 f9                	sub    %edi,%ecx
 8b6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 8b9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 8bc:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 8bf:	89 15 b0 0d 00 00    	mov    %edx,0xdb0
}
 8c5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 8c8:	83 c0 08             	add    $0x8,%eax
}
 8cb:	5b                   	pop    %ebx
 8cc:	5e                   	pop    %esi
 8cd:	5f                   	pop    %edi
 8ce:	5d                   	pop    %ebp
 8cf:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 8d0:	c7 05 b0 0d 00 00 b4 	movl   $0xdb4,0xdb0
 8d7:	0d 00 00 
    base.s.size = 0;
 8da:	b8 b4 0d 00 00       	mov    $0xdb4,%eax
    base.s.ptr = freep = prevp = &base;
 8df:	c7 05 b4 0d 00 00 b4 	movl   $0xdb4,0xdb4
 8e6:	0d 00 00 
    base.s.size = 0;
 8e9:	c7 05 b8 0d 00 00 00 	movl   $0x0,0xdb8
 8f0:	00 00 00 
    if(p->s.size >= nunits){
 8f3:	e9 54 ff ff ff       	jmp    84c <malloc+0x2c>
 8f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 8ff:	00 
        prevp->s.ptr = p->s.ptr;
 900:	8b 08                	mov    (%eax),%ecx
 902:	89 0a                	mov    %ecx,(%edx)
 904:	eb b9                	jmp    8bf <malloc+0x9f>
