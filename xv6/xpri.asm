
_xpri:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fcntl.h"

//Changes priority of a particular pid
int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	56                   	push   %esi
   e:	53                   	push   %ebx
   f:	51                   	push   %ecx
  10:	83 ec 0c             	sub    $0xc,%esp
  int priority, pid;

  if(argc < 3){
  13:	83 39 02             	cmpl   $0x2,(%ecx)
{
  16:	8b 71 04             	mov    0x4(%ecx),%esi
  if(argc < 3){
  19:	7f 1f                	jg     3a <main+0x3a>
      printf(2, "Usage: xpri pid priority\n" );
  1b:	50                   	push   %eax
  1c:	50                   	push   %eax
  1d:	68 a8 07 00 00       	push   $0x7a8
  22:	6a 02                	push   $0x2
  24:	e8 77 04 00 00       	call   4a0 <printf>
      sleep(1);
  29:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  30:	e8 90 03 00 00       	call   3c5 <sleep>
      exit();
  35:	e8 fb 02 00 00       	call   335 <exit>
  }
  priority = atoi ( argv[2] );
  3a:	83 ec 0c             	sub    $0xc,%esp
  3d:	ff 76 08             	push   0x8(%esi)
  40:	e8 0b 02 00 00       	call   250 <atoi>
  45:	89 c3                	mov    %eax,%ebx
  pid = atoi ( argv[1] );
  47:	58                   	pop    %eax
  48:	ff 76 04             	push   0x4(%esi)
  4b:	e8 00 02 00 00       	call   250 <atoi>
  if ( priority < 0 || priority > 100 ) {
  50:	83 c4 10             	add    $0x10,%esp
  53:	83 fb 64             	cmp    $0x64,%ebx
  56:	76 13                	jbe    6b <main+0x6b>
      printf(2, "Invalid priority (0-100)!\n" );
  58:	51                   	push   %ecx
  59:	51                   	push   %ecx
  5a:	68 c2 07 00 00       	push   $0x7c2
  5f:	6a 02                	push   $0x2
  61:	e8 3a 04 00 00       	call   4a0 <printf>
      exit();
  66:	e8 ca 02 00 00       	call   335 <exit>
  }
  chprty ( pid, priority );
  6b:	52                   	push   %edx
  6c:	52                   	push   %edx
  6d:	53                   	push   %ebx
  6e:	50                   	push   %eax
  6f:	e8 61 03 00 00       	call   3d5 <chprty>

  exit();
  74:	e8 bc 02 00 00       	call   335 <exit>
  79:	66 90                	xchg   %ax,%ax
  7b:	66 90                	xchg   %ax,%ax
  7d:	66 90                	xchg   %ax,%ax
  7f:	90                   	nop

00000080 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  80:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  81:	31 c0                	xor    %eax,%eax
{
  83:	89 e5                	mov    %esp,%ebp
  85:	53                   	push   %ebx
  86:	8b 4d 08             	mov    0x8(%ebp),%ecx
  89:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  90:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  94:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  97:	83 c0 01             	add    $0x1,%eax
  9a:	84 d2                	test   %dl,%dl
  9c:	75 f2                	jne    90 <strcpy+0x10>
    ;
  return os;
}
  9e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  a1:	89 c8                	mov    %ecx,%eax
  a3:	c9                   	leave
  a4:	c3                   	ret
  a5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  ac:	00 
  ad:	8d 76 00             	lea    0x0(%esi),%esi

000000b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	53                   	push   %ebx
  b4:	8b 55 08             	mov    0x8(%ebp),%edx
  b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  ba:	0f b6 02             	movzbl (%edx),%eax
  bd:	84 c0                	test   %al,%al
  bf:	75 17                	jne    d8 <strcmp+0x28>
  c1:	eb 3a                	jmp    fd <strcmp+0x4d>
  c3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  c8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
  cc:	83 c2 01             	add    $0x1,%edx
  cf:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
  d2:	84 c0                	test   %al,%al
  d4:	74 1a                	je     f0 <strcmp+0x40>
  d6:	89 d9                	mov    %ebx,%ecx
  d8:	0f b6 19             	movzbl (%ecx),%ebx
  db:	38 c3                	cmp    %al,%bl
  dd:	74 e9                	je     c8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
  df:	29 d8                	sub    %ebx,%eax
}
  e1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  e4:	c9                   	leave
  e5:	c3                   	ret
  e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
  ed:	00 
  ee:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
  f0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  f4:	31 c0                	xor    %eax,%eax
  f6:	29 d8                	sub    %ebx,%eax
}
  f8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  fb:	c9                   	leave
  fc:	c3                   	ret
  return (uchar)*p - (uchar)*q;
  fd:	0f b6 19             	movzbl (%ecx),%ebx
 100:	31 c0                	xor    %eax,%eax
 102:	eb db                	jmp    df <strcmp+0x2f>
 104:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 10b:	00 
 10c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000110 <strlen>:

uint
strlen(const char *s)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 116:	80 3a 00             	cmpb   $0x0,(%edx)
 119:	74 15                	je     130 <strlen+0x20>
 11b:	31 c0                	xor    %eax,%eax
 11d:	8d 76 00             	lea    0x0(%esi),%esi
 120:	83 c0 01             	add    $0x1,%eax
 123:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 127:	89 c1                	mov    %eax,%ecx
 129:	75 f5                	jne    120 <strlen+0x10>
    ;
  return n;
}
 12b:	89 c8                	mov    %ecx,%eax
 12d:	5d                   	pop    %ebp
 12e:	c3                   	ret
 12f:	90                   	nop
  for(n = 0; s[n]; n++)
 130:	31 c9                	xor    %ecx,%ecx
}
 132:	5d                   	pop    %ebp
 133:	89 c8                	mov    %ecx,%eax
 135:	c3                   	ret
 136:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 13d:	00 
 13e:	66 90                	xchg   %ax,%ax

00000140 <memset>:

void*
memset(void *dst, int c, uint n)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	57                   	push   %edi
 144:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 147:	8b 4d 10             	mov    0x10(%ebp),%ecx
 14a:	8b 45 0c             	mov    0xc(%ebp),%eax
 14d:	89 d7                	mov    %edx,%edi
 14f:	fc                   	cld
 150:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 152:	8b 7d fc             	mov    -0x4(%ebp),%edi
 155:	89 d0                	mov    %edx,%eax
 157:	c9                   	leave
 158:	c3                   	ret
 159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000160 <strchr>:

char*
strchr(const char *s, char c)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	8b 45 08             	mov    0x8(%ebp),%eax
 166:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 16a:	0f b6 10             	movzbl (%eax),%edx
 16d:	84 d2                	test   %dl,%dl
 16f:	75 12                	jne    183 <strchr+0x23>
 171:	eb 1d                	jmp    190 <strchr+0x30>
 173:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 178:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 17c:	83 c0 01             	add    $0x1,%eax
 17f:	84 d2                	test   %dl,%dl
 181:	74 0d                	je     190 <strchr+0x30>
    if(*s == c)
 183:	38 d1                	cmp    %dl,%cl
 185:	75 f1                	jne    178 <strchr+0x18>
      return (char*)s;
  return 0;
}
 187:	5d                   	pop    %ebp
 188:	c3                   	ret
 189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 190:	31 c0                	xor    %eax,%eax
}
 192:	5d                   	pop    %ebp
 193:	c3                   	ret
 194:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 19b:	00 
 19c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001a0 <gets>:

char*
gets(char *buf, int max)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	57                   	push   %edi
 1a4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 1a5:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 1a8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 1a9:	31 db                	xor    %ebx,%ebx
{
 1ab:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 1ae:	eb 27                	jmp    1d7 <gets+0x37>
    cc = read(0, &c, 1);
 1b0:	83 ec 04             	sub    $0x4,%esp
 1b3:	6a 01                	push   $0x1
 1b5:	56                   	push   %esi
 1b6:	6a 00                	push   $0x0
 1b8:	e8 90 01 00 00       	call   34d <read>
    if(cc < 1)
 1bd:	83 c4 10             	add    $0x10,%esp
 1c0:	85 c0                	test   %eax,%eax
 1c2:	7e 1d                	jle    1e1 <gets+0x41>
      break;
    buf[i++] = c;
 1c4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1c8:	8b 55 08             	mov    0x8(%ebp),%edx
 1cb:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 1cf:	3c 0a                	cmp    $0xa,%al
 1d1:	74 10                	je     1e3 <gets+0x43>
 1d3:	3c 0d                	cmp    $0xd,%al
 1d5:	74 0c                	je     1e3 <gets+0x43>
  for(i=0; i+1 < max; ){
 1d7:	89 df                	mov    %ebx,%edi
 1d9:	83 c3 01             	add    $0x1,%ebx
 1dc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1df:	7c cf                	jl     1b0 <gets+0x10>
 1e1:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 1e3:	8b 45 08             	mov    0x8(%ebp),%eax
 1e6:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 1ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1ed:	5b                   	pop    %ebx
 1ee:	5e                   	pop    %esi
 1ef:	5f                   	pop    %edi
 1f0:	5d                   	pop    %ebp
 1f1:	c3                   	ret
 1f2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1f9:	00 
 1fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000200 <stat>:

int
stat(const char *n, struct stat *st)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	56                   	push   %esi
 204:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 205:	83 ec 08             	sub    $0x8,%esp
 208:	6a 00                	push   $0x0
 20a:	ff 75 08             	push   0x8(%ebp)
 20d:	e8 63 01 00 00       	call   375 <open>
  if(fd < 0)
 212:	83 c4 10             	add    $0x10,%esp
 215:	85 c0                	test   %eax,%eax
 217:	78 27                	js     240 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 219:	83 ec 08             	sub    $0x8,%esp
 21c:	ff 75 0c             	push   0xc(%ebp)
 21f:	89 c3                	mov    %eax,%ebx
 221:	50                   	push   %eax
 222:	e8 66 01 00 00       	call   38d <fstat>
  close(fd);
 227:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 22a:	89 c6                	mov    %eax,%esi
  close(fd);
 22c:	e8 2c 01 00 00       	call   35d <close>
  return r;
 231:	83 c4 10             	add    $0x10,%esp
}
 234:	8d 65 f8             	lea    -0x8(%ebp),%esp
 237:	89 f0                	mov    %esi,%eax
 239:	5b                   	pop    %ebx
 23a:	5e                   	pop    %esi
 23b:	5d                   	pop    %ebp
 23c:	c3                   	ret
 23d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 240:	be ff ff ff ff       	mov    $0xffffffff,%esi
 245:	eb ed                	jmp    234 <stat+0x34>
 247:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 24e:	00 
 24f:	90                   	nop

00000250 <atoi>:

int
atoi(const char *s)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	53                   	push   %ebx
 254:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 257:	0f be 02             	movsbl (%edx),%eax
 25a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 25d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 260:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 265:	77 1e                	ja     285 <atoi+0x35>
 267:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 26e:	00 
 26f:	90                   	nop
    n = n*10 + *s++ - '0';
 270:	83 c2 01             	add    $0x1,%edx
 273:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 276:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 27a:	0f be 02             	movsbl (%edx),%eax
 27d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 280:	80 fb 09             	cmp    $0x9,%bl
 283:	76 eb                	jbe    270 <atoi+0x20>
  return n;
}
 285:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 288:	89 c8                	mov    %ecx,%eax
 28a:	c9                   	leave
 28b:	c3                   	ret
 28c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000290 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	57                   	push   %edi
 294:	8b 45 10             	mov    0x10(%ebp),%eax
 297:	8b 55 08             	mov    0x8(%ebp),%edx
 29a:	56                   	push   %esi
 29b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 29e:	85 c0                	test   %eax,%eax
 2a0:	7e 13                	jle    2b5 <memmove+0x25>
 2a2:	01 d0                	add    %edx,%eax
  dst = vdst;
 2a4:	89 d7                	mov    %edx,%edi
 2a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2ad:	00 
 2ae:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 2b0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 2b1:	39 f8                	cmp    %edi,%eax
 2b3:	75 fb                	jne    2b0 <memmove+0x20>
  return vdst;
}
 2b5:	5e                   	pop    %esi
 2b6:	89 d0                	mov    %edx,%eax
 2b8:	5f                   	pop    %edi
 2b9:	5d                   	pop    %ebp
 2ba:	c3                   	ret
 2bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

000002c0 <copyfd>:

int copyfd(int srcfd, int dstfd) {
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	57                   	push   %edi
 2c4:	56                   	push   %esi
 2c5:	53                   	push   %ebx
 2c6:	8d 9d e8 fd ff ff    	lea    -0x218(%ebp),%ebx
 2cc:	81 ec 0c 02 00 00    	sub    $0x20c,%esp
 2d2:	8b 75 08             	mov    0x8(%ebp),%esi
    char buf[512];
    int n;

    while((n = read(srcfd, buf, sizeof(buf))) > 0) {
 2d5:	eb 1d                	jmp    2f4 <copyfd+0x34>
 2d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2de:	00 
 2df:	90                   	nop
        if(write(dstfd, buf, n) != n) {
 2e0:	83 ec 04             	sub    $0x4,%esp
 2e3:	57                   	push   %edi
 2e4:	53                   	push   %ebx
 2e5:	ff 75 0c             	push   0xc(%ebp)
 2e8:	e8 68 00 00 00       	call   355 <write>
 2ed:	83 c4 10             	add    $0x10,%esp
 2f0:	39 f8                	cmp    %edi,%eax
 2f2:	75 2c                	jne    320 <copyfd+0x60>
    while((n = read(srcfd, buf, sizeof(buf))) > 0) {
 2f4:	83 ec 04             	sub    $0x4,%esp
 2f7:	68 00 02 00 00       	push   $0x200
 2fc:	53                   	push   %ebx
 2fd:	56                   	push   %esi
 2fe:	e8 4a 00 00 00       	call   34d <read>
 303:	83 c4 10             	add    $0x10,%esp
 306:	89 c7                	mov    %eax,%edi
 308:	85 c0                	test   %eax,%eax
 30a:	7f d4                	jg     2e0 <copyfd+0x20>
            return -1;   // write error
        }
    }
    if(n < 0) return -1;   // read error
 30c:	0f 95 c0             	setne  %al
    return 0;              // success
}
 30f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(n < 0) return -1;   // read error
 312:	0f b6 c0             	movzbl %al,%eax
}
 315:	5b                   	pop    %ebx
 316:	5e                   	pop    %esi
    if(n < 0) return -1;   // read error
 317:	f7 d8                	neg    %eax
}
 319:	5f                   	pop    %edi
 31a:	5d                   	pop    %ebp
 31b:	c3                   	ret
 31c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 320:	8d 65 f4             	lea    -0xc(%ebp),%esp
            return -1;   // write error
 323:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 328:	5b                   	pop    %ebx
 329:	5e                   	pop    %esi
 32a:	5f                   	pop    %edi
 32b:	5d                   	pop    %ebp
 32c:	c3                   	ret

