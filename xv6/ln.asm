
_ln:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
  if(argc != 3){
   f:	83 39 03             	cmpl   $0x3,(%ecx)
{
  12:	8b 59 04             	mov    0x4(%ecx),%ebx
  if(argc != 3){
  15:	74 13                	je     2a <main+0x2a>
    printf(2, "Usage: ln old new\n");
  17:	52                   	push   %edx
  18:	52                   	push   %edx
  19:	68 88 07 00 00       	push   $0x788
  1e:	6a 02                	push   $0x2
  20:	e8 5b 04 00 00       	call   480 <printf>
    exit();
  25:	e8 eb 02 00 00       	call   315 <exit>
  }
  if(link(argv[1], argv[2]) < 0)
  2a:	50                   	push   %eax
  2b:	50                   	push   %eax
  2c:	ff 73 08             	push   0x8(%ebx)
  2f:	ff 73 04             	push   0x4(%ebx)
  32:	e8 3e 03 00 00       	call   375 <link>
  37:	83 c4 10             	add    $0x10,%esp
  3a:	85 c0                	test   %eax,%eax
  3c:	78 05                	js     43 <main+0x43>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit();
  3e:	e8 d2 02 00 00       	call   315 <exit>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  43:	ff 73 08             	push   0x8(%ebx)
  46:	ff 73 04             	push   0x4(%ebx)
  49:	68 9b 07 00 00       	push   $0x79b
  4e:	6a 02                	push   $0x2
  50:	e8 2b 04 00 00       	call   480 <printf>
  55:	83 c4 10             	add    $0x10,%esp
  58:	eb e4                	jmp    3e <main+0x3e>
  5a:	66 90                	xchg   %ax,%ax
  5c:	66 90                	xchg   %ax,%ax
  5e:	66 90                	xchg   %ax,%ax

00000060 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  60:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  61:	31 c0                	xor    %eax,%eax
{
  63:	89 e5                	mov    %esp,%ebp
  65:	53                   	push   %ebx
  66:	8b 4d 08             	mov    0x8(%ebp),%ecx
  69:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  70:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  74:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  77:	83 c0 01             	add    $0x1,%eax
  7a:	84 d2                	test   %dl,%dl
  7c:	75 f2                	jne    70 <strcpy+0x10>
    ;
  return os;
}
  7e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  81:	89 c8                	mov    %ecx,%eax
  83:	c9                   	leave
  84:	c3                   	ret
  85:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  8c:	00 
  8d:	8d 76 00             	lea    0x0(%esi),%esi

00000090 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	53                   	push   %ebx
  94:	8b 55 08             	mov    0x8(%ebp),%edx
  97:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  9a:	0f b6 02             	movzbl (%edx),%eax
  9d:	84 c0                	test   %al,%al
  9f:	75 17                	jne    b8 <strcmp+0x28>
  a1:	eb 3a                	jmp    dd <strcmp+0x4d>
  a3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  a8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
  ac:	83 c2 01             	add    $0x1,%edx
  af:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
  b2:	84 c0                	test   %al,%al
  b4:	74 1a                	je     d0 <strcmp+0x40>
  b6:	89 d9                	mov    %ebx,%ecx
  b8:	0f b6 19             	movzbl (%ecx),%ebx
  bb:	38 c3                	cmp    %al,%bl
  bd:	74 e9                	je     a8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
  bf:	29 d8                	sub    %ebx,%eax
}
  c1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  c4:	c9                   	leave
  c5:	c3                   	ret
  c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  cd:	00 
  ce:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
  d0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  d4:	31 c0                	xor    %eax,%eax
  d6:	29 d8                	sub    %ebx,%eax
}
  d8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  db:	c9                   	leave
  dc:	c3                   	ret
  return (uchar)*p - (uchar)*q;
  dd:	0f b6 19             	movzbl (%ecx),%ebx
  e0:	31 c0                	xor    %eax,%eax
  e2:	eb db                	jmp    bf <strcmp+0x2f>
  e4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  eb:	00 
  ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000000f0 <strlen>:

uint
strlen(const char *s)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  f6:	80 3a 00             	cmpb   $0x0,(%edx)
  f9:	74 15                	je     110 <strlen+0x20>
  fb:	31 c0                	xor    %eax,%eax
  fd:	8d 76 00             	lea    0x0(%esi),%esi
 100:	83 c0 01             	add    $0x1,%eax
 103:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 107:	89 c1                	mov    %eax,%ecx
 109:	75 f5                	jne    100 <strlen+0x10>
    ;
  return n;
}
 10b:	89 c8                	mov    %ecx,%eax
 10d:	5d                   	pop    %ebp
 10e:	c3                   	ret
 10f:	90                   	nop
  for(n = 0; s[n]; n++)
 110:	31 c9                	xor    %ecx,%ecx
}
 112:	5d                   	pop    %ebp
 113:	89 c8                	mov    %ecx,%eax
 115:	c3                   	ret
 116:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 11d:	00 
 11e:	66 90                	xchg   %ax,%ax

