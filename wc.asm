
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(1, "%d %d %d %s\n", l, w, c, name);
}

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
   f:	be 01 00 00 00       	mov    $0x1,%esi
  14:	53                   	push   %ebx
  15:	51                   	push   %ecx
  16:	83 ec 18             	sub    $0x18,%esp
  19:	8b 01                	mov    (%ecx),%eax
  1b:	8b 59 04             	mov    0x4(%ecx),%ebx
  1e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  21:	83 c3 04             	add    $0x4,%ebx
  int fd, i;

  if(argc <= 1){
  24:	83 f8 01             	cmp    $0x1,%eax
  27:	7f 28                	jg     51 <main+0x51>
  29:	eb 54                	jmp    7f <main+0x7f>
  2b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "wc: cannot open %s\n", argv[i]);
      exit();
    }
    wc(fd, argv[i]);
  30:	83 ec 08             	sub    $0x8,%esp
  33:	ff 33                	push   (%ebx)
  for(i = 1; i < argc; i++){
  35:	83 c6 01             	add    $0x1,%esi
  38:	83 c3 04             	add    $0x4,%ebx
    wc(fd, argv[i]);
  3b:	50                   	push   %eax
  3c:	e8 5f 00 00 00       	call   a0 <wc>
    close(fd);
  41:	89 3c 24             	mov    %edi,(%esp)
  44:	e8 14 04 00 00       	call   45d <close>
  for(i = 1; i < argc; i++){
  49:	83 c4 10             	add    $0x10,%esp
  4c:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  4f:	74 29                	je     7a <main+0x7a>
    if((fd = open(argv[i], 0)) < 0){
  51:	83 ec 08             	sub    $0x8,%esp
  54:	6a 00                	push   $0x0
  56:	ff 33                	push   (%ebx)
  58:	e8 18 04 00 00       	call   475 <open>
  5d:	83 c4 10             	add    $0x10,%esp
  60:	89 c7                	mov    %eax,%edi
  62:	85 c0                	test   %eax,%eax
  64:	79 ca                	jns    30 <main+0x30>
      printf(1, "wc: cannot open %s\n", argv[i]);
  66:	50                   	push   %eax
  67:	ff 33                	push   (%ebx)
  69:	68 cb 08 00 00       	push   $0x8cb
  6e:	6a 01                	push   $0x1
  70:	e8 2b 05 00 00       	call   5a0 <printf>
      exit();
  75:	e8 bb 03 00 00       	call   435 <exit>
  }
  exit();
  7a:	e8 b6 03 00 00       	call   435 <exit>
    wc(0, "");
  7f:	52                   	push   %edx
  80:	52                   	push   %edx
  81:	68 bd 08 00 00       	push   $0x8bd
  86:	6a 00                	push   $0x0
  88:	e8 13 00 00 00       	call   a0 <wc>
    exit();
  8d:	e8 a3 03 00 00       	call   435 <exit>
  92:	66 90                	xchg   %ax,%ax
  94:	66 90                	xchg   %ax,%ax
  96:	66 90                	xchg   %ax,%ax
  98:	66 90                	xchg   %ax,%ax
  9a:	66 90                	xchg   %ax,%ax
  9c:	66 90                	xchg   %ax,%ax
  9e:	66 90                	xchg   %ax,%ax

000000a0 <wc>:
{
  a0:	55                   	push   %ebp
  l = w = c = 0;
  a1:	31 d2                	xor    %edx,%edx
{
  a3:	89 e5                	mov    %esp,%ebp
  a5:	57                   	push   %edi
  a6:	56                   	push   %esi
  inword = 0;
  a7:	31 f6                	xor    %esi,%esi
{
  a9:	53                   	push   %ebx
  l = w = c = 0;
  aa:	31 db                	xor    %ebx,%ebx
{
  ac:	83 ec 1c             	sub    $0x1c,%esp
  l = w = c = 0;
  af:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  b6:	89 55 dc             	mov    %edx,-0x24(%ebp)
  b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  while((n = read(fd, buf, sizeof(buf))) > 0){
  c0:	83 ec 04             	sub    $0x4,%esp
  c3:	68 00 02 00 00       	push   $0x200
  c8:	68 60 0c 00 00       	push   $0xc60
  cd:	ff 75 08             	push   0x8(%ebp)
  d0:	e8 78 03 00 00       	call   44d <read>
  d5:	83 c4 10             	add    $0x10,%esp
  d8:	89 c1                	mov    %eax,%ecx
  da:	85 c0                	test   %eax,%eax
  dc:	7e 62                	jle    140 <wc+0xa0>
    for(i=0; i<n; i++){
  de:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  e1:	31 ff                	xor    %edi,%edi
  e3:	eb 0d                	jmp    f2 <wc+0x52>
  e5:	8d 76 00             	lea    0x0(%esi),%esi
        inword = 0;
  e8:	31 f6                	xor    %esi,%esi
    for(i=0; i<n; i++){
  ea:	83 c7 01             	add    $0x1,%edi
  ed:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
  f0:	74 3e                	je     130 <wc+0x90>
      if(buf[i] == '\n')
  f2:	0f be 87 60 0c 00 00 	movsbl 0xc60(%edi),%eax
        l++;
  f9:	31 c9                	xor    %ecx,%ecx
  fb:	3c 0a                	cmp    $0xa,%al
  fd:	0f 94 c1             	sete   %cl
      if(strchr(" \r\t\n\v", buf[i]))
 100:	83 ec 08             	sub    $0x8,%esp
 103:	50                   	push   %eax
        l++;
 104:	01 cb                	add    %ecx,%ebx
      if(strchr(" \r\t\n\v", buf[i]))
 106:	68 a8 08 00 00       	push   $0x8a8
 10b:	e8 50 01 00 00       	call   260 <strchr>
 110:	83 c4 10             	add    $0x10,%esp
 113:	85 c0                	test   %eax,%eax
 115:	75 d1                	jne    e8 <wc+0x48>
      else if(!inword){
 117:	85 f6                	test   %esi,%esi
 119:	75 cf                	jne    ea <wc+0x4a>
        w++;
 11b:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
        inword = 1;
 11f:	be 01 00 00 00       	mov    $0x1,%esi
    for(i=0; i<n; i++){
 124:	83 c7 01             	add    $0x1,%edi
 127:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
 12a:	75 c6                	jne    f2 <wc+0x52>
 12c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 130:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
 133:	01 4d dc             	add    %ecx,-0x24(%ebp)
 136:	eb 88                	jmp    c0 <wc+0x20>
 138:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 13f:	00 
  if(n < 0){
 140:	8b 55 dc             	mov    -0x24(%ebp),%edx
 143:	75 22                	jne    167 <wc+0xc7>
  printf(1, "%d %d %d %s\n", l, w, c, name);
 145:	83 ec 08             	sub    $0x8,%esp
 148:	ff 75 0c             	push   0xc(%ebp)
 14b:	52                   	push   %edx
 14c:	ff 75 e0             	push   -0x20(%ebp)
 14f:	53                   	push   %ebx
 150:	68 be 08 00 00       	push   $0x8be
 155:	6a 01                	push   $0x1
 157:	e8 44 04 00 00       	call   5a0 <printf>
}
 15c:	83 c4 20             	add    $0x20,%esp
 15f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 162:	5b                   	pop    %ebx
 163:	5e                   	pop    %esi
 164:	5f                   	pop    %edi
 165:	5d                   	pop    %ebp
 166:	c3                   	ret
    printf(1, "wc: read error\n");
 167:	50                   	push   %eax
 168:	50                   	push   %eax
 169:	68 ae 08 00 00       	push   $0x8ae
 16e:	6a 01                	push   $0x1
 170:	e8 2b 04 00 00       	call   5a0 <printf>
    exit();
 175:	e8 bb 02 00 00       	call   435 <exit>
 17a:	66 90                	xchg   %ax,%ax
 17c:	66 90                	xchg   %ax,%ax
 17e:	66 90                	xchg   %ax,%ax

00000180 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 180:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 181:	31 c0                	xor    %eax,%eax
{
 183:	89 e5                	mov    %esp,%ebp
 185:	53                   	push   %ebx
 186:	8b 4d 08             	mov    0x8(%ebp),%ecx
 189:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 190:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 194:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 197:	83 c0 01             	add    $0x1,%eax
 19a:	84 d2                	test   %dl,%dl
 19c:	75 f2                	jne    190 <strcpy+0x10>
    ;
  return os;
}
 19e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1a1:	89 c8                	mov    %ecx,%eax
 1a3:	c9                   	leave
 1a4:	c3                   	ret
 1a5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1ac:	00 
 1ad:	8d 76 00             	lea    0x0(%esi),%esi

000001b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	53                   	push   %ebx
 1b4:	8b 55 08             	mov    0x8(%ebp),%edx
 1b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 1ba:	0f b6 02             	movzbl (%edx),%eax
 1bd:	84 c0                	test   %al,%al
 1bf:	75 17                	jne    1d8 <strcmp+0x28>
 1c1:	eb 3a                	jmp    1fd <strcmp+0x4d>
 1c3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 1c8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 1cc:	83 c2 01             	add    $0x1,%edx
 1cf:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 1d2:	84 c0                	test   %al,%al
 1d4:	74 1a                	je     1f0 <strcmp+0x40>
 1d6:	89 d9                	mov    %ebx,%ecx
 1d8:	0f b6 19             	movzbl (%ecx),%ebx
 1db:	38 c3                	cmp    %al,%bl
 1dd:	74 e9                	je     1c8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 1df:	29 d8                	sub    %ebx,%eax
}
 1e1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1e4:	c9                   	leave
 1e5:	c3                   	ret
 1e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1ed:	00 
 1ee:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 1f0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 1f4:	31 c0                	xor    %eax,%eax
 1f6:	29 d8                	sub    %ebx,%eax
}
 1f8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1fb:	c9                   	leave
 1fc:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 1fd:	0f b6 19             	movzbl (%ecx),%ebx
 200:	31 c0                	xor    %eax,%eax
 202:	eb db                	jmp    1df <strcmp+0x2f>
 204:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 20b:	00 
 20c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000210 <strlen>:

uint
strlen(const char *s)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 216:	80 3a 00             	cmpb   $0x0,(%edx)
 219:	74 15                	je     230 <strlen+0x20>
 21b:	31 c0                	xor    %eax,%eax
 21d:	8d 76 00             	lea    0x0(%esi),%esi
 220:	83 c0 01             	add    $0x1,%eax
 223:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 227:	89 c1                	mov    %eax,%ecx
 229:	75 f5                	jne    220 <strlen+0x10>
    ;
  return n;
}
 22b:	89 c8                	mov    %ecx,%eax
 22d:	5d                   	pop    %ebp
 22e:	c3                   	ret
 22f:	90                   	nop
  for(n = 0; s[n]; n++)
 230:	31 c9                	xor    %ecx,%ecx
}
 232:	5d                   	pop    %ebp
 233:	89 c8                	mov    %ecx,%eax
 235:	c3                   	ret
 236:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 23d:	00 
 23e:	66 90                	xchg   %ax,%ax

00000240 <memset>:

void*
memset(void *dst, int c, uint n)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	57                   	push   %edi
 244:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 247:	8b 4d 10             	mov    0x10(%ebp),%ecx
 24a:	8b 45 0c             	mov    0xc(%ebp),%eax
 24d:	89 d7                	mov    %edx,%edi
 24f:	fc                   	cld
 250:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 252:	8b 7d fc             	mov    -0x4(%ebp),%edi
 255:	89 d0                	mov    %edx,%eax
 257:	c9                   	leave
 258:	c3                   	ret
 259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000260 <strchr>:

char*
strchr(const char *s, char c)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	8b 45 08             	mov    0x8(%ebp),%eax
 266:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 26a:	0f b6 10             	movzbl (%eax),%edx
 26d:	84 d2                	test   %dl,%dl
 26f:	75 12                	jne    283 <strchr+0x23>
 271:	eb 1d                	jmp    290 <strchr+0x30>
 273:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 278:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 27c:	83 c0 01             	add    $0x1,%eax
 27f:	84 d2                	test   %dl,%dl
 281:	74 0d                	je     290 <strchr+0x30>
    if(*s == c)
 283:	38 d1                	cmp    %dl,%cl
 285:	75 f1                	jne    278 <strchr+0x18>
      return (char*)s;
  return 0;
}
 287:	5d                   	pop    %ebp
 288:	c3                   	ret
 289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 290:	31 c0                	xor    %eax,%eax
}
 292:	5d                   	pop    %ebp
 293:	c3                   	ret
 294:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 29b:	00 
 29c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000002a0 <gets>:

char*
gets(char *buf, int max)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	57                   	push   %edi
 2a4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 2a5:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 2a8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 2a9:	31 db                	xor    %ebx,%ebx
{
 2ab:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 2ae:	eb 27                	jmp    2d7 <gets+0x37>
    cc = read(0, &c, 1);
 2b0:	83 ec 04             	sub    $0x4,%esp
 2b3:	6a 01                	push   $0x1
 2b5:	56                   	push   %esi
 2b6:	6a 00                	push   $0x0
 2b8:	e8 90 01 00 00       	call   44d <read>
    if(cc < 1)
 2bd:	83 c4 10             	add    $0x10,%esp
 2c0:	85 c0                	test   %eax,%eax
 2c2:	7e 1d                	jle    2e1 <gets+0x41>
      break;
    buf[i++] = c;
 2c4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2c8:	8b 55 08             	mov    0x8(%ebp),%edx
 2cb:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 2cf:	3c 0a                	cmp    $0xa,%al
 2d1:	74 10                	je     2e3 <gets+0x43>
 2d3:	3c 0d                	cmp    $0xd,%al
 2d5:	74 0c                	je     2e3 <gets+0x43>
  for(i=0; i+1 < max; ){
 2d7:	89 df                	mov    %ebx,%edi
 2d9:	83 c3 01             	add    $0x1,%ebx
 2dc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2df:	7c cf                	jl     2b0 <gets+0x10>
 2e1:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 2e3:	8b 45 08             	mov    0x8(%ebp),%eax
 2e6:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 2ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2ed:	5b                   	pop    %ebx
 2ee:	5e                   	pop    %esi
 2ef:	5f                   	pop    %edi
 2f0:	5d                   	pop    %ebp
 2f1:	c3                   	ret
 2f2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2f9:	00 
 2fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000300 <stat>:

int
stat(const char *n, struct stat *st)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	56                   	push   %esi
 304:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 305:	83 ec 08             	sub    $0x8,%esp
 308:	6a 00                	push   $0x0
 30a:	ff 75 08             	push   0x8(%ebp)
 30d:	e8 63 01 00 00       	call   475 <open>
  if(fd < 0)
 312:	83 c4 10             	add    $0x10,%esp
 315:	85 c0                	test   %eax,%eax
 317:	78 27                	js     340 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 319:	83 ec 08             	sub    $0x8,%esp
 31c:	ff 75 0c             	push   0xc(%ebp)
 31f:	89 c3                	mov    %eax,%ebx
 321:	50                   	push   %eax
 322:	e8 66 01 00 00       	call   48d <fstat>
  close(fd);
 327:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 32a:	89 c6                	mov    %eax,%esi
  close(fd);
 32c:	e8 2c 01 00 00       	call   45d <close>
  return r;
 331:	83 c4 10             	add    $0x10,%esp
}
 334:	8d 65 f8             	lea    -0x8(%ebp),%esp
 337:	89 f0                	mov    %esi,%eax
 339:	5b                   	pop    %ebx
 33a:	5e                   	pop    %esi
 33b:	5d                   	pop    %ebp
 33c:	c3                   	ret
 33d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 340:	be ff ff ff ff       	mov    $0xffffffff,%esi
 345:	eb ed                	jmp    334 <stat+0x34>
 347:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 34e:	00 
 34f:	90                   	nop

00000350 <atoi>:

int
atoi(const char *s)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	53                   	push   %ebx
 354:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 357:	0f be 02             	movsbl (%edx),%eax
 35a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 35d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 360:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 365:	77 1e                	ja     385 <atoi+0x35>
 367:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 36e:	00 
 36f:	90                   	nop
    n = n*10 + *s++ - '0';
 370:	83 c2 01             	add    $0x1,%edx
 373:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 376:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 37a:	0f be 02             	movsbl (%edx),%eax
 37d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 380:	80 fb 09             	cmp    $0x9,%bl
 383:	76 eb                	jbe    370 <atoi+0x20>
  return n;
}
 385:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 388:	89 c8                	mov    %ecx,%eax
 38a:	c9                   	leave
 38b:	c3                   	ret
 38c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000390 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	57                   	push   %edi
 394:	8b 45 10             	mov    0x10(%ebp),%eax
 397:	8b 55 08             	mov    0x8(%ebp),%edx
 39a:	56                   	push   %esi
 39b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 39e:	85 c0                	test   %eax,%eax
 3a0:	7e 13                	jle    3b5 <memmove+0x25>
 3a2:	01 d0                	add    %edx,%eax
  dst = vdst;
 3a4:	89 d7                	mov    %edx,%edi
 3a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3ad:	00 
 3ae:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 3b0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 3b1:	39 f8                	cmp    %edi,%eax
 3b3:	75 fb                	jne    3b0 <memmove+0x20>
  return vdst;
}
 3b5:	5e                   	pop    %esi
 3b6:	89 d0                	mov    %edx,%eax
 3b8:	5f                   	pop    %edi
 3b9:	5d                   	pop    %ebp
 3ba:	c3                   	ret
 3bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

000003c0 <copyfd>:

int copyfd(int srcfd, int dstfd) {
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	57                   	push   %edi
 3c4:	56                   	push   %esi
 3c5:	53                   	push   %ebx
 3c6:	8d 9d e8 fd ff ff    	lea    -0x218(%ebp),%ebx
 3cc:	81 ec 0c 02 00 00    	sub    $0x20c,%esp
 3d2:	8b 75 08             	mov    0x8(%ebp),%esi
    char buf[512];
    int n;

    while((n = read(srcfd, buf, sizeof(buf))) > 0) {
 3d5:	eb 1d                	jmp    3f4 <copyfd+0x34>
 3d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3de:	00 
 3df:	90                   	nop
        if(write(dstfd, buf, n) != n) {
 3e0:	83 ec 04             	sub    $0x4,%esp
 3e3:	57                   	push   %edi
 3e4:	53                   	push   %ebx
 3e5:	ff 75 0c             	push   0xc(%ebp)
 3e8:	e8 68 00 00 00       	call   455 <write>
 3ed:	83 c4 10             	add    $0x10,%esp
 3f0:	39 f8                	cmp    %edi,%eax
 3f2:	75 2c                	jne    420 <copyfd+0x60>
    while((n = read(srcfd, buf, sizeof(buf))) > 0) {
 3f4:	83 ec 04             	sub    $0x4,%esp
 3f7:	68 00 02 00 00       	push   $0x200
 3fc:	53                   	push   %ebx
 3fd:	56                   	push   %esi
 3fe:	e8 4a 00 00 00       	call   44d <read>
 403:	83 c4 10             	add    $0x10,%esp
 406:	89 c7                	mov    %eax,%edi
 408:	85 c0                	test   %eax,%eax
 40a:	7f d4                	jg     3e0 <copyfd+0x20>
            return -1;   // write error
        }
    }
    if(n < 0) return -1;   // read error
 40c:	0f 95 c0             	setne  %al
    return 0;              // success
}
 40f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(n < 0) return -1;   // read error
 412:	0f b6 c0             	movzbl %al,%eax
}
 415:	5b                   	pop    %ebx
 416:	5e                   	pop    %esi
    if(n < 0) return -1;   // read error
 417:	f7 d8                	neg    %eax
}
 419:	5f                   	pop    %edi
 41a:	5d                   	pop    %ebp
 41b:	c3                   	ret
 41c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 420:	8d 65 f4             	lea    -0xc(%ebp),%esp
            return -1;   // write error
 423:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 428:	5b                   	pop    %ebx
 429:	5e                   	pop    %esi
 42a:	5f                   	pop    %edi
 42b:	5d                   	pop    %ebp
 42c:	c3                   	ret

0000042d <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 42d:	b8 01 00 00 00       	mov    $0x1,%eax
 432:	cd 40                	int    $0x40
 434:	c3                   	ret

00000435 <exit>:
SYSCALL(exit)
 435:	b8 02 00 00 00       	mov    $0x2,%eax
 43a:	cd 40                	int    $0x40
 43c:	c3                   	ret

0000043d <wait>:
SYSCALL(wait)
 43d:	b8 03 00 00 00       	mov    $0x3,%eax
 442:	cd 40                	int    $0x40
 444:	c3                   	ret

00000445 <pipe>:
SYSCALL(pipe)
 445:	b8 04 00 00 00       	mov    $0x4,%eax
 44a:	cd 40                	int    $0x40
 44c:	c3                   	ret

0000044d <read>:
SYSCALL(read)
 44d:	b8 05 00 00 00       	mov    $0x5,%eax
 452:	cd 40                	int    $0x40
 454:	c3                   	ret

00000455 <write>:
SYSCALL(write)
 455:	b8 10 00 00 00       	mov    $0x10,%eax
 45a:	cd 40                	int    $0x40
 45c:	c3                   	ret

0000045d <close>:
SYSCALL(close)
 45d:	b8 15 00 00 00       	mov    $0x15,%eax
 462:	cd 40                	int    $0x40
 464:	c3                   	ret

00000465 <kill>:
SYSCALL(kill)
 465:	b8 06 00 00 00       	mov    $0x6,%eax
 46a:	cd 40                	int    $0x40
 46c:	c3                   	ret

0000046d <exec>:
SYSCALL(exec)
 46d:	b8 07 00 00 00       	mov    $0x7,%eax
 472:	cd 40                	int    $0x40
 474:	c3                   	ret

00000475 <open>:
SYSCALL(open)
 475:	b8 0f 00 00 00       	mov    $0xf,%eax
 47a:	cd 40                	int    $0x40
 47c:	c3                   	ret

0000047d <mknod>:
SYSCALL(mknod)
 47d:	b8 11 00 00 00       	mov    $0x11,%eax
 482:	cd 40                	int    $0x40
 484:	c3                   	ret

00000485 <unlink>:
SYSCALL(unlink)
 485:	b8 12 00 00 00       	mov    $0x12,%eax
 48a:	cd 40                	int    $0x40
 48c:	c3                   	ret

0000048d <fstat>:
SYSCALL(fstat)
 48d:	b8 08 00 00 00       	mov    $0x8,%eax
 492:	cd 40                	int    $0x40
 494:	c3                   	ret

00000495 <link>:
SYSCALL(link)
 495:	b8 13 00 00 00       	mov    $0x13,%eax
 49a:	cd 40                	int    $0x40
 49c:	c3                   	ret

0000049d <mkdir>:
SYSCALL(mkdir)
 49d:	b8 14 00 00 00       	mov    $0x14,%eax
 4a2:	cd 40                	int    $0x40
 4a4:	c3                   	ret

000004a5 <chdir>:
SYSCALL(chdir)
 4a5:	b8 09 00 00 00       	mov    $0x9,%eax
 4aa:	cd 40                	int    $0x40
 4ac:	c3                   	ret

000004ad <dup>:
SYSCALL(dup)
 4ad:	b8 0a 00 00 00       	mov    $0xa,%eax
 4b2:	cd 40                	int    $0x40
 4b4:	c3                   	ret

000004b5 <getpid>:
SYSCALL(getpid)
 4b5:	b8 0b 00 00 00       	mov    $0xb,%eax
 4ba:	cd 40                	int    $0x40
 4bc:	c3                   	ret

000004bd <sbrk>:
SYSCALL(sbrk)
 4bd:	b8 0c 00 00 00       	mov    $0xc,%eax
 4c2:	cd 40                	int    $0x40
 4c4:	c3                   	ret

000004c5 <sleep>:
SYSCALL(sleep)
 4c5:	b8 0d 00 00 00       	mov    $0xd,%eax
 4ca:	cd 40                	int    $0x40
 4cc:	c3                   	ret

000004cd <uptime>:
SYSCALL(uptime)
 4cd:	b8 0e 00 00 00       	mov    $0xe,%eax
 4d2:	cd 40                	int    $0x40
 4d4:	c3                   	ret

000004d5 <chprty>:
SYSCALL(chprty)
 4d5:	b8 16 00 00 00       	mov    $0x16,%eax
 4da:	cd 40                	int    $0x40
 4dc:	c3                   	ret

000004dd <cps>:
SYSCALL(cps)
 4dd:	b8 17 00 00 00       	mov    $0x17,%eax
 4e2:	cd 40                	int    $0x40
 4e4:	c3                   	ret

000004e5 <waitx>:
SYSCALL(waitx)
 4e5:	b8 19 00 00 00       	mov    $0x19,%eax
 4ea:	cd 40                	int    $0x40
 4ec:	c3                   	ret

000004ed <getpinfo>:
 4ed:	b8 18 00 00 00       	mov    $0x18,%eax
 4f2:	cd 40                	int    $0x40
 4f4:	c3                   	ret
 4f5:	66 90                	xchg   %ax,%ax
 4f7:	66 90                	xchg   %ax,%ax
 4f9:	66 90                	xchg   %ax,%ax
 4fb:	66 90                	xchg   %ax,%ax
 4fd:	66 90                	xchg   %ax,%ax
 4ff:	90                   	nop

00000500 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 500:	55                   	push   %ebp
 501:	89 e5                	mov    %esp,%ebp
 503:	57                   	push   %edi
 504:	56                   	push   %esi
 505:	53                   	push   %ebx
 506:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 508:	89 d1                	mov    %edx,%ecx
{
 50a:	83 ec 3c             	sub    $0x3c,%esp
 50d:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
 510:	85 d2                	test   %edx,%edx
 512:	0f 89 80 00 00 00    	jns    598 <printint+0x98>
 518:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 51c:	74 7a                	je     598 <printint+0x98>
    x = -xx;
 51e:	f7 d9                	neg    %ecx
    neg = 1;
 520:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 525:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 528:	31 f6                	xor    %esi,%esi
 52a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 530:	89 c8                	mov    %ecx,%eax
 532:	31 d2                	xor    %edx,%edx
 534:	89 f7                	mov    %esi,%edi
 536:	f7 f3                	div    %ebx
 538:	8d 76 01             	lea    0x1(%esi),%esi
 53b:	0f b6 92 40 09 00 00 	movzbl 0x940(%edx),%edx
 542:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 546:	89 ca                	mov    %ecx,%edx
 548:	89 c1                	mov    %eax,%ecx
 54a:	39 da                	cmp    %ebx,%edx
 54c:	73 e2                	jae    530 <printint+0x30>
  if(neg)
 54e:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 551:	85 c0                	test   %eax,%eax
 553:	74 07                	je     55c <printint+0x5c>
    buf[i++] = '-';
 555:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)

  while(--i >= 0)
 55a:	89 f7                	mov    %esi,%edi
 55c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 55f:	8b 75 c0             	mov    -0x40(%ebp),%esi
 562:	01 df                	add    %ebx,%edi
 564:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 568:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 56b:	83 ec 04             	sub    $0x4,%esp
 56e:	88 45 d7             	mov    %al,-0x29(%ebp)
 571:	8d 45 d7             	lea    -0x29(%ebp),%eax
 574:	6a 01                	push   $0x1
 576:	50                   	push   %eax
 577:	56                   	push   %esi
 578:	e8 d8 fe ff ff       	call   455 <write>
  while(--i >= 0)
 57d:	89 f8                	mov    %edi,%eax
 57f:	83 c4 10             	add    $0x10,%esp
 582:	83 ef 01             	sub    $0x1,%edi
 585:	39 c3                	cmp    %eax,%ebx
 587:	75 df                	jne    568 <printint+0x68>
}
 589:	8d 65 f4             	lea    -0xc(%ebp),%esp
 58c:	5b                   	pop    %ebx
 58d:	5e                   	pop    %esi
 58e:	5f                   	pop    %edi
 58f:	5d                   	pop    %ebp
 590:	c3                   	ret
 591:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 598:	31 c0                	xor    %eax,%eax
 59a:	eb 89                	jmp    525 <printint+0x25>
 59c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000005a0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 5a0:	55                   	push   %ebp
 5a1:	89 e5                	mov    %esp,%ebp
 5a3:	57                   	push   %edi
 5a4:	56                   	push   %esi
 5a5:	53                   	push   %ebx
 5a6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5a9:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 5ac:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 5af:	0f b6 1e             	movzbl (%esi),%ebx
 5b2:	83 c6 01             	add    $0x1,%esi
 5b5:	84 db                	test   %bl,%bl
 5b7:	74 67                	je     620 <printf+0x80>
 5b9:	8d 4d 10             	lea    0x10(%ebp),%ecx
 5bc:	31 d2                	xor    %edx,%edx
 5be:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 5c1:	eb 34                	jmp    5f7 <printf+0x57>
 5c3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 5c8:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 5cb:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 5d0:	83 f8 25             	cmp    $0x25,%eax
 5d3:	74 18                	je     5ed <printf+0x4d>
  write(fd, &c, 1);
 5d5:	83 ec 04             	sub    $0x4,%esp
 5d8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 5db:	88 5d e7             	mov    %bl,-0x19(%ebp)
 5de:	6a 01                	push   $0x1
 5e0:	50                   	push   %eax
 5e1:	57                   	push   %edi
 5e2:	e8 6e fe ff ff       	call   455 <write>
 5e7:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 5ea:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 5ed:	0f b6 1e             	movzbl (%esi),%ebx
 5f0:	83 c6 01             	add    $0x1,%esi
 5f3:	84 db                	test   %bl,%bl
 5f5:	74 29                	je     620 <printf+0x80>
    c = fmt[i] & 0xff;
 5f7:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 5fa:	85 d2                	test   %edx,%edx
 5fc:	74 ca                	je     5c8 <printf+0x28>
      }
    } else if(state == '%'){
 5fe:	83 fa 25             	cmp    $0x25,%edx
 601:	75 ea                	jne    5ed <printf+0x4d>
      if(c == 'd'){
 603:	83 f8 25             	cmp    $0x25,%eax
 606:	0f 84 04 01 00 00    	je     710 <printf+0x170>
 60c:	83 e8 63             	sub    $0x63,%eax
 60f:	83 f8 15             	cmp    $0x15,%eax
 612:	77 1c                	ja     630 <printf+0x90>
 614:	ff 24 85 e8 08 00 00 	jmp    *0x8e8(,%eax,4)
 61b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 620:	8d 65 f4             	lea    -0xc(%ebp),%esp
 623:	5b                   	pop    %ebx
 624:	5e                   	pop    %esi
 625:	5f                   	pop    %edi
 626:	5d                   	pop    %ebp
 627:	c3                   	ret
 628:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 62f:	00 
  write(fd, &c, 1);
 630:	83 ec 04             	sub    $0x4,%esp
 633:	8d 55 e7             	lea    -0x19(%ebp),%edx
 636:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 63a:	6a 01                	push   $0x1
 63c:	52                   	push   %edx
 63d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 640:	57                   	push   %edi
 641:	e8 0f fe ff ff       	call   455 <write>
 646:	83 c4 0c             	add    $0xc,%esp
 649:	88 5d e7             	mov    %bl,-0x19(%ebp)
 64c:	6a 01                	push   $0x1
 64e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 651:	52                   	push   %edx
 652:	57                   	push   %edi
 653:	e8 fd fd ff ff       	call   455 <write>
        putc(fd, c);
 658:	83 c4 10             	add    $0x10,%esp
      state = 0;
 65b:	31 d2                	xor    %edx,%edx
 65d:	eb 8e                	jmp    5ed <printf+0x4d>
 65f:	90                   	nop
        printint(fd, *ap, 16, 0);
 660:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 663:	83 ec 0c             	sub    $0xc,%esp
 666:	b9 10 00 00 00       	mov    $0x10,%ecx
 66b:	8b 13                	mov    (%ebx),%edx
 66d:	6a 00                	push   $0x0
 66f:	89 f8                	mov    %edi,%eax
        ap++;
 671:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
 674:	e8 87 fe ff ff       	call   500 <printint>
        ap++;
 679:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 67c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 67f:	31 d2                	xor    %edx,%edx
 681:	e9 67 ff ff ff       	jmp    5ed <printf+0x4d>
        s = (char*)*ap;
 686:	8b 45 d0             	mov    -0x30(%ebp),%eax
 689:	8b 18                	mov    (%eax),%ebx
        ap++;
 68b:	83 c0 04             	add    $0x4,%eax
 68e:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 691:	85 db                	test   %ebx,%ebx
 693:	0f 84 87 00 00 00    	je     720 <printf+0x180>
        while(*s != 0){
 699:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 69c:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 69e:	84 c0                	test   %al,%al
 6a0:	0f 84 47 ff ff ff    	je     5ed <printf+0x4d>
 6a6:	8d 55 e7             	lea    -0x19(%ebp),%edx
 6a9:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 6ac:	89 de                	mov    %ebx,%esi
 6ae:	89 d3                	mov    %edx,%ebx
  write(fd, &c, 1);
 6b0:	83 ec 04             	sub    $0x4,%esp
 6b3:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 6b6:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 6b9:	6a 01                	push   $0x1
 6bb:	53                   	push   %ebx
 6bc:	57                   	push   %edi
 6bd:	e8 93 fd ff ff       	call   455 <write>
        while(*s != 0){
 6c2:	0f b6 06             	movzbl (%esi),%eax
 6c5:	83 c4 10             	add    $0x10,%esp
 6c8:	84 c0                	test   %al,%al
 6ca:	75 e4                	jne    6b0 <printf+0x110>
      state = 0;
 6cc:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 6cf:	31 d2                	xor    %edx,%edx
 6d1:	e9 17 ff ff ff       	jmp    5ed <printf+0x4d>
        printint(fd, *ap, 10, 1);
 6d6:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 6d9:	83 ec 0c             	sub    $0xc,%esp
 6dc:	b9 0a 00 00 00       	mov    $0xa,%ecx
 6e1:	8b 13                	mov    (%ebx),%edx
 6e3:	6a 01                	push   $0x1
 6e5:	eb 88                	jmp    66f <printf+0xcf>
        putc(fd, *ap);
 6e7:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 6ea:	83 ec 04             	sub    $0x4,%esp
 6ed:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
 6f0:	8b 03                	mov    (%ebx),%eax
        ap++;
 6f2:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
 6f5:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 6f8:	6a 01                	push   $0x1
 6fa:	52                   	push   %edx
 6fb:	57                   	push   %edi
 6fc:	e8 54 fd ff ff       	call   455 <write>
        ap++;
 701:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 704:	83 c4 10             	add    $0x10,%esp
      state = 0;
 707:	31 d2                	xor    %edx,%edx
 709:	e9 df fe ff ff       	jmp    5ed <printf+0x4d>
 70e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 710:	83 ec 04             	sub    $0x4,%esp
 713:	88 5d e7             	mov    %bl,-0x19(%ebp)
 716:	8d 55 e7             	lea    -0x19(%ebp),%edx
 719:	6a 01                	push   $0x1
 71b:	e9 31 ff ff ff       	jmp    651 <printf+0xb1>
 720:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 725:	bb df 08 00 00       	mov    $0x8df,%ebx
 72a:	e9 77 ff ff ff       	jmp    6a6 <printf+0x106>
 72f:	90                   	nop

00000730 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 730:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 731:	a1 60 0e 00 00       	mov    0xe60,%eax
{
 736:	89 e5                	mov    %esp,%ebp
 738:	57                   	push   %edi
 739:	56                   	push   %esi
 73a:	53                   	push   %ebx
 73b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 73e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 741:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 748:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 74a:	39 c8                	cmp    %ecx,%eax
 74c:	73 32                	jae    780 <free+0x50>
 74e:	39 d1                	cmp    %edx,%ecx
 750:	72 04                	jb     756 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 752:	39 d0                	cmp    %edx,%eax
 754:	72 32                	jb     788 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 756:	8b 73 fc             	mov    -0x4(%ebx),%esi
 759:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 75c:	39 fa                	cmp    %edi,%edx
 75e:	74 30                	je     790 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 760:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 763:	8b 50 04             	mov    0x4(%eax),%edx
 766:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 769:	39 f1                	cmp    %esi,%ecx
 76b:	74 3a                	je     7a7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 76d:	89 08                	mov    %ecx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 76f:	5b                   	pop    %ebx
  freep = p;
 770:	a3 60 0e 00 00       	mov    %eax,0xe60
}
 775:	5e                   	pop    %esi
 776:	5f                   	pop    %edi
 777:	5d                   	pop    %ebp
 778:	c3                   	ret
 779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 780:	39 d0                	cmp    %edx,%eax
 782:	72 04                	jb     788 <free+0x58>
 784:	39 d1                	cmp    %edx,%ecx
 786:	72 ce                	jb     756 <free+0x26>
{
 788:	89 d0                	mov    %edx,%eax
 78a:	eb bc                	jmp    748 <free+0x18>
 78c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 790:	03 72 04             	add    0x4(%edx),%esi
 793:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 796:	8b 10                	mov    (%eax),%edx
 798:	8b 12                	mov    (%edx),%edx
 79a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 79d:	8b 50 04             	mov    0x4(%eax),%edx
 7a0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7a3:	39 f1                	cmp    %esi,%ecx
 7a5:	75 c6                	jne    76d <free+0x3d>
    p->s.size += bp->s.size;
 7a7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 7aa:	a3 60 0e 00 00       	mov    %eax,0xe60
    p->s.size += bp->s.size;
 7af:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7b2:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 7b5:	89 08                	mov    %ecx,(%eax)
}
 7b7:	5b                   	pop    %ebx
 7b8:	5e                   	pop    %esi
 7b9:	5f                   	pop    %edi
 7ba:	5d                   	pop    %ebp
 7bb:	c3                   	ret
 7bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000007c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7c0:	55                   	push   %ebp
 7c1:	89 e5                	mov    %esp,%ebp
 7c3:	57                   	push   %edi
 7c4:	56                   	push   %esi
 7c5:	53                   	push   %ebx
 7c6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7c9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7cc:	8b 15 60 0e 00 00    	mov    0xe60,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7d2:	8d 78 07             	lea    0x7(%eax),%edi
 7d5:	c1 ef 03             	shr    $0x3,%edi
 7d8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 7db:	85 d2                	test   %edx,%edx
 7dd:	0f 84 8d 00 00 00    	je     870 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7e3:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7e5:	8b 48 04             	mov    0x4(%eax),%ecx
 7e8:	39 f9                	cmp    %edi,%ecx
 7ea:	73 64                	jae    850 <malloc+0x90>
  if(nu < 4096)
 7ec:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7f1:	39 df                	cmp    %ebx,%edi
 7f3:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 7f6:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 7fd:	eb 0a                	jmp    809 <malloc+0x49>
 7ff:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 800:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 802:	8b 48 04             	mov    0x4(%eax),%ecx
 805:	39 f9                	cmp    %edi,%ecx
 807:	73 47                	jae    850 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 809:	89 c2                	mov    %eax,%edx
 80b:	3b 05 60 0e 00 00    	cmp    0xe60,%eax
 811:	75 ed                	jne    800 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 813:	83 ec 0c             	sub    $0xc,%esp
 816:	56                   	push   %esi
 817:	e8 a1 fc ff ff       	call   4bd <sbrk>
  if(p == (char*)-1)
 81c:	83 c4 10             	add    $0x10,%esp
 81f:	83 f8 ff             	cmp    $0xffffffff,%eax
 822:	74 1c                	je     840 <malloc+0x80>
  hp->s.size = nu;
 824:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 827:	83 ec 0c             	sub    $0xc,%esp
 82a:	83 c0 08             	add    $0x8,%eax
 82d:	50                   	push   %eax
 82e:	e8 fd fe ff ff       	call   730 <free>
  return freep;
 833:	8b 15 60 0e 00 00    	mov    0xe60,%edx
      if((p = morecore(nunits)) == 0)
 839:	83 c4 10             	add    $0x10,%esp
 83c:	85 d2                	test   %edx,%edx
 83e:	75 c0                	jne    800 <malloc+0x40>
        return 0;
  }
}
 840:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 843:	31 c0                	xor    %eax,%eax
}
 845:	5b                   	pop    %ebx
 846:	5e                   	pop    %esi
 847:	5f                   	pop    %edi
 848:	5d                   	pop    %ebp
 849:	c3                   	ret
 84a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 850:	39 cf                	cmp    %ecx,%edi
 852:	74 4c                	je     8a0 <malloc+0xe0>
        p->s.size -= nunits;
 854:	29 f9                	sub    %edi,%ecx
 856:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 859:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 85c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 85f:	89 15 60 0e 00 00    	mov    %edx,0xe60
}
 865:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 868:	83 c0 08             	add    $0x8,%eax
}
 86b:	5b                   	pop    %ebx
 86c:	5e                   	pop    %esi
 86d:	5f                   	pop    %edi
 86e:	5d                   	pop    %ebp
 86f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 870:	c7 05 60 0e 00 00 64 	movl   $0xe64,0xe60
 877:	0e 00 00 
    base.s.size = 0;
 87a:	b8 64 0e 00 00       	mov    $0xe64,%eax
    base.s.ptr = freep = prevp = &base;
 87f:	c7 05 64 0e 00 00 64 	movl   $0xe64,0xe64
 886:	0e 00 00 
    base.s.size = 0;
 889:	c7 05 68 0e 00 00 00 	movl   $0x0,0xe68
 890:	00 00 00 
    if(p->s.size >= nunits){
 893:	e9 54 ff ff ff       	jmp    7ec <malloc+0x2c>
 898:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 89f:	00 
        prevp->s.ptr = p->s.ptr;
 8a0:	8b 08                	mov    (%eax),%ecx
 8a2:	89 0a                	mov    %ecx,(%edx)
 8a4:	eb b9                	jmp    85f <malloc+0x9f>
