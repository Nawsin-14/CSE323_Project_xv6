
_echo:     file format elf32-i386


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
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 08             	sub    $0x8,%esp
  14:	8b 31                	mov    (%ecx),%esi
  16:	8b 79 04             	mov    0x4(%ecx),%edi
  int i;

  for(i = 1; i < argc; i++)
  19:	83 fe 01             	cmp    $0x1,%esi
  1c:	7e 47                	jle    65 <main+0x65>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  1e:	8b 47 04             	mov    0x4(%edi),%eax
  21:	83 fe 02             	cmp    $0x2,%esi
  24:	74 2a                	je     50 <main+0x50>
  26:	bb 02 00 00 00       	mov    $0x2,%ebx
  2b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  30:	68 98 07 00 00       	push   $0x798
  35:	83 c3 01             	add    $0x1,%ebx
  38:	50                   	push   %eax
  39:	68 9a 07 00 00       	push   $0x79a
  3e:	6a 01                	push   $0x1
  40:	e8 4b 04 00 00       	call   490 <printf>
  45:	8b 44 9f fc          	mov    -0x4(%edi,%ebx,4),%eax
  49:	83 c4 10             	add    $0x10,%esp
  4c:	39 de                	cmp    %ebx,%esi
  4e:	75 e0                	jne    30 <main+0x30>
  50:	68 9f 07 00 00       	push   $0x79f
  55:	50                   	push   %eax
  56:	68 9a 07 00 00       	push   $0x79a
  5b:	6a 01                	push   $0x1
  5d:	e8 2e 04 00 00       	call   490 <printf>
  62:	83 c4 10             	add    $0x10,%esp
  exit();
  65:	e8 bb 02 00 00       	call   325 <exit>
  6a:	66 90                	xchg   %ax,%ax
  6c:	66 90                	xchg   %ax,%ax
  6e:	66 90                	xchg   %ax,%ax

00000070 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  70:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  71:	31 c0                	xor    %eax,%eax
{
  73:	89 e5                	mov    %esp,%ebp
  75:	53                   	push   %ebx
  76:	8b 4d 08             	mov    0x8(%ebp),%ecx
  79:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  80:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  84:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  87:	83 c0 01             	add    $0x1,%eax
  8a:	84 d2                	test   %dl,%dl
  8c:	75 f2                	jne    80 <strcpy+0x10>
    ;
  return os;
}
  8e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  91:	89 c8                	mov    %ecx,%eax
  93:	c9                   	leave
  94:	c3                   	ret
  95:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  9c:	00 
  9d:	8d 76 00             	lea    0x0(%esi),%esi

000000a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	53                   	push   %ebx
  a4:	8b 55 08             	mov    0x8(%ebp),%edx
  a7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  aa:	0f b6 02             	movzbl (%edx),%eax
  ad:	84 c0                	test   %al,%al
  af:	75 17                	jne    c8 <strcmp+0x28>
  b1:	eb 3a                	jmp    ed <strcmp+0x4d>
  b3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  b8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
  bc:	83 c2 01             	add    $0x1,%edx
  bf:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
  c2:	84 c0                	test   %al,%al
  c4:	74 1a                	je     e0 <strcmp+0x40>
  c6:	89 d9                	mov    %ebx,%ecx
  c8:	0f b6 19             	movzbl (%ecx),%ebx
  cb:	38 c3                	cmp    %al,%bl
  cd:	74 e9                	je     b8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
  cf:	29 d8                	sub    %ebx,%eax
}
  d1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  d4:	c9                   	leave
  d5:	c3                   	ret
  d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  dd:	00 
  de:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
  e0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  e4:	31 c0                	xor    %eax,%eax
  e6:	29 d8                	sub    %ebx,%eax
}
  e8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  eb:	c9                   	leave
  ec:	c3                   	ret
  return (uchar)*p - (uchar)*q;
  ed:	0f b6 19             	movzbl (%ecx),%ebx
  f0:	31 c0                	xor    %eax,%eax
  f2:	eb db                	jmp    cf <strcmp+0x2f>
  f4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  fb:	00 
  fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000100 <strlen>:

uint
strlen(const char *s)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 106:	80 3a 00             	cmpb   $0x0,(%edx)
 109:	74 15                	je     120 <strlen+0x20>
 10b:	31 c0                	xor    %eax,%eax
 10d:	8d 76 00             	lea    0x0(%esi),%esi
 110:	83 c0 01             	add    $0x1,%eax
 113:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 117:	89 c1                	mov    %eax,%ecx
 119:	75 f5                	jne    110 <strlen+0x10>
    ;
  return n;
}
 11b:	89 c8                	mov    %ecx,%eax
 11d:	5d                   	pop    %ebp
 11e:	c3                   	ret
 11f:	90                   	nop
  for(n = 0; s[n]; n++)
 120:	31 c9                	xor    %ecx,%ecx
}
 122:	5d                   	pop    %ebp
 123:	89 c8                	mov    %ecx,%eax
 125:	c3                   	ret
 126:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 12d:	00 
 12e:	66 90                	xchg   %ax,%ax

00000130 <memset>:

void*
memset(void *dst, int c, uint n)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	57                   	push   %edi
 134:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 137:	8b 4d 10             	mov    0x10(%ebp),%ecx
 13a:	8b 45 0c             	mov    0xc(%ebp),%eax
 13d:	89 d7                	mov    %edx,%edi
 13f:	fc                   	cld
 140:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 142:	8b 7d fc             	mov    -0x4(%ebp),%edi
 145:	89 d0                	mov    %edx,%eax
 147:	c9                   	leave
 148:	c3                   	ret
 149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000150 <strchr>:

char*
strchr(const char *s, char c)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	8b 45 08             	mov    0x8(%ebp),%eax
 156:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 15a:	0f b6 10             	movzbl (%eax),%edx
 15d:	84 d2                	test   %dl,%dl
 15f:	75 12                	jne    173 <strchr+0x23>
 161:	eb 1d                	jmp    180 <strchr+0x30>
 163:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 168:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 16c:	83 c0 01             	add    $0x1,%eax
 16f:	84 d2                	test   %dl,%dl
 171:	74 0d                	je     180 <strchr+0x30>
    if(*s == c)
 173:	38 d1                	cmp    %dl,%cl
 175:	75 f1                	jne    168 <strchr+0x18>
      return (char*)s;
  return 0;
}
 177:	5d                   	pop    %ebp
 178:	c3                   	ret
 179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 180:	31 c0                	xor    %eax,%eax
}
 182:	5d                   	pop    %ebp
 183:	c3                   	ret
 184:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 18b:	00 
 18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000190 <gets>:

char*
gets(char *buf, int max)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	57                   	push   %edi
 194:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 195:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 198:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 199:	31 db                	xor    %ebx,%ebx
{
 19b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 19e:	eb 27                	jmp    1c7 <gets+0x37>
    cc = read(0, &c, 1);
 1a0:	83 ec 04             	sub    $0x4,%esp
 1a3:	6a 01                	push   $0x1
 1a5:	56                   	push   %esi
 1a6:	6a 00                	push   $0x0
 1a8:	e8 90 01 00 00       	call   33d <read>
    if(cc < 1)
 1ad:	83 c4 10             	add    $0x10,%esp
 1b0:	85 c0                	test   %eax,%eax
 1b2:	7e 1d                	jle    1d1 <gets+0x41>
      break;
    buf[i++] = c;
 1b4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1b8:	8b 55 08             	mov    0x8(%ebp),%edx
 1bb:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 1bf:	3c 0a                	cmp    $0xa,%al
 1c1:	74 10                	je     1d3 <gets+0x43>
 1c3:	3c 0d                	cmp    $0xd,%al
 1c5:	74 0c                	je     1d3 <gets+0x43>
  for(i=0; i+1 < max; ){
 1c7:	89 df                	mov    %ebx,%edi
 1c9:	83 c3 01             	add    $0x1,%ebx
 1cc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1cf:	7c cf                	jl     1a0 <gets+0x10>
 1d1:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 1d3:	8b 45 08             	mov    0x8(%ebp),%eax
 1d6:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 1da:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1dd:	5b                   	pop    %ebx
 1de:	5e                   	pop    %esi
 1df:	5f                   	pop    %edi
 1e0:	5d                   	pop    %ebp
 1e1:	c3                   	ret
 1e2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1e9:	00 
 1ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001f0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	56                   	push   %esi
 1f4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f5:	83 ec 08             	sub    $0x8,%esp
 1f8:	6a 00                	push   $0x0
 1fa:	ff 75 08             	push   0x8(%ebp)
 1fd:	e8 63 01 00 00       	call   365 <open>
  if(fd < 0)
 202:	83 c4 10             	add    $0x10,%esp
 205:	85 c0                	test   %eax,%eax
 207:	78 27                	js     230 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 209:	83 ec 08             	sub    $0x8,%esp
 20c:	ff 75 0c             	push   0xc(%ebp)
 20f:	89 c3                	mov    %eax,%ebx
 211:	50                   	push   %eax
 212:	e8 66 01 00 00       	call   37d <fstat>
  close(fd);
 217:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 21a:	89 c6                	mov    %eax,%esi
  close(fd);
 21c:	e8 2c 01 00 00       	call   34d <close>
  return r;
 221:	83 c4 10             	add    $0x10,%esp
}
 224:	8d 65 f8             	lea    -0x8(%ebp),%esp
 227:	89 f0                	mov    %esi,%eax
 229:	5b                   	pop    %ebx
 22a:	5e                   	pop    %esi
 22b:	5d                   	pop    %ebp
 22c:	c3                   	ret
 22d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 230:	be ff ff ff ff       	mov    $0xffffffff,%esi
 235:	eb ed                	jmp    224 <stat+0x34>
 237:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 23e:	00 
 23f:	90                   	nop

00000240 <atoi>:

int
atoi(const char *s)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	53                   	push   %ebx
 244:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 247:	0f be 02             	movsbl (%edx),%eax
 24a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 24d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 250:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 255:	77 1e                	ja     275 <atoi+0x35>
 257:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 25e:	00 
 25f:	90                   	nop
    n = n*10 + *s++ - '0';
 260:	83 c2 01             	add    $0x1,%edx
 263:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 266:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 26a:	0f be 02             	movsbl (%edx),%eax
 26d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 270:	80 fb 09             	cmp    $0x9,%bl
 273:	76 eb                	jbe    260 <atoi+0x20>
  return n;
}
 275:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 278:	89 c8                	mov    %ecx,%eax
 27a:	c9                   	leave
 27b:	c3                   	ret
 27c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000280 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	57                   	push   %edi
 284:	8b 45 10             	mov    0x10(%ebp),%eax
 287:	8b 55 08             	mov    0x8(%ebp),%edx
 28a:	56                   	push   %esi
 28b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 28e:	85 c0                	test   %eax,%eax
 290:	7e 13                	jle    2a5 <memmove+0x25>
 292:	01 d0                	add    %edx,%eax
  dst = vdst;
 294:	89 d7                	mov    %edx,%edi
 296:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 29d:	00 
 29e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 2a0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 2a1:	39 f8                	cmp    %edi,%eax
 2a3:	75 fb                	jne    2a0 <memmove+0x20>
  return vdst;
}
 2a5:	5e                   	pop    %esi
 2a6:	89 d0                	mov    %edx,%eax
 2a8:	5f                   	pop    %edi
 2a9:	5d                   	pop    %ebp
 2aa:	c3                   	ret
 2ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

000002b0 <copyfd>:

int copyfd(int srcfd, int dstfd) {
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	57                   	push   %edi
 2b4:	56                   	push   %esi
 2b5:	53                   	push   %ebx
 2b6:	8d 9d e8 fd ff ff    	lea    -0x218(%ebp),%ebx
 2bc:	81 ec 0c 02 00 00    	sub    $0x20c,%esp
 2c2:	8b 75 08             	mov    0x8(%ebp),%esi
    char buf[512];
    int n;

    while((n = read(srcfd, buf, sizeof(buf))) > 0) {
 2c5:	eb 1d                	jmp    2e4 <copyfd+0x34>
 2c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2ce:	00 
 2cf:	90                   	nop
        if(write(dstfd, buf, n) != n) {
 2d0:	83 ec 04             	sub    $0x4,%esp
 2d3:	57                   	push   %edi
 2d4:	53                   	push   %ebx
 2d5:	ff 75 0c             	push   0xc(%ebp)
 2d8:	e8 68 00 00 00       	call   345 <write>
 2dd:	83 c4 10             	add    $0x10,%esp
 2e0:	39 f8                	cmp    %edi,%eax
 2e2:	75 2c                	jne    310 <copyfd+0x60>
    while((n = read(srcfd, buf, sizeof(buf))) > 0) {
 2e4:	83 ec 04             	sub    $0x4,%esp
 2e7:	68 00 02 00 00       	push   $0x200
 2ec:	53                   	push   %ebx
 2ed:	56                   	push   %esi
 2ee:	e8 4a 00 00 00       	call   33d <read>
 2f3:	83 c4 10             	add    $0x10,%esp
 2f6:	89 c7                	mov    %eax,%edi
 2f8:	85 c0                	test   %eax,%eax
 2fa:	7f d4                	jg     2d0 <copyfd+0x20>
            return -1;   // write error
        }
    }
    if(n < 0) return -1;   // read error
 2fc:	0f 95 c0             	setne  %al
    return 0;              // success
}
 2ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(n < 0) return -1;   // read error
 302:	0f b6 c0             	movzbl %al,%eax
}
 305:	5b                   	pop    %ebx
 306:	5e                   	pop    %esi
    if(n < 0) return -1;   // read error
 307:	f7 d8                	neg    %eax
}
 309:	5f                   	pop    %edi
 30a:	5d                   	pop    %ebp
 30b:	c3                   	ret
 30c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 310:	8d 65 f4             	lea    -0xc(%ebp),%esp
            return -1;   // write error
 313:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 318:	5b                   	pop    %ebx
 319:	5e                   	pop    %esi
 31a:	5f                   	pop    %edi
 31b:	5d                   	pop    %ebp
 31c:	c3                   	ret