00000120 <memset>:

void*
memset(void *dst, int c, uint n)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	57                   	push   %edi
 124:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 127:	8b 4d 10             	mov    0x10(%ebp),%ecx
 12a:	8b 45 0c             	mov    0xc(%ebp),%eax
 12d:	89 d7                	mov    %edx,%edi
 12f:	fc                   	cld
 130:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 132:	8b 7d fc             	mov    -0x4(%ebp),%edi
 135:	89 d0                	mov    %edx,%eax
 137:	c9                   	leave
 138:	c3                   	ret
 139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000140 <strchr>:

char*
strchr(const char *s, char c)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	8b 45 08             	mov    0x8(%ebp),%eax
 146:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 14a:	0f b6 10             	movzbl (%eax),%edx
 14d:	84 d2                	test   %dl,%dl
 14f:	75 12                	jne    163 <strchr+0x23>
 151:	eb 1d                	jmp    170 <strchr+0x30>
 153:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 158:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 15c:	83 c0 01             	add    $0x1,%eax
 15f:	84 d2                	test   %dl,%dl
 161:	74 0d                	je     170 <strchr+0x30>
    if(*s == c)
 163:	38 d1                	cmp    %dl,%cl
 165:	75 f1                	jne    158 <strchr+0x18>
      return (char*)s;
  return 0;
}
 167:	5d                   	pop    %ebp
 168:	c3                   	ret
 169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 170:	31 c0                	xor    %eax,%eax
}
 172:	5d                   	pop    %ebp
 173:	c3                   	ret
 174:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 17b:	00 
 17c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000180 <gets>:

char*
gets(char *buf, int max)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	57                   	push   %edi
 184:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 185:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 188:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 189:	31 db                	xor    %ebx,%ebx
{
 18b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 18e:	eb 27                	jmp    1b7 <gets+0x37>
    cc = read(0, &c, 1);
 190:	83 ec 04             	sub    $0x4,%esp
 193:	6a 01                	push   $0x1
 195:	56                   	push   %esi
 196:	6a 00                	push   $0x0
 198:	e8 90 01 00 00       	call   32d <read>
    if(cc < 1)
 19d:	83 c4 10             	add    $0x10,%esp
 1a0:	85 c0                	test   %eax,%eax
 1a2:	7e 1d                	jle    1c1 <gets+0x41>
      break;
    buf[i++] = c;
 1a4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1a8:	8b 55 08             	mov    0x8(%ebp),%edx
 1ab:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 1af:	3c 0a                	cmp    $0xa,%al
 1b1:	74 10                	je     1c3 <gets+0x43>
 1b3:	3c 0d                	cmp    $0xd,%al
 1b5:	74 0c                	je     1c3 <gets+0x43>
  for(i=0; i+1 < max; ){
 1b7:	89 df                	mov    %ebx,%edi
 1b9:	83 c3 01             	add    $0x1,%ebx
 1bc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1bf:	7c cf                	jl     190 <gets+0x10>
 1c1:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 1c3:	8b 45 08             	mov    0x8(%ebp),%eax
 1c6:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 1ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1cd:	5b                   	pop    %ebx
 1ce:	5e                   	pop    %esi
 1cf:	5f                   	pop    %edi
 1d0:	5d                   	pop    %ebp
 1d1:	c3                   	ret
 1d2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1d9:	00 
 1da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001e0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	56                   	push   %esi
 1e4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1e5:	83 ec 08             	sub    $0x8,%esp
 1e8:	6a 00                	push   $0x0
 1ea:	ff 75 08             	push   0x8(%ebp)
 1ed:	e8 63 01 00 00       	call   355 <open>
  if(fd < 0)
 1f2:	83 c4 10             	add    $0x10,%esp
 1f5:	85 c0                	test   %eax,%eax
 1f7:	78 27                	js     220 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 1f9:	83 ec 08             	sub    $0x8,%esp
 1fc:	ff 75 0c             	push   0xc(%ebp)
 1ff:	89 c3                	mov    %eax,%ebx
 201:	50                   	push   %eax
 202:	e8 66 01 00 00       	call   36d <fstat>
  close(fd);
 207:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 20a:	89 c6                	mov    %eax,%esi
  close(fd);
 20c:	e8 2c 01 00 00       	call   33d <close>
  return r;
 211:	83 c4 10             	add    $0x10,%esp
}
 214:	8d 65 f8             	lea    -0x8(%ebp),%esp
 217:	89 f0                	mov    %esi,%eax
 219:	5b                   	pop    %ebx
 21a:	5e                   	pop    %esi
 21b:	5d                   	pop    %ebp
 21c:	c3                   	ret
 21d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 220:	be ff ff ff ff       	mov    $0xffffffff,%esi
 225:	eb ed                	jmp    214 <stat+0x34>
 227:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 22e:	00 
 22f:	90                   	nop

00000230 <atoi>:

int
atoi(const char *s)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	53                   	push   %ebx
 234:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 237:	0f be 02             	movsbl (%edx),%eax
 23a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 23d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 240:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 245:	77 1e                	ja     265 <atoi+0x35>
 247:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 24e:	00 
 24f:	90                   	nop
    n = n*10 + *s++ - '0';
 250:	83 c2 01             	add    $0x1,%edx
 253:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 256:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 25a:	0f be 02             	movsbl (%edx),%eax
 25d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 260:	80 fb 09             	cmp    $0x9,%bl
 263:	76 eb                	jbe    250 <atoi+0x20>
  return n;
}
 265:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 268:	89 c8                	mov    %ecx,%eax
 26a:	c9                   	leave
 26b:	c3                   	ret
 26c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000270 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	57                   	push   %edi
 274:	8b 45 10             	mov    0x10(%ebp),%eax
 277:	8b 55 08             	mov    0x8(%ebp),%edx
 27a:	56                   	push   %esi
 27b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 27e:	85 c0                	test   %eax,%eax
 280:	7e 13                	jle    295 <memmove+0x25>
 282:	01 d0                	add    %edx,%eax
  dst = vdst;
 284:	89 d7                	mov    %edx,%edi
 286:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 28d:	00 
 28e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 290:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 291:	39 f8                	cmp    %edi,%eax
 293:	75 fb                	jne    290 <memmove+0x20>
  return vdst;
}
 295:	5e                   	pop    %esi
 296:	89 d0                	mov    %edx,%eax
 298:	5f                   	pop    %edi
 299:	5d                   	pop    %ebp
 29a:	c3                   	ret
 29b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