0000032d <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 32d:	b8 01 00 00 00       	mov    $0x1,%eax
 332:	cd 40                	int    $0x40
 334:	c3                   	ret

00000335 <exit>:
SYSCALL(exit)
 335:	b8 02 00 00 00       	mov    $0x2,%eax
 33a:	cd 40                	int    $0x40
 33c:	c3                   	ret

0000033d <wait>:
SYSCALL(wait)
 33d:	b8 03 00 00 00       	mov    $0x3,%eax
 342:	cd 40                	int    $0x40
 344:	c3                   	ret

00000345 <pipe>:
SYSCALL(pipe)
 345:	b8 04 00 00 00       	mov    $0x4,%eax
 34a:	cd 40                	int    $0x40
 34c:	c3                   	ret

0000034d <read>:
SYSCALL(read)
 34d:	b8 05 00 00 00       	mov    $0x5,%eax
 352:	cd 40                	int    $0x40
 354:	c3                   	ret

00000355 <write>:
SYSCALL(write)
 355:	b8 10 00 00 00       	mov    $0x10,%eax
 35a:	cd 40                	int    $0x40
 35c:	c3                   	ret

0000035d <close>:
SYSCALL(close)
 35d:	b8 15 00 00 00       	mov    $0x15,%eax
 362:	cd 40                	int    $0x40
 364:	c3                   	ret

00000365 <kill>:
SYSCALL(kill)
 365:	b8 06 00 00 00       	mov    $0x6,%eax
 36a:	cd 40                	int    $0x40
 36c:	c3                   	ret

0000036d <exec>:
SYSCALL(exec)
 36d:	b8 07 00 00 00       	mov    $0x7,%eax
 372:	cd 40                	int    $0x40
 374:	c3                   	ret

00000375 <open>:
SYSCALL(open)
 375:	b8 0f 00 00 00       	mov    $0xf,%eax
 37a:	cd 40                	int    $0x40
 37c:	c3                   	ret

0000037d <mknod>:
SYSCALL(mknod)
 37d:	b8 11 00 00 00       	mov    $0x11,%eax
 382:	cd 40                	int    $0x40
 384:	c3                   	ret

00000385 <unlink>:
SYSCALL(unlink)
 385:	b8 12 00 00 00       	mov    $0x12,%eax
 38a:	cd 40                	int    $0x40
 38c:	c3                   	ret

0000038d <fstat>:
SYSCALL(fstat)
 38d:	b8 08 00 00 00       	mov    $0x8,%eax
 392:	cd 40                	int    $0x40
 394:	c3                   	ret

00000395 <link>:
SYSCALL(link)
 395:	b8 13 00 00 00       	mov    $0x13,%eax
 39a:	cd 40                	int    $0x40
 39c:	c3                   	ret

0000039d <mkdir>:
SYSCALL(mkdir)
 39d:	b8 14 00 00 00       	mov    $0x14,%eax
 3a2:	cd 40                	int    $0x40
 3a4:	c3                   	ret

000003a5 <chdir>:
SYSCALL(chdir)
 3a5:	b8 09 00 00 00       	mov    $0x9,%eax
 3aa:	cd 40                	int    $0x40
 3ac:	c3                   	ret

000003ad <dup>:
SYSCALL(dup)
 3ad:	b8 0a 00 00 00       	mov    $0xa,%eax
 3b2:	cd 40                	int    $0x40
 3b4:	c3                   	ret

000003b5 <getpid>:
SYSCALL(getpid)
 3b5:	b8 0b 00 00 00       	mov    $0xb,%eax
 3ba:	cd 40                	int    $0x40
 3bc:	c3                   	ret