0000031d <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 31d:	b8 01 00 00 00       	mov    $0x1,%eax
 322:	cd 40                	int    $0x40
 324:	c3                   	ret

00000325 <exit>:
SYSCALL(exit)
 325:	b8 02 00 00 00       	mov    $0x2,%eax
 32a:	cd 40                	int    $0x40
 32c:	c3                   	ret

0000032d <wait>:
SYSCALL(wait)
 32d:	b8 03 00 00 00       	mov    $0x3,%eax
 332:	cd 40                	int    $0x40
 334:	c3                   	ret

00000335 <pipe>:
SYSCALL(pipe)
 335:	b8 04 00 00 00       	mov    $0x4,%eax
 33a:	cd 40                	int    $0x40
 33c:	c3                   	ret

0000033d <read>:
SYSCALL(read)
 33d:	b8 05 00 00 00       	mov    $0x5,%eax
 342:	cd 40                	int    $0x40
 344:	c3                   	ret

00000345 <write>:
SYSCALL(write)
 345:	b8 10 00 00 00       	mov    $0x10,%eax
 34a:	cd 40                	int    $0x40
 34c:	c3                   	ret

0000034d <close>:
SYSCALL(close)
 34d:	b8 15 00 00 00       	mov    $0x15,%eax
 352:	cd 40                	int    $0x40
 354:	c3                   	ret

00000355 <kill>:
SYSCALL(kill)
 355:	b8 06 00 00 00       	mov    $0x6,%eax
 35a:	cd 40                	int    $0x40
 35c:	c3                   	ret

0000035d <exec>:
SYSCALL(exec)
 35d:	b8 07 00 00 00       	mov    $0x7,%eax
 362:	cd 40                	int    $0x40
 364:	c3                   	ret

00000365 <open>:
SYSCALL(open)
 365:	b8 0f 00 00 00       	mov    $0xf,%eax
 36a:	cd 40                	int    $0x40
 36c:	c3                   	ret

0000036d <mknod>:
SYSCALL(mknod)
 36d:	b8 11 00 00 00       	mov    $0x11,%eax
 372:	cd 40                	int    $0x40
 374:	c3                   	ret

00000375 <unlink>:
SYSCALL(unlink)
 375:	b8 12 00 00 00       	mov    $0x12,%eax
 37a:	cd 40                	int    $0x40
 37c:	c3                   	ret

0000037d <fstat>:
SYSCALL(fstat)
 37d:	b8 08 00 00 00       	mov    $0x8,%eax
 382:	cd 40                	int    $0x40
 384:	c3                   	ret

00000385 <link>:
SYSCALL(link)
 385:	b8 13 00 00 00       	mov    $0x13,%eax
 38a:	cd 40                	int    $0x40
 38c:	c3                   	ret

0000038d <mkdir>:
SYSCALL(mkdir)
 38d:	b8 14 00 00 00       	mov    $0x14,%eax
 392:	cd 40                	int    $0x40
 394:	c3                   	ret

00000395 <chdir>:
SYSCALL(chdir)
 395:	b8 09 00 00 00       	mov    $0x9,%eax
 39a:	cd 40                	int    $0x40
 39c:	c3                   	ret

0000039d <dup>:
SYSCALL(dup)
 39d:	b8 0a 00 00 00       	mov    $0xa,%eax
 3a2:	cd 40                	int    $0x40
 3a4:	c3                   	ret

000003a5 <getpid>:
SYSCALL(getpid)
 3a5:	b8 0b 00 00 00       	mov    $0xb,%eax
 3aa:	cd 40                	int    $0x40
 3ac:	c3                   	ret

000003ad <sbrk>:
SYSCALL(sbrk)
 3ad:	b8 0c 00 00 00       	mov    $0xc,%eax
 3b2:	cd 40                	int    $0x40
 3b4:	c3                   	ret

000003b5 <sleep>:
SYSCALL(sleep)
 3b5:	b8 0d 00 00 00       	mov    $0xd,%eax
 3ba:	cd 40                	int    $0x40
 3bc:	c3                   	ret