000002a0 <copyfd>:

int copyfd(int srcfd, int dstfd) {
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	57                   	push   %edi
 2a4:	56                   	push   %esi
 2a5:	53                   	push   %ebx
 2a6:	8d 9d e8 fd ff ff    	lea    -0x218(%ebp),%ebx
 2ac:	81 ec 0c 02 00 00    	sub    $0x20c,%esp
 2b2:	8b 75 08             	mov    0x8(%ebp),%esi
    char buf[512];
    int n;

    while((n = read(srcfd, buf, sizeof(buf))) > 0) {
 2b5:	eb 1d                	jmp    2d4 <copyfd+0x34>
 2b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2be:	00 
 2bf:	90                   	nop
        if(write(dstfd, buf, n) != n) {
 2c0:	83 ec 04             	sub    $0x4,%esp
 2c3:	57                   	push   %edi
 2c4:	53                   	push   %ebx
 2c5:	ff 75 0c             	push   0xc(%ebp)
 2c8:	e8 68 00 00 00       	call   335 <write>
 2cd:	83 c4 10             	add    $0x10,%esp
 2d0:	39 f8                	cmp    %edi,%eax
 2d2:	75 2c                	jne    300 <copyfd+0x60>
    while((n = read(srcfd, buf, sizeof(buf))) > 0) {
 2d4:	83 ec 04             	sub    $0x4,%esp
 2d7:	68 00 02 00 00       	push   $0x200
 2dc:	53                   	push   %ebx
 2dd:	56                   	push   %esi
 2de:	e8 4a 00 00 00       	call   32d <read>
 2e3:	83 c4 10             	add    $0x10,%esp
 2e6:	89 c7                	mov    %eax,%edi
 2e8:	85 c0                	test   %eax,%eax
 2ea:	7f d4                	jg     2c0 <copyfd+0x20>
            return -1;   // write error
        }
    }
    if(n < 0) return -1;   // read error
 2ec:	0f 95 c0             	setne  %al
    return 0;              // success
}
 2ef:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(n < 0) return -1;   // read error
 2f2:	0f b6 c0             	movzbl %al,%eax
}
 2f5:	5b                   	pop    %ebx
 2f6:	5e                   	pop    %esi
    if(n < 0) return -1;   // read error
 2f7:	f7 d8                	neg    %eax
}
 2f9:	5f                   	pop    %edi
 2fa:	5d                   	pop    %ebp
 2fb:	c3                   	ret
 2fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 300:	8d 65 f4             	lea    -0xc(%ebp),%esp
            return -1;   // write error
 303:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 308:	5b                   	pop    %ebx
 309:	5e                   	pop    %esi
 30a:	5f                   	pop    %edi
 30b:	5d                   	pop    %ebp
 30c:	c3                   	ret