000003bd <sbrk>:
SYSCALL(sbrk)
 3bd:	b8 0c 00 00 00       	mov    $0xc,%eax
 3c2:	cd 40                	int    $0x40
 3c4:	c3                   	ret

000003c5 <sleep>:
SYSCALL(sleep)
 3c5:	b8 0d 00 00 00       	mov    $0xd,%eax
 3ca:	cd 40                	int    $0x40
 3cc:	c3                   	ret

000003cd <uptime>:
SYSCALL(uptime)
 3cd:	b8 0e 00 00 00       	mov    $0xe,%eax
 3d2:	cd 40                	int    $0x40
 3d4:	c3                   	ret

000003d5 <chprty>:
SYSCALL(chprty)
 3d5:	b8 16 00 00 00       	mov    $0x16,%eax
 3da:	cd 40                	int    $0x40
 3dc:	c3                   	ret

000003dd <cps>:
SYSCALL(cps)
 3dd:	b8 17 00 00 00       	mov    $0x17,%eax
 3e2:	cd 40                	int    $0x40
 3e4:	c3                   	ret

000003e5 <waitx>:
SYSCALL(waitx)
 3e5:	b8 19 00 00 00       	mov    $0x19,%eax
 3ea:	cd 40                	int    $0x40
 3ec:	c3                   	ret

000003ed <getpinfo>:
 3ed:	b8 18 00 00 00       	mov    $0x18,%eax
 3f2:	cd 40                	int    $0x40
 3f4:	c3                   	ret
 3f5:	66 90                	xchg   %ax,%ax
 3f7:	66 90                	xchg   %ax,%ax
 3f9:	66 90                	xchg   %ax,%ax
 3fb:	66 90                	xchg   %ax,%ax
 3fd:	66 90                	xchg   %ax,%ax
 3ff:	90                   	nop