000003bd <uptime>:
SYSCALL(uptime)
 3bd:	b8 0e 00 00 00       	mov    $0xe,%eax
 3c2:	cd 40                	int    $0x40
 3c4:	c3                   	ret

000003c5 <chprty>:
SYSCALL(chprty)
 3c5:	b8 16 00 00 00       	mov    $0x16,%eax
 3ca:	cd 40                	int    $0x40
 3cc:	c3                   	ret

000003cd <cps>:
SYSCALL(cps)
 3cd:	b8 17 00 00 00       	mov    $0x17,%eax
 3d2:	cd 40                	int    $0x40
 3d4:	c3                   	ret

000003d5 <waitx>:
SYSCALL(waitx)
 3d5:	b8 19 00 00 00       	mov    $0x19,%eax
 3da:	cd 40                	int    $0x40
 3dc:	c3                   	ret

000003dd <getpinfo>:
 3dd:	b8 18 00 00 00       	mov    $0x18,%eax
 3e2:	cd 40                	int    $0x40
 3e4:	c3                   	ret
 3e5:	66 90                	xchg   %ax,%ax
 3e7:	66 90                	xchg   %ax,%ax
 3e9:	66 90                	xchg   %ax,%ax
 3eb:	66 90                	xchg   %ax,%ax
 3ed:	66 90                	xchg   %ax,%ax
 3ef:	90                   	nop