0000030d <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 30d:	b8 01 00 00 00       	mov    $0x1,%eax
 312:	cd 40                	int    $0x40
 314:	c3                   	ret

00000315 <exit>:
SYSCALL(exit)
 315:	b8 02 00 00 00       	mov    $0x2,%eax
 31a:	cd 40                	int    $0x40
 31c:	c3                   	ret

0000031d <wait>:
SYSCALL(wait)
 31d:	b8 03 00 00 00       	mov    $0x3,%eax
 322:	cd 40                	int    $0x40
 324:	c3                   	ret

00000325 <pipe>:
SYSCALL(pipe)
 325:	b8 04 00 00 00       	mov    $0x4,%eax
 32a:	cd 40                	int    $0x40
 32c:	c3                   	ret

0000032d <read>:
SYSCALL(read)
 32d:	b8 05 00 00 00       	mov    $0x5,%eax
 332:	cd 40                	int    $0x40
 334:	c3                   	ret

00000335 <write>:
SYSCALL(write)
 335:	b8 10 00 00 00       	mov    $0x10,%eax
 33a:	cd 40                	int    $0x40
 33c:	c3                   	ret

0000033d <close>:
SYSCALL(close)
 33d:	b8 15 00 00 00       	mov    $0x15,%eax
 342:	cd 40                	int    $0x40
 344:	c3                   	ret

00000345 <kill>:
SYSCALL(kill)
 345:	b8 06 00 00 00       	mov    $0x6,%eax
 34a:	cd 40                	int    $0x40
 34c:	c3                   	ret

0000034d <exec>:
SYSCALL(exec)
 34d:	b8 07 00 00 00       	mov    $0x7,%eax
 352:	cd 40                	int    $0x40
 354:	c3                   	ret

00000355 <open>:
SYSCALL(open)
 355:	b8 0f 00 00 00       	mov    $0xf,%eax
 35a:	cd 40                	int    $0x40
 35c:	c3                   	ret

0000035d <mknod>:
SYSCALL(mknod)
 35d:	b8 11 00 00 00       	mov    $0x11,%eax
 362:	cd 40                	int    $0x40
 364:	c3                   	ret

00000365 <unlink>:
SYSCALL(unlink)
 365:	b8 12 00 00 00       	mov    $0x12,%eax
 36a:	cd 40                	int    $0x40
 36c:	c3                   	ret

0000036d <fstat>:
SYSCALL(fstat)
 36d:	b8 08 00 00 00       	mov    $0x8,%eax
 372:	cd 40                	int    $0x40
 374:	c3                   	ret

00000375 <link>:
SYSCALL(link)
 375:	b8 13 00 00 00       	mov    $0x13,%eax
 37a:	cd 40                	int    $0x40
 37c:	c3                   	ret

0000037d <mkdir>:
SYSCALL(mkdir)
 37d:	b8 14 00 00 00       	mov    $0x14,%eax
 382:	cd 40                	int    $0x40
 384:	c3                   	ret

00000385 <chdir>:
SYSCALL(chdir)
 385:	b8 09 00 00 00       	mov    $0x9,%eax
 38a:	cd 40                	int    $0x40
 38c:	c3                   	ret

0000038d <dup>:
SYSCALL(dup)
 38d:	b8 0a 00 00 00       	mov    $0xa,%eax
 392:	cd 40                	int    $0x40
 394:	c3                   	ret

00000395 <getpid>:
SYSCALL(getpid)
 395:	b8 0b 00 00 00       	mov    $0xb,%eax
 39a:	cd 40                	int    $0x40
 39c:	c3                   	ret

0000039d <sbrk>:
SYSCALL(sbrk)
 39d:	b8 0c 00 00 00       	mov    $0xc,%eax
 3a2:	cd 40                	int    $0x40
 3a4:	c3                   	ret

000003a5 <sleep>:
SYSCALL(sleep)
 3a5:	b8 0d 00 00 00       	mov    $0xd,%eax
 3aa:	cd 40                	int    $0x40
 3ac:	c3                   	ret