00000400 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	57                   	push   %edi
 404:	56                   	push   %esi
 405:	53                   	push   %ebx
 406:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 408:	89 d1                	mov    %edx,%ecx
{
 40a:	83 ec 3c             	sub    $0x3c,%esp
 40d:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
 410:	85 d2                	test   %edx,%edx
 412:	0f 89 80 00 00 00    	jns    498 <printint+0x98>
 418:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 41c:	74 7a                	je     498 <printint+0x98>
    x = -xx;
 41e:	f7 d9                	neg    %ecx
    neg = 1;
 420:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 425:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 428:	31 f6                	xor    %esi,%esi
 42a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 430:	89 c8                	mov    %ecx,%eax
 432:	31 d2                	xor    %edx,%edx
 434:	89 f7                	mov    %esi,%edi
 436:	f7 f3                	div    %ebx
 438:	8d 76 01             	lea    0x1(%esi),%esi
 43b:	0f b6 92 3c 08 00 00 	movzbl 0x83c(%edx),%edx
 442:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 446:	89 ca                	mov    %ecx,%edx
 448:	89 c1                	mov    %eax,%ecx
 44a:	39 da                	cmp    %ebx,%edx
 44c:	73 e2                	jae    430 <printint+0x30>
  if(neg)
 44e:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 451:	85 c0                	test   %eax,%eax
 453:	74 07                	je     45c <printint+0x5c>
    buf[i++] = '-';
 455:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)

  while(--i >= 0)
 45a:	89 f7                	mov    %esi,%edi
 45c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 45f:	8b 75 c0             	mov    -0x40(%ebp),%esi
 462:	01 df                	add    %ebx,%edi
 464:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 468:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 46b:	83 ec 04             	sub    $0x4,%esp
 46e:	88 45 d7             	mov    %al,-0x29(%ebp)
 471:	8d 45 d7             	lea    -0x29(%ebp),%eax
 474:	6a 01                	push   $0x1
 476:	50                   	push   %eax
 477:	56                   	push   %esi
 478:	e8 d8 fe ff ff       	call   355 <write>
  while(--i >= 0)
 47d:	89 f8                	mov    %edi,%eax
 47f:	83 c4 10             	add    $0x10,%esp
 482:	83 ef 01             	sub    $0x1,%edi
 485:	39 c3                	cmp    %eax,%ebx
 487:	75 df                	jne    468 <printint+0x68>
}
 489:	8d 65 f4             	lea    -0xc(%ebp),%esp
 48c:	5b                   	pop    %ebx
 48d:	5e                   	pop    %esi
 48e:	5f                   	pop    %edi
 48f:	5d                   	pop    %ebp
 490:	c3                   	ret
 491:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 498:	31 c0                	xor    %eax,%eax
 49a:	eb 89                	jmp    425 <printint+0x25>
 49c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000004a0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	57                   	push   %edi
 4a4:	56                   	push   %esi
 4a5:	53                   	push   %ebx
 4a6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4a9:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 4ac:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 4af:	0f b6 1e             	movzbl (%esi),%ebx
 4b2:	83 c6 01             	add    $0x1,%esi
 4b5:	84 db                	test   %bl,%bl
 4b7:	74 67                	je     520 <printf+0x80>
 4b9:	8d 4d 10             	lea    0x10(%ebp),%ecx
 4bc:	31 d2                	xor    %edx,%edx
 4be:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 4c1:	eb 34                	jmp    4f7 <printf+0x57>
 4c3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 4c8:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 4cb:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 4d0:	83 f8 25             	cmp    $0x25,%eax
 4d3:	74 18                	je     4ed <printf+0x4d>
  write(fd, &c, 1);
 4d5:	83 ec 04             	sub    $0x4,%esp
 4d8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4db:	88 5d e7             	mov    %bl,-0x19(%ebp)
 4de:	6a 01                	push   $0x1
 4e0:	50                   	push   %eax
 4e1:	57                   	push   %edi
 4e2:	e8 6e fe ff ff       	call   355 <write>
 4e7:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 4ea:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 4ed:	0f b6 1e             	movzbl (%esi),%ebx
 4f0:	83 c6 01             	add    $0x1,%esi
 4f3:	84 db                	test   %bl,%bl
 4f5:	74 29                	je     520 <printf+0x80>
    c = fmt[i] & 0xff;
 4f7:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 4fa:	85 d2                	test   %edx,%edx
 4fc:	74 ca                	je     4c8 <printf+0x28>
      }
    } else if(state == '%'){
 4fe:	83 fa 25             	cmp    $0x25,%edx
 501:	75 ea                	jne    4ed <printf+0x4d>
      if(c == 'd'){
 503:	83 f8 25             	cmp    $0x25,%eax
 506:	0f 84 04 01 00 00    	je     610 <printf+0x170>
 50c:	83 e8 63             	sub    $0x63,%eax
 50f:	83 f8 15             	cmp    $0x15,%eax
 512:	77 1c                	ja     530 <printf+0x90>
 514:	ff 24 85 e4 07 00 00 	jmp    *0x7e4(,%eax,4)
 51b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 520:	8d 65 f4             	lea    -0xc(%ebp),%esp
 523:	5b                   	pop    %ebx
 524:	5e                   	pop    %esi
 525:	5f                   	pop    %edi
 526:	5d                   	pop    %ebp
 527:	c3                   	ret
 528:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 52f:	00 
  write(fd, &c, 1);
 530:	83 ec 04             	sub    $0x4,%esp
 533:	8d 55 e7             	lea    -0x19(%ebp),%edx
 536:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 53a:	6a 01                	push   $0x1
 53c:	52                   	push   %edx
 53d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 540:	57                   	push   %edi
 541:	e8 0f fe ff ff       	call   355 <write>
 546:	83 c4 0c             	add    $0xc,%esp
 549:	88 5d e7             	mov    %bl,-0x19(%ebp)
 54c:	6a 01                	push   $0x1
 54e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 551:	52                   	push   %edx
 552:	57                   	push   %edi
 553:	e8 fd fd ff ff       	call   355 <write>
        putc(fd, c);
 558:	83 c4 10             	add    $0x10,%esp
      state = 0;
 55b:	31 d2                	xor    %edx,%edx
 55d:	eb 8e                	jmp    4ed <printf+0x4d>
 55f:	90                   	nop
        printint(fd, *ap, 16, 0);
 560:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 563:	83 ec 0c             	sub    $0xc,%esp
 566:	b9 10 00 00 00       	mov    $0x10,%ecx
 56b:	8b 13                	mov    (%ebx),%edx
 56d:	6a 00                	push   $0x0
 56f:	89 f8                	mov    %edi,%eax
        ap++;
 571:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
 574:	e8 87 fe ff ff       	call   400 <printint>
        ap++;
 579:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 57c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 57f:	31 d2                	xor    %edx,%edx
 581:	e9 67 ff ff ff       	jmp    4ed <printf+0x4d>
        s = (char*)*ap;
 586:	8b 45 d0             	mov    -0x30(%ebp),%eax
 589:	8b 18                	mov    (%eax),%ebx
        ap++;
 58b:	83 c0 04             	add    $0x4,%eax
 58e:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 591:	85 db                	test   %ebx,%ebx
 593:	0f 84 87 00 00 00    	je     620 <printf+0x180>
        while(*s != 0){
 599:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 59c:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 59e:	84 c0                	test   %al,%al
 5a0:	0f 84 47 ff ff ff    	je     4ed <printf+0x4d>
 5a6:	8d 55 e7             	lea    -0x19(%ebp),%edx
 5a9:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 5ac:	89 de                	mov    %ebx,%esi
 5ae:	89 d3                	mov    %edx,%ebx
  write(fd, &c, 1);
 5b0:	83 ec 04             	sub    $0x4,%esp
 5b3:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 5b6:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 5b9:	6a 01                	push   $0x1
 5bb:	53                   	push   %ebx
 5bc:	57                   	push   %edi
 5bd:	e8 93 fd ff ff       	call   355 <write>
        while(*s != 0){
 5c2:	0f b6 06             	movzbl (%esi),%eax
 5c5:	83 c4 10             	add    $0x10,%esp
 5c8:	84 c0                	test   %al,%al
 5ca:	75 e4                	jne    5b0 <printf+0x110>
      state = 0;
 5cc:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 5cf:	31 d2                	xor    %edx,%edx
 5d1:	e9 17 ff ff ff       	jmp    4ed <printf+0x4d>
        printint(fd, *ap, 10, 1);
 5d6:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5d9:	83 ec 0c             	sub    $0xc,%esp
 5dc:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5e1:	8b 13                	mov    (%ebx),%edx
 5e3:	6a 01                	push   $0x1
 5e5:	eb 88                	jmp    56f <printf+0xcf>
        putc(fd, *ap);
 5e7:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 5ea:	83 ec 04             	sub    $0x4,%esp
 5ed:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
 5f0:	8b 03                	mov    (%ebx),%eax
        ap++;
 5f2:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
 5f5:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5f8:	6a 01                	push   $0x1
 5fa:	52                   	push   %edx
 5fb:	57                   	push   %edi
 5fc:	e8 54 fd ff ff       	call   355 <write>
        ap++;
 601:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 604:	83 c4 10             	add    $0x10,%esp
      state = 0;
 607:	31 d2                	xor    %edx,%edx
 609:	e9 df fe ff ff       	jmp    4ed <printf+0x4d>
 60e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 610:	83 ec 04             	sub    $0x4,%esp
 613:	88 5d e7             	mov    %bl,-0x19(%ebp)
 616:	8d 55 e7             	lea    -0x19(%ebp),%edx
 619:	6a 01                	push   $0x1
 61b:	e9 31 ff ff ff       	jmp    551 <printf+0xb1>
 620:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 625:	bb dd 07 00 00       	mov    $0x7dd,%ebx
 62a:	e9 77 ff ff ff       	jmp    5a6 <printf+0x106>
 62f:	90                   	nop

00000630 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 630:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 631:	a1 1c 0b 00 00       	mov    0xb1c,%eax
{
 636:	89 e5                	mov    %esp,%ebp
 638:	57                   	push   %edi
 639:	56                   	push   %esi
 63a:	53                   	push   %ebx
 63b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 63e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 641:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 648:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 64a:	39 c8                	cmp    %ecx,%eax
 64c:	73 32                	jae    680 <free+0x50>
 64e:	39 d1                	cmp    %edx,%ecx
 650:	72 04                	jb     656 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 652:	39 d0                	cmp    %edx,%eax
 654:	72 32                	jb     688 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 656:	8b 73 fc             	mov    -0x4(%ebx),%esi
 659:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 65c:	39 fa                	cmp    %edi,%edx
 65e:	74 30                	je     690 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 660:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 663:	8b 50 04             	mov    0x4(%eax),%edx
 666:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 669:	39 f1                	cmp    %esi,%ecx
 66b:	74 3a                	je     6a7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 66d:	89 08                	mov    %ecx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 66f:	5b                   	pop    %ebx
  freep = p;
 670:	a3 1c 0b 00 00       	mov    %eax,0xb1c
}
 675:	5e                   	pop    %esi
 676:	5f                   	pop    %edi
 677:	5d                   	pop    %ebp
 678:	c3                   	ret
 679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 680:	39 d0                	cmp    %edx,%eax
 682:	72 04                	jb     688 <free+0x58>
 684:	39 d1                	cmp    %edx,%ecx
 686:	72 ce                	jb     656 <free+0x26>
{
 688:	89 d0                	mov    %edx,%eax
 68a:	eb bc                	jmp    648 <free+0x18>
 68c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 690:	03 72 04             	add    0x4(%edx),%esi
 693:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 696:	8b 10                	mov    (%eax),%edx
 698:	8b 12                	mov    (%edx),%edx
 69a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 69d:	8b 50 04             	mov    0x4(%eax),%edx
 6a0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6a3:	39 f1                	cmp    %esi,%ecx
 6a5:	75 c6                	jne    66d <free+0x3d>
    p->s.size += bp->s.size;
 6a7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 6aa:	a3 1c 0b 00 00       	mov    %eax,0xb1c
    p->s.size += bp->s.size;
 6af:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6b2:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 6b5:	89 08                	mov    %ecx,(%eax)
}
 6b7:	5b                   	pop    %ebx
 6b8:	5e                   	pop    %esi
 6b9:	5f                   	pop    %edi
 6ba:	5d                   	pop    %ebp
 6bb:	c3                   	ret
 6bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000006c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6c0:	55                   	push   %ebp
 6c1:	89 e5                	mov    %esp,%ebp
 6c3:	57                   	push   %edi
 6c4:	56                   	push   %esi
 6c5:	53                   	push   %ebx
 6c6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6c9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6cc:	8b 15 1c 0b 00 00    	mov    0xb1c,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6d2:	8d 78 07             	lea    0x7(%eax),%edi
 6d5:	c1 ef 03             	shr    $0x3,%edi
 6d8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 6db:	85 d2                	test   %edx,%edx
 6dd:	0f 84 8d 00 00 00    	je     770 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6e3:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6e5:	8b 48 04             	mov    0x4(%eax),%ecx
 6e8:	39 f9                	cmp    %edi,%ecx
 6ea:	73 64                	jae    750 <malloc+0x90>
  if(nu < 4096)
 6ec:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6f1:	39 df                	cmp    %ebx,%edi
 6f3:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 6f6:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 6fd:	eb 0a                	jmp    709 <malloc+0x49>
 6ff:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 700:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 702:	8b 48 04             	mov    0x4(%eax),%ecx
 705:	39 f9                	cmp    %edi,%ecx
 707:	73 47                	jae    750 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 709:	89 c2                	mov    %eax,%edx
 70b:	3b 05 1c 0b 00 00    	cmp    0xb1c,%eax
 711:	75 ed                	jne    700 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 713:	83 ec 0c             	sub    $0xc,%esp
 716:	56                   	push   %esi
 717:	e8 a1 fc ff ff       	call   3bd <sbrk>
  if(p == (char*)-1)
 71c:	83 c4 10             	add    $0x10,%esp
 71f:	83 f8 ff             	cmp    $0xffffffff,%eax
 722:	74 1c                	je     740 <malloc+0x80>
  hp->s.size = nu;
 724:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 727:	83 ec 0c             	sub    $0xc,%esp
 72a:	83 c0 08             	add    $0x8,%eax
 72d:	50                   	push   %eax
 72e:	e8 fd fe ff ff       	call   630 <free>
  return freep;
 733:	8b 15 1c 0b 00 00    	mov    0xb1c,%edx
      if((p = morecore(nunits)) == 0)
 739:	83 c4 10             	add    $0x10,%esp
 73c:	85 d2                	test   %edx,%edx
 73e:	75 c0                	jne    700 <malloc+0x40>
        return 0;
  }
}
 740:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 743:	31 c0                	xor    %eax,%eax
}
 745:	5b                   	pop    %ebx
 746:	5e                   	pop    %esi
 747:	5f                   	pop    %edi
 748:	5d                   	pop    %ebp
 749:	c3                   	ret
 74a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 750:	39 cf                	cmp    %ecx,%edi
 752:	74 4c                	je     7a0 <malloc+0xe0>
        p->s.size -= nunits;
 754:	29 f9                	sub    %edi,%ecx
 756:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 759:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 75c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 75f:	89 15 1c 0b 00 00    	mov    %edx,0xb1c
}
 765:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 768:	83 c0 08             	add    $0x8,%eax
}
 76b:	5b                   	pop    %ebx
 76c:	5e                   	pop    %esi
 76d:	5f                   	pop    %edi
 76e:	5d                   	pop    %ebp
 76f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 770:	c7 05 1c 0b 00 00 20 	movl   $0xb20,0xb1c
 777:	0b 00 00 
    base.s.size = 0;
 77a:	b8 20 0b 00 00       	mov    $0xb20,%eax
    base.s.ptr = freep = prevp = &base;
 77f:	c7 05 20 0b 00 00 20 	movl   $0xb20,0xb20
 786:	0b 00 00 
    base.s.size = 0;
 789:	c7 05 24 0b 00 00 00 	movl   $0x0,0xb24
 790:	00 00 00 
    if(p->s.size >= nunits){
 793:	e9 54 ff ff ff       	jmp    6ec <malloc+0x2c>
 798:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 79f:	00 
        prevp->s.ptr = p->s.ptr;
 7a0:	8b 08                	mov    (%eax),%ecx
 7a2:	89 0a                	mov    %ecx,(%edx)
 7a4:	eb b9                	jmp    75f <malloc+0x9f>