000003f0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	57                   	push   %edi
 3f4:	56                   	push   %esi
 3f5:	53                   	push   %ebx
 3f6:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3f8:	89 d1                	mov    %edx,%ecx
{
 3fa:	83 ec 3c             	sub    $0x3c,%esp
 3fd:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
 400:	85 d2                	test   %edx,%edx
 402:	0f 89 80 00 00 00    	jns    488 <printint+0x98>
 408:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 40c:	74 7a                	je     488 <printint+0x98>
    x = -xx;
 40e:	f7 d9                	neg    %ecx
    neg = 1;
 410:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 415:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 418:	31 f6                	xor    %esi,%esi
 41a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 420:	89 c8                	mov    %ecx,%eax
 422:	31 d2                	xor    %edx,%edx
 424:	89 f7                	mov    %esi,%edi
 426:	f7 f3                	div    %ebx
 428:	8d 76 01             	lea    0x1(%esi),%esi
 42b:	0f b6 92 00 08 00 00 	movzbl 0x800(%edx),%edx
 432:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 436:	89 ca                	mov    %ecx,%edx
 438:	89 c1                	mov    %eax,%ecx
 43a:	39 da                	cmp    %ebx,%edx
 43c:	73 e2                	jae    420 <printint+0x30>
  if(neg)
 43e:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 441:	85 c0                	test   %eax,%eax
 443:	74 07                	je     44c <printint+0x5c>
    buf[i++] = '-';
 445:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)

  while(--i >= 0)
 44a:	89 f7                	mov    %esi,%edi
 44c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 44f:	8b 75 c0             	mov    -0x40(%ebp),%esi
 452:	01 df                	add    %ebx,%edi
 454:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 458:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 45b:	83 ec 04             	sub    $0x4,%esp
 45e:	88 45 d7             	mov    %al,-0x29(%ebp)
 461:	8d 45 d7             	lea    -0x29(%ebp),%eax
 464:	6a 01                	push   $0x1
 466:	50                   	push   %eax
 467:	56                   	push   %esi
 468:	e8 d8 fe ff ff       	call   345 <write>
  while(--i >= 0)
 46d:	89 f8                	mov    %edi,%eax
 46f:	83 c4 10             	add    $0x10,%esp
 472:	83 ef 01             	sub    $0x1,%edi
 475:	39 c3                	cmp    %eax,%ebx
 477:	75 df                	jne    458 <printint+0x68>
}
 479:	8d 65 f4             	lea    -0xc(%ebp),%esp
 47c:	5b                   	pop    %ebx
 47d:	5e                   	pop    %esi
 47e:	5f                   	pop    %edi
 47f:	5d                   	pop    %ebp
 480:	c3                   	ret
 481:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 488:	31 c0                	xor    %eax,%eax
 48a:	eb 89                	jmp    415 <printint+0x25>
 48c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000490 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	57                   	push   %edi
 494:	56                   	push   %esi
 495:	53                   	push   %ebx
 496:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 499:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 49c:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 49f:	0f b6 1e             	movzbl (%esi),%ebx
 4a2:	83 c6 01             	add    $0x1,%esi
 4a5:	84 db                	test   %bl,%bl
 4a7:	74 67                	je     510 <printf+0x80>
 4a9:	8d 4d 10             	lea    0x10(%ebp),%ecx
 4ac:	31 d2                	xor    %edx,%edx
 4ae:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 4b1:	eb 34                	jmp    4e7 <printf+0x57>
 4b3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 4b8:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 4bb:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 4c0:	83 f8 25             	cmp    $0x25,%eax
 4c3:	74 18                	je     4dd <printf+0x4d>
  write(fd, &c, 1);
 4c5:	83 ec 04             	sub    $0x4,%esp
 4c8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4cb:	88 5d e7             	mov    %bl,-0x19(%ebp)
 4ce:	6a 01                	push   $0x1
 4d0:	50                   	push   %eax
 4d1:	57                   	push   %edi
 4d2:	e8 6e fe ff ff       	call   345 <write>
 4d7:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 4da:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 4dd:	0f b6 1e             	movzbl (%esi),%ebx
 4e0:	83 c6 01             	add    $0x1,%esi
 4e3:	84 db                	test   %bl,%bl
 4e5:	74 29                	je     510 <printf+0x80>
    c = fmt[i] & 0xff;
 4e7:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 4ea:	85 d2                	test   %edx,%edx
 4ec:	74 ca                	je     4b8 <printf+0x28>
      }
    } else if(state == '%'){
 4ee:	83 fa 25             	cmp    $0x25,%edx
 4f1:	75 ea                	jne    4dd <printf+0x4d>
      if(c == 'd'){
 4f3:	83 f8 25             	cmp    $0x25,%eax
 4f6:	0f 84 04 01 00 00    	je     600 <printf+0x170>
 4fc:	83 e8 63             	sub    $0x63,%eax
 4ff:	83 f8 15             	cmp    $0x15,%eax
 502:	77 1c                	ja     520 <printf+0x90>
 504:	ff 24 85 a8 07 00 00 	jmp    *0x7a8(,%eax,4)
 50b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 510:	8d 65 f4             	lea    -0xc(%ebp),%esp
 513:	5b                   	pop    %ebx
 514:	5e                   	pop    %esi
 515:	5f                   	pop    %edi
 516:	5d                   	pop    %ebp
 517:	c3                   	ret
 518:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 51f:	00 
  write(fd, &c, 1);
 520:	83 ec 04             	sub    $0x4,%esp
 523:	8d 55 e7             	lea    -0x19(%ebp),%edx
 526:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 52a:	6a 01                	push   $0x1
 52c:	52                   	push   %edx
 52d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 530:	57                   	push   %edi
 531:	e8 0f fe ff ff       	call   345 <write>
 536:	83 c4 0c             	add    $0xc,%esp
 539:	88 5d e7             	mov    %bl,-0x19(%ebp)
 53c:	6a 01                	push   $0x1
 53e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 541:	52                   	push   %edx
 542:	57                   	push   %edi
 543:	e8 fd fd ff ff       	call   345 <write>
        putc(fd, c);
 548:	83 c4 10             	add    $0x10,%esp
      state = 0;
 54b:	31 d2                	xor    %edx,%edx
 54d:	eb 8e                	jmp    4dd <printf+0x4d>
 54f:	90                   	nop
        printint(fd, *ap, 16, 0);
 550:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 553:	83 ec 0c             	sub    $0xc,%esp
 556:	b9 10 00 00 00       	mov    $0x10,%ecx
 55b:	8b 13                	mov    (%ebx),%edx
 55d:	6a 00                	push   $0x0
 55f:	89 f8                	mov    %edi,%eax
        ap++;
 561:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
 564:	e8 87 fe ff ff       	call   3f0 <printint>
        ap++;
 569:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 56c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 56f:	31 d2                	xor    %edx,%edx
 571:	e9 67 ff ff ff       	jmp    4dd <printf+0x4d>
        s = (char*)*ap;
 576:	8b 45 d0             	mov    -0x30(%ebp),%eax
 579:	8b 18                	mov    (%eax),%ebx
        ap++;
 57b:	83 c0 04             	add    $0x4,%eax
 57e:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 581:	85 db                	test   %ebx,%ebx
 583:	0f 84 87 00 00 00    	je     610 <printf+0x180>
        while(*s != 0){
 589:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 58c:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 58e:	84 c0                	test   %al,%al
 590:	0f 84 47 ff ff ff    	je     4dd <printf+0x4d>
 596:	8d 55 e7             	lea    -0x19(%ebp),%edx
 599:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 59c:	89 de                	mov    %ebx,%esi
 59e:	89 d3                	mov    %edx,%ebx
  write(fd, &c, 1);
 5a0:	83 ec 04             	sub    $0x4,%esp
 5a3:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 5a6:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 5a9:	6a 01                	push   $0x1
 5ab:	53                   	push   %ebx
 5ac:	57                   	push   %edi
 5ad:	e8 93 fd ff ff       	call   345 <write>
        while(*s != 0){
 5b2:	0f b6 06             	movzbl (%esi),%eax
 5b5:	83 c4 10             	add    $0x10,%esp
 5b8:	84 c0                	test   %al,%al
 5ba:	75 e4                	jne    5a0 <printf+0x110>
      state = 0;
 5bc:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 5bf:	31 d2                	xor    %edx,%edx
 5c1:	e9 17 ff ff ff       	jmp    4dd <printf+0x4d>
        printint(fd, *ap, 10, 1);
 5c6:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5c9:	83 ec 0c             	sub    $0xc,%esp
 5cc:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5d1:	8b 13                	mov    (%ebx),%edx
 5d3:	6a 01                	push   $0x1
 5d5:	eb 88                	jmp    55f <printf+0xcf>
        putc(fd, *ap);
 5d7:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 5da:	83 ec 04             	sub    $0x4,%esp
 5dd:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
 5e0:	8b 03                	mov    (%ebx),%eax
        ap++;
 5e2:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
 5e5:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5e8:	6a 01                	push   $0x1
 5ea:	52                   	push   %edx
 5eb:	57                   	push   %edi
 5ec:	e8 54 fd ff ff       	call   345 <write>
        ap++;
 5f1:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 5f4:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5f7:	31 d2                	xor    %edx,%edx
 5f9:	e9 df fe ff ff       	jmp    4dd <printf+0x4d>
 5fe:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 600:	83 ec 04             	sub    $0x4,%esp
 603:	88 5d e7             	mov    %bl,-0x19(%ebp)
 606:	8d 55 e7             	lea    -0x19(%ebp),%edx
 609:	6a 01                	push   $0x1
 60b:	e9 31 ff ff ff       	jmp    541 <printf+0xb1>
 610:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 615:	bb a1 07 00 00       	mov    $0x7a1,%ebx
 61a:	e9 77 ff ff ff       	jmp    596 <printf+0x106>
 61f:	90                   	nop

00000620 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 620:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 621:	a1 e4 0a 00 00       	mov    0xae4,%eax
{
 626:	89 e5                	mov    %esp,%ebp
 628:	57                   	push   %edi
 629:	56                   	push   %esi
 62a:	53                   	push   %ebx
 62b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 62e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 631:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 638:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 63a:	39 c8                	cmp    %ecx,%eax
 63c:	73 32                	jae    670 <free+0x50>
 63e:	39 d1                	cmp    %edx,%ecx
 640:	72 04                	jb     646 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 642:	39 d0                	cmp    %edx,%eax
 644:	72 32                	jb     678 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 646:	8b 73 fc             	mov    -0x4(%ebx),%esi
 649:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 64c:	39 fa                	cmp    %edi,%edx
 64e:	74 30                	je     680 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 650:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 653:	8b 50 04             	mov    0x4(%eax),%edx
 656:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 659:	39 f1                	cmp    %esi,%ecx
 65b:	74 3a                	je     697 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 65d:	89 08                	mov    %ecx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 65f:	5b                   	pop    %ebx
  freep = p;
 660:	a3 e4 0a 00 00       	mov    %eax,0xae4
}
 665:	5e                   	pop    %esi
 666:	5f                   	pop    %edi
 667:	5d                   	pop    %ebp
 668:	c3                   	ret
 669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 670:	39 d0                	cmp    %edx,%eax
 672:	72 04                	jb     678 <free+0x58>
 674:	39 d1                	cmp    %edx,%ecx
 676:	72 ce                	jb     646 <free+0x26>
{
 678:	89 d0                	mov    %edx,%eax
 67a:	eb bc                	jmp    638 <free+0x18>
 67c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 680:	03 72 04             	add    0x4(%edx),%esi
 683:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 686:	8b 10                	mov    (%eax),%edx
 688:	8b 12                	mov    (%edx),%edx
 68a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 68d:	8b 50 04             	mov    0x4(%eax),%edx
 690:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 693:	39 f1                	cmp    %esi,%ecx
 695:	75 c6                	jne    65d <free+0x3d>
    p->s.size += bp->s.size;
 697:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 69a:	a3 e4 0a 00 00       	mov    %eax,0xae4
    p->s.size += bp->s.size;
 69f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6a2:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 6a5:	89 08                	mov    %ecx,(%eax)
}
 6a7:	5b                   	pop    %ebx
 6a8:	5e                   	pop    %esi
 6a9:	5f                   	pop    %edi
 6aa:	5d                   	pop    %ebp
 6ab:	c3                   	ret
 6ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000006b0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6b0:	55                   	push   %ebp
 6b1:	89 e5                	mov    %esp,%ebp
 6b3:	57                   	push   %edi
 6b4:	56                   	push   %esi
 6b5:	53                   	push   %ebx
 6b6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6b9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6bc:	8b 15 e4 0a 00 00    	mov    0xae4,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6c2:	8d 78 07             	lea    0x7(%eax),%edi
 6c5:	c1 ef 03             	shr    $0x3,%edi
 6c8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 6cb:	85 d2                	test   %edx,%edx
 6cd:	0f 84 8d 00 00 00    	je     760 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6d3:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6d5:	8b 48 04             	mov    0x4(%eax),%ecx
 6d8:	39 f9                	cmp    %edi,%ecx
 6da:	73 64                	jae    740 <malloc+0x90>
  if(nu < 4096)
 6dc:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6e1:	39 df                	cmp    %ebx,%edi
 6e3:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 6e6:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 6ed:	eb 0a                	jmp    6f9 <malloc+0x49>
 6ef:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6f0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6f2:	8b 48 04             	mov    0x4(%eax),%ecx
 6f5:	39 f9                	cmp    %edi,%ecx
 6f7:	73 47                	jae    740 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6f9:	89 c2                	mov    %eax,%edx
 6fb:	3b 05 e4 0a 00 00    	cmp    0xae4,%eax
 701:	75 ed                	jne    6f0 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 703:	83 ec 0c             	sub    $0xc,%esp
 706:	56                   	push   %esi
 707:	e8 a1 fc ff ff       	call   3ad <sbrk>
  if(p == (char*)-1)
 70c:	83 c4 10             	add    $0x10,%esp
 70f:	83 f8 ff             	cmp    $0xffffffff,%eax
 712:	74 1c                	je     730 <malloc+0x80>
  hp->s.size = nu;
 714:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 717:	83 ec 0c             	sub    $0xc,%esp
 71a:	83 c0 08             	add    $0x8,%eax
 71d:	50                   	push   %eax
 71e:	e8 fd fe ff ff       	call   620 <free>
  return freep;
 723:	8b 15 e4 0a 00 00    	mov    0xae4,%edx
      if((p = morecore(nunits)) == 0)
 729:	83 c4 10             	add    $0x10,%esp
 72c:	85 d2                	test   %edx,%edx
 72e:	75 c0                	jne    6f0 <malloc+0x40>
        return 0;
  }
}
 730:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 733:	31 c0                	xor    %eax,%eax
}
 735:	5b                   	pop    %ebx
 736:	5e                   	pop    %esi
 737:	5f                   	pop    %edi
 738:	5d                   	pop    %ebp
 739:	c3                   	ret
 73a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 740:	39 cf                	cmp    %ecx,%edi
 742:	74 4c                	je     790 <malloc+0xe0>
        p->s.size -= nunits;
 744:	29 f9                	sub    %edi,%ecx
 746:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 749:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 74c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 74f:	89 15 e4 0a 00 00    	mov    %edx,0xae4
}
 755:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 758:	83 c0 08             	add    $0x8,%eax
}
 75b:	5b                   	pop    %ebx
 75c:	5e                   	pop    %esi
 75d:	5f                   	pop    %edi
 75e:	5d                   	pop    %ebp
 75f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 760:	c7 05 e4 0a 00 00 e8 	movl   $0xae8,0xae4
 767:	0a 00 00 
    base.s.size = 0;
 76a:	b8 e8 0a 00 00       	mov    $0xae8,%eax
    base.s.ptr = freep = prevp = &base;
 76f:	c7 05 e8 0a 00 00 e8 	movl   $0xae8,0xae8
 776:	0a 00 00 
    base.s.size = 0;
 779:	c7 05 ec 0a 00 00 00 	movl   $0x0,0xaec
 780:	00 00 00 
    if(p->s.size >= nunits){
 783:	e9 54 ff ff ff       	jmp    6dc <malloc+0x2c>
 788:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 78f:	00 
        prevp->s.ptr = p->s.ptr;
 790:	8b 08                	mov    (%eax),%ecx
 792:	89 0a                	mov    %ecx,(%edx)
 794:	eb b9                	jmp    74f <malloc+0x9f>