000003ad <uptime>:
SYSCALL(uptime)
 3ad:	b8 0e 00 00 00       	mov    $0xe,%eax
 3b2:	cd 40                	int    $0x40
 3b4:	c3                   	ret

000003b5 <chprty>:
SYSCALL(chprty)
 3b5:	b8 16 00 00 00       	mov    $0x16,%eax
 3ba:	cd 40                	int    $0x40
 3bc:	c3                   	ret

000003bd <cps>:
SYSCALL(cps)
 3bd:	b8 17 00 00 00       	mov    $0x17,%eax
 3c2:	cd 40                	int    $0x40
 3c4:	c3                   	ret

000003c5 <waitx>:
SYSCALL(waitx)
 3c5:	b8 19 00 00 00       	mov    $0x19,%eax
 3ca:	cd 40                	int    $0x40
 3cc:	c3                   	ret

000003cd <getpinfo>:
 3cd:	b8 18 00 00 00       	mov    $0x18,%eax
 3d2:	cd 40                	int    $0x40
 3d4:	c3                   	ret
 3d5:	66 90                	xchg   %ax,%ax
 3d7:	66 90                	xchg   %ax,%ax
 3d9:	66 90                	xchg   %ax,%ax
 3db:	66 90                	xchg   %ax,%ax
 3dd:	66 90                	xchg   %ax,%ax
 3df:	90                   	nop

000003e0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	57                   	push   %edi
 3e4:	56                   	push   %esi
 3e5:	53                   	push   %ebx
 3e6:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3e8:	89 d1                	mov    %edx,%ecx
{
 3ea:	83 ec 3c             	sub    $0x3c,%esp
 3ed:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
 3f0:	85 d2                	test   %edx,%edx
 3f2:	0f 89 80 00 00 00    	jns    478 <printint+0x98>
 3f8:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 3fc:	74 7a                	je     478 <printint+0x98>
    x = -xx;
 3fe:	f7 d9                	neg    %ecx
    neg = 1;
 400:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 405:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 408:	31 f6                	xor    %esi,%esi
 40a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 410:	89 c8                	mov    %ecx,%eax
 412:	31 d2                	xor    %edx,%edx
 414:	89 f7                	mov    %esi,%edi
 416:	f7 f3                	div    %ebx
 418:	8d 76 01             	lea    0x1(%esi),%esi
 41b:	0f b6 92 10 08 00 00 	movzbl 0x810(%edx),%edx
 422:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 426:	89 ca                	mov    %ecx,%edx
 428:	89 c1                	mov    %eax,%ecx
 42a:	39 da                	cmp    %ebx,%edx
 42c:	73 e2                	jae    410 <printint+0x30>
  if(neg)
 42e:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 431:	85 c0                	test   %eax,%eax
 433:	74 07                	je     43c <printint+0x5c>
    buf[i++] = '-';
 435:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)

  while(--i >= 0)
 43a:	89 f7                	mov    %esi,%edi
 43c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 43f:	8b 75 c0             	mov    -0x40(%ebp),%esi
 442:	01 df                	add    %ebx,%edi
 444:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 448:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 44b:	83 ec 04             	sub    $0x4,%esp
 44e:	88 45 d7             	mov    %al,-0x29(%ebp)
 451:	8d 45 d7             	lea    -0x29(%ebp),%eax
 454:	6a 01                	push   $0x1
 456:	50                   	push   %eax
 457:	56                   	push   %esi
 458:	e8 d8 fe ff ff       	call   335 <write>
  while(--i >= 0)
 45d:	89 f8                	mov    %edi,%eax
 45f:	83 c4 10             	add    $0x10,%esp
 462:	83 ef 01             	sub    $0x1,%edi
 465:	39 c3                	cmp    %eax,%ebx
 467:	75 df                	jne    448 <printint+0x68>
}
 469:	8d 65 f4             	lea    -0xc(%ebp),%esp
 46c:	5b                   	pop    %ebx
 46d:	5e                   	pop    %esi
 46e:	5f                   	pop    %edi
 46f:	5d                   	pop    %ebp
 470:	c3                   	ret
 471:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 478:	31 c0                	xor    %eax,%eax
 47a:	eb 89                	jmp    405 <printint+0x25>
 47c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000480 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	57                   	push   %edi
 484:	56                   	push   %esi
 485:	53                   	push   %ebx
 486:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 489:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 48c:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 48f:	0f b6 1e             	movzbl (%esi),%ebx
 492:	83 c6 01             	add    $0x1,%esi
 495:	84 db                	test   %bl,%bl
 497:	74 67                	je     500 <printf+0x80>
 499:	8d 4d 10             	lea    0x10(%ebp),%ecx
 49c:	31 d2                	xor    %edx,%edx
 49e:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 4a1:	eb 34                	jmp    4d7 <printf+0x57>
 4a3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 4a8:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 4ab:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 4b0:	83 f8 25             	cmp    $0x25,%eax
 4b3:	74 18                	je     4cd <printf+0x4d>
  write(fd, &c, 1);
 4b5:	83 ec 04             	sub    $0x4,%esp
 4b8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4bb:	88 5d e7             	mov    %bl,-0x19(%ebp)
 4be:	6a 01                	push   $0x1
 4c0:	50                   	push   %eax
 4c1:	57                   	push   %edi
 4c2:	e8 6e fe ff ff       	call   335 <write>
 4c7:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 4ca:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 4cd:	0f b6 1e             	movzbl (%esi),%ebx
 4d0:	83 c6 01             	add    $0x1,%esi
 4d3:	84 db                	test   %bl,%bl
 4d5:	74 29                	je     500 <printf+0x80>
    c = fmt[i] & 0xff;
 4d7:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 4da:	85 d2                	test   %edx,%edx
 4dc:	74 ca                	je     4a8 <printf+0x28>
      }
    } else if(state == '%'){
 4de:	83 fa 25             	cmp    $0x25,%edx
 4e1:	75 ea                	jne    4cd <printf+0x4d>
      if(c == 'd'){
 4e3:	83 f8 25             	cmp    $0x25,%eax
 4e6:	0f 84 04 01 00 00    	je     5f0 <printf+0x170>
 4ec:	83 e8 63             	sub    $0x63,%eax
 4ef:	83 f8 15             	cmp    $0x15,%eax
 4f2:	77 1c                	ja     510 <printf+0x90>
 4f4:	ff 24 85 b8 07 00 00 	jmp    *0x7b8(,%eax,4)
 4fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 500:	8d 65 f4             	lea    -0xc(%ebp),%esp
 503:	5b                   	pop    %ebx
 504:	5e                   	pop    %esi
 505:	5f                   	pop    %edi
 506:	5d                   	pop    %ebp
 507:	c3                   	ret
 508:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 50f:	00 
  write(fd, &c, 1);
 510:	83 ec 04             	sub    $0x4,%esp
 513:	8d 55 e7             	lea    -0x19(%ebp),%edx
 516:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 51a:	6a 01                	push   $0x1
 51c:	52                   	push   %edx
 51d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 520:	57                   	push   %edi
 521:	e8 0f fe ff ff       	call   335 <write>
 526:	83 c4 0c             	add    $0xc,%esp
 529:	88 5d e7             	mov    %bl,-0x19(%ebp)
 52c:	6a 01                	push   $0x1
 52e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 531:	52                   	push   %edx
 532:	57                   	push   %edi
 533:	e8 fd fd ff ff       	call   335 <write>
        putc(fd, c);
 538:	83 c4 10             	add    $0x10,%esp
      state = 0;
 53b:	31 d2                	xor    %edx,%edx
 53d:	eb 8e                	jmp    4cd <printf+0x4d>
 53f:	90                   	nop
        printint(fd, *ap, 16, 0);
 540:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 543:	83 ec 0c             	sub    $0xc,%esp
 546:	b9 10 00 00 00       	mov    $0x10,%ecx
 54b:	8b 13                	mov    (%ebx),%edx
 54d:	6a 00                	push   $0x0
 54f:	89 f8                	mov    %edi,%eax
        ap++;
 551:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
 554:	e8 87 fe ff ff       	call   3e0 <printint>
        ap++;
 559:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 55c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 55f:	31 d2                	xor    %edx,%edx
 561:	e9 67 ff ff ff       	jmp    4cd <printf+0x4d>
        s = (char*)*ap;
 566:	8b 45 d0             	mov    -0x30(%ebp),%eax
 569:	8b 18                	mov    (%eax),%ebx
        ap++;
 56b:	83 c0 04             	add    $0x4,%eax
 56e:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 571:	85 db                	test   %ebx,%ebx
 573:	0f 84 87 00 00 00    	je     600 <printf+0x180>
        while(*s != 0){
 579:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 57c:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 57e:	84 c0                	test   %al,%al
 580:	0f 84 47 ff ff ff    	je     4cd <printf+0x4d>
 586:	8d 55 e7             	lea    -0x19(%ebp),%edx
 589:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 58c:	89 de                	mov    %ebx,%esi
 58e:	89 d3                	mov    %edx,%ebx
  write(fd, &c, 1);
 590:	83 ec 04             	sub    $0x4,%esp
 593:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 596:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 599:	6a 01                	push   $0x1
 59b:	53                   	push   %ebx
 59c:	57                   	push   %edi
 59d:	e8 93 fd ff ff       	call   335 <write>
        while(*s != 0){
 5a2:	0f b6 06             	movzbl (%esi),%eax
 5a5:	83 c4 10             	add    $0x10,%esp
 5a8:	84 c0                	test   %al,%al
 5aa:	75 e4                	jne    590 <printf+0x110>
      state = 0;
 5ac:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 5af:	31 d2                	xor    %edx,%edx
 5b1:	e9 17 ff ff ff       	jmp    4cd <printf+0x4d>
        printint(fd, *ap, 10, 1);
 5b6:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5b9:	83 ec 0c             	sub    $0xc,%esp
 5bc:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5c1:	8b 13                	mov    (%ebx),%edx
 5c3:	6a 01                	push   $0x1
 5c5:	eb 88                	jmp    54f <printf+0xcf>
        putc(fd, *ap);
 5c7:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 5ca:	83 ec 04             	sub    $0x4,%esp
 5cd:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
 5d0:	8b 03                	mov    (%ebx),%eax
        ap++;
 5d2:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
 5d5:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5d8:	6a 01                	push   $0x1
 5da:	52                   	push   %edx
 5db:	57                   	push   %edi
 5dc:	e8 54 fd ff ff       	call   335 <write>
        ap++;
 5e1:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 5e4:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5e7:	31 d2                	xor    %edx,%edx
 5e9:	e9 df fe ff ff       	jmp    4cd <printf+0x4d>
 5ee:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 5f0:	83 ec 04             	sub    $0x4,%esp
 5f3:	88 5d e7             	mov    %bl,-0x19(%ebp)
 5f6:	8d 55 e7             	lea    -0x19(%ebp),%edx
 5f9:	6a 01                	push   $0x1
 5fb:	e9 31 ff ff ff       	jmp    531 <printf+0xb1>
 600:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 605:	bb af 07 00 00       	mov    $0x7af,%ebx
 60a:	e9 77 ff ff ff       	jmp    586 <printf+0x106>
 60f:	90                   	nop

00000610 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 610:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 611:	a1 ec 0a 00 00       	mov    0xaec,%eax
{
 616:	89 e5                	mov    %esp,%ebp
 618:	57                   	push   %edi
 619:	56                   	push   %esi
 61a:	53                   	push   %ebx
 61b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 61e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 621:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 628:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 62a:	39 c8                	cmp    %ecx,%eax
 62c:	73 32                	jae    660 <free+0x50>
 62e:	39 d1                	cmp    %edx,%ecx
 630:	72 04                	jb     636 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 632:	39 d0                	cmp    %edx,%eax
 634:	72 32                	jb     668 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 636:	8b 73 fc             	mov    -0x4(%ebx),%esi
 639:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 63c:	39 fa                	cmp    %edi,%edx
 63e:	74 30                	je     670 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 640:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 643:	8b 50 04             	mov    0x4(%eax),%edx
 646:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 649:	39 f1                	cmp    %esi,%ecx
 64b:	74 3a                	je     687 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 64d:	89 08                	mov    %ecx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 64f:	5b                   	pop    %ebx
  freep = p;
 650:	a3 ec 0a 00 00       	mov    %eax,0xaec
}
 655:	5e                   	pop    %esi
 656:	5f                   	pop    %edi
 657:	5d                   	pop    %ebp
 658:	c3                   	ret
 659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 660:	39 d0                	cmp    %edx,%eax
 662:	72 04                	jb     668 <free+0x58>
 664:	39 d1                	cmp    %edx,%ecx
 666:	72 ce                	jb     636 <free+0x26>
{
 668:	89 d0                	mov    %edx,%eax
 66a:	eb bc                	jmp    628 <free+0x18>
 66c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 670:	03 72 04             	add    0x4(%edx),%esi
 673:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 676:	8b 10                	mov    (%eax),%edx
 678:	8b 12                	mov    (%edx),%edx
 67a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 67d:	8b 50 04             	mov    0x4(%eax),%edx
 680:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 683:	39 f1                	cmp    %esi,%ecx
 685:	75 c6                	jne    64d <free+0x3d>
    p->s.size += bp->s.size;
 687:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 68a:	a3 ec 0a 00 00       	mov    %eax,0xaec
    p->s.size += bp->s.size;
 68f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 692:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 695:	89 08                	mov    %ecx,(%eax)
}
 697:	5b                   	pop    %ebx
 698:	5e                   	pop    %esi
 699:	5f                   	pop    %edi
 69a:	5d                   	pop    %ebp
 69b:	c3                   	ret
 69c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000006a0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6a0:	55                   	push   %ebp
 6a1:	89 e5                	mov    %esp,%ebp
 6a3:	57                   	push   %edi
 6a4:	56                   	push   %esi
 6a5:	53                   	push   %ebx
 6a6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6a9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6ac:	8b 15 ec 0a 00 00    	mov    0xaec,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6b2:	8d 78 07             	lea    0x7(%eax),%edi
 6b5:	c1 ef 03             	shr    $0x3,%edi
 6b8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 6bb:	85 d2                	test   %edx,%edx
 6bd:	0f 84 8d 00 00 00    	je     750 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6c3:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6c5:	8b 48 04             	mov    0x4(%eax),%ecx
 6c8:	39 f9                	cmp    %edi,%ecx
 6ca:	73 64                	jae    730 <malloc+0x90>
  if(nu < 4096)
 6cc:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6d1:	39 df                	cmp    %ebx,%edi
 6d3:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 6d6:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 6dd:	eb 0a                	jmp    6e9 <malloc+0x49>
 6df:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6e0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6e2:	8b 48 04             	mov    0x4(%eax),%ecx
 6e5:	39 f9                	cmp    %edi,%ecx
 6e7:	73 47                	jae    730 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6e9:	89 c2                	mov    %eax,%edx
 6eb:	3b 05 ec 0a 00 00    	cmp    0xaec,%eax
 6f1:	75 ed                	jne    6e0 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 6f3:	83 ec 0c             	sub    $0xc,%esp
 6f6:	56                   	push   %esi
 6f7:	e8 a1 fc ff ff       	call   39d <sbrk>
  if(p == (char*)-1)
 6fc:	83 c4 10             	add    $0x10,%esp
 6ff:	83 f8 ff             	cmp    $0xffffffff,%eax
 702:	74 1c                	je     720 <malloc+0x80>
  hp->s.size = nu;
 704:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 707:	83 ec 0c             	sub    $0xc,%esp
 70a:	83 c0 08             	add    $0x8,%eax
 70d:	50                   	push   %eax
 70e:	e8 fd fe ff ff       	call   610 <free>
  return freep;
 713:	8b 15 ec 0a 00 00    	mov    0xaec,%edx
      if((p = morecore(nunits)) == 0)
 719:	83 c4 10             	add    $0x10,%esp
 71c:	85 d2                	test   %edx,%edx
 71e:	75 c0                	jne    6e0 <malloc+0x40>
        return 0;
  }
}
 720:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 723:	31 c0                	xor    %eax,%eax
}
 725:	5b                   	pop    %ebx
 726:	5e                   	pop    %esi
 727:	5f                   	pop    %edi
 728:	5d                   	pop    %ebp
 729:	c3                   	ret
 72a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 730:	39 cf                	cmp    %ecx,%edi
 732:	74 4c                	je     780 <malloc+0xe0>
        p->s.size -= nunits;
 734:	29 f9                	sub    %edi,%ecx
 736:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 739:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 73c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 73f:	89 15 ec 0a 00 00    	mov    %edx,0xaec
}
 745:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 748:	83 c0 08             	add    $0x8,%eax
}
 74b:	5b                   	pop    %ebx
 74c:	5e                   	pop    %esi
 74d:	5f                   	pop    %edi
 74e:	5d                   	pop    %ebp
 74f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 750:	c7 05 ec 0a 00 00 f0 	movl   $0xaf0,0xaec
 757:	0a 00 00 
    base.s.size = 0;
 75a:	b8 f0 0a 00 00       	mov    $0xaf0,%eax
    base.s.ptr = freep = prevp = &base;
 75f:	c7 05 f0 0a 00 00 f0 	movl   $0xaf0,0xaf0
 766:	0a 00 00 
    base.s.size = 0;
 769:	c7 05 f4 0a 00 00 00 	movl   $0x0,0xaf4
 770:	00 00 00 
    if(p->s.size >= nunits){
 773:	e9 54 ff ff ff       	jmp    6cc <malloc+0x2c>
 778:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 77f:	00 
        prevp->s.ptr = p->s.ptr;
 780:	8b 08                	mov    (%eax),%ecx
 782:	89 0a                	mov    %ecx,(%edx)
 784:	eb b9                	jmp    73f <malloc+0x9f>
