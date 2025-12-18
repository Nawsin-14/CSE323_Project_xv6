
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc f0 77 11 80       	mov    $0x801177f0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 40 30 10 80       	mov    $0x80103040,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb 54 b5 10 80       	mov    $0x8010b554,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 00 7e 10 80       	push   $0x80107e00
80100051:	68 20 b5 10 80       	push   $0x8010b520
80100056:	e8 15 4f 00 00       	call   80104f70 <initlock>
  bcache.head.next = &bcache.head;
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	b8 1c fc 10 80       	mov    $0x8010fc1c,%eax
  bcache.head.prev = &bcache.head;
80100063:	c7 05 6c fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc6c
8010006a:	fc 10 80 
  bcache.head.next = &bcache.head;
8010006d:	c7 05 70 fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc70
80100074:	fc 10 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 d3                	mov    %edx,%ebx
    b->next = bcache.head.next;
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->prev = &bcache.head;
8010008b:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 07 7e 10 80       	push   $0x80107e07
80100097:	50                   	push   %eax
80100098:	e8 a3 4d 00 00       	call   80104e40 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	81 fb c0 f9 10 80    	cmp    $0x8010f9c0,%ebx
801000bc:	75 c2                	jne    80100080 <binit+0x40>
  }
}
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	c9                   	leave
801000c2:	c3                   	ret
801000c3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801000ca:	00 
801000cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 20 b5 10 80       	push   $0x8010b520
801000e4:	e8 77 50 00 00       	call   80105160 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 70 fc 10 80    	mov    0x8010fc70,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 6c fc 10 80    	mov    0x8010fc6c,%ebx
80100126:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 6e                	jmp    8010019e <bread+0xce>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100139:	74 63                	je     8010019e <bread+0xce>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 20 b5 10 80       	push   $0x8010b520
80100162:	e8 99 4f 00 00       	call   80105100 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 0e 4d 00 00       	call   80104e80 <acquiresleep>
      return b;
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	74 0e                	je     80100188 <bread+0xb8>
    iderw(b);
  }
  return b;
}
8010017a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010017d:	89 d8                	mov    %ebx,%eax
8010017f:	5b                   	pop    %ebx
80100180:	5e                   	pop    %esi
80100181:	5f                   	pop    %edi
80100182:	5d                   	pop    %ebp
80100183:	c3                   	ret
80100184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iderw(b);
80100188:	83 ec 0c             	sub    $0xc,%esp
8010018b:	53                   	push   %ebx
8010018c:	e8 4f 21 00 00       	call   801022e0 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
}
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret
  panic("bget: no buffers");
8010019e:	83 ec 0c             	sub    $0xc,%esp
801001a1:	68 0e 7e 10 80       	push   $0x80107e0e
801001a6:	e8 d5 01 00 00       	call   80100380 <panic>
801001ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801001b0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001b0:	55                   	push   %ebp
801001b1:	89 e5                	mov    %esp,%ebp
801001b3:	53                   	push   %ebx
801001b4:	83 ec 10             	sub    $0x10,%esp
801001b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001ba:	8d 43 0c             	lea    0xc(%ebx),%eax
801001bd:	50                   	push   %eax
801001be:	e8 5d 4d 00 00       	call   80104f20 <holdingsleep>
801001c3:	83 c4 10             	add    $0x10,%esp
801001c6:	85 c0                	test   %eax,%eax
801001c8:	74 0f                	je     801001d9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ca:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001cd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d3:	c9                   	leave
  iderw(b);
801001d4:	e9 07 21 00 00       	jmp    801022e0 <iderw>
    panic("bwrite");
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 1f 7e 10 80       	push   $0x80107e1f
801001e1:	e8 9a 01 00 00       	call   80100380 <panic>
801001e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801001ed:	00 
801001ee:	66 90                	xchg   %ax,%ax

801001f0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001f0:	55                   	push   %ebp
801001f1:	89 e5                	mov    %esp,%ebp
801001f3:	56                   	push   %esi
801001f4:	53                   	push   %ebx
801001f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001f8:	8d 73 0c             	lea    0xc(%ebx),%esi
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 1c 4d 00 00       	call   80104f20 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 63                	je     8010026e <brelse+0x7e>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 cc 4c 00 00       	call   80104ee0 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010021b:	e8 40 4f 00 00       	call   80105160 <acquire>
  b->refcnt--;
80100220:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100223:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100226:	83 e8 01             	sub    $0x1,%eax
80100229:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010022c:	85 c0                	test   %eax,%eax
8010022e:	75 2c                	jne    8010025c <brelse+0x6c>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100230:	8b 53 54             	mov    0x54(%ebx),%edx
80100233:	8b 43 50             	mov    0x50(%ebx),%eax
80100236:	89 42 50             	mov    %eax,0x50(%edx)
    b->prev->next = b->next;
80100239:	8b 53 54             	mov    0x54(%ebx),%edx
8010023c:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
8010023f:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
    b->prev = &bcache.head;
80100244:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    b->next = bcache.head.next;
8010024b:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
8010024e:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
80100253:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100256:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  }
  
  release(&bcache.lock);
8010025c:	c7 45 08 20 b5 10 80 	movl   $0x8010b520,0x8(%ebp)
}
80100263:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100266:	5b                   	pop    %ebx
80100267:	5e                   	pop    %esi
80100268:	5d                   	pop    %ebp
  release(&bcache.lock);
80100269:	e9 92 4e 00 00       	jmp    80105100 <release>
    panic("brelse");
8010026e:	83 ec 0c             	sub    $0xc,%esp
80100271:	68 26 7e 10 80       	push   $0x80107e26
80100276:	e8 05 01 00 00       	call   80100380 <panic>
8010027b:	66 90                	xchg   %ax,%ax
8010027d:	66 90                	xchg   %ax,%ax
8010027f:	90                   	nop

80100280 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100280:	55                   	push   %ebp
80100281:	89 e5                	mov    %esp,%ebp
80100283:	57                   	push   %edi
80100284:	56                   	push   %esi
80100285:	53                   	push   %ebx
80100286:	83 ec 18             	sub    $0x18,%esp
80100289:	8b 5d 10             	mov    0x10(%ebp),%ebx
8010028c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010028f:	ff 75 08             	push   0x8(%ebp)
  target = n;
80100292:	89 df                	mov    %ebx,%edi
  iunlock(ip);
80100294:	e8 f7 15 00 00       	call   80101890 <iunlock>
  acquire(&cons.lock);
80100299:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801002a0:	e8 bb 4e 00 00       	call   80105160 <acquire>
  while(n > 0){
801002a5:	83 c4 10             	add    $0x10,%esp
801002a8:	85 db                	test   %ebx,%ebx
801002aa:	0f 8e 94 00 00 00    	jle    80100344 <consoleread+0xc4>
    while(input.r == input.w){
801002b0:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801002b5:	39 05 04 ff 10 80    	cmp    %eax,0x8010ff04
801002bb:	74 25                	je     801002e2 <consoleread+0x62>
801002bd:	eb 59                	jmp    80100318 <consoleread+0x98>
801002bf:	90                   	nop
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002c0:	83 ec 08             	sub    $0x8,%esp
801002c3:	68 20 ff 10 80       	push   $0x8010ff20
801002c8:	68 00 ff 10 80       	push   $0x8010ff00
801002cd:	e8 ae 46 00 00       	call   80104980 <sleep>
    while(input.r == input.w){
801002d2:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801002d7:	83 c4 10             	add    $0x10,%esp
801002da:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
801002e0:	75 36                	jne    80100318 <consoleread+0x98>
      if(myproc()->killed){
801002e2:	e8 f9 37 00 00       	call   80103ae0 <myproc>
801002e7:	8b 48 24             	mov    0x24(%eax),%ecx
801002ea:	85 c9                	test   %ecx,%ecx
801002ec:	74 d2                	je     801002c0 <consoleread+0x40>
        release(&cons.lock);
801002ee:	83 ec 0c             	sub    $0xc,%esp
801002f1:	68 20 ff 10 80       	push   $0x8010ff20
801002f6:	e8 05 4e 00 00       	call   80105100 <release>
        ilock(ip);
801002fb:	5a                   	pop    %edx
801002fc:	ff 75 08             	push   0x8(%ebp)
801002ff:	e8 ac 14 00 00       	call   801017b0 <ilock>
        return -1;
80100304:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
80100307:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
8010030a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010030f:	5b                   	pop    %ebx
80100310:	5e                   	pop    %esi
80100311:	5f                   	pop    %edi
80100312:	5d                   	pop    %ebp
80100313:	c3                   	ret
80100314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100318:	8d 50 01             	lea    0x1(%eax),%edx
8010031b:	89 15 00 ff 10 80    	mov    %edx,0x8010ff00
80100321:	89 c2                	mov    %eax,%edx
80100323:	83 e2 7f             	and    $0x7f,%edx
80100326:	0f be 8a 80 fe 10 80 	movsbl -0x7fef0180(%edx),%ecx
    if(c == C('D')){  // EOF
8010032d:	80 f9 04             	cmp    $0x4,%cl
80100330:	74 37                	je     80100369 <consoleread+0xe9>
    *dst++ = c;
80100332:	83 c6 01             	add    $0x1,%esi
    --n;
80100335:	83 eb 01             	sub    $0x1,%ebx
    *dst++ = c;
80100338:	88 4e ff             	mov    %cl,-0x1(%esi)
    if(c == '\n')
8010033b:	83 f9 0a             	cmp    $0xa,%ecx
8010033e:	0f 85 64 ff ff ff    	jne    801002a8 <consoleread+0x28>
  release(&cons.lock);
80100344:	83 ec 0c             	sub    $0xc,%esp
80100347:	68 20 ff 10 80       	push   $0x8010ff20
8010034c:	e8 af 4d 00 00       	call   80105100 <release>
  ilock(ip);
80100351:	58                   	pop    %eax
80100352:	ff 75 08             	push   0x8(%ebp)
80100355:	e8 56 14 00 00       	call   801017b0 <ilock>
  return target - n;
8010035a:	89 f8                	mov    %edi,%eax
8010035c:	83 c4 10             	add    $0x10,%esp
}
8010035f:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return target - n;
80100362:	29 d8                	sub    %ebx,%eax
}
80100364:	5b                   	pop    %ebx
80100365:	5e                   	pop    %esi
80100366:	5f                   	pop    %edi
80100367:	5d                   	pop    %ebp
80100368:	c3                   	ret
      if(n < target){
80100369:	39 fb                	cmp    %edi,%ebx
8010036b:	73 d7                	jae    80100344 <consoleread+0xc4>
        input.r--;
8010036d:	a3 00 ff 10 80       	mov    %eax,0x8010ff00
80100372:	eb d0                	jmp    80100344 <consoleread+0xc4>
80100374:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010037b:	00 
8010037c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100380 <panic>:
{
80100380:	55                   	push   %ebp
80100381:	89 e5                	mov    %esp,%ebp
80100383:	56                   	push   %esi
80100384:	53                   	push   %ebx
80100385:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100388:	fa                   	cli
  cons.locking = 0;
80100389:	c7 05 54 ff 10 80 00 	movl   $0x0,0x8010ff54
80100390:	00 00 00 
  getcallerpcs(&s, pcs);
80100393:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100396:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
80100399:	e8 42 25 00 00       	call   801028e0 <lapicid>
8010039e:	83 ec 08             	sub    $0x8,%esp
801003a1:	50                   	push   %eax
801003a2:	68 2d 7e 10 80       	push   $0x80107e2d
801003a7:	e8 04 03 00 00       	call   801006b0 <cprintf>
  cprintf(s);
801003ac:	58                   	pop    %eax
801003ad:	ff 75 08             	push   0x8(%ebp)
801003b0:	e8 fb 02 00 00       	call   801006b0 <cprintf>
  cprintf("\n");
801003b5:	c7 04 24 f5 82 10 80 	movl   $0x801082f5,(%esp)
801003bc:	e8 ef 02 00 00       	call   801006b0 <cprintf>
  getcallerpcs(&s, pcs);
801003c1:	8d 45 08             	lea    0x8(%ebp),%eax
801003c4:	5a                   	pop    %edx
801003c5:	59                   	pop    %ecx
801003c6:	53                   	push   %ebx
801003c7:	50                   	push   %eax
801003c8:	e8 c3 4b 00 00       	call   80104f90 <getcallerpcs>
  for(i=0; i<10; i++)
801003cd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003d0:	83 ec 08             	sub    $0x8,%esp
801003d3:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
801003d5:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
801003d8:	68 41 7e 10 80       	push   $0x80107e41
801003dd:	e8 ce 02 00 00       	call   801006b0 <cprintf>
  for(i=0; i<10; i++)
801003e2:	83 c4 10             	add    $0x10,%esp
801003e5:	39 f3                	cmp    %esi,%ebx
801003e7:	75 e7                	jne    801003d0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003e9:	c7 05 58 ff 10 80 01 	movl   $0x1,0x8010ff58
801003f0:	00 00 00 
  for(;;)
801003f3:	eb fe                	jmp    801003f3 <panic+0x73>
801003f5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801003fc:	00 
801003fd:	8d 76 00             	lea    0x0(%esi),%esi

80100400 <consputc.part.0>:
consputc(int c)
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	57                   	push   %edi
80100404:	56                   	push   %esi
80100405:	53                   	push   %ebx
80100406:	83 ec 1c             	sub    $0x1c,%esp
  if(c == BACKSPACE){
80100409:	3d 00 01 00 00       	cmp    $0x100,%eax
8010040e:	0f 84 cc 00 00 00    	je     801004e0 <consputc.part.0+0xe0>
    uartputc(c);
80100414:	83 ec 0c             	sub    $0xc,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100417:	bf d4 03 00 00       	mov    $0x3d4,%edi
8010041c:	89 c3                	mov    %eax,%ebx
8010041e:	50                   	push   %eax
8010041f:	e8 2c 65 00 00       	call   80106950 <uartputc>
80100424:	b8 0e 00 00 00       	mov    $0xe,%eax
80100429:	89 fa                	mov    %edi,%edx
8010042b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010042c:	be d5 03 00 00       	mov    $0x3d5,%esi
80100431:	89 f2                	mov    %esi,%edx
80100433:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100434:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100437:	89 fa                	mov    %edi,%edx
80100439:	b8 0f 00 00 00       	mov    $0xf,%eax
8010043e:	c1 e1 08             	shl    $0x8,%ecx
80100441:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100442:	89 f2                	mov    %esi,%edx
80100444:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100445:	0f b6 c0             	movzbl %al,%eax
  if(c == '\n')
80100448:	83 c4 10             	add    $0x10,%esp
  pos |= inb(CRTPORT+1);
8010044b:	09 c8                	or     %ecx,%eax
  if(c == '\n')
8010044d:	83 fb 0a             	cmp    $0xa,%ebx
80100450:	75 76                	jne    801004c8 <consputc.part.0+0xc8>
    pos += 80 - pos%80;
80100452:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
80100457:	f7 e2                	mul    %edx
80100459:	c1 ea 06             	shr    $0x6,%edx
8010045c:	8d 04 92             	lea    (%edx,%edx,4),%eax
8010045f:	c1 e0 04             	shl    $0x4,%eax
80100462:	8d 70 50             	lea    0x50(%eax),%esi
  if(pos < 0 || pos > 25*80)
80100465:	81 fe d0 07 00 00    	cmp    $0x7d0,%esi
8010046b:	0f 8f 2f 01 00 00    	jg     801005a0 <consputc.part.0+0x1a0>
  if((pos/80) >= 24){  // Scroll up.
80100471:	81 fe 7f 07 00 00    	cmp    $0x77f,%esi
80100477:	0f 8f c3 00 00 00    	jg     80100540 <consputc.part.0+0x140>
  outb(CRTPORT+1, pos>>8);
8010047d:	89 f0                	mov    %esi,%eax
  crt[pos] = ' ' | 0x0700;
8010047f:	8d b4 36 00 80 0b 80 	lea    -0x7ff48000(%esi,%esi,1),%esi
  outb(CRTPORT+1, pos);
80100486:	88 45 e7             	mov    %al,-0x19(%ebp)
  outb(CRTPORT+1, pos>>8);
80100489:	0f b6 fc             	movzbl %ah,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010048c:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100491:	b8 0e 00 00 00       	mov    $0xe,%eax
80100496:	89 da                	mov    %ebx,%edx
80100498:	ee                   	out    %al,(%dx)
80100499:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
8010049e:	89 f8                	mov    %edi,%eax
801004a0:	89 ca                	mov    %ecx,%edx
801004a2:	ee                   	out    %al,(%dx)
801004a3:	b8 0f 00 00 00       	mov    $0xf,%eax
801004a8:	89 da                	mov    %ebx,%edx
801004aa:	ee                   	out    %al,(%dx)
801004ab:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801004af:	89 ca                	mov    %ecx,%edx
801004b1:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004b2:	b8 20 07 00 00       	mov    $0x720,%eax
801004b7:	66 89 06             	mov    %ax,(%esi)
}
801004ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004bd:	5b                   	pop    %ebx
801004be:	5e                   	pop    %esi
801004bf:	5f                   	pop    %edi
801004c0:	5d                   	pop    %ebp
801004c1:	c3                   	ret
801004c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
801004c8:	0f b6 db             	movzbl %bl,%ebx
801004cb:	8d 70 01             	lea    0x1(%eax),%esi
801004ce:	80 cf 07             	or     $0x7,%bh
801004d1:	66 89 9c 00 00 80 0b 	mov    %bx,-0x7ff48000(%eax,%eax,1)
801004d8:	80 
801004d9:	eb 8a                	jmp    80100465 <consputc.part.0+0x65>
801004db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004e0:	83 ec 0c             	sub    $0xc,%esp
801004e3:	be d4 03 00 00       	mov    $0x3d4,%esi
801004e8:	6a 08                	push   $0x8
801004ea:	e8 61 64 00 00       	call   80106950 <uartputc>
801004ef:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f6:	e8 55 64 00 00       	call   80106950 <uartputc>
801004fb:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100502:	e8 49 64 00 00       	call   80106950 <uartputc>
80100507:	b8 0e 00 00 00       	mov    $0xe,%eax
8010050c:	89 f2                	mov    %esi,%edx
8010050e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010050f:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100514:	89 da                	mov    %ebx,%edx
80100516:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100517:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010051a:	89 f2                	mov    %esi,%edx
8010051c:	b8 0f 00 00 00       	mov    $0xf,%eax
80100521:	c1 e1 08             	shl    $0x8,%ecx
80100524:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100525:	89 da                	mov    %ebx,%edx
80100527:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100528:	0f b6 f0             	movzbl %al,%esi
    if(pos > 0) --pos;
8010052b:	83 c4 10             	add    $0x10,%esp
8010052e:	09 ce                	or     %ecx,%esi
80100530:	74 5e                	je     80100590 <consputc.part.0+0x190>
80100532:	83 ee 01             	sub    $0x1,%esi
80100535:	e9 2b ff ff ff       	jmp    80100465 <consputc.part.0+0x65>
8010053a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100540:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
80100543:	8d 5e b0             	lea    -0x50(%esi),%ebx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100546:	8d b4 36 60 7f 0b 80 	lea    -0x7ff480a0(%esi,%esi,1),%esi
  outb(CRTPORT+1, pos);
8010054d:	bf 07 00 00 00       	mov    $0x7,%edi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100552:	68 60 0e 00 00       	push   $0xe60
80100557:	68 a0 80 0b 80       	push   $0x800b80a0
8010055c:	68 00 80 0b 80       	push   $0x800b8000
80100561:	e8 8a 4d 00 00       	call   801052f0 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100566:	b8 80 07 00 00       	mov    $0x780,%eax
8010056b:	83 c4 0c             	add    $0xc,%esp
8010056e:	29 d8                	sub    %ebx,%eax
80100570:	01 c0                	add    %eax,%eax
80100572:	50                   	push   %eax
80100573:	6a 00                	push   $0x0
80100575:	56                   	push   %esi
80100576:	e8 e5 4c 00 00       	call   80105260 <memset>
  outb(CRTPORT+1, pos);
8010057b:	88 5d e7             	mov    %bl,-0x19(%ebp)
8010057e:	83 c4 10             	add    $0x10,%esp
80100581:	e9 06 ff ff ff       	jmp    8010048c <consputc.part.0+0x8c>
80100586:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010058d:	00 
8010058e:	66 90                	xchg   %ax,%ax
80100590:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
80100594:	be 00 80 0b 80       	mov    $0x800b8000,%esi
80100599:	31 ff                	xor    %edi,%edi
8010059b:	e9 ec fe ff ff       	jmp    8010048c <consputc.part.0+0x8c>
    panic("pos under/overflow");
801005a0:	83 ec 0c             	sub    $0xc,%esp
801005a3:	68 45 7e 10 80       	push   $0x80107e45
801005a8:	e8 d3 fd ff ff       	call   80100380 <panic>
801005ad:	8d 76 00             	lea    0x0(%esi),%esi

801005b0 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
801005b0:	55                   	push   %ebp
801005b1:	89 e5                	mov    %esp,%ebp
801005b3:	57                   	push   %edi
801005b4:	56                   	push   %esi
801005b5:	53                   	push   %ebx
801005b6:	83 ec 18             	sub    $0x18,%esp
801005b9:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
801005bc:	ff 75 08             	push   0x8(%ebp)
801005bf:	e8 cc 12 00 00       	call   80101890 <iunlock>
  acquire(&cons.lock);
801005c4:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801005cb:	e8 90 4b 00 00       	call   80105160 <acquire>
  for(i = 0; i < n; i++)
801005d0:	83 c4 10             	add    $0x10,%esp
801005d3:	85 f6                	test   %esi,%esi
801005d5:	7e 25                	jle    801005fc <consolewrite+0x4c>
801005d7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801005da:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
  if(panicked){
801005dd:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
    consputc(buf[i] & 0xff);
801005e3:	0f b6 03             	movzbl (%ebx),%eax
  if(panicked){
801005e6:	85 d2                	test   %edx,%edx
801005e8:	74 06                	je     801005f0 <consolewrite+0x40>
  asm volatile("cli");
801005ea:	fa                   	cli
    for(;;)
801005eb:	eb fe                	jmp    801005eb <consolewrite+0x3b>
801005ed:	8d 76 00             	lea    0x0(%esi),%esi
801005f0:	e8 0b fe ff ff       	call   80100400 <consputc.part.0>
  for(i = 0; i < n; i++)
801005f5:	83 c3 01             	add    $0x1,%ebx
801005f8:	39 fb                	cmp    %edi,%ebx
801005fa:	75 e1                	jne    801005dd <consolewrite+0x2d>
  release(&cons.lock);
801005fc:	83 ec 0c             	sub    $0xc,%esp
801005ff:	68 20 ff 10 80       	push   $0x8010ff20
80100604:	e8 f7 4a 00 00       	call   80105100 <release>
  ilock(ip);
80100609:	58                   	pop    %eax
8010060a:	ff 75 08             	push   0x8(%ebp)
8010060d:	e8 9e 11 00 00       	call   801017b0 <ilock>

  return n;
}
80100612:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100615:	89 f0                	mov    %esi,%eax
80100617:	5b                   	pop    %ebx
80100618:	5e                   	pop    %esi
80100619:	5f                   	pop    %edi
8010061a:	5d                   	pop    %ebp
8010061b:	c3                   	ret
8010061c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100620 <printint>:
{
80100620:	55                   	push   %ebp
80100621:	89 e5                	mov    %esp,%ebp
80100623:	57                   	push   %edi
80100624:	56                   	push   %esi
80100625:	53                   	push   %ebx
80100626:	89 d3                	mov    %edx,%ebx
80100628:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010062b:	85 c0                	test   %eax,%eax
8010062d:	79 05                	jns    80100634 <printint+0x14>
8010062f:	83 e1 01             	and    $0x1,%ecx
80100632:	75 64                	jne    80100698 <printint+0x78>
    x = xx;
80100634:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
8010063b:	89 c1                	mov    %eax,%ecx
  i = 0;
8010063d:	31 f6                	xor    %esi,%esi
8010063f:	90                   	nop
    buf[i++] = digits[x % base];
80100640:	89 c8                	mov    %ecx,%eax
80100642:	31 d2                	xor    %edx,%edx
80100644:	89 f7                	mov    %esi,%edi
80100646:	f7 f3                	div    %ebx
80100648:	8d 76 01             	lea    0x1(%esi),%esi
8010064b:	0f b6 92 48 83 10 80 	movzbl -0x7fef7cb8(%edx),%edx
80100652:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
80100656:	89 ca                	mov    %ecx,%edx
80100658:	89 c1                	mov    %eax,%ecx
8010065a:	39 da                	cmp    %ebx,%edx
8010065c:	73 e2                	jae    80100640 <printint+0x20>
  if(sign)
8010065e:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
80100661:	85 c9                	test   %ecx,%ecx
80100663:	74 07                	je     8010066c <printint+0x4c>
    buf[i++] = '-';
80100665:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
  while(--i >= 0)
8010066a:	89 f7                	mov    %esi,%edi
8010066c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
8010066f:	01 df                	add    %ebx,%edi
  if(panicked){
80100671:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
    consputc(buf[i]);
80100677:	0f be 07             	movsbl (%edi),%eax
  if(panicked){
8010067a:	85 d2                	test   %edx,%edx
8010067c:	74 0a                	je     80100688 <printint+0x68>
8010067e:	fa                   	cli
    for(;;)
8010067f:	eb fe                	jmp    8010067f <printint+0x5f>
80100681:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100688:	e8 73 fd ff ff       	call   80100400 <consputc.part.0>
  while(--i >= 0)
8010068d:	8d 47 ff             	lea    -0x1(%edi),%eax
80100690:	39 df                	cmp    %ebx,%edi
80100692:	74 11                	je     801006a5 <printint+0x85>
80100694:	89 c7                	mov    %eax,%edi
80100696:	eb d9                	jmp    80100671 <printint+0x51>
    x = -xx;
80100698:	f7 d8                	neg    %eax
  if(sign && (sign = xx < 0))
8010069a:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
    x = -xx;
801006a1:	89 c1                	mov    %eax,%ecx
801006a3:	eb 98                	jmp    8010063d <printint+0x1d>
}
801006a5:	83 c4 2c             	add    $0x2c,%esp
801006a8:	5b                   	pop    %ebx
801006a9:	5e                   	pop    %esi
801006aa:	5f                   	pop    %edi
801006ab:	5d                   	pop    %ebp
801006ac:	c3                   	ret
801006ad:	8d 76 00             	lea    0x0(%esi),%esi

801006b0 <cprintf>:
{
801006b0:	55                   	push   %ebp
801006b1:	89 e5                	mov    %esp,%ebp
801006b3:	57                   	push   %edi
801006b4:	56                   	push   %esi
801006b5:	53                   	push   %ebx
801006b6:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
801006b9:	8b 3d 54 ff 10 80    	mov    0x8010ff54,%edi
  if (fmt == 0)
801006bf:	8b 75 08             	mov    0x8(%ebp),%esi
  if(locking)
801006c2:	85 ff                	test   %edi,%edi
801006c4:	0f 85 06 01 00 00    	jne    801007d0 <cprintf+0x120>
  if (fmt == 0)
801006ca:	85 f6                	test   %esi,%esi
801006cc:	0f 84 b7 01 00 00    	je     80100889 <cprintf+0x1d9>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006d2:	0f b6 06             	movzbl (%esi),%eax
801006d5:	85 c0                	test   %eax,%eax
801006d7:	74 5f                	je     80100738 <cprintf+0x88>
  argp = (uint*)(void*)(&fmt + 1);
801006d9:	8d 55 0c             	lea    0xc(%ebp),%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006dc:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801006df:	31 db                	xor    %ebx,%ebx
801006e1:	89 d7                	mov    %edx,%edi
    if(c != '%'){
801006e3:	83 f8 25             	cmp    $0x25,%eax
801006e6:	75 58                	jne    80100740 <cprintf+0x90>
    c = fmt[++i] & 0xff;
801006e8:	83 c3 01             	add    $0x1,%ebx
801006eb:	0f b6 0c 1e          	movzbl (%esi,%ebx,1),%ecx
    if(c == 0)
801006ef:	85 c9                	test   %ecx,%ecx
801006f1:	74 3a                	je     8010072d <cprintf+0x7d>
    switch(c){
801006f3:	83 f9 70             	cmp    $0x70,%ecx
801006f6:	0f 84 b4 00 00 00    	je     801007b0 <cprintf+0x100>
801006fc:	7f 72                	jg     80100770 <cprintf+0xc0>
801006fe:	83 f9 25             	cmp    $0x25,%ecx
80100701:	74 4d                	je     80100750 <cprintf+0xa0>
80100703:	83 f9 64             	cmp    $0x64,%ecx
80100706:	75 76                	jne    8010077e <cprintf+0xce>
      printint(*argp++, 10, 1);
80100708:	8d 47 04             	lea    0x4(%edi),%eax
8010070b:	b9 01 00 00 00       	mov    $0x1,%ecx
80100710:	ba 0a 00 00 00       	mov    $0xa,%edx
80100715:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100718:	8b 07                	mov    (%edi),%eax
8010071a:	e8 01 ff ff ff       	call   80100620 <printint>
8010071f:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100722:	83 c3 01             	add    $0x1,%ebx
80100725:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100729:	85 c0                	test   %eax,%eax
8010072b:	75 b6                	jne    801006e3 <cprintf+0x33>
8010072d:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  if(locking)
80100730:	85 ff                	test   %edi,%edi
80100732:	0f 85 bb 00 00 00    	jne    801007f3 <cprintf+0x143>
}
80100738:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010073b:	5b                   	pop    %ebx
8010073c:	5e                   	pop    %esi
8010073d:	5f                   	pop    %edi
8010073e:	5d                   	pop    %ebp
8010073f:	c3                   	ret
  if(panicked){
80100740:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
80100746:	85 c9                	test   %ecx,%ecx
80100748:	74 19                	je     80100763 <cprintf+0xb3>
8010074a:	fa                   	cli
    for(;;)
8010074b:	eb fe                	jmp    8010074b <cprintf+0x9b>
8010074d:	8d 76 00             	lea    0x0(%esi),%esi
  if(panicked){
80100750:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
80100756:	85 c9                	test   %ecx,%ecx
80100758:	0f 85 f2 00 00 00    	jne    80100850 <cprintf+0x1a0>
8010075e:	b8 25 00 00 00       	mov    $0x25,%eax
80100763:	e8 98 fc ff ff       	call   80100400 <consputc.part.0>
      break;
80100768:	eb b8                	jmp    80100722 <cprintf+0x72>
8010076a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    switch(c){
80100770:	83 f9 73             	cmp    $0x73,%ecx
80100773:	0f 84 8f 00 00 00    	je     80100808 <cprintf+0x158>
80100779:	83 f9 78             	cmp    $0x78,%ecx
8010077c:	74 32                	je     801007b0 <cprintf+0x100>
  if(panicked){
8010077e:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
80100784:	85 d2                	test   %edx,%edx
80100786:	0f 85 b8 00 00 00    	jne    80100844 <cprintf+0x194>
8010078c:	b8 25 00 00 00       	mov    $0x25,%eax
80100791:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100794:	e8 67 fc ff ff       	call   80100400 <consputc.part.0>
80100799:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
8010079e:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801007a1:	85 c0                	test   %eax,%eax
801007a3:	0f 84 cd 00 00 00    	je     80100876 <cprintf+0x1c6>
801007a9:	fa                   	cli
    for(;;)
801007aa:	eb fe                	jmp    801007aa <cprintf+0xfa>
801007ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      printint(*argp++, 16, 0);
801007b0:	8d 47 04             	lea    0x4(%edi),%eax
801007b3:	31 c9                	xor    %ecx,%ecx
801007b5:	ba 10 00 00 00       	mov    $0x10,%edx
801007ba:	89 45 e0             	mov    %eax,-0x20(%ebp)
801007bd:	8b 07                	mov    (%edi),%eax
801007bf:	e8 5c fe ff ff       	call   80100620 <printint>
801007c4:	8b 7d e0             	mov    -0x20(%ebp),%edi
      break;
801007c7:	e9 56 ff ff ff       	jmp    80100722 <cprintf+0x72>
801007cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007d0:	83 ec 0c             	sub    $0xc,%esp
801007d3:	68 20 ff 10 80       	push   $0x8010ff20
801007d8:	e8 83 49 00 00       	call   80105160 <acquire>
  if (fmt == 0)
801007dd:	83 c4 10             	add    $0x10,%esp
801007e0:	85 f6                	test   %esi,%esi
801007e2:	0f 84 a1 00 00 00    	je     80100889 <cprintf+0x1d9>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007e8:	0f b6 06             	movzbl (%esi),%eax
801007eb:	85 c0                	test   %eax,%eax
801007ed:	0f 85 e6 fe ff ff    	jne    801006d9 <cprintf+0x29>
    release(&cons.lock);
801007f3:	83 ec 0c             	sub    $0xc,%esp
801007f6:	68 20 ff 10 80       	push   $0x8010ff20
801007fb:	e8 00 49 00 00       	call   80105100 <release>
80100800:	83 c4 10             	add    $0x10,%esp
80100803:	e9 30 ff ff ff       	jmp    80100738 <cprintf+0x88>
      if((s = (char*)*argp++) == 0)
80100808:	8b 17                	mov    (%edi),%edx
8010080a:	8d 47 04             	lea    0x4(%edi),%eax
8010080d:	85 d2                	test   %edx,%edx
8010080f:	74 27                	je     80100838 <cprintf+0x188>
      for(; *s; s++)
80100811:	0f b6 0a             	movzbl (%edx),%ecx
      if((s = (char*)*argp++) == 0)
80100814:	89 d7                	mov    %edx,%edi
      for(; *s; s++)
80100816:	84 c9                	test   %cl,%cl
80100818:	74 68                	je     80100882 <cprintf+0x1d2>
8010081a:	89 5d e0             	mov    %ebx,-0x20(%ebp)
8010081d:	89 fb                	mov    %edi,%ebx
8010081f:	89 f7                	mov    %esi,%edi
80100821:	89 c6                	mov    %eax,%esi
80100823:	0f be c1             	movsbl %cl,%eax
  if(panicked){
80100826:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
8010082c:	85 d2                	test   %edx,%edx
8010082e:	74 28                	je     80100858 <cprintf+0x1a8>
80100830:	fa                   	cli
    for(;;)
80100831:	eb fe                	jmp    80100831 <cprintf+0x181>
80100833:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80100838:	b9 28 00 00 00       	mov    $0x28,%ecx
        s = "(null)";
8010083d:	bf 58 7e 10 80       	mov    $0x80107e58,%edi
80100842:	eb d6                	jmp    8010081a <cprintf+0x16a>
80100844:	fa                   	cli
    for(;;)
80100845:	eb fe                	jmp    80100845 <cprintf+0x195>
80100847:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010084e:	00 
8010084f:	90                   	nop
80100850:	fa                   	cli
80100851:	eb fe                	jmp    80100851 <cprintf+0x1a1>
80100853:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80100858:	e8 a3 fb ff ff       	call   80100400 <consputc.part.0>
      for(; *s; s++)
8010085d:	0f be 43 01          	movsbl 0x1(%ebx),%eax
80100861:	83 c3 01             	add    $0x1,%ebx
80100864:	84 c0                	test   %al,%al
80100866:	75 be                	jne    80100826 <cprintf+0x176>
      if((s = (char*)*argp++) == 0)
80100868:	89 f0                	mov    %esi,%eax
8010086a:	8b 5d e0             	mov    -0x20(%ebp),%ebx
8010086d:	89 fe                	mov    %edi,%esi
8010086f:	89 c7                	mov    %eax,%edi
80100871:	e9 ac fe ff ff       	jmp    80100722 <cprintf+0x72>
80100876:	89 c8                	mov    %ecx,%eax
80100878:	e8 83 fb ff ff       	call   80100400 <consputc.part.0>
      break;
8010087d:	e9 a0 fe ff ff       	jmp    80100722 <cprintf+0x72>
      if((s = (char*)*argp++) == 0)
80100882:	89 c7                	mov    %eax,%edi
80100884:	e9 99 fe ff ff       	jmp    80100722 <cprintf+0x72>
    panic("null fmt");
80100889:	83 ec 0c             	sub    $0xc,%esp
8010088c:	68 5f 7e 10 80       	push   $0x80107e5f
80100891:	e8 ea fa ff ff       	call   80100380 <panic>
80100896:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010089d:	00 
8010089e:	66 90                	xchg   %ax,%ax

801008a0 <consoleintr>:
{
801008a0:	55                   	push   %ebp
801008a1:	89 e5                	mov    %esp,%ebp
801008a3:	57                   	push   %edi
  int c, doprocdump = 0;
801008a4:	31 ff                	xor    %edi,%edi
{
801008a6:	56                   	push   %esi
801008a7:	53                   	push   %ebx
801008a8:	83 ec 18             	sub    $0x18,%esp
801008ab:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&cons.lock);
801008ae:	68 20 ff 10 80       	push   $0x8010ff20
801008b3:	e8 a8 48 00 00       	call   80105160 <acquire>
  while((c = getc()) >= 0){
801008b8:	83 c4 10             	add    $0x10,%esp
801008bb:	ff d6                	call   *%esi
801008bd:	89 c3                	mov    %eax,%ebx
801008bf:	85 c0                	test   %eax,%eax
801008c1:	78 22                	js     801008e5 <consoleintr+0x45>
    switch(c){
801008c3:	83 fb 15             	cmp    $0x15,%ebx
801008c6:	74 47                	je     8010090f <consoleintr+0x6f>
801008c8:	7f 76                	jg     80100940 <consoleintr+0xa0>
801008ca:	83 fb 08             	cmp    $0x8,%ebx
801008cd:	74 76                	je     80100945 <consoleintr+0xa5>
801008cf:	83 fb 10             	cmp    $0x10,%ebx
801008d2:	0f 85 f8 00 00 00    	jne    801009d0 <consoleintr+0x130>
  while((c = getc()) >= 0){
801008d8:	ff d6                	call   *%esi
    switch(c){
801008da:	bf 01 00 00 00       	mov    $0x1,%edi
  while((c = getc()) >= 0){
801008df:	89 c3                	mov    %eax,%ebx
801008e1:	85 c0                	test   %eax,%eax
801008e3:	79 de                	jns    801008c3 <consoleintr+0x23>
  release(&cons.lock);
801008e5:	83 ec 0c             	sub    $0xc,%esp
801008e8:	68 20 ff 10 80       	push   $0x8010ff20
801008ed:	e8 0e 48 00 00       	call   80105100 <release>
  if(doprocdump) {
801008f2:	83 c4 10             	add    $0x10,%esp
801008f5:	85 ff                	test   %edi,%edi
801008f7:	0f 85 4b 01 00 00    	jne    80100a48 <consoleintr+0x1a8>
}
801008fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100900:	5b                   	pop    %ebx
80100901:	5e                   	pop    %esi
80100902:	5f                   	pop    %edi
80100903:	5d                   	pop    %ebp
80100904:	c3                   	ret
80100905:	b8 00 01 00 00       	mov    $0x100,%eax
8010090a:	e8 f1 fa ff ff       	call   80100400 <consputc.part.0>
      while(input.e != input.w &&
8010090f:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80100914:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
8010091a:	74 9f                	je     801008bb <consoleintr+0x1b>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
8010091c:	83 e8 01             	sub    $0x1,%eax
8010091f:	89 c2                	mov    %eax,%edx
80100921:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100924:	80 ba 80 fe 10 80 0a 	cmpb   $0xa,-0x7fef0180(%edx)
8010092b:	74 8e                	je     801008bb <consoleintr+0x1b>
  if(panicked){
8010092d:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
        input.e--;
80100933:	a3 08 ff 10 80       	mov    %eax,0x8010ff08
  if(panicked){
80100938:	85 d2                	test   %edx,%edx
8010093a:	74 c9                	je     80100905 <consoleintr+0x65>
8010093c:	fa                   	cli
    for(;;)
8010093d:	eb fe                	jmp    8010093d <consoleintr+0x9d>
8010093f:	90                   	nop
    switch(c){
80100940:	83 fb 7f             	cmp    $0x7f,%ebx
80100943:	75 2b                	jne    80100970 <consoleintr+0xd0>
      if(input.e != input.w){
80100945:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
8010094a:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
80100950:	0f 84 65 ff ff ff    	je     801008bb <consoleintr+0x1b>
        input.e--;
80100956:	83 e8 01             	sub    $0x1,%eax
80100959:	a3 08 ff 10 80       	mov    %eax,0x8010ff08
  if(panicked){
8010095e:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
80100963:	85 c0                	test   %eax,%eax
80100965:	0f 84 ce 00 00 00    	je     80100a39 <consoleintr+0x199>
8010096b:	fa                   	cli
    for(;;)
8010096c:	eb fe                	jmp    8010096c <consoleintr+0xcc>
8010096e:	66 90                	xchg   %ax,%ax
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100970:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80100975:	89 c2                	mov    %eax,%edx
80100977:	2b 15 00 ff 10 80    	sub    0x8010ff00,%edx
8010097d:	83 fa 7f             	cmp    $0x7f,%edx
80100980:	0f 87 35 ff ff ff    	ja     801008bb <consoleintr+0x1b>
  if(panicked){
80100986:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
        input.buf[input.e++ % INPUT_BUF] = c;
8010098c:	8d 50 01             	lea    0x1(%eax),%edx
8010098f:	83 e0 7f             	and    $0x7f,%eax
80100992:	89 15 08 ff 10 80    	mov    %edx,0x8010ff08
80100998:	88 98 80 fe 10 80    	mov    %bl,-0x7fef0180(%eax)
  if(panicked){
8010099e:	85 c9                	test   %ecx,%ecx
801009a0:	0f 85 ae 00 00 00    	jne    80100a54 <consoleintr+0x1b4>
801009a6:	89 d8                	mov    %ebx,%eax
801009a8:	e8 53 fa ff ff       	call   80100400 <consputc.part.0>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801009ad:	83 fb 0a             	cmp    $0xa,%ebx
801009b0:	74 68                	je     80100a1a <consoleintr+0x17a>
801009b2:	83 fb 04             	cmp    $0x4,%ebx
801009b5:	74 63                	je     80100a1a <consoleintr+0x17a>
801009b7:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801009bc:	83 e8 80             	sub    $0xffffff80,%eax
801009bf:	39 05 08 ff 10 80    	cmp    %eax,0x8010ff08
801009c5:	0f 85 f0 fe ff ff    	jne    801008bb <consoleintr+0x1b>
801009cb:	eb 52                	jmp    80100a1f <consoleintr+0x17f>
801009cd:	8d 76 00             	lea    0x0(%esi),%esi
      if(c != 0 && input.e-input.r < INPUT_BUF){
801009d0:	85 db                	test   %ebx,%ebx
801009d2:	0f 84 e3 fe ff ff    	je     801008bb <consoleintr+0x1b>
801009d8:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
801009dd:	89 c2                	mov    %eax,%edx
801009df:	2b 15 00 ff 10 80    	sub    0x8010ff00,%edx
801009e5:	83 fa 7f             	cmp    $0x7f,%edx
801009e8:	0f 87 cd fe ff ff    	ja     801008bb <consoleintr+0x1b>
        input.buf[input.e++ % INPUT_BUF] = c;
801009ee:	8d 50 01             	lea    0x1(%eax),%edx
  if(panicked){
801009f1:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
        input.buf[input.e++ % INPUT_BUF] = c;
801009f7:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
801009fa:	83 fb 0d             	cmp    $0xd,%ebx
801009fd:	75 93                	jne    80100992 <consoleintr+0xf2>
        input.buf[input.e++ % INPUT_BUF] = c;
801009ff:	89 15 08 ff 10 80    	mov    %edx,0x8010ff08
80100a05:	c6 80 80 fe 10 80 0a 	movb   $0xa,-0x7fef0180(%eax)
  if(panicked){
80100a0c:	85 c9                	test   %ecx,%ecx
80100a0e:	75 44                	jne    80100a54 <consoleintr+0x1b4>
80100a10:	b8 0a 00 00 00       	mov    $0xa,%eax
80100a15:	e8 e6 f9 ff ff       	call   80100400 <consputc.part.0>
          input.w = input.e;
80100a1a:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
          wakeup(&input.r);
80100a1f:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
80100a22:	a3 04 ff 10 80       	mov    %eax,0x8010ff04
          wakeup(&input.r);
80100a27:	68 00 ff 10 80       	push   $0x8010ff00
80100a2c:	e8 0f 40 00 00       	call   80104a40 <wakeup>
80100a31:	83 c4 10             	add    $0x10,%esp
80100a34:	e9 82 fe ff ff       	jmp    801008bb <consoleintr+0x1b>
80100a39:	b8 00 01 00 00       	mov    $0x100,%eax
80100a3e:	e8 bd f9 ff ff       	call   80100400 <consputc.part.0>
80100a43:	e9 73 fe ff ff       	jmp    801008bb <consoleintr+0x1b>
}
80100a48:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a4b:	5b                   	pop    %ebx
80100a4c:	5e                   	pop    %esi
80100a4d:	5f                   	pop    %edi
80100a4e:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100a4f:	e9 cc 40 00 00       	jmp    80104b20 <procdump>
80100a54:	fa                   	cli
    for(;;)
80100a55:	eb fe                	jmp    80100a55 <consoleintr+0x1b5>
80100a57:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100a5e:	00 
80100a5f:	90                   	nop

80100a60 <consoleinit>:

void
consoleinit(void)
{
80100a60:	55                   	push   %ebp
80100a61:	89 e5                	mov    %esp,%ebp
80100a63:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100a66:	68 68 7e 10 80       	push   $0x80107e68
80100a6b:	68 20 ff 10 80       	push   $0x8010ff20
80100a70:	e8 fb 44 00 00       	call   80104f70 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100a75:	58                   	pop    %eax
80100a76:	5a                   	pop    %edx
80100a77:	6a 00                	push   $0x0
80100a79:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100a7b:	c7 05 0c 09 11 80 b0 	movl   $0x801005b0,0x8011090c
80100a82:	05 10 80 
  devsw[CONSOLE].read = consoleread;
80100a85:	c7 05 08 09 11 80 80 	movl   $0x80100280,0x80110908
80100a8c:	02 10 80 
  cons.locking = 1;
80100a8f:	c7 05 54 ff 10 80 01 	movl   $0x1,0x8010ff54
80100a96:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100a99:	e8 d2 19 00 00       	call   80102470 <ioapicenable>
}
80100a9e:	83 c4 10             	add    $0x10,%esp
80100aa1:	c9                   	leave
80100aa2:	c3                   	ret
80100aa3:	66 90                	xchg   %ax,%ax
80100aa5:	66 90                	xchg   %ax,%ax
80100aa7:	66 90                	xchg   %ax,%ax
80100aa9:	66 90                	xchg   %ax,%ax
80100aab:	66 90                	xchg   %ax,%ax
80100aad:	66 90                	xchg   %ax,%ax
80100aaf:	90                   	nop

80100ab0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100ab0:	55                   	push   %ebp
80100ab1:	89 e5                	mov    %esp,%ebp
80100ab3:	57                   	push   %edi
80100ab4:	56                   	push   %esi
80100ab5:	53                   	push   %ebx
80100ab6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100abc:	e8 1f 30 00 00       	call   80103ae0 <myproc>
80100ac1:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80100ac7:	e8 84 22 00 00       	call   80102d50 <begin_op>

  if((ip = namei(path)) == 0){
80100acc:	83 ec 0c             	sub    $0xc,%esp
80100acf:	ff 75 08             	push   0x8(%ebp)
80100ad2:	e8 b9 15 00 00       	call   80102090 <namei>
80100ad7:	83 c4 10             	add    $0x10,%esp
80100ada:	85 c0                	test   %eax,%eax
80100adc:	0f 84 37 03 00 00    	je     80100e19 <exec+0x369>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100ae2:	83 ec 0c             	sub    $0xc,%esp
80100ae5:	89 c7                	mov    %eax,%edi
80100ae7:	50                   	push   %eax
80100ae8:	e8 c3 0c 00 00       	call   801017b0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100aed:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100af3:	6a 34                	push   $0x34
80100af5:	6a 00                	push   $0x0
80100af7:	50                   	push   %eax
80100af8:	57                   	push   %edi
80100af9:	e8 c2 0f 00 00       	call   80101ac0 <readi>
80100afe:	83 c4 20             	add    $0x20,%esp
80100b01:	83 f8 34             	cmp    $0x34,%eax
80100b04:	0f 85 01 01 00 00    	jne    80100c0b <exec+0x15b>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100b0a:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100b11:	45 4c 46 
80100b14:	0f 85 f1 00 00 00    	jne    80100c0b <exec+0x15b>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100b1a:	e8 a1 6f 00 00       	call   80107ac0 <setupkvm>
80100b1f:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100b25:	85 c0                	test   %eax,%eax
80100b27:	0f 84 de 00 00 00    	je     80100c0b <exec+0x15b>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b2d:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100b34:	00 
80100b35:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100b3b:	0f 84 a8 02 00 00    	je     80100de9 <exec+0x339>
  sz = 0;
80100b41:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100b48:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b4b:	31 db                	xor    %ebx,%ebx
80100b4d:	e9 8c 00 00 00       	jmp    80100bde <exec+0x12e>
80100b52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100b58:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100b5f:	75 6c                	jne    80100bcd <exec+0x11d>
      continue;
    if(ph.memsz < ph.filesz)
80100b61:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100b67:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100b6d:	0f 82 87 00 00 00    	jb     80100bfa <exec+0x14a>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100b73:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100b79:	72 7f                	jb     80100bfa <exec+0x14a>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100b7b:	83 ec 04             	sub    $0x4,%esp
80100b7e:	50                   	push   %eax
80100b7f:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80100b85:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100b8b:	e8 60 6d 00 00       	call   801078f0 <allocuvm>
80100b90:	83 c4 10             	add    $0x10,%esp
80100b93:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100b99:	85 c0                	test   %eax,%eax
80100b9b:	74 5d                	je     80100bfa <exec+0x14a>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100b9d:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100ba3:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100ba8:	75 50                	jne    80100bfa <exec+0x14a>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100baa:	83 ec 0c             	sub    $0xc,%esp
80100bad:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
80100bb3:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
80100bb9:	57                   	push   %edi
80100bba:	50                   	push   %eax
80100bbb:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100bc1:	e8 5a 6c 00 00       	call   80107820 <loaduvm>
80100bc6:	83 c4 20             	add    $0x20,%esp
80100bc9:	85 c0                	test   %eax,%eax
80100bcb:	78 2d                	js     80100bfa <exec+0x14a>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100bcd:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100bd4:	83 c3 01             	add    $0x1,%ebx
80100bd7:	83 c6 20             	add    $0x20,%esi
80100bda:	39 d8                	cmp    %ebx,%eax
80100bdc:	7e 52                	jle    80100c30 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100bde:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100be4:	6a 20                	push   $0x20
80100be6:	56                   	push   %esi
80100be7:	50                   	push   %eax
80100be8:	57                   	push   %edi
80100be9:	e8 d2 0e 00 00       	call   80101ac0 <readi>
80100bee:	83 c4 10             	add    $0x10,%esp
80100bf1:	83 f8 20             	cmp    $0x20,%eax
80100bf4:	0f 84 5e ff ff ff    	je     80100b58 <exec+0xa8>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100bfa:	83 ec 0c             	sub    $0xc,%esp
80100bfd:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100c03:	e8 38 6e 00 00       	call   80107a40 <freevm>
  if(ip){
80100c08:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80100c0b:	83 ec 0c             	sub    $0xc,%esp
80100c0e:	57                   	push   %edi
80100c0f:	e8 2c 0e 00 00       	call   80101a40 <iunlockput>
    end_op();
80100c14:	e8 a7 21 00 00       	call   80102dc0 <end_op>
80100c19:	83 c4 10             	add    $0x10,%esp
    return -1;
80100c1c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return -1;
}
80100c21:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100c24:	5b                   	pop    %ebx
80100c25:	5e                   	pop    %esi
80100c26:	5f                   	pop    %edi
80100c27:	5d                   	pop    %ebp
80100c28:	c3                   	ret
80100c29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  sz = PGROUNDUP(sz);
80100c30:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100c36:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
80100c3c:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c42:	8d 9e 00 20 00 00    	lea    0x2000(%esi),%ebx
  iunlockput(ip);
80100c48:	83 ec 0c             	sub    $0xc,%esp
80100c4b:	57                   	push   %edi
80100c4c:	e8 ef 0d 00 00       	call   80101a40 <iunlockput>
  end_op();
80100c51:	e8 6a 21 00 00       	call   80102dc0 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c56:	83 c4 0c             	add    $0xc,%esp
80100c59:	53                   	push   %ebx
80100c5a:	56                   	push   %esi
80100c5b:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100c61:	56                   	push   %esi
80100c62:	e8 89 6c 00 00       	call   801078f0 <allocuvm>
80100c67:	83 c4 10             	add    $0x10,%esp
80100c6a:	89 c7                	mov    %eax,%edi
80100c6c:	85 c0                	test   %eax,%eax
80100c6e:	0f 84 86 00 00 00    	je     80100cfa <exec+0x24a>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c74:	83 ec 08             	sub    $0x8,%esp
80100c77:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  sp = sz;
80100c7d:	89 fb                	mov    %edi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c7f:	50                   	push   %eax
80100c80:	56                   	push   %esi
  for(argc = 0; argv[argc]; argc++) {
80100c81:	31 f6                	xor    %esi,%esi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c83:	e8 d8 6e 00 00       	call   80107b60 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100c88:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c8b:	83 c4 10             	add    $0x10,%esp
80100c8e:	8b 10                	mov    (%eax),%edx
80100c90:	85 d2                	test   %edx,%edx
80100c92:	0f 84 5d 01 00 00    	je     80100df5 <exec+0x345>
80100c98:	89 bd f0 fe ff ff    	mov    %edi,-0x110(%ebp)
80100c9e:	8b 7d 0c             	mov    0xc(%ebp),%edi
80100ca1:	eb 23                	jmp    80100cc6 <exec+0x216>
80100ca3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80100ca8:	8d 46 01             	lea    0x1(%esi),%eax
    ustack[3+argc] = sp;
80100cab:	89 9c b5 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%esi,4)
80100cb2:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
  for(argc = 0; argv[argc]; argc++) {
80100cb8:	8b 14 87             	mov    (%edi,%eax,4),%edx
80100cbb:	85 d2                	test   %edx,%edx
80100cbd:	74 51                	je     80100d10 <exec+0x260>
    if(argc >= MAXARG)
80100cbf:	83 f8 20             	cmp    $0x20,%eax
80100cc2:	74 36                	je     80100cfa <exec+0x24a>
80100cc4:	89 c6                	mov    %eax,%esi
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100cc6:	83 ec 0c             	sub    $0xc,%esp
80100cc9:	52                   	push   %edx
80100cca:	e8 81 47 00 00       	call   80105450 <strlen>
80100ccf:	29 c3                	sub    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100cd1:	58                   	pop    %eax
80100cd2:	ff 34 b7             	push   (%edi,%esi,4)
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100cd5:	83 eb 01             	sub    $0x1,%ebx
80100cd8:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100cdb:	e8 70 47 00 00       	call   80105450 <strlen>
80100ce0:	83 c0 01             	add    $0x1,%eax
80100ce3:	50                   	push   %eax
80100ce4:	ff 34 b7             	push   (%edi,%esi,4)
80100ce7:	53                   	push   %ebx
80100ce8:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100cee:	e8 3d 70 00 00       	call   80107d30 <copyout>
80100cf3:	83 c4 20             	add    $0x20,%esp
80100cf6:	85 c0                	test   %eax,%eax
80100cf8:	79 ae                	jns    80100ca8 <exec+0x1f8>
    freevm(pgdir);
80100cfa:	83 ec 0c             	sub    $0xc,%esp
80100cfd:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100d03:	e8 38 6d 00 00       	call   80107a40 <freevm>
80100d08:	83 c4 10             	add    $0x10,%esp
80100d0b:	e9 0c ff ff ff       	jmp    80100c1c <exec+0x16c>
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d10:	8d 14 b5 08 00 00 00 	lea    0x8(,%esi,4),%edx
  ustack[3+argc] = 0;
80100d17:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80100d1d:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100d23:	8d 46 04             	lea    0x4(%esi),%eax
  sp -= (3+argc+1) * 4;
80100d26:	8d 72 0c             	lea    0xc(%edx),%esi
  ustack[3+argc] = 0;
80100d29:	c7 84 85 58 ff ff ff 	movl   $0x0,-0xa8(%ebp,%eax,4)
80100d30:	00 00 00 00 
  ustack[1] = argc;
80100d34:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  ustack[0] = 0xffffffff;  // fake return PC
80100d3a:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100d41:	ff ff ff 
  ustack[1] = argc;
80100d44:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d4a:	89 d8                	mov    %ebx,%eax
  sp -= (3+argc+1) * 4;
80100d4c:	29 f3                	sub    %esi,%ebx
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d4e:	29 d0                	sub    %edx,%eax
80100d50:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d56:	56                   	push   %esi
80100d57:	51                   	push   %ecx
80100d58:	53                   	push   %ebx
80100d59:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100d5f:	e8 cc 6f 00 00       	call   80107d30 <copyout>
80100d64:	83 c4 10             	add    $0x10,%esp
80100d67:	85 c0                	test   %eax,%eax
80100d69:	78 8f                	js     80100cfa <exec+0x24a>
  for(last=s=path; *s; s++)
80100d6b:	8b 45 08             	mov    0x8(%ebp),%eax
80100d6e:	8b 55 08             	mov    0x8(%ebp),%edx
80100d71:	0f b6 00             	movzbl (%eax),%eax
80100d74:	84 c0                	test   %al,%al
80100d76:	74 17                	je     80100d8f <exec+0x2df>
80100d78:	89 d1                	mov    %edx,%ecx
80100d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      last = s+1;
80100d80:	83 c1 01             	add    $0x1,%ecx
80100d83:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80100d85:	0f b6 01             	movzbl (%ecx),%eax
      last = s+1;
80100d88:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
80100d8b:	84 c0                	test   %al,%al
80100d8d:	75 f1                	jne    80100d80 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100d8f:	83 ec 04             	sub    $0x4,%esp
80100d92:	6a 10                	push   $0x10
80100d94:	52                   	push   %edx
80100d95:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
80100d9b:	8d 46 6c             	lea    0x6c(%esi),%eax
80100d9e:	50                   	push   %eax
80100d9f:	e8 6c 46 00 00       	call   80105410 <safestrcpy>
  curproc->pgdir = pgdir;
80100da4:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80100daa:	89 f0                	mov    %esi,%eax
80100dac:	8b 76 04             	mov    0x4(%esi),%esi
  curproc->sz = sz;
80100daf:	89 38                	mov    %edi,(%eax)
  curproc->pgdir = pgdir;
80100db1:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
80100db4:	89 c1                	mov    %eax,%ecx
80100db6:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100dbc:	8b 40 18             	mov    0x18(%eax),%eax
80100dbf:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100dc2:	8b 41 18             	mov    0x18(%ecx),%eax
80100dc5:	89 58 44             	mov    %ebx,0x44(%eax)
  curproc->priority = 10;   // default priority of new process
80100dc8:	c7 41 7c 0a 00 00 00 	movl   $0xa,0x7c(%ecx)
  switchuvm(curproc);
80100dcf:	89 0c 24             	mov    %ecx,(%esp)
80100dd2:	e8 b9 68 00 00       	call   80107690 <switchuvm>
  freevm(oldpgdir);
80100dd7:	89 34 24             	mov    %esi,(%esp)
80100dda:	e8 61 6c 00 00       	call   80107a40 <freevm>
  return 0;
80100ddf:	83 c4 10             	add    $0x10,%esp
80100de2:	31 c0                	xor    %eax,%eax
80100de4:	e9 38 fe ff ff       	jmp    80100c21 <exec+0x171>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100de9:	bb 00 20 00 00       	mov    $0x2000,%ebx
80100dee:	31 f6                	xor    %esi,%esi
80100df0:	e9 53 fe ff ff       	jmp    80100c48 <exec+0x198>
  for(argc = 0; argv[argc]; argc++) {
80100df5:	be 10 00 00 00       	mov    $0x10,%esi
80100dfa:	ba 04 00 00 00       	mov    $0x4,%edx
80100dff:	b8 03 00 00 00       	mov    $0x3,%eax
80100e04:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100e0b:	00 00 00 
80100e0e:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
80100e14:	e9 10 ff ff ff       	jmp    80100d29 <exec+0x279>
    end_op();
80100e19:	e8 a2 1f 00 00       	call   80102dc0 <end_op>
    cprintf("exec: fail\n");
80100e1e:	83 ec 0c             	sub    $0xc,%esp
80100e21:	68 70 7e 10 80       	push   $0x80107e70
80100e26:	e8 85 f8 ff ff       	call   801006b0 <cprintf>
    return -1;
80100e2b:	83 c4 10             	add    $0x10,%esp
80100e2e:	e9 e9 fd ff ff       	jmp    80100c1c <exec+0x16c>
80100e33:	66 90                	xchg   %ax,%ax
80100e35:	66 90                	xchg   %ax,%ax
80100e37:	66 90                	xchg   %ax,%ax
80100e39:	66 90                	xchg   %ax,%ax
80100e3b:	66 90                	xchg   %ax,%ax
80100e3d:	66 90                	xchg   %ax,%ax
80100e3f:	90                   	nop

80100e40 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100e40:	55                   	push   %ebp
80100e41:	89 e5                	mov    %esp,%ebp
80100e43:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100e46:	68 7c 7e 10 80       	push   $0x80107e7c
80100e4b:	68 60 ff 10 80       	push   $0x8010ff60
80100e50:	e8 1b 41 00 00       	call   80104f70 <initlock>
}
80100e55:	83 c4 10             	add    $0x10,%esp
80100e58:	c9                   	leave
80100e59:	c3                   	ret
80100e5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100e60 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100e60:	55                   	push   %ebp
80100e61:	89 e5                	mov    %esp,%ebp
80100e63:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e64:	bb 94 ff 10 80       	mov    $0x8010ff94,%ebx
{
80100e69:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100e6c:	68 60 ff 10 80       	push   $0x8010ff60
80100e71:	e8 ea 42 00 00       	call   80105160 <acquire>
80100e76:	83 c4 10             	add    $0x10,%esp
80100e79:	eb 10                	jmp    80100e8b <filealloc+0x2b>
80100e7b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e80:	83 c3 18             	add    $0x18,%ebx
80100e83:	81 fb f4 08 11 80    	cmp    $0x801108f4,%ebx
80100e89:	74 25                	je     80100eb0 <filealloc+0x50>
    if(f->ref == 0){
80100e8b:	8b 43 04             	mov    0x4(%ebx),%eax
80100e8e:	85 c0                	test   %eax,%eax
80100e90:	75 ee                	jne    80100e80 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100e92:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100e95:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100e9c:	68 60 ff 10 80       	push   $0x8010ff60
80100ea1:	e8 5a 42 00 00       	call   80105100 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100ea6:	89 d8                	mov    %ebx,%eax
      return f;
80100ea8:	83 c4 10             	add    $0x10,%esp
}
80100eab:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100eae:	c9                   	leave
80100eaf:	c3                   	ret
  release(&ftable.lock);
80100eb0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100eb3:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100eb5:	68 60 ff 10 80       	push   $0x8010ff60
80100eba:	e8 41 42 00 00       	call   80105100 <release>
}
80100ebf:	89 d8                	mov    %ebx,%eax
  return 0;
80100ec1:	83 c4 10             	add    $0x10,%esp
}
80100ec4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100ec7:	c9                   	leave
80100ec8:	c3                   	ret
80100ec9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100ed0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100ed0:	55                   	push   %ebp
80100ed1:	89 e5                	mov    %esp,%ebp
80100ed3:	53                   	push   %ebx
80100ed4:	83 ec 10             	sub    $0x10,%esp
80100ed7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100eda:	68 60 ff 10 80       	push   $0x8010ff60
80100edf:	e8 7c 42 00 00       	call   80105160 <acquire>
  if(f->ref < 1)
80100ee4:	8b 43 04             	mov    0x4(%ebx),%eax
80100ee7:	83 c4 10             	add    $0x10,%esp
80100eea:	85 c0                	test   %eax,%eax
80100eec:	7e 1a                	jle    80100f08 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100eee:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100ef1:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100ef4:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100ef7:	68 60 ff 10 80       	push   $0x8010ff60
80100efc:	e8 ff 41 00 00       	call   80105100 <release>
  return f;
}
80100f01:	89 d8                	mov    %ebx,%eax
80100f03:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f06:	c9                   	leave
80100f07:	c3                   	ret
    panic("filedup");
80100f08:	83 ec 0c             	sub    $0xc,%esp
80100f0b:	68 83 7e 10 80       	push   $0x80107e83
80100f10:	e8 6b f4 ff ff       	call   80100380 <panic>
80100f15:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100f1c:	00 
80100f1d:	8d 76 00             	lea    0x0(%esi),%esi

80100f20 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100f20:	55                   	push   %ebp
80100f21:	89 e5                	mov    %esp,%ebp
80100f23:	57                   	push   %edi
80100f24:	56                   	push   %esi
80100f25:	53                   	push   %ebx
80100f26:	83 ec 28             	sub    $0x28,%esp
80100f29:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100f2c:	68 60 ff 10 80       	push   $0x8010ff60
80100f31:	e8 2a 42 00 00       	call   80105160 <acquire>
  if(f->ref < 1)
80100f36:	8b 53 04             	mov    0x4(%ebx),%edx
80100f39:	83 c4 10             	add    $0x10,%esp
80100f3c:	85 d2                	test   %edx,%edx
80100f3e:	0f 8e a5 00 00 00    	jle    80100fe9 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80100f44:	83 ea 01             	sub    $0x1,%edx
80100f47:	89 53 04             	mov    %edx,0x4(%ebx)
80100f4a:	75 44                	jne    80100f90 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100f4c:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100f50:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100f53:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
80100f55:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100f5b:	8b 73 0c             	mov    0xc(%ebx),%esi
80100f5e:	88 45 e7             	mov    %al,-0x19(%ebp)
80100f61:	8b 43 10             	mov    0x10(%ebx),%eax
80100f64:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100f67:	68 60 ff 10 80       	push   $0x8010ff60
80100f6c:	e8 8f 41 00 00       	call   80105100 <release>

  if(ff.type == FD_PIPE)
80100f71:	83 c4 10             	add    $0x10,%esp
80100f74:	83 ff 01             	cmp    $0x1,%edi
80100f77:	74 57                	je     80100fd0 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100f79:	83 ff 02             	cmp    $0x2,%edi
80100f7c:	74 2a                	je     80100fa8 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100f7e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f81:	5b                   	pop    %ebx
80100f82:	5e                   	pop    %esi
80100f83:	5f                   	pop    %edi
80100f84:	5d                   	pop    %ebp
80100f85:	c3                   	ret
80100f86:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100f8d:	00 
80100f8e:	66 90                	xchg   %ax,%ax
    release(&ftable.lock);
80100f90:	c7 45 08 60 ff 10 80 	movl   $0x8010ff60,0x8(%ebp)
}
80100f97:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f9a:	5b                   	pop    %ebx
80100f9b:	5e                   	pop    %esi
80100f9c:	5f                   	pop    %edi
80100f9d:	5d                   	pop    %ebp
    release(&ftable.lock);
80100f9e:	e9 5d 41 00 00       	jmp    80105100 <release>
80100fa3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    begin_op();
80100fa8:	e8 a3 1d 00 00       	call   80102d50 <begin_op>
    iput(ff.ip);
80100fad:	83 ec 0c             	sub    $0xc,%esp
80100fb0:	ff 75 e0             	push   -0x20(%ebp)
80100fb3:	e8 28 09 00 00       	call   801018e0 <iput>
    end_op();
80100fb8:	83 c4 10             	add    $0x10,%esp
}
80100fbb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fbe:	5b                   	pop    %ebx
80100fbf:	5e                   	pop    %esi
80100fc0:	5f                   	pop    %edi
80100fc1:	5d                   	pop    %ebp
    end_op();
80100fc2:	e9 f9 1d 00 00       	jmp    80102dc0 <end_op>
80100fc7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100fce:	00 
80100fcf:	90                   	nop
    pipeclose(ff.pipe, ff.writable);
80100fd0:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100fd4:	83 ec 08             	sub    $0x8,%esp
80100fd7:	53                   	push   %ebx
80100fd8:	56                   	push   %esi
80100fd9:	e8 92 25 00 00       	call   80103570 <pipeclose>
80100fde:	83 c4 10             	add    $0x10,%esp
}
80100fe1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fe4:	5b                   	pop    %ebx
80100fe5:	5e                   	pop    %esi
80100fe6:	5f                   	pop    %edi
80100fe7:	5d                   	pop    %ebp
80100fe8:	c3                   	ret
    panic("fileclose");
80100fe9:	83 ec 0c             	sub    $0xc,%esp
80100fec:	68 8b 7e 10 80       	push   $0x80107e8b
80100ff1:	e8 8a f3 ff ff       	call   80100380 <panic>
80100ff6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100ffd:	00 
80100ffe:	66 90                	xchg   %ax,%ax

80101000 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101000:	55                   	push   %ebp
80101001:	89 e5                	mov    %esp,%ebp
80101003:	53                   	push   %ebx
80101004:	83 ec 04             	sub    $0x4,%esp
80101007:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
8010100a:	83 3b 02             	cmpl   $0x2,(%ebx)
8010100d:	75 31                	jne    80101040 <filestat+0x40>
    ilock(f->ip);
8010100f:	83 ec 0c             	sub    $0xc,%esp
80101012:	ff 73 10             	push   0x10(%ebx)
80101015:	e8 96 07 00 00       	call   801017b0 <ilock>
    stati(f->ip, st);
8010101a:	58                   	pop    %eax
8010101b:	5a                   	pop    %edx
8010101c:	ff 75 0c             	push   0xc(%ebp)
8010101f:	ff 73 10             	push   0x10(%ebx)
80101022:	e8 69 0a 00 00       	call   80101a90 <stati>
    iunlock(f->ip);
80101027:	59                   	pop    %ecx
80101028:	ff 73 10             	push   0x10(%ebx)
8010102b:	e8 60 08 00 00       	call   80101890 <iunlock>
    return 0;
  }
  return -1;
}
80101030:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80101033:	83 c4 10             	add    $0x10,%esp
80101036:	31 c0                	xor    %eax,%eax
}
80101038:	c9                   	leave
80101039:	c3                   	ret
8010103a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101040:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80101043:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101048:	c9                   	leave
80101049:	c3                   	ret
8010104a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101050 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101050:	55                   	push   %ebp
80101051:	89 e5                	mov    %esp,%ebp
80101053:	57                   	push   %edi
80101054:	56                   	push   %esi
80101055:	53                   	push   %ebx
80101056:	83 ec 0c             	sub    $0xc,%esp
80101059:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010105c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010105f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101062:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101066:	74 60                	je     801010c8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101068:	8b 03                	mov    (%ebx),%eax
8010106a:	83 f8 01             	cmp    $0x1,%eax
8010106d:	74 41                	je     801010b0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010106f:	83 f8 02             	cmp    $0x2,%eax
80101072:	75 5b                	jne    801010cf <fileread+0x7f>
    ilock(f->ip);
80101074:	83 ec 0c             	sub    $0xc,%esp
80101077:	ff 73 10             	push   0x10(%ebx)
8010107a:	e8 31 07 00 00       	call   801017b0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010107f:	57                   	push   %edi
80101080:	ff 73 14             	push   0x14(%ebx)
80101083:	56                   	push   %esi
80101084:	ff 73 10             	push   0x10(%ebx)
80101087:	e8 34 0a 00 00       	call   80101ac0 <readi>
8010108c:	83 c4 20             	add    $0x20,%esp
8010108f:	89 c6                	mov    %eax,%esi
80101091:	85 c0                	test   %eax,%eax
80101093:	7e 03                	jle    80101098 <fileread+0x48>
      f->off += r;
80101095:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101098:	83 ec 0c             	sub    $0xc,%esp
8010109b:	ff 73 10             	push   0x10(%ebx)
8010109e:	e8 ed 07 00 00       	call   80101890 <iunlock>
    return r;
801010a3:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
801010a6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010a9:	89 f0                	mov    %esi,%eax
801010ab:	5b                   	pop    %ebx
801010ac:	5e                   	pop    %esi
801010ad:	5f                   	pop    %edi
801010ae:	5d                   	pop    %ebp
801010af:	c3                   	ret
    return piperead(f->pipe, addr, n);
801010b0:	8b 43 0c             	mov    0xc(%ebx),%eax
801010b3:	89 45 08             	mov    %eax,0x8(%ebp)
}
801010b6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010b9:	5b                   	pop    %ebx
801010ba:	5e                   	pop    %esi
801010bb:	5f                   	pop    %edi
801010bc:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
801010bd:	e9 6e 26 00 00       	jmp    80103730 <piperead>
801010c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801010c8:	be ff ff ff ff       	mov    $0xffffffff,%esi
801010cd:	eb d7                	jmp    801010a6 <fileread+0x56>
  panic("fileread");
801010cf:	83 ec 0c             	sub    $0xc,%esp
801010d2:	68 95 7e 10 80       	push   $0x80107e95
801010d7:	e8 a4 f2 ff ff       	call   80100380 <panic>
801010dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801010e0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801010e0:	55                   	push   %ebp
801010e1:	89 e5                	mov    %esp,%ebp
801010e3:	57                   	push   %edi
801010e4:	56                   	push   %esi
801010e5:	53                   	push   %ebx
801010e6:	83 ec 1c             	sub    $0x1c,%esp
801010e9:	8b 45 0c             	mov    0xc(%ebp),%eax
801010ec:	8b 5d 08             	mov    0x8(%ebp),%ebx
801010ef:	89 45 dc             	mov    %eax,-0x24(%ebp)
801010f2:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
801010f5:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
{
801010f9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
801010fc:	0f 84 bb 00 00 00    	je     801011bd <filewrite+0xdd>
    return -1;
  if(f->type == FD_PIPE)
80101102:	8b 03                	mov    (%ebx),%eax
80101104:	83 f8 01             	cmp    $0x1,%eax
80101107:	0f 84 bf 00 00 00    	je     801011cc <filewrite+0xec>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010110d:	83 f8 02             	cmp    $0x2,%eax
80101110:	0f 85 c8 00 00 00    	jne    801011de <filewrite+0xfe>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101116:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101119:	31 f6                	xor    %esi,%esi
    while(i < n){
8010111b:	85 c0                	test   %eax,%eax
8010111d:	7f 30                	jg     8010114f <filewrite+0x6f>
8010111f:	e9 94 00 00 00       	jmp    801011b8 <filewrite+0xd8>
80101124:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101128:	01 43 14             	add    %eax,0x14(%ebx)
      iunlock(f->ip);
8010112b:	83 ec 0c             	sub    $0xc,%esp
        f->off += r;
8010112e:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101131:	ff 73 10             	push   0x10(%ebx)
80101134:	e8 57 07 00 00       	call   80101890 <iunlock>
      end_op();
80101139:	e8 82 1c 00 00       	call   80102dc0 <end_op>

      if(r < 0)
        break;
      if(r != n1)
8010113e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101141:	83 c4 10             	add    $0x10,%esp
80101144:	39 c7                	cmp    %eax,%edi
80101146:	75 5c                	jne    801011a4 <filewrite+0xc4>
        panic("short filewrite");
      i += r;
80101148:	01 fe                	add    %edi,%esi
    while(i < n){
8010114a:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
8010114d:	7e 69                	jle    801011b8 <filewrite+0xd8>
      int n1 = n - i;
8010114f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      if(n1 > max)
80101152:	b8 00 06 00 00       	mov    $0x600,%eax
      int n1 = n - i;
80101157:	29 f7                	sub    %esi,%edi
      if(n1 > max)
80101159:	39 c7                	cmp    %eax,%edi
8010115b:	0f 4f f8             	cmovg  %eax,%edi
      begin_op();
8010115e:	e8 ed 1b 00 00       	call   80102d50 <begin_op>
      ilock(f->ip);
80101163:	83 ec 0c             	sub    $0xc,%esp
80101166:	ff 73 10             	push   0x10(%ebx)
80101169:	e8 42 06 00 00       	call   801017b0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
8010116e:	57                   	push   %edi
8010116f:	ff 73 14             	push   0x14(%ebx)
80101172:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101175:	01 f0                	add    %esi,%eax
80101177:	50                   	push   %eax
80101178:	ff 73 10             	push   0x10(%ebx)
8010117b:	e8 40 0a 00 00       	call   80101bc0 <writei>
80101180:	83 c4 20             	add    $0x20,%esp
80101183:	85 c0                	test   %eax,%eax
80101185:	7f a1                	jg     80101128 <filewrite+0x48>
80101187:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
8010118a:	83 ec 0c             	sub    $0xc,%esp
8010118d:	ff 73 10             	push   0x10(%ebx)
80101190:	e8 fb 06 00 00       	call   80101890 <iunlock>
      end_op();
80101195:	e8 26 1c 00 00       	call   80102dc0 <end_op>
      if(r < 0)
8010119a:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010119d:	83 c4 10             	add    $0x10,%esp
801011a0:	85 c0                	test   %eax,%eax
801011a2:	75 14                	jne    801011b8 <filewrite+0xd8>
        panic("short filewrite");
801011a4:	83 ec 0c             	sub    $0xc,%esp
801011a7:	68 9e 7e 10 80       	push   $0x80107e9e
801011ac:	e8 cf f1 ff ff       	call   80100380 <panic>
801011b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
    return i == n ? n : -1;
801011b8:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
801011bb:	74 05                	je     801011c2 <filewrite+0xe2>
801011bd:	be ff ff ff ff       	mov    $0xffffffff,%esi
  }
  panic("filewrite");
}
801011c2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011c5:	89 f0                	mov    %esi,%eax
801011c7:	5b                   	pop    %ebx
801011c8:	5e                   	pop    %esi
801011c9:	5f                   	pop    %edi
801011ca:	5d                   	pop    %ebp
801011cb:	c3                   	ret
    return pipewrite(f->pipe, addr, n);
801011cc:	8b 43 0c             	mov    0xc(%ebx),%eax
801011cf:	89 45 08             	mov    %eax,0x8(%ebp)
}
801011d2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011d5:	5b                   	pop    %ebx
801011d6:	5e                   	pop    %esi
801011d7:	5f                   	pop    %edi
801011d8:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801011d9:	e9 32 24 00 00       	jmp    80103610 <pipewrite>
  panic("filewrite");
801011de:	83 ec 0c             	sub    $0xc,%esp
801011e1:	68 a4 7e 10 80       	push   $0x80107ea4
801011e6:	e8 95 f1 ff ff       	call   80100380 <panic>
801011eb:	66 90                	xchg   %ax,%ax
801011ed:	66 90                	xchg   %ax,%ax
801011ef:	90                   	nop

801011f0 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801011f0:	55                   	push   %ebp
801011f1:	89 e5                	mov    %esp,%ebp
801011f3:	57                   	push   %edi
801011f4:	56                   	push   %esi
801011f5:	53                   	push   %ebx
801011f6:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801011f9:	8b 0d b4 25 11 80    	mov    0x801125b4,%ecx
{
801011ff:	89 45 dc             	mov    %eax,-0x24(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101202:	85 c9                	test   %ecx,%ecx
80101204:	0f 84 8c 00 00 00    	je     80101296 <balloc+0xa6>
8010120a:	31 ff                	xor    %edi,%edi
    bp = bread(dev, BBLOCK(b, sb));
8010120c:	89 f8                	mov    %edi,%eax
8010120e:	83 ec 08             	sub    $0x8,%esp
80101211:	89 fe                	mov    %edi,%esi
80101213:	c1 f8 0c             	sar    $0xc,%eax
80101216:	03 05 cc 25 11 80    	add    0x801125cc,%eax
8010121c:	50                   	push   %eax
8010121d:	ff 75 dc             	push   -0x24(%ebp)
80101220:	e8 ab ee ff ff       	call   801000d0 <bread>
80101225:	83 c4 10             	add    $0x10,%esp
80101228:	89 7d d8             	mov    %edi,-0x28(%ebp)
8010122b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010122e:	a1 b4 25 11 80       	mov    0x801125b4,%eax
80101233:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101236:	31 c0                	xor    %eax,%eax
80101238:	eb 32                	jmp    8010126c <balloc+0x7c>
8010123a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101240:	89 c1                	mov    %eax,%ecx
80101242:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101247:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      m = 1 << (bi % 8);
8010124a:	83 e1 07             	and    $0x7,%ecx
8010124d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010124f:	89 c1                	mov    %eax,%ecx
80101251:	c1 f9 03             	sar    $0x3,%ecx
80101254:	0f b6 7c 0f 5c       	movzbl 0x5c(%edi,%ecx,1),%edi
80101259:	89 fa                	mov    %edi,%edx
8010125b:	85 df                	test   %ebx,%edi
8010125d:	74 49                	je     801012a8 <balloc+0xb8>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010125f:	83 c0 01             	add    $0x1,%eax
80101262:	83 c6 01             	add    $0x1,%esi
80101265:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010126a:	74 07                	je     80101273 <balloc+0x83>
8010126c:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010126f:	39 d6                	cmp    %edx,%esi
80101271:	72 cd                	jb     80101240 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101273:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101276:	83 ec 0c             	sub    $0xc,%esp
80101279:	ff 75 e4             	push   -0x1c(%ebp)
  for(b = 0; b < sb.size; b += BPB){
8010127c:	81 c7 00 10 00 00    	add    $0x1000,%edi
    brelse(bp);
80101282:	e8 69 ef ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
80101287:	83 c4 10             	add    $0x10,%esp
8010128a:	3b 3d b4 25 11 80    	cmp    0x801125b4,%edi
80101290:	0f 82 76 ff ff ff    	jb     8010120c <balloc+0x1c>
  }
  panic("balloc: out of blocks");
80101296:	83 ec 0c             	sub    $0xc,%esp
80101299:	68 ae 7e 10 80       	push   $0x80107eae
8010129e:	e8 dd f0 ff ff       	call   80100380 <panic>
801012a3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        bp->data[bi/8] |= m;  // Mark block in use.
801012a8:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801012ab:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
801012ae:	09 da                	or     %ebx,%edx
801012b0:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801012b4:	57                   	push   %edi
801012b5:	e8 76 1c 00 00       	call   80102f30 <log_write>
        brelse(bp);
801012ba:	89 3c 24             	mov    %edi,(%esp)
801012bd:	e8 2e ef ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
801012c2:	58                   	pop    %eax
801012c3:	5a                   	pop    %edx
801012c4:	56                   	push   %esi
801012c5:	ff 75 dc             	push   -0x24(%ebp)
801012c8:	e8 03 ee ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
801012cd:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
801012d0:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801012d2:	8d 40 5c             	lea    0x5c(%eax),%eax
801012d5:	68 00 02 00 00       	push   $0x200
801012da:	6a 00                	push   $0x0
801012dc:	50                   	push   %eax
801012dd:	e8 7e 3f 00 00       	call   80105260 <memset>
  log_write(bp);
801012e2:	89 1c 24             	mov    %ebx,(%esp)
801012e5:	e8 46 1c 00 00       	call   80102f30 <log_write>
  brelse(bp);
801012ea:	89 1c 24             	mov    %ebx,(%esp)
801012ed:	e8 fe ee ff ff       	call   801001f0 <brelse>
}
801012f2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012f5:	89 f0                	mov    %esi,%eax
801012f7:	5b                   	pop    %ebx
801012f8:	5e                   	pop    %esi
801012f9:	5f                   	pop    %edi
801012fa:	5d                   	pop    %ebp
801012fb:	c3                   	ret
801012fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101300 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101300:	55                   	push   %ebp
80101301:	89 e5                	mov    %esp,%ebp
80101303:	57                   	push   %edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101304:	31 ff                	xor    %edi,%edi
{
80101306:	56                   	push   %esi
80101307:	89 c6                	mov    %eax,%esi
80101309:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010130a:	bb 94 09 11 80       	mov    $0x80110994,%ebx
{
8010130f:	83 ec 28             	sub    $0x28,%esp
80101312:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101315:	68 60 09 11 80       	push   $0x80110960
8010131a:	e8 41 3e 00 00       	call   80105160 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010131f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
80101322:	83 c4 10             	add    $0x10,%esp
80101325:	eb 1b                	jmp    80101342 <iget+0x42>
80101327:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010132e:	00 
8010132f:	90                   	nop
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101330:	39 33                	cmp    %esi,(%ebx)
80101332:	74 6c                	je     801013a0 <iget+0xa0>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101334:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010133a:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
80101340:	74 26                	je     80101368 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101342:	8b 43 08             	mov    0x8(%ebx),%eax
80101345:	85 c0                	test   %eax,%eax
80101347:	7f e7                	jg     80101330 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101349:	85 ff                	test   %edi,%edi
8010134b:	75 e7                	jne    80101334 <iget+0x34>
8010134d:	85 c0                	test   %eax,%eax
8010134f:	75 76                	jne    801013c7 <iget+0xc7>
      empty = ip;
80101351:	89 df                	mov    %ebx,%edi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101353:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101359:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
8010135f:	75 e1                	jne    80101342 <iget+0x42>
80101361:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101368:	85 ff                	test   %edi,%edi
8010136a:	74 79                	je     801013e5 <iget+0xe5>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
8010136c:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
8010136f:	89 37                	mov    %esi,(%edi)
  ip->inum = inum;
80101371:	89 57 04             	mov    %edx,0x4(%edi)
  ip->ref = 1;
80101374:	c7 47 08 01 00 00 00 	movl   $0x1,0x8(%edi)
  ip->valid = 0;
8010137b:	c7 47 4c 00 00 00 00 	movl   $0x0,0x4c(%edi)
  release(&icache.lock);
80101382:	68 60 09 11 80       	push   $0x80110960
80101387:	e8 74 3d 00 00       	call   80105100 <release>

  return ip;
8010138c:	83 c4 10             	add    $0x10,%esp
}
8010138f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101392:	89 f8                	mov    %edi,%eax
80101394:	5b                   	pop    %ebx
80101395:	5e                   	pop    %esi
80101396:	5f                   	pop    %edi
80101397:	5d                   	pop    %ebp
80101398:	c3                   	ret
80101399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801013a0:	39 53 04             	cmp    %edx,0x4(%ebx)
801013a3:	75 8f                	jne    80101334 <iget+0x34>
      ip->ref++;
801013a5:	83 c0 01             	add    $0x1,%eax
      release(&icache.lock);
801013a8:	83 ec 0c             	sub    $0xc,%esp
      return ip;
801013ab:	89 df                	mov    %ebx,%edi
      ip->ref++;
801013ad:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
801013b0:	68 60 09 11 80       	push   $0x80110960
801013b5:	e8 46 3d 00 00       	call   80105100 <release>
      return ip;
801013ba:	83 c4 10             	add    $0x10,%esp
}
801013bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013c0:	89 f8                	mov    %edi,%eax
801013c2:	5b                   	pop    %ebx
801013c3:	5e                   	pop    %esi
801013c4:	5f                   	pop    %edi
801013c5:	5d                   	pop    %ebp
801013c6:	c3                   	ret
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013c7:	81 c3 90 00 00 00    	add    $0x90,%ebx
801013cd:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
801013d3:	74 10                	je     801013e5 <iget+0xe5>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801013d5:	8b 43 08             	mov    0x8(%ebx),%eax
801013d8:	85 c0                	test   %eax,%eax
801013da:	0f 8f 50 ff ff ff    	jg     80101330 <iget+0x30>
801013e0:	e9 68 ff ff ff       	jmp    8010134d <iget+0x4d>
    panic("iget: no inodes");
801013e5:	83 ec 0c             	sub    $0xc,%esp
801013e8:	68 c4 7e 10 80       	push   $0x80107ec4
801013ed:	e8 8e ef ff ff       	call   80100380 <panic>
801013f2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801013f9:	00 
801013fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101400 <bfree>:
{
80101400:	55                   	push   %ebp
80101401:	89 c1                	mov    %eax,%ecx
  bp = bread(dev, BBLOCK(b, sb));
80101403:	89 d0                	mov    %edx,%eax
80101405:	c1 e8 0c             	shr    $0xc,%eax
{
80101408:	89 e5                	mov    %esp,%ebp
8010140a:	56                   	push   %esi
8010140b:	53                   	push   %ebx
  bp = bread(dev, BBLOCK(b, sb));
8010140c:	03 05 cc 25 11 80    	add    0x801125cc,%eax
{
80101412:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
80101414:	83 ec 08             	sub    $0x8,%esp
80101417:	50                   	push   %eax
80101418:	51                   	push   %ecx
80101419:	e8 b2 ec ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
8010141e:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
80101420:	c1 fb 03             	sar    $0x3,%ebx
80101423:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
80101426:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
80101428:	83 e1 07             	and    $0x7,%ecx
8010142b:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
80101430:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  m = 1 << (bi % 8);
80101436:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
80101438:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
8010143d:	85 c1                	test   %eax,%ecx
8010143f:	74 23                	je     80101464 <bfree+0x64>
  bp->data[bi/8] &= ~m;
80101441:	f7 d0                	not    %eax
  log_write(bp);
80101443:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101446:	21 c8                	and    %ecx,%eax
80101448:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
8010144c:	56                   	push   %esi
8010144d:	e8 de 1a 00 00       	call   80102f30 <log_write>
  brelse(bp);
80101452:	89 34 24             	mov    %esi,(%esp)
80101455:	e8 96 ed ff ff       	call   801001f0 <brelse>
}
8010145a:	83 c4 10             	add    $0x10,%esp
8010145d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101460:	5b                   	pop    %ebx
80101461:	5e                   	pop    %esi
80101462:	5d                   	pop    %ebp
80101463:	c3                   	ret
    panic("freeing free block");
80101464:	83 ec 0c             	sub    $0xc,%esp
80101467:	68 d4 7e 10 80       	push   $0x80107ed4
8010146c:	e8 0f ef ff ff       	call   80100380 <panic>
80101471:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101478:	00 
80101479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101480 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101480:	55                   	push   %ebp
80101481:	89 e5                	mov    %esp,%ebp
80101483:	57                   	push   %edi
80101484:	56                   	push   %esi
80101485:	89 c6                	mov    %eax,%esi
80101487:	53                   	push   %ebx
80101488:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010148b:	83 fa 0b             	cmp    $0xb,%edx
8010148e:	0f 86 8c 00 00 00    	jbe    80101520 <bmap+0xa0>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101494:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
80101497:	83 fb 7f             	cmp    $0x7f,%ebx
8010149a:	0f 87 a2 00 00 00    	ja     80101542 <bmap+0xc2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
801014a0:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
801014a6:	85 c0                	test   %eax,%eax
801014a8:	74 5e                	je     80101508 <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801014aa:	83 ec 08             	sub    $0x8,%esp
801014ad:	50                   	push   %eax
801014ae:	ff 36                	push   (%esi)
801014b0:	e8 1b ec ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
801014b5:	83 c4 10             	add    $0x10,%esp
801014b8:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
    bp = bread(ip->dev, addr);
801014bc:	89 c2                	mov    %eax,%edx
    if((addr = a[bn]) == 0){
801014be:	8b 3b                	mov    (%ebx),%edi
801014c0:	85 ff                	test   %edi,%edi
801014c2:	74 1c                	je     801014e0 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
801014c4:	83 ec 0c             	sub    $0xc,%esp
801014c7:	52                   	push   %edx
801014c8:	e8 23 ed ff ff       	call   801001f0 <brelse>
801014cd:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
801014d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014d3:	89 f8                	mov    %edi,%eax
801014d5:	5b                   	pop    %ebx
801014d6:	5e                   	pop    %esi
801014d7:	5f                   	pop    %edi
801014d8:	5d                   	pop    %ebp
801014d9:	c3                   	ret
801014da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801014e0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
801014e3:	8b 06                	mov    (%esi),%eax
801014e5:	e8 06 fd ff ff       	call   801011f0 <balloc>
      log_write(bp);
801014ea:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801014ed:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
801014f0:	89 03                	mov    %eax,(%ebx)
801014f2:	89 c7                	mov    %eax,%edi
      log_write(bp);
801014f4:	52                   	push   %edx
801014f5:	e8 36 1a 00 00       	call   80102f30 <log_write>
801014fa:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801014fd:	83 c4 10             	add    $0x10,%esp
80101500:	eb c2                	jmp    801014c4 <bmap+0x44>
80101502:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101508:	8b 06                	mov    (%esi),%eax
8010150a:	e8 e1 fc ff ff       	call   801011f0 <balloc>
8010150f:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80101515:	eb 93                	jmp    801014aa <bmap+0x2a>
80101517:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010151e:	00 
8010151f:	90                   	nop
    if((addr = ip->addrs[bn]) == 0)
80101520:	8d 5a 14             	lea    0x14(%edx),%ebx
80101523:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
80101527:	85 ff                	test   %edi,%edi
80101529:	75 a5                	jne    801014d0 <bmap+0x50>
      ip->addrs[bn] = addr = balloc(ip->dev);
8010152b:	8b 00                	mov    (%eax),%eax
8010152d:	e8 be fc ff ff       	call   801011f0 <balloc>
80101532:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
80101536:	89 c7                	mov    %eax,%edi
}
80101538:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010153b:	5b                   	pop    %ebx
8010153c:	89 f8                	mov    %edi,%eax
8010153e:	5e                   	pop    %esi
8010153f:	5f                   	pop    %edi
80101540:	5d                   	pop    %ebp
80101541:	c3                   	ret
  panic("bmap: out of range");
80101542:	83 ec 0c             	sub    $0xc,%esp
80101545:	68 e7 7e 10 80       	push   $0x80107ee7
8010154a:	e8 31 ee ff ff       	call   80100380 <panic>
8010154f:	90                   	nop

80101550 <readsb>:
{
80101550:	55                   	push   %ebp
80101551:	89 e5                	mov    %esp,%ebp
80101553:	56                   	push   %esi
80101554:	53                   	push   %ebx
80101555:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101558:	83 ec 08             	sub    $0x8,%esp
8010155b:	6a 01                	push   $0x1
8010155d:	ff 75 08             	push   0x8(%ebp)
80101560:	e8 6b eb ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101565:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80101568:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010156a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010156d:	6a 1c                	push   $0x1c
8010156f:	50                   	push   %eax
80101570:	56                   	push   %esi
80101571:	e8 7a 3d 00 00       	call   801052f0 <memmove>
  brelse(bp);
80101576:	83 c4 10             	add    $0x10,%esp
80101579:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010157c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010157f:	5b                   	pop    %ebx
80101580:	5e                   	pop    %esi
80101581:	5d                   	pop    %ebp
  brelse(bp);
80101582:	e9 69 ec ff ff       	jmp    801001f0 <brelse>
80101587:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010158e:	00 
8010158f:	90                   	nop

80101590 <iinit>:
{
80101590:	55                   	push   %ebp
80101591:	89 e5                	mov    %esp,%ebp
80101593:	53                   	push   %ebx
80101594:	bb a0 09 11 80       	mov    $0x801109a0,%ebx
80101599:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010159c:	68 fa 7e 10 80       	push   $0x80107efa
801015a1:	68 60 09 11 80       	push   $0x80110960
801015a6:	e8 c5 39 00 00       	call   80104f70 <initlock>
  for(i = 0; i < NINODE; i++) {
801015ab:	83 c4 10             	add    $0x10,%esp
801015ae:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801015b0:	83 ec 08             	sub    $0x8,%esp
801015b3:	68 01 7f 10 80       	push   $0x80107f01
801015b8:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
801015b9:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
801015bf:	e8 7c 38 00 00       	call   80104e40 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801015c4:	83 c4 10             	add    $0x10,%esp
801015c7:	81 fb c0 25 11 80    	cmp    $0x801125c0,%ebx
801015cd:	75 e1                	jne    801015b0 <iinit+0x20>
  bp = bread(dev, 1);
801015cf:	83 ec 08             	sub    $0x8,%esp
801015d2:	6a 01                	push   $0x1
801015d4:	ff 75 08             	push   0x8(%ebp)
801015d7:	e8 f4 ea ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801015dc:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
801015df:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801015e1:	8d 40 5c             	lea    0x5c(%eax),%eax
801015e4:	6a 1c                	push   $0x1c
801015e6:	50                   	push   %eax
801015e7:	68 b4 25 11 80       	push   $0x801125b4
801015ec:	e8 ff 3c 00 00       	call   801052f0 <memmove>
  brelse(bp);
801015f1:	89 1c 24             	mov    %ebx,(%esp)
801015f4:	e8 f7 eb ff ff       	call   801001f0 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801015f9:	ff 35 cc 25 11 80    	push   0x801125cc
801015ff:	ff 35 c8 25 11 80    	push   0x801125c8
80101605:	ff 35 c4 25 11 80    	push   0x801125c4
8010160b:	ff 35 c0 25 11 80    	push   0x801125c0
80101611:	ff 35 bc 25 11 80    	push   0x801125bc
80101617:	ff 35 b8 25 11 80    	push   0x801125b8
8010161d:	ff 35 b4 25 11 80    	push   0x801125b4
80101623:	68 5c 83 10 80       	push   $0x8010835c
80101628:	e8 83 f0 ff ff       	call   801006b0 <cprintf>
}
8010162d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101630:	83 c4 30             	add    $0x30,%esp
80101633:	c9                   	leave
80101634:	c3                   	ret
80101635:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010163c:	00 
8010163d:	8d 76 00             	lea    0x0(%esi),%esi

80101640 <ialloc>:
{
80101640:	55                   	push   %ebp
80101641:	89 e5                	mov    %esp,%ebp
80101643:	57                   	push   %edi
80101644:	56                   	push   %esi
80101645:	53                   	push   %ebx
80101646:	83 ec 1c             	sub    $0x1c,%esp
80101649:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
8010164c:	83 3d bc 25 11 80 01 	cmpl   $0x1,0x801125bc
{
80101653:	8b 75 08             	mov    0x8(%ebp),%esi
80101656:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101659:	0f 86 91 00 00 00    	jbe    801016f0 <ialloc+0xb0>
8010165f:	bf 01 00 00 00       	mov    $0x1,%edi
80101664:	eb 21                	jmp    80101687 <ialloc+0x47>
80101666:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010166d:	00 
8010166e:	66 90                	xchg   %ax,%ax
    brelse(bp);
80101670:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101673:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
80101676:	53                   	push   %ebx
80101677:	e8 74 eb ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010167c:	83 c4 10             	add    $0x10,%esp
8010167f:	3b 3d bc 25 11 80    	cmp    0x801125bc,%edi
80101685:	73 69                	jae    801016f0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101687:	89 f8                	mov    %edi,%eax
80101689:	83 ec 08             	sub    $0x8,%esp
8010168c:	c1 e8 03             	shr    $0x3,%eax
8010168f:	03 05 c8 25 11 80    	add    0x801125c8,%eax
80101695:	50                   	push   %eax
80101696:	56                   	push   %esi
80101697:	e8 34 ea ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
8010169c:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
8010169f:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
801016a1:	89 f8                	mov    %edi,%eax
801016a3:	83 e0 07             	and    $0x7,%eax
801016a6:	c1 e0 06             	shl    $0x6,%eax
801016a9:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801016ad:	66 83 39 00          	cmpw   $0x0,(%ecx)
801016b1:	75 bd                	jne    80101670 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
801016b3:	83 ec 04             	sub    $0x4,%esp
801016b6:	6a 40                	push   $0x40
801016b8:	6a 00                	push   $0x0
801016ba:	51                   	push   %ecx
801016bb:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801016be:	e8 9d 3b 00 00       	call   80105260 <memset>
      dip->type = type;
801016c3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801016c7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801016ca:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801016cd:	89 1c 24             	mov    %ebx,(%esp)
801016d0:	e8 5b 18 00 00       	call   80102f30 <log_write>
      brelse(bp);
801016d5:	89 1c 24             	mov    %ebx,(%esp)
801016d8:	e8 13 eb ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
801016dd:	83 c4 10             	add    $0x10,%esp
}
801016e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801016e3:	89 fa                	mov    %edi,%edx
}
801016e5:	5b                   	pop    %ebx
      return iget(dev, inum);
801016e6:	89 f0                	mov    %esi,%eax
}
801016e8:	5e                   	pop    %esi
801016e9:	5f                   	pop    %edi
801016ea:	5d                   	pop    %ebp
      return iget(dev, inum);
801016eb:	e9 10 fc ff ff       	jmp    80101300 <iget>
  panic("ialloc: no inodes");
801016f0:	83 ec 0c             	sub    $0xc,%esp
801016f3:	68 07 7f 10 80       	push   $0x80107f07
801016f8:	e8 83 ec ff ff       	call   80100380 <panic>
801016fd:	8d 76 00             	lea    0x0(%esi),%esi

80101700 <iupdate>:
{
80101700:	55                   	push   %ebp
80101701:	89 e5                	mov    %esp,%ebp
80101703:	56                   	push   %esi
80101704:	53                   	push   %ebx
80101705:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101708:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010170b:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010170e:	83 ec 08             	sub    $0x8,%esp
80101711:	c1 e8 03             	shr    $0x3,%eax
80101714:	03 05 c8 25 11 80    	add    0x801125c8,%eax
8010171a:	50                   	push   %eax
8010171b:	ff 73 a4             	push   -0x5c(%ebx)
8010171e:	e8 ad e9 ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
80101723:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101727:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010172a:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010172c:	8b 43 a8             	mov    -0x58(%ebx),%eax
8010172f:	83 e0 07             	and    $0x7,%eax
80101732:	c1 e0 06             	shl    $0x6,%eax
80101735:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101739:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010173c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101740:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101743:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101747:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010174b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010174f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101753:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101757:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010175a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010175d:	6a 34                	push   $0x34
8010175f:	53                   	push   %ebx
80101760:	50                   	push   %eax
80101761:	e8 8a 3b 00 00       	call   801052f0 <memmove>
  log_write(bp);
80101766:	89 34 24             	mov    %esi,(%esp)
80101769:	e8 c2 17 00 00       	call   80102f30 <log_write>
  brelse(bp);
8010176e:	83 c4 10             	add    $0x10,%esp
80101771:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101774:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101777:	5b                   	pop    %ebx
80101778:	5e                   	pop    %esi
80101779:	5d                   	pop    %ebp
  brelse(bp);
8010177a:	e9 71 ea ff ff       	jmp    801001f0 <brelse>
8010177f:	90                   	nop

80101780 <idup>:
{
80101780:	55                   	push   %ebp
80101781:	89 e5                	mov    %esp,%ebp
80101783:	53                   	push   %ebx
80101784:	83 ec 10             	sub    $0x10,%esp
80101787:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010178a:	68 60 09 11 80       	push   $0x80110960
8010178f:	e8 cc 39 00 00       	call   80105160 <acquire>
  ip->ref++;
80101794:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101798:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
8010179f:	e8 5c 39 00 00       	call   80105100 <release>
}
801017a4:	89 d8                	mov    %ebx,%eax
801017a6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801017a9:	c9                   	leave
801017aa:	c3                   	ret
801017ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801017b0 <ilock>:
{
801017b0:	55                   	push   %ebp
801017b1:	89 e5                	mov    %esp,%ebp
801017b3:	56                   	push   %esi
801017b4:	53                   	push   %ebx
801017b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
801017b8:	85 db                	test   %ebx,%ebx
801017ba:	0f 84 b7 00 00 00    	je     80101877 <ilock+0xc7>
801017c0:	8b 53 08             	mov    0x8(%ebx),%edx
801017c3:	85 d2                	test   %edx,%edx
801017c5:	0f 8e ac 00 00 00    	jle    80101877 <ilock+0xc7>
  acquiresleep(&ip->lock);
801017cb:	83 ec 0c             	sub    $0xc,%esp
801017ce:	8d 43 0c             	lea    0xc(%ebx),%eax
801017d1:	50                   	push   %eax
801017d2:	e8 a9 36 00 00       	call   80104e80 <acquiresleep>
  if(ip->valid == 0){
801017d7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801017da:	83 c4 10             	add    $0x10,%esp
801017dd:	85 c0                	test   %eax,%eax
801017df:	74 0f                	je     801017f0 <ilock+0x40>
}
801017e1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801017e4:	5b                   	pop    %ebx
801017e5:	5e                   	pop    %esi
801017e6:	5d                   	pop    %ebp
801017e7:	c3                   	ret
801017e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801017ef:	00 
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017f0:	8b 43 04             	mov    0x4(%ebx),%eax
801017f3:	83 ec 08             	sub    $0x8,%esp
801017f6:	c1 e8 03             	shr    $0x3,%eax
801017f9:	03 05 c8 25 11 80    	add    0x801125c8,%eax
801017ff:	50                   	push   %eax
80101800:	ff 33                	push   (%ebx)
80101802:	e8 c9 e8 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101807:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010180a:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010180c:	8b 43 04             	mov    0x4(%ebx),%eax
8010180f:	83 e0 07             	and    $0x7,%eax
80101812:	c1 e0 06             	shl    $0x6,%eax
80101815:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101819:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010181c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
8010181f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101823:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101827:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010182b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010182f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101833:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101837:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010183b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010183e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101841:	6a 34                	push   $0x34
80101843:	50                   	push   %eax
80101844:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101847:	50                   	push   %eax
80101848:	e8 a3 3a 00 00       	call   801052f0 <memmove>
    brelse(bp);
8010184d:	89 34 24             	mov    %esi,(%esp)
80101850:	e8 9b e9 ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
80101855:	83 c4 10             	add    $0x10,%esp
80101858:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010185d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101864:	0f 85 77 ff ff ff    	jne    801017e1 <ilock+0x31>
      panic("ilock: no type");
8010186a:	83 ec 0c             	sub    $0xc,%esp
8010186d:	68 1f 7f 10 80       	push   $0x80107f1f
80101872:	e8 09 eb ff ff       	call   80100380 <panic>
    panic("ilock");
80101877:	83 ec 0c             	sub    $0xc,%esp
8010187a:	68 19 7f 10 80       	push   $0x80107f19
8010187f:	e8 fc ea ff ff       	call   80100380 <panic>
80101884:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010188b:	00 
8010188c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101890 <iunlock>:
{
80101890:	55                   	push   %ebp
80101891:	89 e5                	mov    %esp,%ebp
80101893:	56                   	push   %esi
80101894:	53                   	push   %ebx
80101895:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101898:	85 db                	test   %ebx,%ebx
8010189a:	74 28                	je     801018c4 <iunlock+0x34>
8010189c:	83 ec 0c             	sub    $0xc,%esp
8010189f:	8d 73 0c             	lea    0xc(%ebx),%esi
801018a2:	56                   	push   %esi
801018a3:	e8 78 36 00 00       	call   80104f20 <holdingsleep>
801018a8:	83 c4 10             	add    $0x10,%esp
801018ab:	85 c0                	test   %eax,%eax
801018ad:	74 15                	je     801018c4 <iunlock+0x34>
801018af:	8b 43 08             	mov    0x8(%ebx),%eax
801018b2:	85 c0                	test   %eax,%eax
801018b4:	7e 0e                	jle    801018c4 <iunlock+0x34>
  releasesleep(&ip->lock);
801018b6:	89 75 08             	mov    %esi,0x8(%ebp)
}
801018b9:	8d 65 f8             	lea    -0x8(%ebp),%esp
801018bc:	5b                   	pop    %ebx
801018bd:	5e                   	pop    %esi
801018be:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
801018bf:	e9 1c 36 00 00       	jmp    80104ee0 <releasesleep>
    panic("iunlock");
801018c4:	83 ec 0c             	sub    $0xc,%esp
801018c7:	68 2e 7f 10 80       	push   $0x80107f2e
801018cc:	e8 af ea ff ff       	call   80100380 <panic>
801018d1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801018d8:	00 
801018d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801018e0 <iput>:
{
801018e0:	55                   	push   %ebp
801018e1:	89 e5                	mov    %esp,%ebp
801018e3:	57                   	push   %edi
801018e4:	56                   	push   %esi
801018e5:	53                   	push   %ebx
801018e6:	83 ec 28             	sub    $0x28,%esp
801018e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
801018ec:	8d 7b 0c             	lea    0xc(%ebx),%edi
801018ef:	57                   	push   %edi
801018f0:	e8 8b 35 00 00       	call   80104e80 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801018f5:	8b 53 4c             	mov    0x4c(%ebx),%edx
801018f8:	83 c4 10             	add    $0x10,%esp
801018fb:	85 d2                	test   %edx,%edx
801018fd:	74 07                	je     80101906 <iput+0x26>
801018ff:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101904:	74 32                	je     80101938 <iput+0x58>
  releasesleep(&ip->lock);
80101906:	83 ec 0c             	sub    $0xc,%esp
80101909:	57                   	push   %edi
8010190a:	e8 d1 35 00 00       	call   80104ee0 <releasesleep>
  acquire(&icache.lock);
8010190f:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101916:	e8 45 38 00 00       	call   80105160 <acquire>
  ip->ref--;
8010191b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
8010191f:	83 c4 10             	add    $0x10,%esp
80101922:	c7 45 08 60 09 11 80 	movl   $0x80110960,0x8(%ebp)
}
80101929:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010192c:	5b                   	pop    %ebx
8010192d:	5e                   	pop    %esi
8010192e:	5f                   	pop    %edi
8010192f:	5d                   	pop    %ebp
  release(&icache.lock);
80101930:	e9 cb 37 00 00       	jmp    80105100 <release>
80101935:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101938:	83 ec 0c             	sub    $0xc,%esp
8010193b:	68 60 09 11 80       	push   $0x80110960
80101940:	e8 1b 38 00 00       	call   80105160 <acquire>
    int r = ip->ref;
80101945:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101948:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
8010194f:	e8 ac 37 00 00       	call   80105100 <release>
    if(r == 1){
80101954:	83 c4 10             	add    $0x10,%esp
80101957:	83 fe 01             	cmp    $0x1,%esi
8010195a:	75 aa                	jne    80101906 <iput+0x26>
8010195c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101962:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101965:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101968:	89 df                	mov    %ebx,%edi
8010196a:	89 cb                	mov    %ecx,%ebx
8010196c:	eb 09                	jmp    80101977 <iput+0x97>
8010196e:	66 90                	xchg   %ax,%ax
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101970:	83 c6 04             	add    $0x4,%esi
80101973:	39 de                	cmp    %ebx,%esi
80101975:	74 19                	je     80101990 <iput+0xb0>
    if(ip->addrs[i]){
80101977:	8b 16                	mov    (%esi),%edx
80101979:	85 d2                	test   %edx,%edx
8010197b:	74 f3                	je     80101970 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010197d:	8b 07                	mov    (%edi),%eax
8010197f:	e8 7c fa ff ff       	call   80101400 <bfree>
      ip->addrs[i] = 0;
80101984:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010198a:	eb e4                	jmp    80101970 <iput+0x90>
8010198c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101990:	89 fb                	mov    %edi,%ebx
80101992:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101995:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
8010199b:	85 c0                	test   %eax,%eax
8010199d:	75 2d                	jne    801019cc <iput+0xec>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010199f:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
801019a2:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
801019a9:	53                   	push   %ebx
801019aa:	e8 51 fd ff ff       	call   80101700 <iupdate>
      ip->type = 0;
801019af:	31 c0                	xor    %eax,%eax
801019b1:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
801019b5:	89 1c 24             	mov    %ebx,(%esp)
801019b8:	e8 43 fd ff ff       	call   80101700 <iupdate>
      ip->valid = 0;
801019bd:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
801019c4:	83 c4 10             	add    $0x10,%esp
801019c7:	e9 3a ff ff ff       	jmp    80101906 <iput+0x26>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801019cc:	83 ec 08             	sub    $0x8,%esp
801019cf:	50                   	push   %eax
801019d0:	ff 33                	push   (%ebx)
801019d2:	e8 f9 e6 ff ff       	call   801000d0 <bread>
    for(j = 0; j < NINDIRECT; j++){
801019d7:	83 c4 10             	add    $0x10,%esp
801019da:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801019dd:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
801019e3:	89 45 e0             	mov    %eax,-0x20(%ebp)
801019e6:	8d 70 5c             	lea    0x5c(%eax),%esi
801019e9:	89 cf                	mov    %ecx,%edi
801019eb:	eb 0a                	jmp    801019f7 <iput+0x117>
801019ed:	8d 76 00             	lea    0x0(%esi),%esi
801019f0:	83 c6 04             	add    $0x4,%esi
801019f3:	39 fe                	cmp    %edi,%esi
801019f5:	74 0f                	je     80101a06 <iput+0x126>
      if(a[j])
801019f7:	8b 16                	mov    (%esi),%edx
801019f9:	85 d2                	test   %edx,%edx
801019fb:	74 f3                	je     801019f0 <iput+0x110>
        bfree(ip->dev, a[j]);
801019fd:	8b 03                	mov    (%ebx),%eax
801019ff:	e8 fc f9 ff ff       	call   80101400 <bfree>
80101a04:	eb ea                	jmp    801019f0 <iput+0x110>
    brelse(bp);
80101a06:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101a09:	83 ec 0c             	sub    $0xc,%esp
80101a0c:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101a0f:	50                   	push   %eax
80101a10:	e8 db e7 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101a15:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101a1b:	8b 03                	mov    (%ebx),%eax
80101a1d:	e8 de f9 ff ff       	call   80101400 <bfree>
    ip->addrs[NDIRECT] = 0;
80101a22:	83 c4 10             	add    $0x10,%esp
80101a25:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101a2c:	00 00 00 
80101a2f:	e9 6b ff ff ff       	jmp    8010199f <iput+0xbf>
80101a34:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101a3b:	00 
80101a3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101a40 <iunlockput>:
{
80101a40:	55                   	push   %ebp
80101a41:	89 e5                	mov    %esp,%ebp
80101a43:	56                   	push   %esi
80101a44:	53                   	push   %ebx
80101a45:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101a48:	85 db                	test   %ebx,%ebx
80101a4a:	74 34                	je     80101a80 <iunlockput+0x40>
80101a4c:	83 ec 0c             	sub    $0xc,%esp
80101a4f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101a52:	56                   	push   %esi
80101a53:	e8 c8 34 00 00       	call   80104f20 <holdingsleep>
80101a58:	83 c4 10             	add    $0x10,%esp
80101a5b:	85 c0                	test   %eax,%eax
80101a5d:	74 21                	je     80101a80 <iunlockput+0x40>
80101a5f:	8b 43 08             	mov    0x8(%ebx),%eax
80101a62:	85 c0                	test   %eax,%eax
80101a64:	7e 1a                	jle    80101a80 <iunlockput+0x40>
  releasesleep(&ip->lock);
80101a66:	83 ec 0c             	sub    $0xc,%esp
80101a69:	56                   	push   %esi
80101a6a:	e8 71 34 00 00       	call   80104ee0 <releasesleep>
  iput(ip);
80101a6f:	83 c4 10             	add    $0x10,%esp
80101a72:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101a75:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101a78:	5b                   	pop    %ebx
80101a79:	5e                   	pop    %esi
80101a7a:	5d                   	pop    %ebp
  iput(ip);
80101a7b:	e9 60 fe ff ff       	jmp    801018e0 <iput>
    panic("iunlock");
80101a80:	83 ec 0c             	sub    $0xc,%esp
80101a83:	68 2e 7f 10 80       	push   $0x80107f2e
80101a88:	e8 f3 e8 ff ff       	call   80100380 <panic>
80101a8d:	8d 76 00             	lea    0x0(%esi),%esi

80101a90 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101a90:	55                   	push   %ebp
80101a91:	89 e5                	mov    %esp,%ebp
80101a93:	8b 55 08             	mov    0x8(%ebp),%edx
80101a96:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101a99:	8b 0a                	mov    (%edx),%ecx
80101a9b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101a9e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101aa1:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101aa4:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101aa8:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101aab:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101aaf:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101ab3:	8b 52 58             	mov    0x58(%edx),%edx
80101ab6:	89 50 10             	mov    %edx,0x10(%eax)
}
80101ab9:	5d                   	pop    %ebp
80101aba:	c3                   	ret
80101abb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80101ac0 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101ac0:	55                   	push   %ebp
80101ac1:	89 e5                	mov    %esp,%ebp
80101ac3:	57                   	push   %edi
80101ac4:	56                   	push   %esi
80101ac5:	53                   	push   %ebx
80101ac6:	83 ec 1c             	sub    $0x1c,%esp
80101ac9:	8b 75 08             	mov    0x8(%ebp),%esi
80101acc:	8b 45 0c             	mov    0xc(%ebp),%eax
80101acf:	8b 7d 10             	mov    0x10(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101ad2:	66 83 7e 50 03       	cmpw   $0x3,0x50(%esi)
{
80101ad7:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101ada:	89 75 d8             	mov    %esi,-0x28(%ebp)
80101add:	8b 45 14             	mov    0x14(%ebp),%eax
  if(ip->type == T_DEV){
80101ae0:	0f 84 aa 00 00 00    	je     80101b90 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101ae6:	8b 75 d8             	mov    -0x28(%ebp),%esi
80101ae9:	8b 56 58             	mov    0x58(%esi),%edx
80101aec:	39 fa                	cmp    %edi,%edx
80101aee:	0f 82 bd 00 00 00    	jb     80101bb1 <readi+0xf1>
80101af4:	89 f9                	mov    %edi,%ecx
80101af6:	31 db                	xor    %ebx,%ebx
80101af8:	01 c1                	add    %eax,%ecx
80101afa:	0f 92 c3             	setb   %bl
80101afd:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80101b00:	0f 82 ab 00 00 00    	jb     80101bb1 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101b06:	89 d3                	mov    %edx,%ebx
80101b08:	29 fb                	sub    %edi,%ebx
80101b0a:	39 ca                	cmp    %ecx,%edx
80101b0c:	0f 42 c3             	cmovb  %ebx,%eax

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b0f:	85 c0                	test   %eax,%eax
80101b11:	74 73                	je     80101b86 <readi+0xc6>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101b13:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80101b16:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101b19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b20:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101b23:	89 fa                	mov    %edi,%edx
80101b25:	c1 ea 09             	shr    $0x9,%edx
80101b28:	89 d8                	mov    %ebx,%eax
80101b2a:	e8 51 f9 ff ff       	call   80101480 <bmap>
80101b2f:	83 ec 08             	sub    $0x8,%esp
80101b32:	50                   	push   %eax
80101b33:	ff 33                	push   (%ebx)
80101b35:	e8 96 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101b3a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101b3d:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b42:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101b44:	89 f8                	mov    %edi,%eax
80101b46:	25 ff 01 00 00       	and    $0x1ff,%eax
80101b4b:	29 f3                	sub    %esi,%ebx
80101b4d:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101b4f:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101b53:	39 d9                	cmp    %ebx,%ecx
80101b55:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101b58:	83 c4 0c             	add    $0xc,%esp
80101b5b:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b5c:	01 de                	add    %ebx,%esi
80101b5e:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101b60:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101b63:	50                   	push   %eax
80101b64:	ff 75 e0             	push   -0x20(%ebp)
80101b67:	e8 84 37 00 00       	call   801052f0 <memmove>
    brelse(bp);
80101b6c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101b6f:	89 14 24             	mov    %edx,(%esp)
80101b72:	e8 79 e6 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b77:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101b7a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101b7d:	83 c4 10             	add    $0x10,%esp
80101b80:	39 de                	cmp    %ebx,%esi
80101b82:	72 9c                	jb     80101b20 <readi+0x60>
80101b84:	89 d8                	mov    %ebx,%eax
  }
  return n;
}
80101b86:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b89:	5b                   	pop    %ebx
80101b8a:	5e                   	pop    %esi
80101b8b:	5f                   	pop    %edi
80101b8c:	5d                   	pop    %ebp
80101b8d:	c3                   	ret
80101b8e:	66 90                	xchg   %ax,%ax
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101b90:	0f bf 56 52          	movswl 0x52(%esi),%edx
80101b94:	66 83 fa 09          	cmp    $0x9,%dx
80101b98:	77 17                	ja     80101bb1 <readi+0xf1>
80101b9a:	8b 14 d5 00 09 11 80 	mov    -0x7feef700(,%edx,8),%edx
80101ba1:	85 d2                	test   %edx,%edx
80101ba3:	74 0c                	je     80101bb1 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101ba5:	89 45 10             	mov    %eax,0x10(%ebp)
}
80101ba8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101bab:	5b                   	pop    %ebx
80101bac:	5e                   	pop    %esi
80101bad:	5f                   	pop    %edi
80101bae:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101baf:	ff e2                	jmp    *%edx
      return -1;
80101bb1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101bb6:	eb ce                	jmp    80101b86 <readi+0xc6>
80101bb8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101bbf:	00 

80101bc0 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101bc0:	55                   	push   %ebp
80101bc1:	89 e5                	mov    %esp,%ebp
80101bc3:	57                   	push   %edi
80101bc4:	56                   	push   %esi
80101bc5:	53                   	push   %ebx
80101bc6:	83 ec 1c             	sub    $0x1c,%esp
80101bc9:	8b 45 08             	mov    0x8(%ebp),%eax
80101bcc:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101bcf:	8b 75 14             	mov    0x14(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101bd2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101bd7:	89 7d dc             	mov    %edi,-0x24(%ebp)
80101bda:	89 75 e0             	mov    %esi,-0x20(%ebp)
80101bdd:	8b 7d 10             	mov    0x10(%ebp),%edi
  if(ip->type == T_DEV){
80101be0:	0f 84 ba 00 00 00    	je     80101ca0 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101be6:	39 78 58             	cmp    %edi,0x58(%eax)
80101be9:	0f 82 ea 00 00 00    	jb     80101cd9 <writei+0x119>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101bef:	8b 75 e0             	mov    -0x20(%ebp),%esi
80101bf2:	89 f2                	mov    %esi,%edx
80101bf4:	01 fa                	add    %edi,%edx
80101bf6:	0f 82 dd 00 00 00    	jb     80101cd9 <writei+0x119>
80101bfc:	81 fa 00 18 01 00    	cmp    $0x11800,%edx
80101c02:	0f 87 d1 00 00 00    	ja     80101cd9 <writei+0x119>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c08:	85 f6                	test   %esi,%esi
80101c0a:	0f 84 85 00 00 00    	je     80101c95 <writei+0xd5>
80101c10:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101c17:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101c1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c20:	8b 75 d8             	mov    -0x28(%ebp),%esi
80101c23:	89 fa                	mov    %edi,%edx
80101c25:	c1 ea 09             	shr    $0x9,%edx
80101c28:	89 f0                	mov    %esi,%eax
80101c2a:	e8 51 f8 ff ff       	call   80101480 <bmap>
80101c2f:	83 ec 08             	sub    $0x8,%esp
80101c32:	50                   	push   %eax
80101c33:	ff 36                	push   (%esi)
80101c35:	e8 96 e4 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101c3a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101c3d:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101c40:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c45:	89 c6                	mov    %eax,%esi
    m = min(n - tot, BSIZE - off%BSIZE);
80101c47:	89 f8                	mov    %edi,%eax
80101c49:	25 ff 01 00 00       	and    $0x1ff,%eax
80101c4e:	29 d3                	sub    %edx,%ebx
80101c50:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101c52:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101c56:	39 d9                	cmp    %ebx,%ecx
80101c58:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101c5b:	83 c4 0c             	add    $0xc,%esp
80101c5e:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c5f:	01 df                	add    %ebx,%edi
    memmove(bp->data + off%BSIZE, src, m);
80101c61:	ff 75 dc             	push   -0x24(%ebp)
80101c64:	50                   	push   %eax
80101c65:	e8 86 36 00 00       	call   801052f0 <memmove>
    log_write(bp);
80101c6a:	89 34 24             	mov    %esi,(%esp)
80101c6d:	e8 be 12 00 00       	call   80102f30 <log_write>
    brelse(bp);
80101c72:	89 34 24             	mov    %esi,(%esp)
80101c75:	e8 76 e5 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c7a:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101c7d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101c80:	83 c4 10             	add    $0x10,%esp
80101c83:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101c86:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101c89:	39 d8                	cmp    %ebx,%eax
80101c8b:	72 93                	jb     80101c20 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101c8d:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101c90:	39 78 58             	cmp    %edi,0x58(%eax)
80101c93:	72 33                	jb     80101cc8 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101c95:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101c98:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c9b:	5b                   	pop    %ebx
80101c9c:	5e                   	pop    %esi
80101c9d:	5f                   	pop    %edi
80101c9e:	5d                   	pop    %ebp
80101c9f:	c3                   	ret
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101ca0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101ca4:	66 83 f8 09          	cmp    $0x9,%ax
80101ca8:	77 2f                	ja     80101cd9 <writei+0x119>
80101caa:	8b 04 c5 04 09 11 80 	mov    -0x7feef6fc(,%eax,8),%eax
80101cb1:	85 c0                	test   %eax,%eax
80101cb3:	74 24                	je     80101cd9 <writei+0x119>
    return devsw[ip->major].write(ip, src, n);
80101cb5:	89 75 10             	mov    %esi,0x10(%ebp)
}
80101cb8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101cbb:	5b                   	pop    %ebx
80101cbc:	5e                   	pop    %esi
80101cbd:	5f                   	pop    %edi
80101cbe:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101cbf:	ff e0                	jmp    *%eax
80101cc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    iupdate(ip);
80101cc8:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101ccb:	89 78 58             	mov    %edi,0x58(%eax)
    iupdate(ip);
80101cce:	50                   	push   %eax
80101ccf:	e8 2c fa ff ff       	call   80101700 <iupdate>
80101cd4:	83 c4 10             	add    $0x10,%esp
80101cd7:	eb bc                	jmp    80101c95 <writei+0xd5>
      return -1;
80101cd9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101cde:	eb b8                	jmp    80101c98 <writei+0xd8>

80101ce0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101ce0:	55                   	push   %ebp
80101ce1:	89 e5                	mov    %esp,%ebp
80101ce3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101ce6:	6a 0e                	push   $0xe
80101ce8:	ff 75 0c             	push   0xc(%ebp)
80101ceb:	ff 75 08             	push   0x8(%ebp)
80101cee:	e8 6d 36 00 00       	call   80105360 <strncmp>
}
80101cf3:	c9                   	leave
80101cf4:	c3                   	ret
80101cf5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101cfc:	00 
80101cfd:	8d 76 00             	lea    0x0(%esi),%esi

80101d00 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101d00:	55                   	push   %ebp
80101d01:	89 e5                	mov    %esp,%ebp
80101d03:	57                   	push   %edi
80101d04:	56                   	push   %esi
80101d05:	53                   	push   %ebx
80101d06:	83 ec 1c             	sub    $0x1c,%esp
80101d09:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101d0c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101d11:	0f 85 85 00 00 00    	jne    80101d9c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101d17:	8b 53 58             	mov    0x58(%ebx),%edx
80101d1a:	31 ff                	xor    %edi,%edi
80101d1c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101d1f:	85 d2                	test   %edx,%edx
80101d21:	74 3e                	je     80101d61 <dirlookup+0x61>
80101d23:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101d28:	6a 10                	push   $0x10
80101d2a:	57                   	push   %edi
80101d2b:	56                   	push   %esi
80101d2c:	53                   	push   %ebx
80101d2d:	e8 8e fd ff ff       	call   80101ac0 <readi>
80101d32:	83 c4 10             	add    $0x10,%esp
80101d35:	83 f8 10             	cmp    $0x10,%eax
80101d38:	75 55                	jne    80101d8f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101d3a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101d3f:	74 18                	je     80101d59 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101d41:	83 ec 04             	sub    $0x4,%esp
80101d44:	8d 45 da             	lea    -0x26(%ebp),%eax
80101d47:	6a 0e                	push   $0xe
80101d49:	50                   	push   %eax
80101d4a:	ff 75 0c             	push   0xc(%ebp)
80101d4d:	e8 0e 36 00 00       	call   80105360 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101d52:	83 c4 10             	add    $0x10,%esp
80101d55:	85 c0                	test   %eax,%eax
80101d57:	74 17                	je     80101d70 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101d59:	83 c7 10             	add    $0x10,%edi
80101d5c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101d5f:	72 c7                	jb     80101d28 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101d61:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101d64:	31 c0                	xor    %eax,%eax
}
80101d66:	5b                   	pop    %ebx
80101d67:	5e                   	pop    %esi
80101d68:	5f                   	pop    %edi
80101d69:	5d                   	pop    %ebp
80101d6a:	c3                   	ret
80101d6b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(poff)
80101d70:	8b 45 10             	mov    0x10(%ebp),%eax
80101d73:	85 c0                	test   %eax,%eax
80101d75:	74 05                	je     80101d7c <dirlookup+0x7c>
        *poff = off;
80101d77:	8b 45 10             	mov    0x10(%ebp),%eax
80101d7a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101d7c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101d80:	8b 03                	mov    (%ebx),%eax
80101d82:	e8 79 f5 ff ff       	call   80101300 <iget>
}
80101d87:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d8a:	5b                   	pop    %ebx
80101d8b:	5e                   	pop    %esi
80101d8c:	5f                   	pop    %edi
80101d8d:	5d                   	pop    %ebp
80101d8e:	c3                   	ret
      panic("dirlookup read");
80101d8f:	83 ec 0c             	sub    $0xc,%esp
80101d92:	68 48 7f 10 80       	push   $0x80107f48
80101d97:	e8 e4 e5 ff ff       	call   80100380 <panic>
    panic("dirlookup not DIR");
80101d9c:	83 ec 0c             	sub    $0xc,%esp
80101d9f:	68 36 7f 10 80       	push   $0x80107f36
80101da4:	e8 d7 e5 ff ff       	call   80100380 <panic>
80101da9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101db0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101db0:	55                   	push   %ebp
80101db1:	89 e5                	mov    %esp,%ebp
80101db3:	57                   	push   %edi
80101db4:	56                   	push   %esi
80101db5:	53                   	push   %ebx
80101db6:	89 c3                	mov    %eax,%ebx
80101db8:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101dbb:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101dbe:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101dc1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80101dc4:	0f 84 9e 01 00 00    	je     80101f68 <namex+0x1b8>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101dca:	e8 11 1d 00 00       	call   80103ae0 <myproc>
  acquire(&icache.lock);
80101dcf:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101dd2:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101dd5:	68 60 09 11 80       	push   $0x80110960
80101dda:	e8 81 33 00 00       	call   80105160 <acquire>
  ip->ref++;
80101ddf:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101de3:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101dea:	e8 11 33 00 00       	call   80105100 <release>
80101def:	83 c4 10             	add    $0x10,%esp
80101df2:	eb 07                	jmp    80101dfb <namex+0x4b>
80101df4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101df8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101dfb:	0f b6 03             	movzbl (%ebx),%eax
80101dfe:	3c 2f                	cmp    $0x2f,%al
80101e00:	74 f6                	je     80101df8 <namex+0x48>
  if(*path == 0)
80101e02:	84 c0                	test   %al,%al
80101e04:	0f 84 06 01 00 00    	je     80101f10 <namex+0x160>
  while(*path != '/' && *path != 0)
80101e0a:	0f b6 03             	movzbl (%ebx),%eax
80101e0d:	84 c0                	test   %al,%al
80101e0f:	0f 84 10 01 00 00    	je     80101f25 <namex+0x175>
80101e15:	89 df                	mov    %ebx,%edi
80101e17:	3c 2f                	cmp    $0x2f,%al
80101e19:	0f 84 06 01 00 00    	je     80101f25 <namex+0x175>
80101e1f:	90                   	nop
80101e20:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
80101e24:	83 c7 01             	add    $0x1,%edi
  while(*path != '/' && *path != 0)
80101e27:	3c 2f                	cmp    $0x2f,%al
80101e29:	74 04                	je     80101e2f <namex+0x7f>
80101e2b:	84 c0                	test   %al,%al
80101e2d:	75 f1                	jne    80101e20 <namex+0x70>
  len = path - s;
80101e2f:	89 f8                	mov    %edi,%eax
80101e31:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
80101e33:	83 f8 0d             	cmp    $0xd,%eax
80101e36:	0f 8e ac 00 00 00    	jle    80101ee8 <namex+0x138>
    memmove(name, s, DIRSIZ);
80101e3c:	83 ec 04             	sub    $0x4,%esp
80101e3f:	6a 0e                	push   $0xe
80101e41:	53                   	push   %ebx
80101e42:	89 fb                	mov    %edi,%ebx
80101e44:	ff 75 e4             	push   -0x1c(%ebp)
80101e47:	e8 a4 34 00 00       	call   801052f0 <memmove>
80101e4c:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80101e4f:	80 3f 2f             	cmpb   $0x2f,(%edi)
80101e52:	75 0c                	jne    80101e60 <namex+0xb0>
80101e54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101e58:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101e5b:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101e5e:	74 f8                	je     80101e58 <namex+0xa8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101e60:	83 ec 0c             	sub    $0xc,%esp
80101e63:	56                   	push   %esi
80101e64:	e8 47 f9 ff ff       	call   801017b0 <ilock>
    if(ip->type != T_DIR){
80101e69:	83 c4 10             	add    $0x10,%esp
80101e6c:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101e71:	0f 85 b7 00 00 00    	jne    80101f2e <namex+0x17e>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101e77:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101e7a:	85 c0                	test   %eax,%eax
80101e7c:	74 09                	je     80101e87 <namex+0xd7>
80101e7e:	80 3b 00             	cmpb   $0x0,(%ebx)
80101e81:	0f 84 f7 00 00 00    	je     80101f7e <namex+0x1ce>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101e87:	83 ec 04             	sub    $0x4,%esp
80101e8a:	6a 00                	push   $0x0
80101e8c:	ff 75 e4             	push   -0x1c(%ebp)
80101e8f:	56                   	push   %esi
80101e90:	e8 6b fe ff ff       	call   80101d00 <dirlookup>
80101e95:	83 c4 10             	add    $0x10,%esp
80101e98:	89 c7                	mov    %eax,%edi
80101e9a:	85 c0                	test   %eax,%eax
80101e9c:	0f 84 8c 00 00 00    	je     80101f2e <namex+0x17e>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101ea2:	83 ec 0c             	sub    $0xc,%esp
80101ea5:	8d 4e 0c             	lea    0xc(%esi),%ecx
80101ea8:	51                   	push   %ecx
80101ea9:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101eac:	e8 6f 30 00 00       	call   80104f20 <holdingsleep>
80101eb1:	83 c4 10             	add    $0x10,%esp
80101eb4:	85 c0                	test   %eax,%eax
80101eb6:	0f 84 02 01 00 00    	je     80101fbe <namex+0x20e>
80101ebc:	8b 56 08             	mov    0x8(%esi),%edx
80101ebf:	85 d2                	test   %edx,%edx
80101ec1:	0f 8e f7 00 00 00    	jle    80101fbe <namex+0x20e>
  releasesleep(&ip->lock);
80101ec7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101eca:	83 ec 0c             	sub    $0xc,%esp
80101ecd:	51                   	push   %ecx
80101ece:	e8 0d 30 00 00       	call   80104ee0 <releasesleep>
  iput(ip);
80101ed3:	89 34 24             	mov    %esi,(%esp)
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
    ip = next;
80101ed6:	89 fe                	mov    %edi,%esi
  iput(ip);
80101ed8:	e8 03 fa ff ff       	call   801018e0 <iput>
80101edd:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80101ee0:	e9 16 ff ff ff       	jmp    80101dfb <namex+0x4b>
80101ee5:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
80101ee8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101eeb:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    memmove(name, s, len);
80101eee:	83 ec 04             	sub    $0x4,%esp
80101ef1:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101ef4:	50                   	push   %eax
80101ef5:	53                   	push   %ebx
    name[len] = 0;
80101ef6:	89 fb                	mov    %edi,%ebx
    memmove(name, s, len);
80101ef8:	ff 75 e4             	push   -0x1c(%ebp)
80101efb:	e8 f0 33 00 00       	call   801052f0 <memmove>
    name[len] = 0;
80101f00:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101f03:	83 c4 10             	add    $0x10,%esp
80101f06:	c6 01 00             	movb   $0x0,(%ecx)
80101f09:	e9 41 ff ff ff       	jmp    80101e4f <namex+0x9f>
80101f0e:	66 90                	xchg   %ax,%ax
  }
  if(nameiparent){
80101f10:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101f13:	85 c0                	test   %eax,%eax
80101f15:	0f 85 93 00 00 00    	jne    80101fae <namex+0x1fe>
    iput(ip);
    return 0;
  }
  return ip;
}
80101f1b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f1e:	89 f0                	mov    %esi,%eax
80101f20:	5b                   	pop    %ebx
80101f21:	5e                   	pop    %esi
80101f22:	5f                   	pop    %edi
80101f23:	5d                   	pop    %ebp
80101f24:	c3                   	ret
  while(*path != '/' && *path != 0)
80101f25:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101f28:	89 df                	mov    %ebx,%edi
80101f2a:	31 c0                	xor    %eax,%eax
80101f2c:	eb c0                	jmp    80101eee <namex+0x13e>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101f2e:	83 ec 0c             	sub    $0xc,%esp
80101f31:	8d 5e 0c             	lea    0xc(%esi),%ebx
80101f34:	53                   	push   %ebx
80101f35:	e8 e6 2f 00 00       	call   80104f20 <holdingsleep>
80101f3a:	83 c4 10             	add    $0x10,%esp
80101f3d:	85 c0                	test   %eax,%eax
80101f3f:	74 7d                	je     80101fbe <namex+0x20e>
80101f41:	8b 4e 08             	mov    0x8(%esi),%ecx
80101f44:	85 c9                	test   %ecx,%ecx
80101f46:	7e 76                	jle    80101fbe <namex+0x20e>
  releasesleep(&ip->lock);
80101f48:	83 ec 0c             	sub    $0xc,%esp
80101f4b:	53                   	push   %ebx
80101f4c:	e8 8f 2f 00 00       	call   80104ee0 <releasesleep>
  iput(ip);
80101f51:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101f54:	31 f6                	xor    %esi,%esi
  iput(ip);
80101f56:	e8 85 f9 ff ff       	call   801018e0 <iput>
      return 0;
80101f5b:	83 c4 10             	add    $0x10,%esp
}
80101f5e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f61:	89 f0                	mov    %esi,%eax
80101f63:	5b                   	pop    %ebx
80101f64:	5e                   	pop    %esi
80101f65:	5f                   	pop    %edi
80101f66:	5d                   	pop    %ebp
80101f67:	c3                   	ret
    ip = iget(ROOTDEV, ROOTINO);
80101f68:	ba 01 00 00 00       	mov    $0x1,%edx
80101f6d:	b8 01 00 00 00       	mov    $0x1,%eax
80101f72:	e8 89 f3 ff ff       	call   80101300 <iget>
80101f77:	89 c6                	mov    %eax,%esi
80101f79:	e9 7d fe ff ff       	jmp    80101dfb <namex+0x4b>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101f7e:	83 ec 0c             	sub    $0xc,%esp
80101f81:	8d 5e 0c             	lea    0xc(%esi),%ebx
80101f84:	53                   	push   %ebx
80101f85:	e8 96 2f 00 00       	call   80104f20 <holdingsleep>
80101f8a:	83 c4 10             	add    $0x10,%esp
80101f8d:	85 c0                	test   %eax,%eax
80101f8f:	74 2d                	je     80101fbe <namex+0x20e>
80101f91:	8b 7e 08             	mov    0x8(%esi),%edi
80101f94:	85 ff                	test   %edi,%edi
80101f96:	7e 26                	jle    80101fbe <namex+0x20e>
  releasesleep(&ip->lock);
80101f98:	83 ec 0c             	sub    $0xc,%esp
80101f9b:	53                   	push   %ebx
80101f9c:	e8 3f 2f 00 00       	call   80104ee0 <releasesleep>
}
80101fa1:	83 c4 10             	add    $0x10,%esp
}
80101fa4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fa7:	89 f0                	mov    %esi,%eax
80101fa9:	5b                   	pop    %ebx
80101faa:	5e                   	pop    %esi
80101fab:	5f                   	pop    %edi
80101fac:	5d                   	pop    %ebp
80101fad:	c3                   	ret
    iput(ip);
80101fae:	83 ec 0c             	sub    $0xc,%esp
80101fb1:	56                   	push   %esi
      return 0;
80101fb2:	31 f6                	xor    %esi,%esi
    iput(ip);
80101fb4:	e8 27 f9 ff ff       	call   801018e0 <iput>
    return 0;
80101fb9:	83 c4 10             	add    $0x10,%esp
80101fbc:	eb a0                	jmp    80101f5e <namex+0x1ae>
    panic("iunlock");
80101fbe:	83 ec 0c             	sub    $0xc,%esp
80101fc1:	68 2e 7f 10 80       	push   $0x80107f2e
80101fc6:	e8 b5 e3 ff ff       	call   80100380 <panic>
80101fcb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80101fd0 <dirlink>:
{
80101fd0:	55                   	push   %ebp
80101fd1:	89 e5                	mov    %esp,%ebp
80101fd3:	57                   	push   %edi
80101fd4:	56                   	push   %esi
80101fd5:	53                   	push   %ebx
80101fd6:	83 ec 20             	sub    $0x20,%esp
80101fd9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101fdc:	6a 00                	push   $0x0
80101fde:	ff 75 0c             	push   0xc(%ebp)
80101fe1:	53                   	push   %ebx
80101fe2:	e8 19 fd ff ff       	call   80101d00 <dirlookup>
80101fe7:	83 c4 10             	add    $0x10,%esp
80101fea:	85 c0                	test   %eax,%eax
80101fec:	75 67                	jne    80102055 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101fee:	8b 7b 58             	mov    0x58(%ebx),%edi
80101ff1:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101ff4:	85 ff                	test   %edi,%edi
80101ff6:	74 29                	je     80102021 <dirlink+0x51>
80101ff8:	31 ff                	xor    %edi,%edi
80101ffa:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101ffd:	eb 09                	jmp    80102008 <dirlink+0x38>
80101fff:	90                   	nop
80102000:	83 c7 10             	add    $0x10,%edi
80102003:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102006:	73 19                	jae    80102021 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102008:	6a 10                	push   $0x10
8010200a:	57                   	push   %edi
8010200b:	56                   	push   %esi
8010200c:	53                   	push   %ebx
8010200d:	e8 ae fa ff ff       	call   80101ac0 <readi>
80102012:	83 c4 10             	add    $0x10,%esp
80102015:	83 f8 10             	cmp    $0x10,%eax
80102018:	75 4e                	jne    80102068 <dirlink+0x98>
    if(de.inum == 0)
8010201a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010201f:	75 df                	jne    80102000 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80102021:	83 ec 04             	sub    $0x4,%esp
80102024:	8d 45 da             	lea    -0x26(%ebp),%eax
80102027:	6a 0e                	push   $0xe
80102029:	ff 75 0c             	push   0xc(%ebp)
8010202c:	50                   	push   %eax
8010202d:	e8 7e 33 00 00       	call   801053b0 <strncpy>
  de.inum = inum;
80102032:	8b 45 10             	mov    0x10(%ebp),%eax
80102035:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102039:	6a 10                	push   $0x10
8010203b:	57                   	push   %edi
8010203c:	56                   	push   %esi
8010203d:	53                   	push   %ebx
8010203e:	e8 7d fb ff ff       	call   80101bc0 <writei>
80102043:	83 c4 20             	add    $0x20,%esp
80102046:	83 f8 10             	cmp    $0x10,%eax
80102049:	75 2a                	jne    80102075 <dirlink+0xa5>
  return 0;
8010204b:	31 c0                	xor    %eax,%eax
}
8010204d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102050:	5b                   	pop    %ebx
80102051:	5e                   	pop    %esi
80102052:	5f                   	pop    %edi
80102053:	5d                   	pop    %ebp
80102054:	c3                   	ret
    iput(ip);
80102055:	83 ec 0c             	sub    $0xc,%esp
80102058:	50                   	push   %eax
80102059:	e8 82 f8 ff ff       	call   801018e0 <iput>
    return -1;
8010205e:	83 c4 10             	add    $0x10,%esp
80102061:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102066:	eb e5                	jmp    8010204d <dirlink+0x7d>
      panic("dirlink read");
80102068:	83 ec 0c             	sub    $0xc,%esp
8010206b:	68 57 7f 10 80       	push   $0x80107f57
80102070:	e8 0b e3 ff ff       	call   80100380 <panic>
    panic("dirlink");
80102075:	83 ec 0c             	sub    $0xc,%esp
80102078:	68 f9 81 10 80       	push   $0x801081f9
8010207d:	e8 fe e2 ff ff       	call   80100380 <panic>
80102082:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102089:	00 
8010208a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102090 <namei>:

struct inode*
namei(char *path)
{
80102090:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102091:	31 d2                	xor    %edx,%edx
{
80102093:	89 e5                	mov    %esp,%ebp
80102095:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80102098:	8b 45 08             	mov    0x8(%ebp),%eax
8010209b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
8010209e:	e8 0d fd ff ff       	call   80101db0 <namex>
}
801020a3:	c9                   	leave
801020a4:	c3                   	ret
801020a5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801020ac:	00 
801020ad:	8d 76 00             	lea    0x0(%esi),%esi

801020b0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
801020b0:	55                   	push   %ebp
  return namex(path, 1, name);
801020b1:	ba 01 00 00 00       	mov    $0x1,%edx
{
801020b6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
801020b8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801020bb:	8b 45 08             	mov    0x8(%ebp),%eax
}
801020be:	5d                   	pop    %ebp
  return namex(path, 1, name);
801020bf:	e9 ec fc ff ff       	jmp    80101db0 <namex>
801020c4:	66 90                	xchg   %ax,%ax
801020c6:	66 90                	xchg   %ax,%ax
801020c8:	66 90                	xchg   %ax,%ax
801020ca:	66 90                	xchg   %ax,%ax
801020cc:	66 90                	xchg   %ax,%ax
801020ce:	66 90                	xchg   %ax,%ax

801020d0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801020d0:	55                   	push   %ebp
801020d1:	89 e5                	mov    %esp,%ebp
801020d3:	57                   	push   %edi
801020d4:	56                   	push   %esi
801020d5:	53                   	push   %ebx
801020d6:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
801020d9:	85 c0                	test   %eax,%eax
801020db:	0f 84 b4 00 00 00    	je     80102195 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
801020e1:	8b 70 08             	mov    0x8(%eax),%esi
801020e4:	89 c3                	mov    %eax,%ebx
801020e6:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
801020ec:	0f 87 96 00 00 00    	ja     80102188 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020f2:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
801020f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801020fe:	00 
801020ff:	90                   	nop
80102100:	89 ca                	mov    %ecx,%edx
80102102:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102103:	83 e0 c0             	and    $0xffffffc0,%eax
80102106:	3c 40                	cmp    $0x40,%al
80102108:	75 f6                	jne    80102100 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010210a:	31 ff                	xor    %edi,%edi
8010210c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102111:	89 f8                	mov    %edi,%eax
80102113:	ee                   	out    %al,(%dx)
80102114:	b8 01 00 00 00       	mov    $0x1,%eax
80102119:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010211e:	ee                   	out    %al,(%dx)
8010211f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102124:	89 f0                	mov    %esi,%eax
80102126:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102127:	89 f0                	mov    %esi,%eax
80102129:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010212e:	c1 f8 08             	sar    $0x8,%eax
80102131:	ee                   	out    %al,(%dx)
80102132:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102137:	89 f8                	mov    %edi,%eax
80102139:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
8010213a:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
8010213e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102143:	c1 e0 04             	shl    $0x4,%eax
80102146:	83 e0 10             	and    $0x10,%eax
80102149:	83 c8 e0             	or     $0xffffffe0,%eax
8010214c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010214d:	f6 03 04             	testb  $0x4,(%ebx)
80102150:	75 16                	jne    80102168 <idestart+0x98>
80102152:	b8 20 00 00 00       	mov    $0x20,%eax
80102157:	89 ca                	mov    %ecx,%edx
80102159:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010215a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010215d:	5b                   	pop    %ebx
8010215e:	5e                   	pop    %esi
8010215f:	5f                   	pop    %edi
80102160:	5d                   	pop    %ebp
80102161:	c3                   	ret
80102162:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102168:	b8 30 00 00 00       	mov    $0x30,%eax
8010216d:	89 ca                	mov    %ecx,%edx
8010216f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102170:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102175:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102178:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010217d:	fc                   	cld
8010217e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102180:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102183:	5b                   	pop    %ebx
80102184:	5e                   	pop    %esi
80102185:	5f                   	pop    %edi
80102186:	5d                   	pop    %ebp
80102187:	c3                   	ret
    panic("incorrect blockno");
80102188:	83 ec 0c             	sub    $0xc,%esp
8010218b:	68 6d 7f 10 80       	push   $0x80107f6d
80102190:	e8 eb e1 ff ff       	call   80100380 <panic>
    panic("idestart");
80102195:	83 ec 0c             	sub    $0xc,%esp
80102198:	68 64 7f 10 80       	push   $0x80107f64
8010219d:	e8 de e1 ff ff       	call   80100380 <panic>
801021a2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801021a9:	00 
801021aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801021b0 <ideinit>:
{
801021b0:	55                   	push   %ebp
801021b1:	89 e5                	mov    %esp,%ebp
801021b3:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
801021b6:	68 7f 7f 10 80       	push   $0x80107f7f
801021bb:	68 00 26 11 80       	push   $0x80112600
801021c0:	e8 ab 2d 00 00       	call   80104f70 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801021c5:	58                   	pop    %eax
801021c6:	a1 84 27 11 80       	mov    0x80112784,%eax
801021cb:	5a                   	pop    %edx
801021cc:	83 e8 01             	sub    $0x1,%eax
801021cf:	50                   	push   %eax
801021d0:	6a 0e                	push   $0xe
801021d2:	e8 99 02 00 00       	call   80102470 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801021d7:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801021da:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
801021df:	90                   	nop
801021e0:	89 ca                	mov    %ecx,%edx
801021e2:	ec                   	in     (%dx),%al
801021e3:	83 e0 c0             	and    $0xffffffc0,%eax
801021e6:	3c 40                	cmp    $0x40,%al
801021e8:	75 f6                	jne    801021e0 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801021ea:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
801021ef:	ba f6 01 00 00       	mov    $0x1f6,%edx
801021f4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801021f5:	89 ca                	mov    %ecx,%edx
801021f7:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
801021f8:	84 c0                	test   %al,%al
801021fa:	75 1e                	jne    8010221a <ideinit+0x6a>
801021fc:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
80102201:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102206:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010220d:	00 
8010220e:	66 90                	xchg   %ax,%ax
  for(i=0; i<1000; i++){
80102210:	83 e9 01             	sub    $0x1,%ecx
80102213:	74 0f                	je     80102224 <ideinit+0x74>
80102215:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102216:	84 c0                	test   %al,%al
80102218:	74 f6                	je     80102210 <ideinit+0x60>
      havedisk1 = 1;
8010221a:	c7 05 e0 25 11 80 01 	movl   $0x1,0x801125e0
80102221:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102224:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102229:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010222e:	ee                   	out    %al,(%dx)
}
8010222f:	c9                   	leave
80102230:	c3                   	ret
80102231:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102238:	00 
80102239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102240 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102240:	55                   	push   %ebp
80102241:	89 e5                	mov    %esp,%ebp
80102243:	57                   	push   %edi
80102244:	56                   	push   %esi
80102245:	53                   	push   %ebx
80102246:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102249:	68 00 26 11 80       	push   $0x80112600
8010224e:	e8 0d 2f 00 00       	call   80105160 <acquire>

  if((b = idequeue) == 0){
80102253:	8b 1d e4 25 11 80    	mov    0x801125e4,%ebx
80102259:	83 c4 10             	add    $0x10,%esp
8010225c:	85 db                	test   %ebx,%ebx
8010225e:	74 63                	je     801022c3 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102260:	8b 43 58             	mov    0x58(%ebx),%eax
80102263:	a3 e4 25 11 80       	mov    %eax,0x801125e4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102268:	8b 33                	mov    (%ebx),%esi
8010226a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102270:	75 2f                	jne    801022a1 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102272:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102277:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010227e:	00 
8010227f:	90                   	nop
80102280:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102281:	89 c1                	mov    %eax,%ecx
80102283:	83 e1 c0             	and    $0xffffffc0,%ecx
80102286:	80 f9 40             	cmp    $0x40,%cl
80102289:	75 f5                	jne    80102280 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010228b:	a8 21                	test   $0x21,%al
8010228d:	75 12                	jne    801022a1 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
8010228f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102292:	b9 80 00 00 00       	mov    $0x80,%ecx
80102297:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010229c:	fc                   	cld
8010229d:	f3 6d                	rep insl (%dx),%es:(%edi)

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
8010229f:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
801022a1:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
801022a4:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
801022a7:	83 ce 02             	or     $0x2,%esi
801022aa:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
801022ac:	53                   	push   %ebx
801022ad:	e8 8e 27 00 00       	call   80104a40 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801022b2:	a1 e4 25 11 80       	mov    0x801125e4,%eax
801022b7:	83 c4 10             	add    $0x10,%esp
801022ba:	85 c0                	test   %eax,%eax
801022bc:	74 05                	je     801022c3 <ideintr+0x83>
    idestart(idequeue);
801022be:	e8 0d fe ff ff       	call   801020d0 <idestart>
    release(&idelock);
801022c3:	83 ec 0c             	sub    $0xc,%esp
801022c6:	68 00 26 11 80       	push   $0x80112600
801022cb:	e8 30 2e 00 00       	call   80105100 <release>

  release(&idelock);
}
801022d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801022d3:	5b                   	pop    %ebx
801022d4:	5e                   	pop    %esi
801022d5:	5f                   	pop    %edi
801022d6:	5d                   	pop    %ebp
801022d7:	c3                   	ret
801022d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801022df:	00 

801022e0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801022e0:	55                   	push   %ebp
801022e1:	89 e5                	mov    %esp,%ebp
801022e3:	53                   	push   %ebx
801022e4:	83 ec 10             	sub    $0x10,%esp
801022e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801022ea:	8d 43 0c             	lea    0xc(%ebx),%eax
801022ed:	50                   	push   %eax
801022ee:	e8 2d 2c 00 00       	call   80104f20 <holdingsleep>
801022f3:	83 c4 10             	add    $0x10,%esp
801022f6:	85 c0                	test   %eax,%eax
801022f8:	0f 84 c3 00 00 00    	je     801023c1 <iderw+0xe1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801022fe:	8b 03                	mov    (%ebx),%eax
80102300:	83 e0 06             	and    $0x6,%eax
80102303:	83 f8 02             	cmp    $0x2,%eax
80102306:	0f 84 a8 00 00 00    	je     801023b4 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010230c:	8b 53 04             	mov    0x4(%ebx),%edx
8010230f:	85 d2                	test   %edx,%edx
80102311:	74 0d                	je     80102320 <iderw+0x40>
80102313:	a1 e0 25 11 80       	mov    0x801125e0,%eax
80102318:	85 c0                	test   %eax,%eax
8010231a:	0f 84 87 00 00 00    	je     801023a7 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102320:	83 ec 0c             	sub    $0xc,%esp
80102323:	68 00 26 11 80       	push   $0x80112600
80102328:	e8 33 2e 00 00       	call   80105160 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010232d:	a1 e4 25 11 80       	mov    0x801125e4,%eax
  b->qnext = 0;
80102332:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102339:	83 c4 10             	add    $0x10,%esp
8010233c:	85 c0                	test   %eax,%eax
8010233e:	74 60                	je     801023a0 <iderw+0xc0>
80102340:	89 c2                	mov    %eax,%edx
80102342:	8b 40 58             	mov    0x58(%eax),%eax
80102345:	85 c0                	test   %eax,%eax
80102347:	75 f7                	jne    80102340 <iderw+0x60>
80102349:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
8010234c:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
8010234e:	39 1d e4 25 11 80    	cmp    %ebx,0x801125e4
80102354:	74 3a                	je     80102390 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102356:	8b 03                	mov    (%ebx),%eax
80102358:	83 e0 06             	and    $0x6,%eax
8010235b:	83 f8 02             	cmp    $0x2,%eax
8010235e:	74 1b                	je     8010237b <iderw+0x9b>
    sleep(b, &idelock);
80102360:	83 ec 08             	sub    $0x8,%esp
80102363:	68 00 26 11 80       	push   $0x80112600
80102368:	53                   	push   %ebx
80102369:	e8 12 26 00 00       	call   80104980 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010236e:	8b 03                	mov    (%ebx),%eax
80102370:	83 c4 10             	add    $0x10,%esp
80102373:	83 e0 06             	and    $0x6,%eax
80102376:	83 f8 02             	cmp    $0x2,%eax
80102379:	75 e5                	jne    80102360 <iderw+0x80>
  }


  release(&idelock);
8010237b:	c7 45 08 00 26 11 80 	movl   $0x80112600,0x8(%ebp)
}
80102382:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102385:	c9                   	leave
  release(&idelock);
80102386:	e9 75 2d 00 00       	jmp    80105100 <release>
8010238b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    idestart(b);
80102390:	89 d8                	mov    %ebx,%eax
80102392:	e8 39 fd ff ff       	call   801020d0 <idestart>
80102397:	eb bd                	jmp    80102356 <iderw+0x76>
80102399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801023a0:	ba e4 25 11 80       	mov    $0x801125e4,%edx
801023a5:	eb a5                	jmp    8010234c <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
801023a7:	83 ec 0c             	sub    $0xc,%esp
801023aa:	68 ae 7f 10 80       	push   $0x80107fae
801023af:	e8 cc df ff ff       	call   80100380 <panic>
    panic("iderw: nothing to do");
801023b4:	83 ec 0c             	sub    $0xc,%esp
801023b7:	68 99 7f 10 80       	push   $0x80107f99
801023bc:	e8 bf df ff ff       	call   80100380 <panic>
    panic("iderw: buf not locked");
801023c1:	83 ec 0c             	sub    $0xc,%esp
801023c4:	68 83 7f 10 80       	push   $0x80107f83
801023c9:	e8 b2 df ff ff       	call   80100380 <panic>
801023ce:	66 90                	xchg   %ax,%ax

801023d0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801023d0:	55                   	push   %ebp
801023d1:	89 e5                	mov    %esp,%ebp
801023d3:	56                   	push   %esi
801023d4:	53                   	push   %ebx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801023d5:	c7 05 34 26 11 80 00 	movl   $0xfec00000,0x80112634
801023dc:	00 c0 fe 
  ioapic->reg = reg;
801023df:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801023e6:	00 00 00 
  return ioapic->data;
801023e9:	8b 15 34 26 11 80    	mov    0x80112634,%edx
801023ef:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
801023f2:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
801023f8:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801023fe:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102405:	c1 ee 10             	shr    $0x10,%esi
80102408:	89 f0                	mov    %esi,%eax
8010240a:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
8010240d:	8b 43 10             	mov    0x10(%ebx),%eax
  id = ioapicread(REG_ID) >> 24;
80102410:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102413:	39 c2                	cmp    %eax,%edx
80102415:	74 16                	je     8010242d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102417:	83 ec 0c             	sub    $0xc,%esp
8010241a:	68 b0 83 10 80       	push   $0x801083b0
8010241f:	e8 8c e2 ff ff       	call   801006b0 <cprintf>
  ioapic->reg = reg;
80102424:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
8010242a:	83 c4 10             	add    $0x10,%esp
{
8010242d:	ba 10 00 00 00       	mov    $0x10,%edx
80102432:	31 c0                	xor    %eax,%eax
80102434:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  ioapic->reg = reg;
80102438:	89 13                	mov    %edx,(%ebx)
8010243a:	8d 48 20             	lea    0x20(%eax),%ecx
  ioapic->data = data;
8010243d:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102443:	83 c0 01             	add    $0x1,%eax
80102446:	81 c9 00 00 01 00    	or     $0x10000,%ecx
  ioapic->data = data;
8010244c:	89 4b 10             	mov    %ecx,0x10(%ebx)
  ioapic->reg = reg;
8010244f:	8d 4a 01             	lea    0x1(%edx),%ecx
  for(i = 0; i <= maxintr; i++){
80102452:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
80102455:	89 0b                	mov    %ecx,(%ebx)
  ioapic->data = data;
80102457:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
8010245d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
  for(i = 0; i <= maxintr; i++){
80102464:	39 c6                	cmp    %eax,%esi
80102466:	7d d0                	jge    80102438 <ioapicinit+0x68>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
80102468:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010246b:	5b                   	pop    %ebx
8010246c:	5e                   	pop    %esi
8010246d:	5d                   	pop    %ebp
8010246e:	c3                   	ret
8010246f:	90                   	nop

80102470 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102470:	55                   	push   %ebp
  ioapic->reg = reg;
80102471:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
{
80102477:	89 e5                	mov    %esp,%ebp
80102479:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010247c:	8d 50 20             	lea    0x20(%eax),%edx
8010247f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102483:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102485:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010248b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010248e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102491:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102494:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102496:	a1 34 26 11 80       	mov    0x80112634,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010249b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010249e:	89 50 10             	mov    %edx,0x10(%eax)
}
801024a1:	5d                   	pop    %ebp
801024a2:	c3                   	ret
801024a3:	66 90                	xchg   %ax,%ax
801024a5:	66 90                	xchg   %ax,%ax
801024a7:	66 90                	xchg   %ax,%ax
801024a9:	66 90                	xchg   %ax,%ax
801024ab:	66 90                	xchg   %ax,%ax
801024ad:	66 90                	xchg   %ax,%ax
801024af:	90                   	nop

801024b0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801024b0:	55                   	push   %ebp
801024b1:	89 e5                	mov    %esp,%ebp
801024b3:	53                   	push   %ebx
801024b4:	83 ec 04             	sub    $0x4,%esp
801024b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801024ba:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801024c0:	75 76                	jne    80102538 <kfree+0x88>
801024c2:	81 fb f0 77 11 80    	cmp    $0x801177f0,%ebx
801024c8:	72 6e                	jb     80102538 <kfree+0x88>
801024ca:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801024d0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801024d5:	77 61                	ja     80102538 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801024d7:	83 ec 04             	sub    $0x4,%esp
801024da:	68 00 10 00 00       	push   $0x1000
801024df:	6a 01                	push   $0x1
801024e1:	53                   	push   %ebx
801024e2:	e8 79 2d 00 00       	call   80105260 <memset>

  if(kmem.use_lock)
801024e7:	8b 15 74 26 11 80    	mov    0x80112674,%edx
801024ed:	83 c4 10             	add    $0x10,%esp
801024f0:	85 d2                	test   %edx,%edx
801024f2:	75 1c                	jne    80102510 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
801024f4:	a1 78 26 11 80       	mov    0x80112678,%eax
801024f9:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
801024fb:	a1 74 26 11 80       	mov    0x80112674,%eax
  kmem.freelist = r;
80102500:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
  if(kmem.use_lock)
80102506:	85 c0                	test   %eax,%eax
80102508:	75 1e                	jne    80102528 <kfree+0x78>
    release(&kmem.lock);
}
8010250a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010250d:	c9                   	leave
8010250e:	c3                   	ret
8010250f:	90                   	nop
    acquire(&kmem.lock);
80102510:	83 ec 0c             	sub    $0xc,%esp
80102513:	68 40 26 11 80       	push   $0x80112640
80102518:	e8 43 2c 00 00       	call   80105160 <acquire>
8010251d:	83 c4 10             	add    $0x10,%esp
80102520:	eb d2                	jmp    801024f4 <kfree+0x44>
80102522:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102528:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
}
8010252f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102532:	c9                   	leave
    release(&kmem.lock);
80102533:	e9 c8 2b 00 00       	jmp    80105100 <release>
    panic("kfree");
80102538:	83 ec 0c             	sub    $0xc,%esp
8010253b:	68 cc 7f 10 80       	push   $0x80107fcc
80102540:	e8 3b de ff ff       	call   80100380 <panic>
80102545:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010254c:	00 
8010254d:	8d 76 00             	lea    0x0(%esi),%esi

80102550 <freerange>:
{
80102550:	55                   	push   %ebp
80102551:	89 e5                	mov    %esp,%ebp
80102553:	56                   	push   %esi
80102554:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102555:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102558:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010255b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102561:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102567:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010256d:	39 de                	cmp    %ebx,%esi
8010256f:	72 23                	jb     80102594 <freerange+0x44>
80102571:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102578:	83 ec 0c             	sub    $0xc,%esp
8010257b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102581:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102587:	50                   	push   %eax
80102588:	e8 23 ff ff ff       	call   801024b0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010258d:	83 c4 10             	add    $0x10,%esp
80102590:	39 de                	cmp    %ebx,%esi
80102592:	73 e4                	jae    80102578 <freerange+0x28>
}
80102594:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102597:	5b                   	pop    %ebx
80102598:	5e                   	pop    %esi
80102599:	5d                   	pop    %ebp
8010259a:	c3                   	ret
8010259b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801025a0 <kinit2>:
{
801025a0:	55                   	push   %ebp
801025a1:	89 e5                	mov    %esp,%ebp
801025a3:	56                   	push   %esi
801025a4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801025a5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801025a8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801025ab:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801025b1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025b7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801025bd:	39 de                	cmp    %ebx,%esi
801025bf:	72 23                	jb     801025e4 <kinit2+0x44>
801025c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801025c8:	83 ec 0c             	sub    $0xc,%esp
801025cb:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025d1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801025d7:	50                   	push   %eax
801025d8:	e8 d3 fe ff ff       	call   801024b0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025dd:	83 c4 10             	add    $0x10,%esp
801025e0:	39 de                	cmp    %ebx,%esi
801025e2:	73 e4                	jae    801025c8 <kinit2+0x28>
  kmem.use_lock = 1;
801025e4:	c7 05 74 26 11 80 01 	movl   $0x1,0x80112674
801025eb:	00 00 00 
}
801025ee:	8d 65 f8             	lea    -0x8(%ebp),%esp
801025f1:	5b                   	pop    %ebx
801025f2:	5e                   	pop    %esi
801025f3:	5d                   	pop    %ebp
801025f4:	c3                   	ret
801025f5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801025fc:	00 
801025fd:	8d 76 00             	lea    0x0(%esi),%esi

80102600 <kinit1>:
{
80102600:	55                   	push   %ebp
80102601:	89 e5                	mov    %esp,%ebp
80102603:	56                   	push   %esi
80102604:	53                   	push   %ebx
80102605:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102608:	83 ec 08             	sub    $0x8,%esp
8010260b:	68 d2 7f 10 80       	push   $0x80107fd2
80102610:	68 40 26 11 80       	push   $0x80112640
80102615:	e8 56 29 00 00       	call   80104f70 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010261a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010261d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102620:	c7 05 74 26 11 80 00 	movl   $0x0,0x80112674
80102627:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010262a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102630:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102636:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010263c:	39 de                	cmp    %ebx,%esi
8010263e:	72 1c                	jb     8010265c <kinit1+0x5c>
    kfree(p);
80102640:	83 ec 0c             	sub    $0xc,%esp
80102643:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102649:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010264f:	50                   	push   %eax
80102650:	e8 5b fe ff ff       	call   801024b0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102655:	83 c4 10             	add    $0x10,%esp
80102658:	39 de                	cmp    %ebx,%esi
8010265a:	73 e4                	jae    80102640 <kinit1+0x40>
}
8010265c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010265f:	5b                   	pop    %ebx
80102660:	5e                   	pop    %esi
80102661:	5d                   	pop    %ebp
80102662:	c3                   	ret
80102663:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010266a:	00 
8010266b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102670 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102670:	55                   	push   %ebp
80102671:	89 e5                	mov    %esp,%ebp
80102673:	53                   	push   %ebx
80102674:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
80102677:	a1 74 26 11 80       	mov    0x80112674,%eax
8010267c:	85 c0                	test   %eax,%eax
8010267e:	75 20                	jne    801026a0 <kalloc+0x30>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102680:	8b 1d 78 26 11 80    	mov    0x80112678,%ebx
  if(r)
80102686:	85 db                	test   %ebx,%ebx
80102688:	74 07                	je     80102691 <kalloc+0x21>
    kmem.freelist = r->next;
8010268a:	8b 03                	mov    (%ebx),%eax
8010268c:	a3 78 26 11 80       	mov    %eax,0x80112678
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
80102691:	89 d8                	mov    %ebx,%eax
80102693:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102696:	c9                   	leave
80102697:	c3                   	ret
80102698:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010269f:	00 
    acquire(&kmem.lock);
801026a0:	83 ec 0c             	sub    $0xc,%esp
801026a3:	68 40 26 11 80       	push   $0x80112640
801026a8:	e8 b3 2a 00 00       	call   80105160 <acquire>
  r = kmem.freelist;
801026ad:	8b 1d 78 26 11 80    	mov    0x80112678,%ebx
  if(kmem.use_lock)
801026b3:	a1 74 26 11 80       	mov    0x80112674,%eax
  if(r)
801026b8:	83 c4 10             	add    $0x10,%esp
801026bb:	85 db                	test   %ebx,%ebx
801026bd:	74 08                	je     801026c7 <kalloc+0x57>
    kmem.freelist = r->next;
801026bf:	8b 13                	mov    (%ebx),%edx
801026c1:	89 15 78 26 11 80    	mov    %edx,0x80112678
  if(kmem.use_lock)
801026c7:	85 c0                	test   %eax,%eax
801026c9:	74 c6                	je     80102691 <kalloc+0x21>
    release(&kmem.lock);
801026cb:	83 ec 0c             	sub    $0xc,%esp
801026ce:	68 40 26 11 80       	push   $0x80112640
801026d3:	e8 28 2a 00 00       	call   80105100 <release>
}
801026d8:	89 d8                	mov    %ebx,%eax
    release(&kmem.lock);
801026da:	83 c4 10             	add    $0x10,%esp
}
801026dd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801026e0:	c9                   	leave
801026e1:	c3                   	ret
801026e2:	66 90                	xchg   %ax,%ax
801026e4:	66 90                	xchg   %ax,%ax
801026e6:	66 90                	xchg   %ax,%ax
801026e8:	66 90                	xchg   %ax,%ax
801026ea:	66 90                	xchg   %ax,%ax
801026ec:	66 90                	xchg   %ax,%ax
801026ee:	66 90                	xchg   %ax,%ax

801026f0 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801026f0:	ba 64 00 00 00       	mov    $0x64,%edx
801026f5:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801026f6:	a8 01                	test   $0x1,%al
801026f8:	0f 84 c2 00 00 00    	je     801027c0 <kbdgetc+0xd0>
{
801026fe:	55                   	push   %ebp
801026ff:	ba 60 00 00 00       	mov    $0x60,%edx
80102704:	89 e5                	mov    %esp,%ebp
80102706:	53                   	push   %ebx
80102707:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80102708:	8b 1d 7c 26 11 80    	mov    0x8011267c,%ebx
  data = inb(KBDATAP);
8010270e:	0f b6 c8             	movzbl %al,%ecx
  if(data == 0xE0){
80102711:	3c e0                	cmp    $0xe0,%al
80102713:	74 5b                	je     80102770 <kbdgetc+0x80>
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102715:	89 da                	mov    %ebx,%edx
80102717:	83 e2 40             	and    $0x40,%edx
  } else if(data & 0x80){
8010271a:	84 c0                	test   %al,%al
8010271c:	78 62                	js     80102780 <kbdgetc+0x90>
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
8010271e:	85 d2                	test   %edx,%edx
80102720:	74 09                	je     8010272b <kbdgetc+0x3b>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102722:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102725:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80102728:	0f b6 c8             	movzbl %al,%ecx
  }

  shift |= shiftcode[data];
8010272b:	0f b6 91 40 87 10 80 	movzbl -0x7fef78c0(%ecx),%edx
  shift ^= togglecode[data];
80102732:	0f b6 81 40 86 10 80 	movzbl -0x7fef79c0(%ecx),%eax
  shift |= shiftcode[data];
80102739:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
8010273b:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010273d:	89 d0                	mov    %edx,%eax
  shift ^= togglecode[data];
8010273f:	89 15 7c 26 11 80    	mov    %edx,0x8011267c
  c = charcode[shift & (CTL | SHIFT)][data];
80102745:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102748:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010274b:	8b 04 85 20 86 10 80 	mov    -0x7fef79e0(,%eax,4),%eax
80102752:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
80102756:	74 0b                	je     80102763 <kbdgetc+0x73>
    if('a' <= c && c <= 'z')
80102758:	8d 50 9f             	lea    -0x61(%eax),%edx
8010275b:	83 fa 19             	cmp    $0x19,%edx
8010275e:	77 48                	ja     801027a8 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102760:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102763:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102766:	c9                   	leave
80102767:	c3                   	ret
80102768:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010276f:	00 
    shift |= E0ESC;
80102770:	83 cb 40             	or     $0x40,%ebx
    return 0;
80102773:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102775:	89 1d 7c 26 11 80    	mov    %ebx,0x8011267c
}
8010277b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010277e:	c9                   	leave
8010277f:	c3                   	ret
    data = (shift & E0ESC ? data : data & 0x7F);
80102780:	83 e0 7f             	and    $0x7f,%eax
80102783:	85 d2                	test   %edx,%edx
80102785:	0f 44 c8             	cmove  %eax,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
80102788:	0f b6 81 40 87 10 80 	movzbl -0x7fef78c0(%ecx),%eax
8010278f:	83 c8 40             	or     $0x40,%eax
80102792:	0f b6 c0             	movzbl %al,%eax
80102795:	f7 d0                	not    %eax
80102797:	21 d8                	and    %ebx,%eax
80102799:	a3 7c 26 11 80       	mov    %eax,0x8011267c
    return 0;
8010279e:	31 c0                	xor    %eax,%eax
801027a0:	eb d9                	jmp    8010277b <kbdgetc+0x8b>
801027a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    else if('A' <= c && c <= 'Z')
801027a8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801027ab:	8d 50 20             	lea    0x20(%eax),%edx
}
801027ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801027b1:	c9                   	leave
      c += 'a' - 'A';
801027b2:	83 f9 1a             	cmp    $0x1a,%ecx
801027b5:	0f 42 c2             	cmovb  %edx,%eax
}
801027b8:	c3                   	ret
801027b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801027c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801027c5:	c3                   	ret
801027c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801027cd:	00 
801027ce:	66 90                	xchg   %ax,%ax

801027d0 <kbdintr>:

void
kbdintr(void)
{
801027d0:	55                   	push   %ebp
801027d1:	89 e5                	mov    %esp,%ebp
801027d3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801027d6:	68 f0 26 10 80       	push   $0x801026f0
801027db:	e8 c0 e0 ff ff       	call   801008a0 <consoleintr>
}
801027e0:	83 c4 10             	add    $0x10,%esp
801027e3:	c9                   	leave
801027e4:	c3                   	ret
801027e5:	66 90                	xchg   %ax,%ax
801027e7:	66 90                	xchg   %ax,%ax
801027e9:	66 90                	xchg   %ax,%ax
801027eb:	66 90                	xchg   %ax,%ax
801027ed:	66 90                	xchg   %ax,%ax
801027ef:	90                   	nop

801027f0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
801027f0:	a1 80 26 11 80       	mov    0x80112680,%eax
801027f5:	85 c0                	test   %eax,%eax
801027f7:	0f 84 c3 00 00 00    	je     801028c0 <lapicinit+0xd0>
  lapic[index] = value;
801027fd:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102804:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102807:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010280a:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102811:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102814:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102817:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
8010281e:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102821:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102824:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010282b:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
8010282e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102831:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102838:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010283b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010283e:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102845:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102848:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010284b:	8b 50 30             	mov    0x30(%eax),%edx
8010284e:	81 e2 00 00 fc 00    	and    $0xfc0000,%edx
80102854:	75 72                	jne    801028c8 <lapicinit+0xd8>
  lapic[index] = value;
80102856:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
8010285d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102860:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102863:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010286a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010286d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102870:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102877:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010287a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010287d:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102884:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102887:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010288a:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102891:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102894:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102897:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
8010289e:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801028a1:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801028a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801028a8:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801028ae:	80 e6 10             	and    $0x10,%dh
801028b1:	75 f5                	jne    801028a8 <lapicinit+0xb8>
  lapic[index] = value;
801028b3:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801028ba:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028bd:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801028c0:	c3                   	ret
801028c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
801028c8:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801028cf:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801028d2:	8b 50 20             	mov    0x20(%eax),%edx
}
801028d5:	e9 7c ff ff ff       	jmp    80102856 <lapicinit+0x66>
801028da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801028e0 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
801028e0:	a1 80 26 11 80       	mov    0x80112680,%eax
801028e5:	85 c0                	test   %eax,%eax
801028e7:	74 07                	je     801028f0 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
801028e9:	8b 40 20             	mov    0x20(%eax),%eax
801028ec:	c1 e8 18             	shr    $0x18,%eax
801028ef:	c3                   	ret
    return 0;
801028f0:	31 c0                	xor    %eax,%eax
}
801028f2:	c3                   	ret
801028f3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801028fa:	00 
801028fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102900 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102900:	a1 80 26 11 80       	mov    0x80112680,%eax
80102905:	85 c0                	test   %eax,%eax
80102907:	74 0d                	je     80102916 <lapiceoi+0x16>
  lapic[index] = value;
80102909:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102910:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102913:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102916:	c3                   	ret
80102917:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010291e:	00 
8010291f:	90                   	nop

80102920 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80102920:	c3                   	ret
80102921:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102928:	00 
80102929:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102930 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102930:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102931:	b8 0f 00 00 00       	mov    $0xf,%eax
80102936:	ba 70 00 00 00       	mov    $0x70,%edx
8010293b:	89 e5                	mov    %esp,%ebp
8010293d:	53                   	push   %ebx
8010293e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102941:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102944:	ee                   	out    %al,(%dx)
80102945:	b8 0a 00 00 00       	mov    $0xa,%eax
8010294a:	ba 71 00 00 00       	mov    $0x71,%edx
8010294f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102950:	31 c0                	xor    %eax,%eax
  lapic[index] = value;
80102952:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102955:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010295b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010295d:	c1 e9 0c             	shr    $0xc,%ecx
  lapic[index] = value;
80102960:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80102962:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80102965:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102968:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
8010296e:	a1 80 26 11 80       	mov    0x80112680,%eax
80102973:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102979:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010297c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102983:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102986:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102989:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102990:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102993:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102996:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010299c:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010299f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801029a5:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801029a8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801029ae:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029b1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801029b7:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
801029ba:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801029bd:	c9                   	leave
801029be:	c3                   	ret
801029bf:	90                   	nop

801029c0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
801029c0:	55                   	push   %ebp
801029c1:	b8 0b 00 00 00       	mov    $0xb,%eax
801029c6:	ba 70 00 00 00       	mov    $0x70,%edx
801029cb:	89 e5                	mov    %esp,%ebp
801029cd:	57                   	push   %edi
801029ce:	56                   	push   %esi
801029cf:	53                   	push   %ebx
801029d0:	83 ec 4c             	sub    $0x4c,%esp
801029d3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029d4:	ba 71 00 00 00       	mov    $0x71,%edx
801029d9:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
801029da:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029dd:	bf 70 00 00 00       	mov    $0x70,%edi
801029e2:	88 45 b3             	mov    %al,-0x4d(%ebp)
801029e5:	8d 76 00             	lea    0x0(%esi),%esi
801029e8:	31 c0                	xor    %eax,%eax
801029ea:	89 fa                	mov    %edi,%edx
801029ec:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029ed:	b9 71 00 00 00       	mov    $0x71,%ecx
801029f2:	89 ca                	mov    %ecx,%edx
801029f4:	ec                   	in     (%dx),%al
801029f5:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029f8:	89 fa                	mov    %edi,%edx
801029fa:	b8 02 00 00 00       	mov    $0x2,%eax
801029ff:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a00:	89 ca                	mov    %ecx,%edx
80102a02:	ec                   	in     (%dx),%al
80102a03:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a06:	89 fa                	mov    %edi,%edx
80102a08:	b8 04 00 00 00       	mov    $0x4,%eax
80102a0d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a0e:	89 ca                	mov    %ecx,%edx
80102a10:	ec                   	in     (%dx),%al
80102a11:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a14:	89 fa                	mov    %edi,%edx
80102a16:	b8 07 00 00 00       	mov    $0x7,%eax
80102a1b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a1c:	89 ca                	mov    %ecx,%edx
80102a1e:	ec                   	in     (%dx),%al
80102a1f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a22:	89 fa                	mov    %edi,%edx
80102a24:	b8 08 00 00 00       	mov    $0x8,%eax
80102a29:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a2a:	89 ca                	mov    %ecx,%edx
80102a2c:	ec                   	in     (%dx),%al
80102a2d:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a2f:	89 fa                	mov    %edi,%edx
80102a31:	b8 09 00 00 00       	mov    $0x9,%eax
80102a36:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a37:	89 ca                	mov    %ecx,%edx
80102a39:	ec                   	in     (%dx),%al
80102a3a:	0f b6 d8             	movzbl %al,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a3d:	89 fa                	mov    %edi,%edx
80102a3f:	b8 0a 00 00 00       	mov    $0xa,%eax
80102a44:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a45:	89 ca                	mov    %ecx,%edx
80102a47:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102a48:	84 c0                	test   %al,%al
80102a4a:	78 9c                	js     801029e8 <cmostime+0x28>
  return inb(CMOS_RETURN);
80102a4c:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102a50:	89 f2                	mov    %esi,%edx
80102a52:	89 5d cc             	mov    %ebx,-0x34(%ebp)
80102a55:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a58:	89 fa                	mov    %edi,%edx
80102a5a:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102a5d:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102a61:	89 75 c8             	mov    %esi,-0x38(%ebp)
80102a64:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102a67:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102a6b:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102a6e:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102a72:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102a75:	31 c0                	xor    %eax,%eax
80102a77:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a78:	89 ca                	mov    %ecx,%edx
80102a7a:	ec                   	in     (%dx),%al
80102a7b:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a7e:	89 fa                	mov    %edi,%edx
80102a80:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102a83:	b8 02 00 00 00       	mov    $0x2,%eax
80102a88:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a89:	89 ca                	mov    %ecx,%edx
80102a8b:	ec                   	in     (%dx),%al
80102a8c:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a8f:	89 fa                	mov    %edi,%edx
80102a91:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102a94:	b8 04 00 00 00       	mov    $0x4,%eax
80102a99:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a9a:	89 ca                	mov    %ecx,%edx
80102a9c:	ec                   	in     (%dx),%al
80102a9d:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102aa0:	89 fa                	mov    %edi,%edx
80102aa2:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102aa5:	b8 07 00 00 00       	mov    $0x7,%eax
80102aaa:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102aab:	89 ca                	mov    %ecx,%edx
80102aad:	ec                   	in     (%dx),%al
80102aae:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ab1:	89 fa                	mov    %edi,%edx
80102ab3:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102ab6:	b8 08 00 00 00       	mov    $0x8,%eax
80102abb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102abc:	89 ca                	mov    %ecx,%edx
80102abe:	ec                   	in     (%dx),%al
80102abf:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ac2:	89 fa                	mov    %edi,%edx
80102ac4:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102ac7:	b8 09 00 00 00       	mov    $0x9,%eax
80102acc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102acd:	89 ca                	mov    %ecx,%edx
80102acf:	ec                   	in     (%dx),%al
80102ad0:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102ad3:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102ad6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102ad9:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102adc:	6a 18                	push   $0x18
80102ade:	50                   	push   %eax
80102adf:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102ae2:	50                   	push   %eax
80102ae3:	e8 b8 27 00 00       	call   801052a0 <memcmp>
80102ae8:	83 c4 10             	add    $0x10,%esp
80102aeb:	85 c0                	test   %eax,%eax
80102aed:	0f 85 f5 fe ff ff    	jne    801029e8 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102af3:	0f b6 75 b3          	movzbl -0x4d(%ebp),%esi
80102af7:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102afa:	89 f0                	mov    %esi,%eax
80102afc:	84 c0                	test   %al,%al
80102afe:	75 78                	jne    80102b78 <cmostime+0x1b8>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102b00:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102b03:	89 c2                	mov    %eax,%edx
80102b05:	83 e0 0f             	and    $0xf,%eax
80102b08:	c1 ea 04             	shr    $0x4,%edx
80102b0b:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b0e:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b11:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102b14:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102b17:	89 c2                	mov    %eax,%edx
80102b19:	83 e0 0f             	and    $0xf,%eax
80102b1c:	c1 ea 04             	shr    $0x4,%edx
80102b1f:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b22:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b25:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102b28:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102b2b:	89 c2                	mov    %eax,%edx
80102b2d:	83 e0 0f             	and    $0xf,%eax
80102b30:	c1 ea 04             	shr    $0x4,%edx
80102b33:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b36:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b39:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102b3c:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102b3f:	89 c2                	mov    %eax,%edx
80102b41:	83 e0 0f             	and    $0xf,%eax
80102b44:	c1 ea 04             	shr    $0x4,%edx
80102b47:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b4a:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b4d:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102b50:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102b53:	89 c2                	mov    %eax,%edx
80102b55:	83 e0 0f             	and    $0xf,%eax
80102b58:	c1 ea 04             	shr    $0x4,%edx
80102b5b:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b5e:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b61:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102b64:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102b67:	89 c2                	mov    %eax,%edx
80102b69:	83 e0 0f             	and    $0xf,%eax
80102b6c:	c1 ea 04             	shr    $0x4,%edx
80102b6f:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b72:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b75:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102b78:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102b7b:	89 03                	mov    %eax,(%ebx)
80102b7d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102b80:	89 43 04             	mov    %eax,0x4(%ebx)
80102b83:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102b86:	89 43 08             	mov    %eax,0x8(%ebx)
80102b89:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102b8c:	89 43 0c             	mov    %eax,0xc(%ebx)
80102b8f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102b92:	89 43 10             	mov    %eax,0x10(%ebx)
80102b95:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102b98:	89 43 14             	mov    %eax,0x14(%ebx)
  r->year += 2000;
80102b9b:	81 43 14 d0 07 00 00 	addl   $0x7d0,0x14(%ebx)
}
80102ba2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ba5:	5b                   	pop    %ebx
80102ba6:	5e                   	pop    %esi
80102ba7:	5f                   	pop    %edi
80102ba8:	5d                   	pop    %ebp
80102ba9:	c3                   	ret
80102baa:	66 90                	xchg   %ax,%ax
80102bac:	66 90                	xchg   %ax,%ax
80102bae:	66 90                	xchg   %ax,%ax

80102bb0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102bb0:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102bb6:	85 c9                	test   %ecx,%ecx
80102bb8:	0f 8e 8a 00 00 00    	jle    80102c48 <install_trans+0x98>
{
80102bbe:	55                   	push   %ebp
80102bbf:	89 e5                	mov    %esp,%ebp
80102bc1:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80102bc2:	31 ff                	xor    %edi,%edi
{
80102bc4:	56                   	push   %esi
80102bc5:	53                   	push   %ebx
80102bc6:	83 ec 0c             	sub    $0xc,%esp
80102bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102bd0:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102bd5:	83 ec 08             	sub    $0x8,%esp
80102bd8:	01 f8                	add    %edi,%eax
80102bda:	83 c0 01             	add    $0x1,%eax
80102bdd:	50                   	push   %eax
80102bde:	ff 35 e4 26 11 80    	push   0x801126e4
80102be4:	e8 e7 d4 ff ff       	call   801000d0 <bread>
80102be9:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102beb:	58                   	pop    %eax
80102bec:	5a                   	pop    %edx
80102bed:	ff 34 bd ec 26 11 80 	push   -0x7feed914(,%edi,4)
80102bf4:	ff 35 e4 26 11 80    	push   0x801126e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102bfa:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102bfd:	e8 ce d4 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102c02:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102c05:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102c07:	8d 46 5c             	lea    0x5c(%esi),%eax
80102c0a:	68 00 02 00 00       	push   $0x200
80102c0f:	50                   	push   %eax
80102c10:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102c13:	50                   	push   %eax
80102c14:	e8 d7 26 00 00       	call   801052f0 <memmove>
    bwrite(dbuf);  // write dst to disk
80102c19:	89 1c 24             	mov    %ebx,(%esp)
80102c1c:	e8 8f d5 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80102c21:	89 34 24             	mov    %esi,(%esp)
80102c24:	e8 c7 d5 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80102c29:	89 1c 24             	mov    %ebx,(%esp)
80102c2c:	e8 bf d5 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102c31:	83 c4 10             	add    $0x10,%esp
80102c34:	39 3d e8 26 11 80    	cmp    %edi,0x801126e8
80102c3a:	7f 94                	jg     80102bd0 <install_trans+0x20>
  }
}
80102c3c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102c3f:	5b                   	pop    %ebx
80102c40:	5e                   	pop    %esi
80102c41:	5f                   	pop    %edi
80102c42:	5d                   	pop    %ebp
80102c43:	c3                   	ret
80102c44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c48:	c3                   	ret
80102c49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102c50 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102c50:	55                   	push   %ebp
80102c51:	89 e5                	mov    %esp,%ebp
80102c53:	53                   	push   %ebx
80102c54:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102c57:	ff 35 d4 26 11 80    	push   0x801126d4
80102c5d:	ff 35 e4 26 11 80    	push   0x801126e4
80102c63:	e8 68 d4 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102c68:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102c6b:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
80102c6d:	a1 e8 26 11 80       	mov    0x801126e8,%eax
80102c72:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80102c75:	85 c0                	test   %eax,%eax
80102c77:	7e 19                	jle    80102c92 <write_head+0x42>
80102c79:	31 d2                	xor    %edx,%edx
80102c7b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102c80:	8b 0c 95 ec 26 11 80 	mov    -0x7feed914(,%edx,4),%ecx
80102c87:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102c8b:	83 c2 01             	add    $0x1,%edx
80102c8e:	39 d0                	cmp    %edx,%eax
80102c90:	75 ee                	jne    80102c80 <write_head+0x30>
  }
  bwrite(buf);
80102c92:	83 ec 0c             	sub    $0xc,%esp
80102c95:	53                   	push   %ebx
80102c96:	e8 15 d5 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
80102c9b:	89 1c 24             	mov    %ebx,(%esp)
80102c9e:	e8 4d d5 ff ff       	call   801001f0 <brelse>
}
80102ca3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102ca6:	83 c4 10             	add    $0x10,%esp
80102ca9:	c9                   	leave
80102caa:	c3                   	ret
80102cab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102cb0 <initlog>:
{
80102cb0:	55                   	push   %ebp
80102cb1:	89 e5                	mov    %esp,%ebp
80102cb3:	53                   	push   %ebx
80102cb4:	83 ec 2c             	sub    $0x2c,%esp
80102cb7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102cba:	68 d7 7f 10 80       	push   $0x80107fd7
80102cbf:	68 a0 26 11 80       	push   $0x801126a0
80102cc4:	e8 a7 22 00 00       	call   80104f70 <initlock>
  readsb(dev, &sb);
80102cc9:	58                   	pop    %eax
80102cca:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102ccd:	5a                   	pop    %edx
80102cce:	50                   	push   %eax
80102ccf:	53                   	push   %ebx
80102cd0:	e8 7b e8 ff ff       	call   80101550 <readsb>
  log.start = sb.logstart;
80102cd5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102cd8:	59                   	pop    %ecx
  log.dev = dev;
80102cd9:	89 1d e4 26 11 80    	mov    %ebx,0x801126e4
  log.size = sb.nlog;
80102cdf:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102ce2:	a3 d4 26 11 80       	mov    %eax,0x801126d4
  log.size = sb.nlog;
80102ce7:	89 15 d8 26 11 80    	mov    %edx,0x801126d8
  struct buf *buf = bread(log.dev, log.start);
80102ced:	5a                   	pop    %edx
80102cee:	50                   	push   %eax
80102cef:	53                   	push   %ebx
80102cf0:	e8 db d3 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80102cf5:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80102cf8:	8b 58 5c             	mov    0x5c(%eax),%ebx
80102cfb:	89 1d e8 26 11 80    	mov    %ebx,0x801126e8
  for (i = 0; i < log.lh.n; i++) {
80102d01:	85 db                	test   %ebx,%ebx
80102d03:	7e 1d                	jle    80102d22 <initlog+0x72>
80102d05:	31 d2                	xor    %edx,%edx
80102d07:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102d0e:	00 
80102d0f:	90                   	nop
    log.lh.block[i] = lh->block[i];
80102d10:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80102d14:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102d1b:	83 c2 01             	add    $0x1,%edx
80102d1e:	39 d3                	cmp    %edx,%ebx
80102d20:	75 ee                	jne    80102d10 <initlog+0x60>
  brelse(buf);
80102d22:	83 ec 0c             	sub    $0xc,%esp
80102d25:	50                   	push   %eax
80102d26:	e8 c5 d4 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102d2b:	e8 80 fe ff ff       	call   80102bb0 <install_trans>
  log.lh.n = 0;
80102d30:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102d37:	00 00 00 
  write_head(); // clear the log
80102d3a:	e8 11 ff ff ff       	call   80102c50 <write_head>
}
80102d3f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102d42:	83 c4 10             	add    $0x10,%esp
80102d45:	c9                   	leave
80102d46:	c3                   	ret
80102d47:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102d4e:	00 
80102d4f:	90                   	nop

80102d50 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102d50:	55                   	push   %ebp
80102d51:	89 e5                	mov    %esp,%ebp
80102d53:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102d56:	68 a0 26 11 80       	push   $0x801126a0
80102d5b:	e8 00 24 00 00       	call   80105160 <acquire>
80102d60:	83 c4 10             	add    $0x10,%esp
80102d63:	eb 18                	jmp    80102d7d <begin_op+0x2d>
80102d65:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102d68:	83 ec 08             	sub    $0x8,%esp
80102d6b:	68 a0 26 11 80       	push   $0x801126a0
80102d70:	68 a0 26 11 80       	push   $0x801126a0
80102d75:	e8 06 1c 00 00       	call   80104980 <sleep>
80102d7a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102d7d:	a1 e0 26 11 80       	mov    0x801126e0,%eax
80102d82:	85 c0                	test   %eax,%eax
80102d84:	75 e2                	jne    80102d68 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102d86:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102d8b:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80102d91:	83 c0 01             	add    $0x1,%eax
80102d94:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102d97:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102d9a:	83 fa 1e             	cmp    $0x1e,%edx
80102d9d:	7f c9                	jg     80102d68 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102d9f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102da2:	a3 dc 26 11 80       	mov    %eax,0x801126dc
      release(&log.lock);
80102da7:	68 a0 26 11 80       	push   $0x801126a0
80102dac:	e8 4f 23 00 00       	call   80105100 <release>
      break;
    }
  }
}
80102db1:	83 c4 10             	add    $0x10,%esp
80102db4:	c9                   	leave
80102db5:	c3                   	ret
80102db6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102dbd:	00 
80102dbe:	66 90                	xchg   %ax,%ax

80102dc0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102dc0:	55                   	push   %ebp
80102dc1:	89 e5                	mov    %esp,%ebp
80102dc3:	57                   	push   %edi
80102dc4:	56                   	push   %esi
80102dc5:	53                   	push   %ebx
80102dc6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102dc9:	68 a0 26 11 80       	push   $0x801126a0
80102dce:	e8 8d 23 00 00       	call   80105160 <acquire>
  log.outstanding -= 1;
80102dd3:	a1 dc 26 11 80       	mov    0x801126dc,%eax
  if(log.committing)
80102dd8:	8b 35 e0 26 11 80    	mov    0x801126e0,%esi
80102dde:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102de1:	8d 58 ff             	lea    -0x1(%eax),%ebx
80102de4:	89 1d dc 26 11 80    	mov    %ebx,0x801126dc
  if(log.committing)
80102dea:	85 f6                	test   %esi,%esi
80102dec:	0f 85 22 01 00 00    	jne    80102f14 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102df2:	85 db                	test   %ebx,%ebx
80102df4:	0f 85 f6 00 00 00    	jne    80102ef0 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
80102dfa:	c7 05 e0 26 11 80 01 	movl   $0x1,0x801126e0
80102e01:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102e04:	83 ec 0c             	sub    $0xc,%esp
80102e07:	68 a0 26 11 80       	push   $0x801126a0
80102e0c:	e8 ef 22 00 00       	call   80105100 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102e11:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102e17:	83 c4 10             	add    $0x10,%esp
80102e1a:	85 c9                	test   %ecx,%ecx
80102e1c:	7f 42                	jg     80102e60 <end_op+0xa0>
    acquire(&log.lock);
80102e1e:	83 ec 0c             	sub    $0xc,%esp
80102e21:	68 a0 26 11 80       	push   $0x801126a0
80102e26:	e8 35 23 00 00       	call   80105160 <acquire>
    log.committing = 0;
80102e2b:	c7 05 e0 26 11 80 00 	movl   $0x0,0x801126e0
80102e32:	00 00 00 
    wakeup(&log);
80102e35:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102e3c:	e8 ff 1b 00 00       	call   80104a40 <wakeup>
    release(&log.lock);
80102e41:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102e48:	e8 b3 22 00 00       	call   80105100 <release>
80102e4d:	83 c4 10             	add    $0x10,%esp
}
80102e50:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e53:	5b                   	pop    %ebx
80102e54:	5e                   	pop    %esi
80102e55:	5f                   	pop    %edi
80102e56:	5d                   	pop    %ebp
80102e57:	c3                   	ret
80102e58:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102e5f:	00 
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102e60:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102e65:	83 ec 08             	sub    $0x8,%esp
80102e68:	01 d8                	add    %ebx,%eax
80102e6a:	83 c0 01             	add    $0x1,%eax
80102e6d:	50                   	push   %eax
80102e6e:	ff 35 e4 26 11 80    	push   0x801126e4
80102e74:	e8 57 d2 ff ff       	call   801000d0 <bread>
80102e79:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102e7b:	58                   	pop    %eax
80102e7c:	5a                   	pop    %edx
80102e7d:	ff 34 9d ec 26 11 80 	push   -0x7feed914(,%ebx,4)
80102e84:	ff 35 e4 26 11 80    	push   0x801126e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102e8a:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102e8d:	e8 3e d2 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80102e92:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102e95:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102e97:	8d 40 5c             	lea    0x5c(%eax),%eax
80102e9a:	68 00 02 00 00       	push   $0x200
80102e9f:	50                   	push   %eax
80102ea0:	8d 46 5c             	lea    0x5c(%esi),%eax
80102ea3:	50                   	push   %eax
80102ea4:	e8 47 24 00 00       	call   801052f0 <memmove>
    bwrite(to);  // write the log
80102ea9:	89 34 24             	mov    %esi,(%esp)
80102eac:	e8 ff d2 ff ff       	call   801001b0 <bwrite>
    brelse(from);
80102eb1:	89 3c 24             	mov    %edi,(%esp)
80102eb4:	e8 37 d3 ff ff       	call   801001f0 <brelse>
    brelse(to);
80102eb9:	89 34 24             	mov    %esi,(%esp)
80102ebc:	e8 2f d3 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102ec1:	83 c4 10             	add    $0x10,%esp
80102ec4:	3b 1d e8 26 11 80    	cmp    0x801126e8,%ebx
80102eca:	7c 94                	jl     80102e60 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102ecc:	e8 7f fd ff ff       	call   80102c50 <write_head>
    install_trans(); // Now install writes to home locations
80102ed1:	e8 da fc ff ff       	call   80102bb0 <install_trans>
    log.lh.n = 0;
80102ed6:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102edd:	00 00 00 
    write_head();    // Erase the transaction from the log
80102ee0:	e8 6b fd ff ff       	call   80102c50 <write_head>
80102ee5:	e9 34 ff ff ff       	jmp    80102e1e <end_op+0x5e>
80102eea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80102ef0:	83 ec 0c             	sub    $0xc,%esp
80102ef3:	68 a0 26 11 80       	push   $0x801126a0
80102ef8:	e8 43 1b 00 00       	call   80104a40 <wakeup>
  release(&log.lock);
80102efd:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102f04:	e8 f7 21 00 00       	call   80105100 <release>
80102f09:	83 c4 10             	add    $0x10,%esp
}
80102f0c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102f0f:	5b                   	pop    %ebx
80102f10:	5e                   	pop    %esi
80102f11:	5f                   	pop    %edi
80102f12:	5d                   	pop    %ebp
80102f13:	c3                   	ret
    panic("log.committing");
80102f14:	83 ec 0c             	sub    $0xc,%esp
80102f17:	68 db 7f 10 80       	push   $0x80107fdb
80102f1c:	e8 5f d4 ff ff       	call   80100380 <panic>
80102f21:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102f28:	00 
80102f29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102f30 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102f30:	55                   	push   %ebp
80102f31:	89 e5                	mov    %esp,%ebp
80102f33:	53                   	push   %ebx
80102f34:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102f37:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
{
80102f3d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102f40:	83 fa 1d             	cmp    $0x1d,%edx
80102f43:	7f 7d                	jg     80102fc2 <log_write+0x92>
80102f45:	a1 d8 26 11 80       	mov    0x801126d8,%eax
80102f4a:	83 e8 01             	sub    $0x1,%eax
80102f4d:	39 c2                	cmp    %eax,%edx
80102f4f:	7d 71                	jge    80102fc2 <log_write+0x92>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102f51:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102f56:	85 c0                	test   %eax,%eax
80102f58:	7e 75                	jle    80102fcf <log_write+0x9f>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102f5a:	83 ec 0c             	sub    $0xc,%esp
80102f5d:	68 a0 26 11 80       	push   $0x801126a0
80102f62:	e8 f9 21 00 00       	call   80105160 <acquire>
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102f67:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102f6a:	83 c4 10             	add    $0x10,%esp
80102f6d:	31 c0                	xor    %eax,%eax
80102f6f:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80102f75:	85 d2                	test   %edx,%edx
80102f77:	7f 0e                	jg     80102f87 <log_write+0x57>
80102f79:	eb 15                	jmp    80102f90 <log_write+0x60>
80102f7b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80102f80:	83 c0 01             	add    $0x1,%eax
80102f83:	39 c2                	cmp    %eax,%edx
80102f85:	74 29                	je     80102fb0 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102f87:	39 0c 85 ec 26 11 80 	cmp    %ecx,-0x7feed914(,%eax,4)
80102f8e:	75 f0                	jne    80102f80 <log_write+0x50>
      break;
  }
  log.lh.block[i] = b->blockno;
80102f90:	89 0c 85 ec 26 11 80 	mov    %ecx,-0x7feed914(,%eax,4)
  if (i == log.lh.n)
80102f97:	39 c2                	cmp    %eax,%edx
80102f99:	74 1c                	je     80102fb7 <log_write+0x87>
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80102f9b:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
80102f9e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
80102fa1:	c7 45 08 a0 26 11 80 	movl   $0x801126a0,0x8(%ebp)
}
80102fa8:	c9                   	leave
  release(&log.lock);
80102fa9:	e9 52 21 00 00       	jmp    80105100 <release>
80102fae:	66 90                	xchg   %ax,%ax
  log.lh.block[i] = b->blockno;
80102fb0:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
    log.lh.n++;
80102fb7:	83 c2 01             	add    $0x1,%edx
80102fba:	89 15 e8 26 11 80    	mov    %edx,0x801126e8
80102fc0:	eb d9                	jmp    80102f9b <log_write+0x6b>
    panic("too big a transaction");
80102fc2:	83 ec 0c             	sub    $0xc,%esp
80102fc5:	68 ea 7f 10 80       	push   $0x80107fea
80102fca:	e8 b1 d3 ff ff       	call   80100380 <panic>
    panic("log_write outside of trans");
80102fcf:	83 ec 0c             	sub    $0xc,%esp
80102fd2:	68 00 80 10 80       	push   $0x80108000
80102fd7:	e8 a4 d3 ff ff       	call   80100380 <panic>
80102fdc:	66 90                	xchg   %ax,%ax
80102fde:	66 90                	xchg   %ax,%ax

80102fe0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102fe0:	55                   	push   %ebp
80102fe1:	89 e5                	mov    %esp,%ebp
80102fe3:	53                   	push   %ebx
80102fe4:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102fe7:	e8 d4 0a 00 00       	call   80103ac0 <cpuid>
80102fec:	89 c3                	mov    %eax,%ebx
80102fee:	e8 cd 0a 00 00       	call   80103ac0 <cpuid>
80102ff3:	83 ec 04             	sub    $0x4,%esp
80102ff6:	53                   	push   %ebx
80102ff7:	50                   	push   %eax
80102ff8:	68 1b 80 10 80       	push   $0x8010801b
80102ffd:	e8 ae d6 ff ff       	call   801006b0 <cprintf>
  idtinit();       // load idt register
80103002:	e8 69 35 00 00       	call   80106570 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103007:	e8 54 0a 00 00       	call   80103a60 <mycpu>
8010300c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010300e:	b8 01 00 00 00       	mov    $0x1,%eax
80103013:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010301a:	e8 01 14 00 00       	call   80104420 <scheduler>
8010301f:	90                   	nop

80103020 <mpenter>:
{
80103020:	55                   	push   %ebp
80103021:	89 e5                	mov    %esp,%ebp
80103023:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103026:	e8 55 46 00 00       	call   80107680 <switchkvm>
  seginit();
8010302b:	e8 c0 45 00 00       	call   801075f0 <seginit>
  lapicinit();
80103030:	e8 bb f7 ff ff       	call   801027f0 <lapicinit>
  mpmain();
80103035:	e8 a6 ff ff ff       	call   80102fe0 <mpmain>
8010303a:	66 90                	xchg   %ax,%ax
8010303c:	66 90                	xchg   %ax,%ax
8010303e:	66 90                	xchg   %ax,%ax

80103040 <main>:
{
80103040:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103044:	83 e4 f0             	and    $0xfffffff0,%esp
80103047:	ff 71 fc             	push   -0x4(%ecx)
8010304a:	55                   	push   %ebp
8010304b:	89 e5                	mov    %esp,%ebp
8010304d:	53                   	push   %ebx
8010304e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010304f:	83 ec 08             	sub    $0x8,%esp
80103052:	68 00 00 40 80       	push   $0x80400000
80103057:	68 f0 77 11 80       	push   $0x801177f0
8010305c:	e8 9f f5 ff ff       	call   80102600 <kinit1>
  kvmalloc();      // kernel page table
80103061:	e8 da 4a 00 00       	call   80107b40 <kvmalloc>
  mpinit();        // detect other processors
80103066:	e8 85 01 00 00       	call   801031f0 <mpinit>
  lapicinit();     // interrupt controller
8010306b:	e8 80 f7 ff ff       	call   801027f0 <lapicinit>
  seginit();       // segment descriptors
80103070:	e8 7b 45 00 00       	call   801075f0 <seginit>
  picinit();       // disable pic
80103075:	e8 e6 03 00 00       	call   80103460 <picinit>
  ioapicinit();    // another interrupt controller
8010307a:	e8 51 f3 ff ff       	call   801023d0 <ioapicinit>
  consoleinit();   // console hardware
8010307f:	e8 dc d9 ff ff       	call   80100a60 <consoleinit>
  uartinit();      // serial port
80103084:	e8 d7 37 00 00       	call   80106860 <uartinit>
  pinit();         // process table
80103089:	e8 b2 09 00 00       	call   80103a40 <pinit>
  tvinit();        // trap vectors
8010308e:	e8 5d 34 00 00       	call   801064f0 <tvinit>
  binit();         // buffer cache
80103093:	e8 a8 cf ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103098:	e8 a3 dd ff ff       	call   80100e40 <fileinit>
  ideinit();       // disk 
8010309d:	e8 0e f1 ff ff       	call   801021b0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
801030a2:	83 c4 0c             	add    $0xc,%esp
801030a5:	68 8a 00 00 00       	push   $0x8a
801030aa:	68 8c b4 10 80       	push   $0x8010b48c
801030af:	68 00 70 00 80       	push   $0x80007000
801030b4:	e8 37 22 00 00       	call   801052f0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
801030b9:	83 c4 10             	add    $0x10,%esp
801030bc:	69 05 84 27 11 80 b0 	imul   $0xb0,0x80112784,%eax
801030c3:	00 00 00 
801030c6:	05 a0 27 11 80       	add    $0x801127a0,%eax
801030cb:	3d a0 27 11 80       	cmp    $0x801127a0,%eax
801030d0:	76 7e                	jbe    80103150 <main+0x110>
801030d2:	bb a0 27 11 80       	mov    $0x801127a0,%ebx
801030d7:	eb 20                	jmp    801030f9 <main+0xb9>
801030d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030e0:	69 05 84 27 11 80 b0 	imul   $0xb0,0x80112784,%eax
801030e7:	00 00 00 
801030ea:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
801030f0:	05 a0 27 11 80       	add    $0x801127a0,%eax
801030f5:	39 c3                	cmp    %eax,%ebx
801030f7:	73 57                	jae    80103150 <main+0x110>
    if(c == mycpu())  // We've started already.
801030f9:	e8 62 09 00 00       	call   80103a60 <mycpu>
801030fe:	39 c3                	cmp    %eax,%ebx
80103100:	74 de                	je     801030e0 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103102:	e8 69 f5 ff ff       	call   80102670 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103107:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
8010310a:	c7 05 f8 6f 00 80 20 	movl   $0x80103020,0x80006ff8
80103111:	30 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103114:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
8010311b:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
8010311e:	05 00 10 00 00       	add    $0x1000,%eax
80103123:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103128:	0f b6 03             	movzbl (%ebx),%eax
8010312b:	68 00 70 00 00       	push   $0x7000
80103130:	50                   	push   %eax
80103131:	e8 fa f7 ff ff       	call   80102930 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103136:	83 c4 10             	add    $0x10,%esp
80103139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103140:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103146:	85 c0                	test   %eax,%eax
80103148:	74 f6                	je     80103140 <main+0x100>
8010314a:	eb 94                	jmp    801030e0 <main+0xa0>
8010314c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103150:	83 ec 08             	sub    $0x8,%esp
80103153:	68 00 00 00 8e       	push   $0x8e000000
80103158:	68 00 00 40 80       	push   $0x80400000
8010315d:	e8 3e f4 ff ff       	call   801025a0 <kinit2>
  userinit();      // first user process
80103162:	e8 a9 09 00 00       	call   80103b10 <userinit>
  mpmain();        // finish this processor's setup
80103167:	e8 74 fe ff ff       	call   80102fe0 <mpmain>
8010316c:	66 90                	xchg   %ax,%ax
8010316e:	66 90                	xchg   %ax,%ax

80103170 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103170:	55                   	push   %ebp
80103171:	89 e5                	mov    %esp,%ebp
80103173:	57                   	push   %edi
80103174:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103175:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010317b:	53                   	push   %ebx
  e = addr+len;
8010317c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010317f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103182:	39 de                	cmp    %ebx,%esi
80103184:	72 10                	jb     80103196 <mpsearch1+0x26>
80103186:	eb 50                	jmp    801031d8 <mpsearch1+0x68>
80103188:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010318f:	00 
80103190:	89 fe                	mov    %edi,%esi
80103192:	39 df                	cmp    %ebx,%edi
80103194:	73 42                	jae    801031d8 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103196:	83 ec 04             	sub    $0x4,%esp
80103199:	8d 7e 10             	lea    0x10(%esi),%edi
8010319c:	6a 04                	push   $0x4
8010319e:	68 2f 80 10 80       	push   $0x8010802f
801031a3:	56                   	push   %esi
801031a4:	e8 f7 20 00 00       	call   801052a0 <memcmp>
801031a9:	83 c4 10             	add    $0x10,%esp
801031ac:	85 c0                	test   %eax,%eax
801031ae:	75 e0                	jne    80103190 <mpsearch1+0x20>
801031b0:	89 f2                	mov    %esi,%edx
801031b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
801031b8:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
801031bb:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
801031be:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
801031c0:	39 fa                	cmp    %edi,%edx
801031c2:	75 f4                	jne    801031b8 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801031c4:	84 c0                	test   %al,%al
801031c6:	75 c8                	jne    80103190 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
801031c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801031cb:	89 f0                	mov    %esi,%eax
801031cd:	5b                   	pop    %ebx
801031ce:	5e                   	pop    %esi
801031cf:	5f                   	pop    %edi
801031d0:	5d                   	pop    %ebp
801031d1:	c3                   	ret
801031d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801031d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801031db:	31 f6                	xor    %esi,%esi
}
801031dd:	5b                   	pop    %ebx
801031de:	89 f0                	mov    %esi,%eax
801031e0:	5e                   	pop    %esi
801031e1:	5f                   	pop    %edi
801031e2:	5d                   	pop    %ebp
801031e3:	c3                   	ret
801031e4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801031eb:	00 
801031ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801031f0 <mpinit>:
    return conf;
}

void
mpinit(void)
{
801031f0:	55                   	push   %ebp
801031f1:	89 e5                	mov    %esp,%ebp
801031f3:	57                   	push   %edi
801031f4:	56                   	push   %esi
801031f5:	53                   	push   %ebx
801031f6:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801031f9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103200:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103207:	c1 e0 08             	shl    $0x8,%eax
8010320a:	09 d0                	or     %edx,%eax
8010320c:	c1 e0 04             	shl    $0x4,%eax
8010320f:	75 1b                	jne    8010322c <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103211:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103218:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
8010321f:	c1 e0 08             	shl    $0x8,%eax
80103222:	09 d0                	or     %edx,%eax
80103224:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103227:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010322c:	ba 00 04 00 00       	mov    $0x400,%edx
80103231:	e8 3a ff ff ff       	call   80103170 <mpsearch1>
80103236:	89 c3                	mov    %eax,%ebx
80103238:	85 c0                	test   %eax,%eax
8010323a:	0f 84 48 01 00 00    	je     80103388 <mpinit+0x198>
    if (mp->physaddr == 0) {
80103240:	8b 73 04             	mov    0x4(%ebx),%esi
80103243:	85 f6                	test   %esi,%esi
80103245:	0f 84 d7 01 00 00    	je     80103422 <mpinit+0x232>
    if (memcmp(conf, "PCMP", 4) != 0) {
8010324b:	83 ec 04             	sub    $0x4,%esp
    conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010324e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80103254:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if (memcmp(conf, "PCMP", 4) != 0) {
80103257:	6a 04                	push   $0x4
80103259:	68 34 80 10 80       	push   $0x80108034
8010325e:	50                   	push   %eax
8010325f:	e8 3c 20 00 00       	call   801052a0 <memcmp>
80103264:	83 c4 10             	add    $0x10,%esp
80103267:	85 c0                	test   %eax,%eax
80103269:	0f 85 a1 01 00 00    	jne    80103410 <mpinit+0x220>
    if (conf->version != 1 && conf->version != 4) {
8010326f:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
80103276:	3c 01                	cmp    $0x1,%al
80103278:	74 08                	je     80103282 <mpinit+0x92>
8010327a:	3c 04                	cmp    $0x4,%al
8010327c:	0f 85 6e 01 00 00    	jne    801033f0 <mpinit+0x200>
    if (sum((uchar*)conf, conf->length) != 0) {
80103282:	0f b7 be 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edi
  for(i=0; i<len; i++)
80103289:	66 85 ff             	test   %di,%di
8010328c:	74 22                	je     801032b0 <mpinit+0xc0>
8010328e:	89 f0                	mov    %esi,%eax
80103290:	01 f7                	add    %esi,%edi
  sum = 0;
80103292:	31 d2                	xor    %edx,%edx
80103294:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
80103298:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i=0; i<len; i++)
8010329f:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
801032a2:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
801032a4:	39 c7                	cmp    %eax,%edi
801032a6:	75 f0                	jne    80103298 <mpinit+0xa8>
    if (sum((uchar*)conf, conf->length) != 0) {
801032a8:	84 d2                	test   %dl,%dl
801032aa:	0f 85 84 01 00 00    	jne    80103434 <mpinit+0x244>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801032b0:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032b6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801032b9:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  lapic = (uint*)conf->lapicaddr;
801032bc:	a3 80 26 11 80       	mov    %eax,0x80112680
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032c1:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
801032c8:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
801032ce:	01 d7                	add    %edx,%edi
801032d0:	89 fa                	mov    %edi,%edx
  ismp = 1;
801032d2:	bf 01 00 00 00       	mov    $0x1,%edi
801032d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801032de:	00 
801032df:	90                   	nop
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032e0:	39 d0                	cmp    %edx,%eax
801032e2:	73 19                	jae    801032fd <mpinit+0x10d>
    switch(*p){
801032e4:	0f b6 08             	movzbl (%eax),%ecx
801032e7:	80 f9 02             	cmp    $0x2,%cl
801032ea:	0f 84 80 00 00 00    	je     80103370 <mpinit+0x180>
801032f0:	77 6e                	ja     80103360 <mpinit+0x170>
801032f2:	84 c9                	test   %cl,%cl
801032f4:	74 3a                	je     80103330 <mpinit+0x140>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801032f6:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032f9:	39 d0                	cmp    %edx,%eax
801032fb:	72 e7                	jb     801032e4 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
801032fd:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103300:	85 ff                	test   %edi,%edi
80103302:	0f 84 3e 01 00 00    	je     80103446 <mpinit+0x256>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
80103308:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
8010330c:	74 15                	je     80103323 <mpinit+0x133>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010330e:	b8 70 00 00 00       	mov    $0x70,%eax
80103313:	ba 22 00 00 00       	mov    $0x22,%edx
80103318:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103319:	ba 23 00 00 00       	mov    $0x23,%edx
8010331e:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
8010331f:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103322:	ee                   	out    %al,(%dx)
  }
}
80103323:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103326:	5b                   	pop    %ebx
80103327:	5e                   	pop    %esi
80103328:	5f                   	pop    %edi
80103329:	5d                   	pop    %ebp
8010332a:	c3                   	ret
8010332b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(ncpu < NCPU) {
80103330:	8b 0d 84 27 11 80    	mov    0x80112784,%ecx
80103336:	83 f9 07             	cmp    $0x7,%ecx
80103339:	7f 19                	jg     80103354 <mpinit+0x164>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010333b:	69 f1 b0 00 00 00    	imul   $0xb0,%ecx,%esi
80103341:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
80103345:	83 c1 01             	add    $0x1,%ecx
80103348:	89 0d 84 27 11 80    	mov    %ecx,0x80112784
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010334e:	88 9e a0 27 11 80    	mov    %bl,-0x7feed860(%esi)
      p += sizeof(struct mpproc);
80103354:	83 c0 14             	add    $0x14,%eax
      continue;
80103357:	eb 87                	jmp    801032e0 <mpinit+0xf0>
80103359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(*p){
80103360:	83 e9 03             	sub    $0x3,%ecx
80103363:	80 f9 01             	cmp    $0x1,%cl
80103366:	76 8e                	jbe    801032f6 <mpinit+0x106>
80103368:	31 ff                	xor    %edi,%edi
8010336a:	e9 71 ff ff ff       	jmp    801032e0 <mpinit+0xf0>
8010336f:	90                   	nop
      ioapicid = ioapic->apicno;
80103370:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
80103374:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
80103377:	88 0d 80 27 11 80    	mov    %cl,0x80112780
      continue;
8010337d:	e9 5e ff ff ff       	jmp    801032e0 <mpinit+0xf0>
80103382:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
80103388:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
8010338d:	eb 0b                	jmp    8010339a <mpinit+0x1aa>
8010338f:	90                   	nop
  for(p = addr; p < e; p += sizeof(struct mp))
80103390:	89 f3                	mov    %esi,%ebx
80103392:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
80103398:	74 44                	je     801033de <mpinit+0x1ee>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010339a:	83 ec 04             	sub    $0x4,%esp
8010339d:	8d 73 10             	lea    0x10(%ebx),%esi
801033a0:	6a 04                	push   $0x4
801033a2:	68 2f 80 10 80       	push   $0x8010802f
801033a7:	53                   	push   %ebx
801033a8:	e8 f3 1e 00 00       	call   801052a0 <memcmp>
801033ad:	83 c4 10             	add    $0x10,%esp
801033b0:	85 c0                	test   %eax,%eax
801033b2:	75 dc                	jne    80103390 <mpinit+0x1a0>
801033b4:	89 da                	mov    %ebx,%edx
801033b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801033bd:	00 
801033be:	66 90                	xchg   %ax,%ax
    sum += addr[i];
801033c0:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
801033c3:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
801033c6:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
801033c8:	39 d6                	cmp    %edx,%esi
801033ca:	75 f4                	jne    801033c0 <mpinit+0x1d0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801033cc:	84 c0                	test   %al,%al
801033ce:	0f 84 6c fe ff ff    	je     80103240 <mpinit+0x50>
  for(p = addr; p < e; p += sizeof(struct mp))
801033d4:	89 f3                	mov    %esi,%ebx
801033d6:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
801033dc:	75 bc                	jne    8010339a <mpinit+0x1aa>
        cprintf("Error: mpsearch failed\n");
801033de:	83 ec 0c             	sub    $0xc,%esp
801033e1:	68 51 80 10 80       	push   $0x80108051
801033e6:	e8 c5 d2 ff ff       	call   801006b0 <cprintf>
801033eb:	83 c4 10             	add    $0x10,%esp
801033ee:	eb 10                	jmp    80103400 <mpinit+0x210>
        cprintf("Error: Unsupported MP version\n");
801033f0:	83 ec 0c             	sub    $0xc,%esp
801033f3:	68 3c 84 10 80       	push   $0x8010843c
801033f8:	e8 b3 d2 ff ff       	call   801006b0 <cprintf>
801033fd:	83 c4 10             	add    $0x10,%esp
    panic("Expect to run on an SMP");
80103400:	83 ec 0c             	sub    $0xc,%esp
80103403:	68 39 80 10 80       	push   $0x80108039
80103408:	e8 73 cf ff ff       	call   80100380 <panic>
8010340d:	8d 76 00             	lea    0x0(%esi),%esi
        cprintf("Error: Invalid MP configuration signature\n");
80103410:	83 ec 0c             	sub    $0xc,%esp
80103413:	68 10 84 10 80       	push   $0x80108410
80103418:	e8 93 d2 ff ff       	call   801006b0 <cprintf>
8010341d:	83 c4 10             	add    $0x10,%esp
80103420:	eb de                	jmp    80103400 <mpinit+0x210>
        cprintf("Error: Invalid physaddr in MP structure\n");
80103422:	83 ec 0c             	sub    $0xc,%esp
80103425:	68 e4 83 10 80       	push   $0x801083e4
8010342a:	e8 81 d2 ff ff       	call   801006b0 <cprintf>
8010342f:	83 c4 10             	add    $0x10,%esp
80103432:	eb cc                	jmp    80103400 <mpinit+0x210>
        cprintf("Error: MP configuration checksum failed\n");
80103434:	83 ec 0c             	sub    $0xc,%esp
80103437:	68 5c 84 10 80       	push   $0x8010845c
8010343c:	e8 6f d2 ff ff       	call   801006b0 <cprintf>
80103441:	83 c4 10             	add    $0x10,%esp
80103444:	eb ba                	jmp    80103400 <mpinit+0x210>
    panic("Didn't find a suitable machine");
80103446:	83 ec 0c             	sub    $0xc,%esp
80103449:	68 88 84 10 80       	push   $0x80108488
8010344e:	e8 2d cf ff ff       	call   80100380 <panic>
80103453:	66 90                	xchg   %ax,%ax
80103455:	66 90                	xchg   %ax,%ax
80103457:	66 90                	xchg   %ax,%ax
80103459:	66 90                	xchg   %ax,%ax
8010345b:	66 90                	xchg   %ax,%ax
8010345d:	66 90                	xchg   %ax,%ax
8010345f:	90                   	nop

80103460 <picinit>:
80103460:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103465:	ba 21 00 00 00       	mov    $0x21,%edx
8010346a:	ee                   	out    %al,(%dx)
8010346b:	ba a1 00 00 00       	mov    $0xa1,%edx
80103470:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103471:	c3                   	ret
80103472:	66 90                	xchg   %ax,%ax
80103474:	66 90                	xchg   %ax,%ax
80103476:	66 90                	xchg   %ax,%ax
80103478:	66 90                	xchg   %ax,%ax
8010347a:	66 90                	xchg   %ax,%ax
8010347c:	66 90                	xchg   %ax,%ax
8010347e:	66 90                	xchg   %ax,%ax

80103480 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103480:	55                   	push   %ebp
80103481:	89 e5                	mov    %esp,%ebp
80103483:	57                   	push   %edi
80103484:	56                   	push   %esi
80103485:	53                   	push   %ebx
80103486:	83 ec 0c             	sub    $0xc,%esp
80103489:	8b 75 08             	mov    0x8(%ebp),%esi
8010348c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010348f:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
80103495:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010349b:	e8 c0 d9 ff ff       	call   80100e60 <filealloc>
801034a0:	89 06                	mov    %eax,(%esi)
801034a2:	85 c0                	test   %eax,%eax
801034a4:	0f 84 a5 00 00 00    	je     8010354f <pipealloc+0xcf>
801034aa:	e8 b1 d9 ff ff       	call   80100e60 <filealloc>
801034af:	89 07                	mov    %eax,(%edi)
801034b1:	85 c0                	test   %eax,%eax
801034b3:	0f 84 84 00 00 00    	je     8010353d <pipealloc+0xbd>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801034b9:	e8 b2 f1 ff ff       	call   80102670 <kalloc>
801034be:	89 c3                	mov    %eax,%ebx
801034c0:	85 c0                	test   %eax,%eax
801034c2:	0f 84 a0 00 00 00    	je     80103568 <pipealloc+0xe8>
    goto bad;
  p->readopen = 1;
801034c8:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801034cf:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
801034d2:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
801034d5:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801034dc:	00 00 00 
  p->nwrite = 0;
801034df:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801034e6:	00 00 00 
  p->nread = 0;
801034e9:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801034f0:	00 00 00 
  initlock(&p->lock, "pipe");
801034f3:	68 69 80 10 80       	push   $0x80108069
801034f8:	50                   	push   %eax
801034f9:	e8 72 1a 00 00       	call   80104f70 <initlock>
  (*f0)->type = FD_PIPE;
801034fe:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103500:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103503:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103509:	8b 06                	mov    (%esi),%eax
8010350b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010350f:	8b 06                	mov    (%esi),%eax
80103511:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103515:	8b 06                	mov    (%esi),%eax
80103517:	89 58 0c             	mov    %ebx,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010351a:	8b 07                	mov    (%edi),%eax
8010351c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103522:	8b 07                	mov    (%edi),%eax
80103524:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103528:	8b 07                	mov    (%edi),%eax
8010352a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010352e:	8b 07                	mov    (%edi),%eax
80103530:	89 58 0c             	mov    %ebx,0xc(%eax)
  return 0;
80103533:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103535:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103538:	5b                   	pop    %ebx
80103539:	5e                   	pop    %esi
8010353a:	5f                   	pop    %edi
8010353b:	5d                   	pop    %ebp
8010353c:	c3                   	ret
  if(*f0)
8010353d:	8b 06                	mov    (%esi),%eax
8010353f:	85 c0                	test   %eax,%eax
80103541:	74 1e                	je     80103561 <pipealloc+0xe1>
    fileclose(*f0);
80103543:	83 ec 0c             	sub    $0xc,%esp
80103546:	50                   	push   %eax
80103547:	e8 d4 d9 ff ff       	call   80100f20 <fileclose>
8010354c:	83 c4 10             	add    $0x10,%esp
  if(*f1)
8010354f:	8b 07                	mov    (%edi),%eax
80103551:	85 c0                	test   %eax,%eax
80103553:	74 0c                	je     80103561 <pipealloc+0xe1>
    fileclose(*f1);
80103555:	83 ec 0c             	sub    $0xc,%esp
80103558:	50                   	push   %eax
80103559:	e8 c2 d9 ff ff       	call   80100f20 <fileclose>
8010355e:	83 c4 10             	add    $0x10,%esp
  return -1;
80103561:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103566:	eb cd                	jmp    80103535 <pipealloc+0xb5>
  if(*f0)
80103568:	8b 06                	mov    (%esi),%eax
8010356a:	85 c0                	test   %eax,%eax
8010356c:	75 d5                	jne    80103543 <pipealloc+0xc3>
8010356e:	eb df                	jmp    8010354f <pipealloc+0xcf>

80103570 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103570:	55                   	push   %ebp
80103571:	89 e5                	mov    %esp,%ebp
80103573:	56                   	push   %esi
80103574:	53                   	push   %ebx
80103575:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103578:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010357b:	83 ec 0c             	sub    $0xc,%esp
8010357e:	53                   	push   %ebx
8010357f:	e8 dc 1b 00 00       	call   80105160 <acquire>
  if(writable){
80103584:	83 c4 10             	add    $0x10,%esp
80103587:	85 f6                	test   %esi,%esi
80103589:	74 65                	je     801035f0 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
8010358b:	83 ec 0c             	sub    $0xc,%esp
8010358e:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80103594:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010359b:	00 00 00 
    wakeup(&p->nread);
8010359e:	50                   	push   %eax
8010359f:	e8 9c 14 00 00       	call   80104a40 <wakeup>
801035a4:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
801035a7:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801035ad:	85 d2                	test   %edx,%edx
801035af:	75 0a                	jne    801035bb <pipeclose+0x4b>
801035b1:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801035b7:	85 c0                	test   %eax,%eax
801035b9:	74 15                	je     801035d0 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801035bb:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801035be:	8d 65 f8             	lea    -0x8(%ebp),%esp
801035c1:	5b                   	pop    %ebx
801035c2:	5e                   	pop    %esi
801035c3:	5d                   	pop    %ebp
    release(&p->lock);
801035c4:	e9 37 1b 00 00       	jmp    80105100 <release>
801035c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
801035d0:	83 ec 0c             	sub    $0xc,%esp
801035d3:	53                   	push   %ebx
801035d4:	e8 27 1b 00 00       	call   80105100 <release>
    kfree((char*)p);
801035d9:	83 c4 10             	add    $0x10,%esp
801035dc:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801035df:	8d 65 f8             	lea    -0x8(%ebp),%esp
801035e2:	5b                   	pop    %ebx
801035e3:	5e                   	pop    %esi
801035e4:	5d                   	pop    %ebp
    kfree((char*)p);
801035e5:	e9 c6 ee ff ff       	jmp    801024b0 <kfree>
801035ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
801035f0:	83 ec 0c             	sub    $0xc,%esp
801035f3:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
801035f9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103600:	00 00 00 
    wakeup(&p->nwrite);
80103603:	50                   	push   %eax
80103604:	e8 37 14 00 00       	call   80104a40 <wakeup>
80103609:	83 c4 10             	add    $0x10,%esp
8010360c:	eb 99                	jmp    801035a7 <pipeclose+0x37>
8010360e:	66 90                	xchg   %ax,%ax

80103610 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103610:	55                   	push   %ebp
80103611:	89 e5                	mov    %esp,%ebp
80103613:	57                   	push   %edi
80103614:	56                   	push   %esi
80103615:	53                   	push   %ebx
80103616:	83 ec 28             	sub    $0x28,%esp
80103619:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010361c:	8b 7d 10             	mov    0x10(%ebp),%edi
  int i;

  acquire(&p->lock);
8010361f:	53                   	push   %ebx
80103620:	e8 3b 1b 00 00       	call   80105160 <acquire>
  for(i = 0; i < n; i++){
80103625:	83 c4 10             	add    $0x10,%esp
80103628:	85 ff                	test   %edi,%edi
8010362a:	0f 8e ce 00 00 00    	jle    801036fe <pipewrite+0xee>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103630:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
80103636:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103639:	89 7d 10             	mov    %edi,0x10(%ebp)
8010363c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010363f:	8d 34 39             	lea    (%ecx,%edi,1),%esi
80103642:	89 75 e0             	mov    %esi,-0x20(%ebp)
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103645:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010364b:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103651:	8d bb 38 02 00 00    	lea    0x238(%ebx),%edi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103657:	8d 90 00 02 00 00    	lea    0x200(%eax),%edx
8010365d:	39 55 e4             	cmp    %edx,-0x1c(%ebp)
80103660:	0f 85 b6 00 00 00    	jne    8010371c <pipewrite+0x10c>
80103666:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103669:	eb 3b                	jmp    801036a6 <pipewrite+0x96>
8010366b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || myproc()->killed){
80103670:	e8 6b 04 00 00       	call   80103ae0 <myproc>
80103675:	8b 48 24             	mov    0x24(%eax),%ecx
80103678:	85 c9                	test   %ecx,%ecx
8010367a:	75 34                	jne    801036b0 <pipewrite+0xa0>
      wakeup(&p->nread);
8010367c:	83 ec 0c             	sub    $0xc,%esp
8010367f:	56                   	push   %esi
80103680:	e8 bb 13 00 00       	call   80104a40 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103685:	58                   	pop    %eax
80103686:	5a                   	pop    %edx
80103687:	53                   	push   %ebx
80103688:	57                   	push   %edi
80103689:	e8 f2 12 00 00       	call   80104980 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010368e:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103694:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010369a:	83 c4 10             	add    $0x10,%esp
8010369d:	05 00 02 00 00       	add    $0x200,%eax
801036a2:	39 c2                	cmp    %eax,%edx
801036a4:	75 2a                	jne    801036d0 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
801036a6:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801036ac:	85 c0                	test   %eax,%eax
801036ae:	75 c0                	jne    80103670 <pipewrite+0x60>
        release(&p->lock);
801036b0:	83 ec 0c             	sub    $0xc,%esp
801036b3:	53                   	push   %ebx
801036b4:	e8 47 1a 00 00       	call   80105100 <release>
        return -1;
801036b9:	83 c4 10             	add    $0x10,%esp
801036bc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801036c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801036c4:	5b                   	pop    %ebx
801036c5:	5e                   	pop    %esi
801036c6:	5f                   	pop    %edi
801036c7:	5d                   	pop    %ebp
801036c8:	c3                   	ret
801036c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036d0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801036d3:	8d 42 01             	lea    0x1(%edx),%eax
801036d6:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
  for(i = 0; i < n; i++){
801036dc:	83 c1 01             	add    $0x1,%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801036df:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
801036e5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801036e8:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
801036ec:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801036f0:	8b 45 e0             	mov    -0x20(%ebp),%eax
801036f3:	39 c1                	cmp    %eax,%ecx
801036f5:	0f 85 50 ff ff ff    	jne    8010364b <pipewrite+0x3b>
801036fb:	8b 7d 10             	mov    0x10(%ebp),%edi
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801036fe:	83 ec 0c             	sub    $0xc,%esp
80103701:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103707:	50                   	push   %eax
80103708:	e8 33 13 00 00       	call   80104a40 <wakeup>
  release(&p->lock);
8010370d:	89 1c 24             	mov    %ebx,(%esp)
80103710:	e8 eb 19 00 00       	call   80105100 <release>
  return n;
80103715:	83 c4 10             	add    $0x10,%esp
80103718:	89 f8                	mov    %edi,%eax
8010371a:	eb a5                	jmp    801036c1 <pipewrite+0xb1>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010371c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010371f:	eb b2                	jmp    801036d3 <pipewrite+0xc3>
80103721:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103728:	00 
80103729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103730 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103730:	55                   	push   %ebp
80103731:	89 e5                	mov    %esp,%ebp
80103733:	57                   	push   %edi
80103734:	56                   	push   %esi
80103735:	53                   	push   %ebx
80103736:	83 ec 18             	sub    $0x18,%esp
80103739:	8b 75 08             	mov    0x8(%ebp),%esi
8010373c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010373f:	56                   	push   %esi
80103740:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103746:	e8 15 1a 00 00       	call   80105160 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010374b:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103751:	83 c4 10             	add    $0x10,%esp
80103754:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010375a:	74 2f                	je     8010378b <piperead+0x5b>
8010375c:	eb 37                	jmp    80103795 <piperead+0x65>
8010375e:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
80103760:	e8 7b 03 00 00       	call   80103ae0 <myproc>
80103765:	8b 40 24             	mov    0x24(%eax),%eax
80103768:	85 c0                	test   %eax,%eax
8010376a:	0f 85 80 00 00 00    	jne    801037f0 <piperead+0xc0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103770:	83 ec 08             	sub    $0x8,%esp
80103773:	56                   	push   %esi
80103774:	53                   	push   %ebx
80103775:	e8 06 12 00 00       	call   80104980 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010377a:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103780:	83 c4 10             	add    $0x10,%esp
80103783:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103789:	75 0a                	jne    80103795 <piperead+0x65>
8010378b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103791:	85 d2                	test   %edx,%edx
80103793:	75 cb                	jne    80103760 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103795:	8b 4d 10             	mov    0x10(%ebp),%ecx
80103798:	31 db                	xor    %ebx,%ebx
8010379a:	85 c9                	test   %ecx,%ecx
8010379c:	7f 26                	jg     801037c4 <piperead+0x94>
8010379e:	eb 2c                	jmp    801037cc <piperead+0x9c>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
801037a0:	8d 48 01             	lea    0x1(%eax),%ecx
801037a3:	25 ff 01 00 00       	and    $0x1ff,%eax
801037a8:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
801037ae:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
801037b3:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801037b6:	83 c3 01             	add    $0x1,%ebx
801037b9:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801037bc:	74 0e                	je     801037cc <piperead+0x9c>
801037be:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
    if(p->nread == p->nwrite)
801037c4:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
801037ca:	75 d4                	jne    801037a0 <piperead+0x70>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801037cc:	83 ec 0c             	sub    $0xc,%esp
801037cf:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
801037d5:	50                   	push   %eax
801037d6:	e8 65 12 00 00       	call   80104a40 <wakeup>
  release(&p->lock);
801037db:	89 34 24             	mov    %esi,(%esp)
801037de:	e8 1d 19 00 00       	call   80105100 <release>
  return i;
801037e3:	83 c4 10             	add    $0x10,%esp
}
801037e6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801037e9:	89 d8                	mov    %ebx,%eax
801037eb:	5b                   	pop    %ebx
801037ec:	5e                   	pop    %esi
801037ed:	5f                   	pop    %edi
801037ee:	5d                   	pop    %ebp
801037ef:	c3                   	ret
      release(&p->lock);
801037f0:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801037f3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
801037f8:	56                   	push   %esi
801037f9:	e8 02 19 00 00       	call   80105100 <release>
      return -1;
801037fe:	83 c4 10             	add    $0x10,%esp
}
80103801:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103804:	89 d8                	mov    %ebx,%eax
80103806:	5b                   	pop    %ebx
80103807:	5e                   	pop    %esi
80103808:	5f                   	pop    %edi
80103809:	5d                   	pop    %ebp
8010380a:	c3                   	ret
8010380b:	66 90                	xchg   %ax,%ax
8010380d:	66 90                	xchg   %ax,%ax
8010380f:	90                   	nop

80103810 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc *
allocproc(void)
{
80103810:	55                   	push   %ebp
80103811:	89 e5                	mov    %esp,%ebp
80103813:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103814:	bb 74 3c 11 80       	mov    $0x80113c74,%ebx
{
80103819:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
8010381c:	68 40 3c 11 80       	push   $0x80113c40
80103821:	e8 3a 19 00 00       	call   80105160 <acquire>
80103826:	83 c4 10             	add    $0x10,%esp
80103829:	eb 17                	jmp    80103842 <allocproc+0x32>
8010382b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103830:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
80103836:	81 fb 74 5f 11 80    	cmp    $0x80115f74,%ebx
8010383c:	0f 84 06 01 00 00    	je     80103948 <allocproc+0x138>
    if (p->state == UNUSED)
80103842:	8b 43 0c             	mov    0xc(%ebx),%eax
80103845:	85 c0                	test   %eax,%eax
80103847:	75 e7                	jne    80103830 <allocproc+0x20>
  return 0;

found:
  p->state = EMBRYO;
  p->priority = 60; //default priority
  p->pid = nextpid++;
80103849:	a1 04 b0 10 80       	mov    0x8010b004,%eax
  pstat_var.inuse[p->pid] = 1;
  cxj[0]++;
8010384e:	8b 0d 08 b0 10 80    	mov    0x8010b008,%ecx
  pstat_var.runtime[p->pid] = ticks;

  p->ctime = ticks;
  p->rtime = 0;

  release(&ptable.lock);
80103854:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80103857:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->priority = 60; //default priority
8010385e:	c7 43 7c 3c 00 00 00 	movl   $0x3c,0x7c(%ebx)
  p->pid = nextpid++;
80103865:	8d 50 01             	lea    0x1(%eax),%edx
80103868:	89 43 10             	mov    %eax,0x10(%ebx)
8010386b:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
  cxj[0]++;
80103871:	8d 51 01             	lea    0x1(%ecx),%edx
80103874:	89 15 08 b0 10 80    	mov    %edx,0x8010b008
  qxj[0][cxj[0]] = p;
8010387a:	89 1c 95 40 37 11 80 	mov    %ebx,-0x7feec8c0(,%edx,4)
  pstat_var.ticks[p->pid][0] = 0;
80103881:	8d 14 80             	lea    (%eax,%eax,4),%edx
80103884:	8d 14 95 40 2d 11 80 	lea    -0x7feed2c0(,%edx,4),%edx
  pstat_var.pid[p->pid] = p->pid;
8010388b:	89 04 85 40 2e 11 80 	mov    %eax,-0x7feed1c0(,%eax,4)
  pstat_var.ticks[p->pid][0] = 0;
80103892:	c7 82 00 05 00 00 00 	movl   $0x0,0x500(%edx)
80103899:	00 00 00 
  pstat_var.ticks[p->pid][1] = 0;
8010389c:	c7 82 04 05 00 00 00 	movl   $0x0,0x504(%edx)
801038a3:	00 00 00 
  pstat_var.ticks[p->pid][2] = 0;
801038a6:	c7 82 08 05 00 00 00 	movl   $0x0,0x508(%edx)
801038ad:	00 00 00 
  pstat_var.ticks[p->pid][3] = 0;
801038b0:	c7 82 0c 05 00 00 00 	movl   $0x0,0x50c(%edx)
801038b7:	00 00 00 
  pstat_var.runtime[p->pid] = ticks;
801038ba:	8b 15 80 5f 11 80    	mov    0x80115f80,%edx
  p->rtime = 0;
801038c0:	c7 83 88 00 00 00 00 	movl   $0x0,0x88(%ebx)
801038c7:	00 00 00 
  p->ctime = ticks;
801038ca:	89 93 80 00 00 00    	mov    %edx,0x80(%ebx)
  release(&ptable.lock);
801038d0:	68 40 3c 11 80       	push   $0x80113c40
  pstat_var.inuse[p->pid] = 1;
801038d5:	c7 04 85 40 2d 11 80 	movl   $0x1,-0x7feed2c0(,%eax,4)
801038dc:	01 00 00 00 
  pstat_var.current_queue[p->pid] = 0;
801038e0:	c7 04 85 40 31 11 80 	movl   $0x0,-0x7feecec0(,%eax,4)
801038e7:	00 00 00 00 
  pstat_var.runtime[p->pid] = ticks;
801038eb:	89 14 85 40 2f 11 80 	mov    %edx,-0x7feed0c0(,%eax,4)
  release(&ptable.lock);
801038f2:	e8 09 18 00 00       	call   80105100 <release>

  // Allocate kernel stack.
  if ((p->kstack = kalloc()) == 0)
801038f7:	e8 74 ed ff ff       	call   80102670 <kalloc>
801038fc:	83 c4 10             	add    $0x10,%esp
801038ff:	89 43 08             	mov    %eax,0x8(%ebx)
80103902:	85 c0                	test   %eax,%eax
80103904:	0f 84 d0 00 00 00    	je     801039da <allocproc+0x1ca>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
8010390a:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint *)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context *)sp;
  memset(p->context, 0, sizeof *p->context);
80103910:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103913:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103918:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint *)sp = (uint)trapret;
8010391b:	c7 40 14 d9 64 10 80 	movl   $0x801064d9,0x14(%eax)
  p->context = (struct context *)sp;
80103922:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103925:	6a 14                	push   $0x14
80103927:	6a 00                	push   $0x0
80103929:	50                   	push   %eax
8010392a:	e8 31 19 00 00       	call   80105260 <memset>
  p->context->eip = (uint)forkret;
8010392f:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
80103932:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103935:	c7 40 10 f0 39 10 80 	movl   $0x801039f0,0x10(%eax)
}
8010393c:	89 d8                	mov    %ebx,%eax
8010393e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103941:	c9                   	leave
80103942:	c3                   	ret
80103943:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  cxj[0]++;
80103948:	a1 08 b0 10 80       	mov    0x8010b008,%eax
  release(&ptable.lock);
8010394d:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103950:	31 db                	xor    %ebx,%ebx
  cxj[0]++;
80103952:	83 c0 01             	add    $0x1,%eax
80103955:	a3 08 b0 10 80       	mov    %eax,0x8010b008
  qxj[0][cxj[0]] = p;
8010395a:	c7 04 85 40 37 11 80 	movl   $0x80115f74,-0x7feec8c0(,%eax,4)
80103961:	74 5f 11 80 
  pstat_var.inuse[p->pid] = 1;
80103965:	a1 84 5f 11 80       	mov    0x80115f84,%eax
  pstat_var.ticks[p->pid][0] = 0;
8010396a:	8d 14 80             	lea    (%eax,%eax,4),%edx
  pstat_var.inuse[p->pid] = 1;
8010396d:	c7 04 85 40 2d 11 80 	movl   $0x1,-0x7feed2c0(,%eax,4)
80103974:	01 00 00 00 
  pstat_var.ticks[p->pid][0] = 0;
80103978:	8d 14 95 40 2d 11 80 	lea    -0x7feed2c0(,%edx,4),%edx
  pstat_var.pid[p->pid] = p->pid;
8010397f:	89 04 85 40 2e 11 80 	mov    %eax,-0x7feed1c0(,%eax,4)
  pstat_var.ticks[p->pid][0] = 0;
80103986:	c7 82 00 05 00 00 00 	movl   $0x0,0x500(%edx)
8010398d:	00 00 00 
  pstat_var.ticks[p->pid][1] = 0;
80103990:	c7 82 04 05 00 00 00 	movl   $0x0,0x504(%edx)
80103997:	00 00 00 
  pstat_var.ticks[p->pid][2] = 0;
8010399a:	c7 82 08 05 00 00 00 	movl   $0x0,0x508(%edx)
801039a1:	00 00 00 
  pstat_var.ticks[p->pid][3] = 0;
801039a4:	c7 82 0c 05 00 00 00 	movl   $0x0,0x50c(%edx)
801039ab:	00 00 00 
  pstat_var.runtime[p->pid] = ticks;
801039ae:	8b 15 80 5f 11 80    	mov    0x80115f80,%edx
  release(&ptable.lock);
801039b4:	68 40 3c 11 80       	push   $0x80113c40
  pstat_var.current_queue[p->pid] = 0;
801039b9:	c7 04 85 40 31 11 80 	movl   $0x0,-0x7feecec0(,%eax,4)
801039c0:	00 00 00 00 
  pstat_var.runtime[p->pid] = ticks;
801039c4:	89 14 85 40 2f 11 80 	mov    %edx,-0x7feed0c0(,%eax,4)
  release(&ptable.lock);
801039cb:	e8 30 17 00 00       	call   80105100 <release>
  return 0;
801039d0:	83 c4 10             	add    $0x10,%esp
}
801039d3:	89 d8                	mov    %ebx,%eax
801039d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801039d8:	c9                   	leave
801039d9:	c3                   	ret
    p->state = UNUSED;
801039da:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  return 0;
801039e1:	31 db                	xor    %ebx,%ebx
801039e3:	eb ee                	jmp    801039d3 <allocproc+0x1c3>
801039e5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801039ec:	00 
801039ed:	8d 76 00             	lea    0x0(%esi),%esi

801039f0 <forkret>:
}

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void forkret(void)
{
801039f0:	55                   	push   %ebp
801039f1:	89 e5                	mov    %esp,%ebp
801039f3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801039f6:	68 40 3c 11 80       	push   $0x80113c40
801039fb:	e8 00 17 00 00       	call   80105100 <release>

  if (first)
80103a00:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80103a05:	83 c4 10             	add    $0x10,%esp
80103a08:	85 c0                	test   %eax,%eax
80103a0a:	75 04                	jne    80103a10 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103a0c:	c9                   	leave
80103a0d:	c3                   	ret
80103a0e:	66 90                	xchg   %ax,%ax
    first = 0;
80103a10:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
80103a17:	00 00 00 
    iinit(ROOTDEV);
80103a1a:	83 ec 0c             	sub    $0xc,%esp
80103a1d:	6a 01                	push   $0x1
80103a1f:	e8 6c db ff ff       	call   80101590 <iinit>
    initlog(ROOTDEV);
80103a24:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103a2b:	e8 80 f2 ff ff       	call   80102cb0 <initlog>
}
80103a30:	83 c4 10             	add    $0x10,%esp
80103a33:	c9                   	leave
80103a34:	c3                   	ret
80103a35:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103a3c:	00 
80103a3d:	8d 76 00             	lea    0x0(%esi),%esi

80103a40 <pinit>:
{
80103a40:	55                   	push   %ebp
80103a41:	89 e5                	mov    %esp,%ebp
80103a43:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103a46:	68 6e 80 10 80       	push   $0x8010806e
80103a4b:	68 40 3c 11 80       	push   $0x80113c40
80103a50:	e8 1b 15 00 00       	call   80104f70 <initlock>
}
80103a55:	83 c4 10             	add    $0x10,%esp
80103a58:	c9                   	leave
80103a59:	c3                   	ret
80103a5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103a60 <mycpu>:
{
80103a60:	55                   	push   %ebp
80103a61:	89 e5                	mov    %esp,%ebp
80103a63:	56                   	push   %esi
80103a64:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103a65:	9c                   	pushf
80103a66:	58                   	pop    %eax
  if (readeflags() & FL_IF)
80103a67:	f6 c4 02             	test   $0x2,%ah
80103a6a:	75 46                	jne    80103ab2 <mycpu+0x52>
  apicid = lapicid();
80103a6c:	e8 6f ee ff ff       	call   801028e0 <lapicid>
  for (i = 0; i < ncpu; ++i)
80103a71:	8b 35 84 27 11 80    	mov    0x80112784,%esi
80103a77:	85 f6                	test   %esi,%esi
80103a79:	7e 2a                	jle    80103aa5 <mycpu+0x45>
80103a7b:	31 d2                	xor    %edx,%edx
80103a7d:	eb 08                	jmp    80103a87 <mycpu+0x27>
80103a7f:	90                   	nop
80103a80:	83 c2 01             	add    $0x1,%edx
80103a83:	39 f2                	cmp    %esi,%edx
80103a85:	74 1e                	je     80103aa5 <mycpu+0x45>
    if (cpus[i].apicid == apicid)
80103a87:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
80103a8d:	0f b6 99 a0 27 11 80 	movzbl -0x7feed860(%ecx),%ebx
80103a94:	39 c3                	cmp    %eax,%ebx
80103a96:	75 e8                	jne    80103a80 <mycpu+0x20>
}
80103a98:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
80103a9b:	8d 81 a0 27 11 80    	lea    -0x7feed860(%ecx),%eax
}
80103aa1:	5b                   	pop    %ebx
80103aa2:	5e                   	pop    %esi
80103aa3:	5d                   	pop    %ebp
80103aa4:	c3                   	ret
  panic("unknown apicid\n");
80103aa5:	83 ec 0c             	sub    $0xc,%esp
80103aa8:	68 75 80 10 80       	push   $0x80108075
80103aad:	e8 ce c8 ff ff       	call   80100380 <panic>
    panic("mycpu called with interrupts enabled\n");
80103ab2:	83 ec 0c             	sub    $0xc,%esp
80103ab5:	68 a8 84 10 80       	push   $0x801084a8
80103aba:	e8 c1 c8 ff ff       	call   80100380 <panic>
80103abf:	90                   	nop

80103ac0 <cpuid>:
{
80103ac0:	55                   	push   %ebp
80103ac1:	89 e5                	mov    %esp,%ebp
80103ac3:	83 ec 08             	sub    $0x8,%esp
  return mycpu() - cpus;
80103ac6:	e8 95 ff ff ff       	call   80103a60 <mycpu>
}
80103acb:	c9                   	leave
  return mycpu() - cpus;
80103acc:	2d a0 27 11 80       	sub    $0x801127a0,%eax
80103ad1:	c1 f8 04             	sar    $0x4,%eax
80103ad4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103ada:	c3                   	ret
80103adb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103ae0 <myproc>:
{
80103ae0:	55                   	push   %ebp
80103ae1:	89 e5                	mov    %esp,%ebp
80103ae3:	53                   	push   %ebx
80103ae4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103ae7:	e8 24 15 00 00       	call   80105010 <pushcli>
  c = mycpu();
80103aec:	e8 6f ff ff ff       	call   80103a60 <mycpu>
  p = c->proc;
80103af1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103af7:	e8 64 15 00 00       	call   80105060 <popcli>
}
80103afc:	89 d8                	mov    %ebx,%eax
80103afe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103b01:	c9                   	leave
80103b02:	c3                   	ret
80103b03:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103b0a:	00 
80103b0b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103b10 <userinit>:
{
80103b10:	55                   	push   %ebp
80103b11:	89 e5                	mov    %esp,%ebp
80103b13:	53                   	push   %ebx
80103b14:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103b17:	e8 f4 fc ff ff       	call   80103810 <allocproc>
80103b1c:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103b1e:	a3 74 5f 11 80       	mov    %eax,0x80115f74
  if ((p->pgdir = setupkvm()) == 0)
80103b23:	e8 98 3f 00 00       	call   80107ac0 <setupkvm>
80103b28:	89 43 04             	mov    %eax,0x4(%ebx)
80103b2b:	85 c0                	test   %eax,%eax
80103b2d:	0f 84 c8 00 00 00    	je     80103bfb <userinit+0xeb>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103b33:	83 ec 04             	sub    $0x4,%esp
80103b36:	68 2c 00 00 00       	push   $0x2c
80103b3b:	68 60 b4 10 80       	push   $0x8010b460
80103b40:	50                   	push   %eax
80103b41:	e8 5a 3c 00 00       	call   801077a0 <inituvm>
  p->sz = PGSIZE;
80103b46:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103b4c:	83 c4 0c             	add    $0xc,%esp
  p->ctime = ticks;
80103b4f:	a1 80 5f 11 80       	mov    0x80115f80,%eax
80103b54:	89 83 80 00 00 00    	mov    %eax,0x80(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103b5a:	6a 4c                	push   $0x4c
80103b5c:	6a 00                	push   $0x0
80103b5e:	ff 73 18             	push   0x18(%ebx)
80103b61:	e8 fa 16 00 00       	call   80105260 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103b66:	8b 43 18             	mov    0x18(%ebx),%eax
80103b69:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103b6e:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103b71:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103b76:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103b7a:	8b 43 18             	mov    0x18(%ebx),%eax
80103b7d:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103b81:	8b 43 18             	mov    0x18(%ebx),%eax
80103b84:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103b88:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103b8c:	8b 43 18             	mov    0x18(%ebx),%eax
80103b8f:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103b93:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103b97:	8b 43 18             	mov    0x18(%ebx),%eax
80103b9a:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103ba1:	8b 43 18             	mov    0x18(%ebx),%eax
80103ba4:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0; // beginning of initcode.S
80103bab:	8b 43 18             	mov    0x18(%ebx),%eax
80103bae:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103bb5:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103bb8:	6a 10                	push   $0x10
80103bba:	68 9e 80 10 80       	push   $0x8010809e
80103bbf:	50                   	push   %eax
80103bc0:	e8 4b 18 00 00       	call   80105410 <safestrcpy>
  p->cwd = namei("/");
80103bc5:	c7 04 24 a7 80 10 80 	movl   $0x801080a7,(%esp)
80103bcc:	e8 bf e4 ff ff       	call   80102090 <namei>
80103bd1:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103bd4:	c7 04 24 40 3c 11 80 	movl   $0x80113c40,(%esp)
80103bdb:	e8 80 15 00 00       	call   80105160 <acquire>
  p->state = RUNNABLE;
80103be0:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103be7:	c7 04 24 40 3c 11 80 	movl   $0x80113c40,(%esp)
80103bee:	e8 0d 15 00 00       	call   80105100 <release>
}
80103bf3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103bf6:	83 c4 10             	add    $0x10,%esp
80103bf9:	c9                   	leave
80103bfa:	c3                   	ret
    panic("userinit: out of memory?");
80103bfb:	83 ec 0c             	sub    $0xc,%esp
80103bfe:	68 85 80 10 80       	push   $0x80108085
80103c03:	e8 78 c7 ff ff       	call   80100380 <panic>
80103c08:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103c0f:	00 

80103c10 <growproc>:
{
80103c10:	55                   	push   %ebp
80103c11:	89 e5                	mov    %esp,%ebp
80103c13:	56                   	push   %esi
80103c14:	53                   	push   %ebx
80103c15:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103c18:	e8 f3 13 00 00       	call   80105010 <pushcli>
  c = mycpu();
80103c1d:	e8 3e fe ff ff       	call   80103a60 <mycpu>
  p = c->proc;
80103c22:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103c28:	e8 33 14 00 00       	call   80105060 <popcli>
  sz = curproc->sz;
80103c2d:	8b 03                	mov    (%ebx),%eax
  if (n > 0)
80103c2f:	85 f6                	test   %esi,%esi
80103c31:	7f 1d                	jg     80103c50 <growproc+0x40>
  else if (n < 0)
80103c33:	75 3b                	jne    80103c70 <growproc+0x60>
  switchuvm(curproc);
80103c35:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103c38:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103c3a:	53                   	push   %ebx
80103c3b:	e8 50 3a 00 00       	call   80107690 <switchuvm>
  return 0;
80103c40:	83 c4 10             	add    $0x10,%esp
80103c43:	31 c0                	xor    %eax,%eax
}
80103c45:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103c48:	5b                   	pop    %ebx
80103c49:	5e                   	pop    %esi
80103c4a:	5d                   	pop    %ebp
80103c4b:	c3                   	ret
80103c4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if ((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103c50:	83 ec 04             	sub    $0x4,%esp
80103c53:	01 c6                	add    %eax,%esi
80103c55:	56                   	push   %esi
80103c56:	50                   	push   %eax
80103c57:	ff 73 04             	push   0x4(%ebx)
80103c5a:	e8 91 3c 00 00       	call   801078f0 <allocuvm>
80103c5f:	83 c4 10             	add    $0x10,%esp
80103c62:	85 c0                	test   %eax,%eax
80103c64:	75 cf                	jne    80103c35 <growproc+0x25>
      return -1;
80103c66:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103c6b:	eb d8                	jmp    80103c45 <growproc+0x35>
80103c6d:	8d 76 00             	lea    0x0(%esi),%esi
    if ((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103c70:	83 ec 04             	sub    $0x4,%esp
80103c73:	01 c6                	add    %eax,%esi
80103c75:	56                   	push   %esi
80103c76:	50                   	push   %eax
80103c77:	ff 73 04             	push   0x4(%ebx)
80103c7a:	e8 91 3d 00 00       	call   80107a10 <deallocuvm>
80103c7f:	83 c4 10             	add    $0x10,%esp
80103c82:	85 c0                	test   %eax,%eax
80103c84:	75 af                	jne    80103c35 <growproc+0x25>
80103c86:	eb de                	jmp    80103c66 <growproc+0x56>
80103c88:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103c8f:	00 

80103c90 <fork>:
{
80103c90:	55                   	push   %ebp
80103c91:	89 e5                	mov    %esp,%ebp
80103c93:	57                   	push   %edi
80103c94:	56                   	push   %esi
80103c95:	53                   	push   %ebx
80103c96:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103c99:	e8 72 13 00 00       	call   80105010 <pushcli>
  c = mycpu();
80103c9e:	e8 bd fd ff ff       	call   80103a60 <mycpu>
  p = c->proc;
80103ca3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ca9:	e8 b2 13 00 00       	call   80105060 <popcli>
  if ((np = allocproc()) == 0)
80103cae:	e8 5d fb ff ff       	call   80103810 <allocproc>
80103cb3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103cb6:	85 c0                	test   %eax,%eax
80103cb8:	0f 84 d6 00 00 00    	je     80103d94 <fork+0x104>
  if ((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0)
80103cbe:	83 ec 08             	sub    $0x8,%esp
80103cc1:	ff 33                	push   (%ebx)
80103cc3:	89 c7                	mov    %eax,%edi
80103cc5:	ff 73 04             	push   0x4(%ebx)
80103cc8:	e8 e3 3e 00 00       	call   80107bb0 <copyuvm>
80103ccd:	83 c4 10             	add    $0x10,%esp
80103cd0:	89 47 04             	mov    %eax,0x4(%edi)
80103cd3:	85 c0                	test   %eax,%eax
80103cd5:	0f 84 9a 00 00 00    	je     80103d75 <fork+0xe5>
  np->sz = curproc->sz;
80103cdb:	8b 03                	mov    (%ebx),%eax
80103cdd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103ce0:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
80103ce2:	8b 79 18             	mov    0x18(%ecx),%edi
  np->parent = curproc;
80103ce5:	89 c8                	mov    %ecx,%eax
80103ce7:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103cea:	b9 13 00 00 00       	mov    $0x13,%ecx
80103cef:	8b 73 18             	mov    0x18(%ebx),%esi
80103cf2:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for (i = 0; i < NOFILE; i++)
80103cf4:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103cf6:	8b 40 18             	mov    0x18(%eax),%eax
80103cf9:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if (curproc->ofile[i])
80103d00:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103d04:	85 c0                	test   %eax,%eax
80103d06:	74 13                	je     80103d1b <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103d08:	83 ec 0c             	sub    $0xc,%esp
80103d0b:	50                   	push   %eax
80103d0c:	e8 bf d1 ff ff       	call   80100ed0 <filedup>
80103d11:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103d14:	83 c4 10             	add    $0x10,%esp
80103d17:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for (i = 0; i < NOFILE; i++)
80103d1b:	83 c6 01             	add    $0x1,%esi
80103d1e:	83 fe 10             	cmp    $0x10,%esi
80103d21:	75 dd                	jne    80103d00 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103d23:	83 ec 0c             	sub    $0xc,%esp
80103d26:	ff 73 68             	push   0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103d29:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80103d2c:	e8 4f da ff ff       	call   80101780 <idup>
80103d31:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103d34:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103d37:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103d3a:	8d 47 6c             	lea    0x6c(%edi),%eax
80103d3d:	6a 10                	push   $0x10
80103d3f:	53                   	push   %ebx
80103d40:	50                   	push   %eax
80103d41:	e8 ca 16 00 00       	call   80105410 <safestrcpy>
  pid = np->pid;
80103d46:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103d49:	c7 04 24 40 3c 11 80 	movl   $0x80113c40,(%esp)
80103d50:	e8 0b 14 00 00       	call   80105160 <acquire>
  np->state = RUNNABLE;
80103d55:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103d5c:	c7 04 24 40 3c 11 80 	movl   $0x80113c40,(%esp)
80103d63:	e8 98 13 00 00       	call   80105100 <release>
  return pid;
80103d68:	83 c4 10             	add    $0x10,%esp
}
80103d6b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103d6e:	89 d8                	mov    %ebx,%eax
80103d70:	5b                   	pop    %ebx
80103d71:	5e                   	pop    %esi
80103d72:	5f                   	pop    %edi
80103d73:	5d                   	pop    %ebp
80103d74:	c3                   	ret
    kfree(np->kstack);
80103d75:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103d78:	83 ec 0c             	sub    $0xc,%esp
80103d7b:	ff 73 08             	push   0x8(%ebx)
80103d7e:	e8 2d e7 ff ff       	call   801024b0 <kfree>
    np->kstack = 0;
80103d83:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
80103d8a:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80103d8d:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103d94:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103d99:	eb d0                	jmp    80103d6b <fork+0xdb>
80103d9b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103da0 <default_scheduler>:
{
80103da0:	55                   	push   %ebp
80103da1:	89 e5                	mov    %esp,%ebp
80103da3:	57                   	push   %edi
80103da4:	56                   	push   %esi
80103da5:	53                   	push   %ebx
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103da6:	bb 74 3c 11 80       	mov    $0x80113c74,%ebx
{
80103dab:	83 ec 18             	sub    $0x18,%esp
80103dae:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&ptable.lock);
80103db1:	68 40 3c 11 80       	push   $0x80113c40
    swtch(&(c->scheduler), p->context);
80103db6:	8d 7e 04             	lea    0x4(%esi),%edi
  acquire(&ptable.lock);
80103db9:	e8 a2 13 00 00       	call   80105160 <acquire>
80103dbe:	83 c4 10             	add    $0x10,%esp
80103dc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (p->state != RUNNABLE)
80103dc8:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103dcc:	75 33                	jne    80103e01 <default_scheduler+0x61>
    switchuvm(p);
80103dce:	83 ec 0c             	sub    $0xc,%esp
    c->proc = p;
80103dd1:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
    switchuvm(p);
80103dd7:	53                   	push   %ebx
80103dd8:	e8 b3 38 00 00       	call   80107690 <switchuvm>
    p->state = RUNNING;
80103ddd:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
    swtch(&(c->scheduler), p->context);
80103de4:	58                   	pop    %eax
80103de5:	5a                   	pop    %edx
80103de6:	ff 73 1c             	push   0x1c(%ebx)
80103de9:	57                   	push   %edi
80103dea:	e8 7c 16 00 00       	call   8010546b <swtch>
    switchkvm();
80103def:	e8 8c 38 00 00       	call   80107680 <switchkvm>
    c->proc = 0;
80103df4:	83 c4 10             	add    $0x10,%esp
80103df7:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103dfe:	00 00 00 
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e01:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
80103e07:	81 fb 74 5f 11 80    	cmp    $0x80115f74,%ebx
80103e0d:	75 b9                	jne    80103dc8 <default_scheduler+0x28>
  release(&ptable.lock);
80103e0f:	c7 45 08 40 3c 11 80 	movl   $0x80113c40,0x8(%ebp)
}
80103e16:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103e19:	5b                   	pop    %ebx
80103e1a:	5e                   	pop    %esi
80103e1b:	5f                   	pop    %edi
80103e1c:	5d                   	pop    %ebp
  release(&ptable.lock);
80103e1d:	e9 de 12 00 00       	jmp    80105100 <release>
80103e22:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103e29:	00 
80103e2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103e30 <priority_scheduler>:
{
80103e30:	55                   	push   %ebp
80103e31:	89 e5                	mov    %esp,%ebp
80103e33:	57                   	push   %edi
80103e34:	56                   	push   %esi
80103e35:	53                   	push   %ebx
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e36:	bb 74 3c 11 80       	mov    $0x80113c74,%ebx
{
80103e3b:	83 ec 18             	sub    $0x18,%esp
80103e3e:	8b 7d 08             	mov    0x8(%ebp),%edi
  acquire(&ptable.lock);
80103e41:	68 40 3c 11 80       	push   $0x80113c40
    swtch(&(c->scheduler), p->context);
80103e46:	8d 77 04             	lea    0x4(%edi),%esi
  acquire(&ptable.lock);
80103e49:	e8 12 13 00 00       	call   80105160 <acquire>
80103e4e:	83 c4 10             	add    $0x10,%esp
80103e51:	eb 13                	jmp    80103e66 <priority_scheduler+0x36>
80103e53:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e58:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
80103e5e:	81 fb 74 5f 11 80    	cmp    $0x80115f74,%ebx
80103e64:	73 6e                	jae    80103ed4 <priority_scheduler+0xa4>
    if (p->state != RUNNABLE)
80103e66:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103e6a:	75 ec                	jne    80103e58 <priority_scheduler+0x28>
    for (p1 = ptable.proc; p1 < &ptable.proc[NPROC]; p1++)
80103e6c:	b8 74 3c 11 80       	mov    $0x80113c74,%eax
80103e71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if (p1->state != RUNNABLE)
80103e78:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
80103e7c:	75 09                	jne    80103e87 <priority_scheduler+0x57>
        highP = p1;
80103e7e:	8b 50 7c             	mov    0x7c(%eax),%edx
80103e81:	39 53 7c             	cmp    %edx,0x7c(%ebx)
80103e84:	0f 4f d8             	cmovg  %eax,%ebx
    for (p1 = ptable.proc; p1 < &ptable.proc[NPROC]; p1++)
80103e87:	05 8c 00 00 00       	add    $0x8c,%eax
80103e8c:	3d 74 5f 11 80       	cmp    $0x80115f74,%eax
80103e91:	75 e5                	jne    80103e78 <priority_scheduler+0x48>
    switchuvm(p);
80103e93:	83 ec 0c             	sub    $0xc,%esp
    c->proc = p;
80103e96:	89 9f ac 00 00 00    	mov    %ebx,0xac(%edi)
    switchuvm(p);
80103e9c:	53                   	push   %ebx
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e9d:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
    switchuvm(p);
80103ea3:	e8 e8 37 00 00       	call   80107690 <switchuvm>
    p->state = RUNNING;
80103ea8:	c7 43 80 04 00 00 00 	movl   $0x4,-0x80(%ebx)
    swtch(&(c->scheduler), p->context);
80103eaf:	58                   	pop    %eax
80103eb0:	5a                   	pop    %edx
80103eb1:	ff 73 90             	push   -0x70(%ebx)
80103eb4:	56                   	push   %esi
80103eb5:	e8 b1 15 00 00       	call   8010546b <swtch>
    switchkvm();
80103eba:	e8 c1 37 00 00       	call   80107680 <switchkvm>
    c->proc = 0;
80103ebf:	83 c4 10             	add    $0x10,%esp
80103ec2:	c7 87 ac 00 00 00 00 	movl   $0x0,0xac(%edi)
80103ec9:	00 00 00 
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ecc:	81 fb 74 5f 11 80    	cmp    $0x80115f74,%ebx
80103ed2:	72 92                	jb     80103e66 <priority_scheduler+0x36>
  release(&ptable.lock);
80103ed4:	c7 45 08 40 3c 11 80 	movl   $0x80113c40,0x8(%ebp)
}
80103edb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ede:	5b                   	pop    %ebx
80103edf:	5e                   	pop    %esi
80103ee0:	5f                   	pop    %edi
80103ee1:	5d                   	pop    %ebp
  release(&ptable.lock);
80103ee2:	e9 19 12 00 00       	jmp    80105100 <release>
80103ee7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103eee:	00 
80103eef:	90                   	nop

80103ef0 <fcfs_scheduler>:
{
80103ef0:	55                   	push   %ebp
80103ef1:	89 e5                	mov    %esp,%ebp
80103ef3:	57                   	push   %edi
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ef4:	bf 74 3c 11 80       	mov    $0x80113c74,%edi
{
80103ef9:	56                   	push   %esi
80103efa:	53                   	push   %ebx
80103efb:	83 ec 18             	sub    $0x18,%esp
80103efe:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80103f01:	68 40 3c 11 80       	push   $0x80113c40
      swtch(&(c->scheduler), p->context);
80103f06:	8d 73 04             	lea    0x4(%ebx),%esi
  acquire(&ptable.lock);
80103f09:	e8 52 12 00 00       	call   80105160 <acquire>
80103f0e:	83 c4 10             	add    $0x10,%esp
80103f11:	eb 17                	jmp    80103f2a <fcfs_scheduler+0x3a>
80103f13:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f18:	81 c7 8c 00 00 00    	add    $0x8c,%edi
80103f1e:	81 ff 74 5f 11 80    	cmp    $0x80115f74,%edi
80103f24:	0f 83 a1 00 00 00    	jae    80103fcb <fcfs_scheduler+0xdb>
    if (p->state != RUNNABLE)
80103f2a:	83 7f 0c 03          	cmpl   $0x3,0xc(%edi)
80103f2e:	75 e8                	jne    80103f18 <fcfs_scheduler+0x28>
    for (p1 = ptable.proc; p1 < &ptable.proc[NPROC]; p1++)
80103f30:	b8 74 3c 11 80       	mov    $0x80113c74,%eax
80103f35:	8d 76 00             	lea    0x0(%esi),%esi
      if (p1->state != RUNNABLE /*|| p->state != RUNNING */)
80103f38:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
80103f3c:	75 0f                	jne    80103f4d <fcfs_scheduler+0x5d>
        highP = p1;
80103f3e:	8b 8f 80 00 00 00    	mov    0x80(%edi),%ecx
80103f44:	39 88 80 00 00 00    	cmp    %ecx,0x80(%eax)
80103f4a:	0f 42 f8             	cmovb  %eax,%edi
    for (p1 = ptable.proc; p1 < &ptable.proc[NPROC]; p1++)
80103f4d:	05 8c 00 00 00       	add    $0x8c,%eax
80103f52:	3d 74 5f 11 80       	cmp    $0x80115f74,%eax
80103f57:	75 df                	jne    80103f38 <fcfs_scheduler+0x48>
    if (running_p == 0 || (running_p->state == RUNNING && p->ctime < running_p->ctime) || running_p->state != RUNNING)
80103f59:	a1 24 2d 11 80       	mov    0x80112d24,%eax
80103f5e:	85 c0                	test   %eax,%eax
80103f60:	74 1e                	je     80103f80 <fcfs_scheduler+0x90>
80103f62:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80103f66:	74 76                	je     80103fde <fcfs_scheduler+0xee>
      if (p->pid > 2 && running_p != 0 && running_p->pid != p->pid && running_p->pid > 2)
80103f68:	8b 57 10             	mov    0x10(%edi),%edx
80103f6b:	83 fa 02             	cmp    $0x2,%edx
80103f6e:	7e 10                	jle    80103f80 <fcfs_scheduler+0x90>
80103f70:	8b 40 10             	mov    0x10(%eax),%eax
80103f73:	39 d0                	cmp    %edx,%eax
80103f75:	74 09                	je     80103f80 <fcfs_scheduler+0x90>
80103f77:	83 f8 02             	cmp    $0x2,%eax
80103f7a:	7f 79                	jg     80103ff5 <fcfs_scheduler+0x105>
80103f7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      switchuvm(p);
80103f80:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103f83:	89 bb ac 00 00 00    	mov    %edi,0xac(%ebx)
      switchuvm(p);
80103f89:	57                   	push   %edi
80103f8a:	e8 01 37 00 00       	call   80107690 <switchuvm>
      p->state = RUNNING;
80103f8f:	c7 47 0c 04 00 00 00 	movl   $0x4,0xc(%edi)
      running_p = p;
80103f96:	89 3d 24 2d 11 80    	mov    %edi,0x80112d24
      swtch(&(c->scheduler), p->context);
80103f9c:	58                   	pop    %eax
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f9d:	81 c7 8c 00 00 00    	add    $0x8c,%edi
      swtch(&(c->scheduler), p->context);
80103fa3:	5a                   	pop    %edx
80103fa4:	ff 77 90             	push   -0x70(%edi)
80103fa7:	56                   	push   %esi
80103fa8:	e8 be 14 00 00       	call   8010546b <swtch>
      switchkvm();
80103fad:	e8 ce 36 00 00       	call   80107680 <switchkvm>
      c->proc = 0;
80103fb2:	83 c4 10             	add    $0x10,%esp
80103fb5:	c7 83 ac 00 00 00 00 	movl   $0x0,0xac(%ebx)
80103fbc:	00 00 00 
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103fbf:	81 ff 74 5f 11 80    	cmp    $0x80115f74,%edi
80103fc5:	0f 82 5f ff ff ff    	jb     80103f2a <fcfs_scheduler+0x3a>
  release(&ptable.lock);
80103fcb:	c7 45 08 40 3c 11 80 	movl   $0x80113c40,0x8(%ebp)
}
80103fd2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103fd5:	5b                   	pop    %ebx
80103fd6:	5e                   	pop    %esi
80103fd7:	5f                   	pop    %edi
80103fd8:	5d                   	pop    %ebp
  release(&ptable.lock);
80103fd9:	e9 22 11 00 00       	jmp    80105100 <release>
    if (running_p == 0 || (running_p->state == RUNNING && p->ctime < running_p->ctime) || running_p->state != RUNNING)
80103fde:	8b 90 80 00 00 00    	mov    0x80(%eax),%edx
80103fe4:	39 97 80 00 00 00    	cmp    %edx,0x80(%edi)
80103fea:	0f 83 28 ff ff ff    	jae    80103f18 <fcfs_scheduler+0x28>
80103ff0:	e9 73 ff ff ff       	jmp    80103f68 <fcfs_scheduler+0x78>
        cprintf("Running process %d .....\n", running_p->pid);
80103ff5:	83 ec 08             	sub    $0x8,%esp
80103ff8:	50                   	push   %eax
80103ff9:	68 a9 80 10 80       	push   $0x801080a9
80103ffe:	e8 ad c6 ff ff       	call   801006b0 <cprintf>
80104003:	83 c4 10             	add    $0x10,%esp
80104006:	e9 75 ff ff ff       	jmp    80103f80 <fcfs_scheduler+0x90>
8010400b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104010 <MLFQ_scheduler>:
{
80104010:	55                   	push   %ebp
80104011:	89 e5                	mov    %esp,%ebp
80104013:	57                   	push   %edi
80104014:	56                   	push   %esi
80104015:	53                   	push   %ebx
80104016:	83 ec 58             	sub    $0x58,%esp
80104019:	8b 45 08             	mov    0x8(%ebp),%eax
8010401c:	89 45 b0             	mov    %eax,-0x50(%ebp)
  acquire(&ptable.lock);
8010401f:	68 40 3c 11 80       	push   $0x80113c40
80104024:	e8 37 11 00 00       	call   80105160 <acquire>
  int timedur[] = {1, 2, 4, 8, 16};
80104029:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
80104030:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104033:	8d 4d e8             	lea    -0x18(%ebp),%ecx
80104036:	c7 45 d8 02 00 00 00 	movl   $0x2,-0x28(%ebp)
8010403d:	83 c4 10             	add    $0x10,%esp
80104040:	c7 45 dc 04 00 00 00 	movl   $0x4,-0x24(%ebp)
80104047:	c7 45 e0 08 00 00 00 	movl   $0x8,-0x20(%ebp)
8010404e:	c7 45 e4 10 00 00 00 	movl   $0x10,-0x1c(%ebp)
  for (int i = 0; i < 5; i++) //**change**
80104055:	8d 76 00             	lea    0x0(%esi),%esi
    timedur[i] *= ticksTodur;
80104058:	6b 10 1e             	imul   $0x1e,(%eax),%edx
  for (int i = 0; i < 5; i++) //**change**
8010405b:	83 c0 04             	add    $0x4,%eax
    timedur[i] *= ticksTodur;
8010405e:	89 50 fc             	mov    %edx,-0x4(%eax)
  for (int i = 0; i < 5; i++) //**change**
80104061:	39 c8                	cmp    %ecx,%eax
80104063:	75 f3                	jne    80104058 <MLFQ_scheduler+0x48>
      if (ticks - pstat_var.runtime[i] >= exceededTimedur)
80104065:	a1 80 5f 11 80       	mov    0x80115f80,%eax
  for (int t = 1; t < 5; t++)
8010406a:	be 01 00 00 00       	mov    $0x1,%esi
      if (ticks - pstat_var.runtime[i] >= exceededTimedur)
8010406f:	89 45 c4             	mov    %eax,-0x3c(%ebp)
        cxj[t - 1]++;
80104072:	8d 7e ff             	lea    -0x1(%esi),%edi
80104075:	89 f0                	mov    %esi,%eax
80104077:	c1 e0 06             	shl    $0x6,%eax
8010407a:	89 7d bc             	mov    %edi,-0x44(%ebp)
        qxj[t - 1][cxj[t - 1]] = p;
8010407d:	c1 e7 06             	shl    $0x6,%edi
80104080:	89 45 b4             	mov    %eax,-0x4c(%ebp)
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104083:	b8 74 3c 11 80       	mov    $0x80113c74,%eax
        qxj[t - 1][cxj[t - 1]] = p;
80104088:	89 7d b8             	mov    %edi,-0x48(%ebp)
8010408b:	eb 13                	jmp    801040a0 <MLFQ_scheduler+0x90>
8010408d:	8d 76 00             	lea    0x0(%esi),%esi
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104090:	05 8c 00 00 00       	add    $0x8c,%eax
80104095:	3d 74 5f 11 80       	cmp    $0x80115f74,%eax
8010409a:	0f 84 f0 00 00 00    	je     80104190 <MLFQ_scheduler+0x180>
      if (p->state != RUNNABLE)
801040a0:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
801040a4:	75 ea                	jne    80104090 <MLFQ_scheduler+0x80>
      int i = p->pid;
801040a6:	8b 48 10             	mov    0x10(%eax),%ecx
      if (pstat_var.current_queue[i] != t) //**change**
801040a9:	8d 91 00 01 00 00    	lea    0x100(%ecx),%edx
801040af:	39 34 8d 40 31 11 80 	cmp    %esi,-0x7feecec0(,%ecx,4)
801040b6:	75 d8                	jne    80104090 <MLFQ_scheduler+0x80>
      if (ticks - pstat_var.runtime[i] >= exceededTimedur)
801040b8:	8b 5d c4             	mov    -0x3c(%ebp),%ebx
801040bb:	2b 1c 8d 40 2f 11 80 	sub    -0x7feed0c0(,%ecx,4),%ebx
801040c2:	8d b9 80 00 00 00    	lea    0x80(%ecx),%edi
801040c8:	81 fb ed 02 00 00    	cmp    $0x2ed,%ebx
801040ce:	76 c0                	jbe    80104090 <MLFQ_scheduler+0x80>
        cxj[t - 1]++;
801040d0:	8b 1c b5 04 b0 10 80 	mov    -0x7fef4ffc(,%esi,4),%ebx
801040d7:	83 c3 01             	add    $0x1,%ebx
801040da:	89 5d c0             	mov    %ebx,-0x40(%ebp)
801040dd:	89 1c b5 04 b0 10 80 	mov    %ebx,-0x7fef4ffc(,%esi,4)
        pstat_var.current_queue[p->pid] = t - 1;
801040e4:	8b 5d bc             	mov    -0x44(%ebp),%ebx
801040e7:	89 1c 95 40 2d 11 80 	mov    %ebx,-0x7feed2c0(,%edx,4)
        pstat_var.runtime[p->pid] = ticks;
801040ee:	8b 5d c4             	mov    -0x3c(%ebp),%ebx
        qxj[t][i] = 0;
801040f1:	89 f2                	mov    %esi,%edx
801040f3:	c1 e2 06             	shl    $0x6,%edx
        pstat_var.runtime[p->pid] = ticks;
801040f6:	89 1c bd 40 2d 11 80 	mov    %ebx,-0x7feed2c0(,%edi,4)
        qxj[t - 1][cxj[t - 1]] = p;
801040fd:	8b 7d b8             	mov    -0x48(%ebp),%edi
        qxj[t][i] = 0;
80104100:	01 ca                	add    %ecx,%edx
        qxj[t - 1][cxj[t - 1]] = p;
80104102:	8b 5d c0             	mov    -0x40(%ebp),%ebx
80104105:	01 fb                	add    %edi,%ebx
        for (j = i; j <= cxj[t] - 1; j++)
80104107:	8b 3c b5 08 b0 10 80 	mov    -0x7fef4ff8(,%esi,4),%edi
        qxj[t - 1][cxj[t - 1]] = p;
8010410e:	89 04 9d 40 37 11 80 	mov    %eax,-0x7feec8c0(,%ebx,4)
        qxj[t][i] = 0;
80104115:	c7 04 95 40 37 11 80 	movl   $0x0,-0x7feec8c0(,%edx,4)
8010411c:	00 00 00 00 
        for (j = i; j <= cxj[t] - 1; j++)
80104120:	39 f9                	cmp    %edi,%ecx
80104122:	7d 2c                	jge    80104150 <MLFQ_scheduler+0x140>
80104124:	8b 5d b4             	mov    -0x4c(%ebp),%ebx
80104127:	89 45 c0             	mov    %eax,-0x40(%ebp)
8010412a:	8d 14 19             	lea    (%ecx,%ebx,1),%edx
8010412d:	01 fb                	add    %edi,%ebx
8010412f:	8d 14 95 40 37 11 80 	lea    -0x7feec8c0(,%edx,4),%edx
80104136:	8d 1c 9d 40 37 11 80 	lea    -0x7feec8c0(,%ebx,4),%ebx
8010413d:	8d 76 00             	lea    0x0(%esi),%esi
          qxj[t][j] = qxj[t][j + 1];
80104140:	8b 42 04             	mov    0x4(%edx),%eax
        for (j = i; j <= cxj[t] - 1; j++)
80104143:	83 c2 04             	add    $0x4,%edx
          qxj[t][j] = qxj[t][j + 1];
80104146:	89 42 fc             	mov    %eax,-0x4(%edx)
        for (j = i; j <= cxj[t] - 1; j++)
80104149:	39 da                	cmp    %ebx,%edx
8010414b:	75 f3                	jne    80104140 <MLFQ_scheduler+0x130>
8010414d:	8b 45 c0             	mov    -0x40(%ebp),%eax
        qxj[t][cxj[t]] = 0;
80104150:	89 f2                	mov    %esi,%edx
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104152:	05 8c 00 00 00       	add    $0x8c,%eax
        pstat_var.num_run[p->pid] = 0;
80104157:	c7 04 8d 40 30 11 80 	movl   $0x0,-0x7feecfc0(,%ecx,4)
8010415e:	00 00 00 00 
        qxj[t][cxj[t]] = 0;
80104162:	c1 e2 06             	shl    $0x6,%edx
80104165:	01 fa                	add    %edi,%edx
        cxj[t]--;
80104167:	83 ef 01             	sub    $0x1,%edi
        qxj[t][cxj[t]] = 0;
8010416a:	c7 04 95 40 37 11 80 	movl   $0x0,-0x7feec8c0(,%edx,4)
80104171:	00 00 00 00 
        cxj[t]--;
80104175:	89 3c b5 08 b0 10 80 	mov    %edi,-0x7fef4ff8(,%esi,4)
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010417c:	3d 74 5f 11 80       	cmp    $0x80115f74,%eax
80104181:	0f 85 19 ff ff ff    	jne    801040a0 <MLFQ_scheduler+0x90>
80104187:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010418e:	00 
8010418f:	90                   	nop
  for (int t = 1; t < 5; t++)
80104190:	83 c6 01             	add    $0x1,%esi
80104193:	83 fe 05             	cmp    $0x5,%esi
80104196:	0f 85 d6 fe ff ff    	jne    80104072 <MLFQ_scheduler+0x62>
        swtch(&(c->scheduler), p->context);
8010419c:	8b 45 b0             	mov    -0x50(%ebp),%eax
8010419f:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
801041a6:	83 c0 04             	add    $0x4,%eax
801041a9:	89 45 bc             	mov    %eax,-0x44(%ebp)
    if (cxj[t] != -1) //cxj[t] is number of process curr in queue
801041ac:	8b 7d c4             	mov    -0x3c(%ebp),%edi
801041af:	8b 04 bd 08 b0 10 80 	mov    -0x7fef4ff8(,%edi,4),%eax
801041b6:	89 f9                	mov    %edi,%ecx
801041b8:	83 c7 01             	add    $0x1,%edi
801041bb:	89 7d c4             	mov    %edi,-0x3c(%ebp)
801041be:	85 c0                	test   %eax,%eax
801041c0:	0f 89 f1 00 00 00    	jns    801042b7 <MLFQ_scheduler+0x2a7>
  for (int t = 0; t < 4; t++)
801041c6:	83 7d c4 04          	cmpl   $0x4,-0x3c(%ebp)
801041ca:	75 e0                	jne    801041ac <MLFQ_scheduler+0x19c>
      swtch(&(c->scheduler), p->context);
801041cc:	8b 45 b0             	mov    -0x50(%ebp),%eax
  if (cxj[4] != -1)
801041cf:	8b 0d 18 b0 10 80    	mov    0x8010b018,%ecx
    for (i = 0; i <= cxj[4]; i++)
801041d5:	31 db                	xor    %ebx,%ebx
      swtch(&(c->scheduler), p->context);
801041d7:	8d 78 04             	lea    0x4(%eax),%edi
  if (cxj[4] != -1)
801041da:	85 c9                	test   %ecx,%ecx
801041dc:	79 1b                	jns    801041f9 <MLFQ_scheduler+0x1e9>
801041de:	e9 c1 00 00 00       	jmp    801042a4 <MLFQ_scheduler+0x294>
801041e3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    for (i = 0; i <= cxj[4]; i++)
801041e8:	8b 15 18 b0 10 80    	mov    0x8010b018,%edx
801041ee:	83 c3 01             	add    $0x1,%ebx
801041f1:	39 d3                	cmp    %edx,%ebx
801041f3:	0f 8f ab 00 00 00    	jg     801042a4 <MLFQ_scheduler+0x294>
      if (qxj[4][i]->state != RUNNABLE)
801041f9:	8b 34 9d 40 3b 11 80 	mov    -0x7feec4c0(,%ebx,4),%esi
80104200:	83 7e 0c 03          	cmpl   $0x3,0xc(%esi)
80104204:	75 e2                	jne    801041e8 <MLFQ_scheduler+0x1d8>
      pstat_var.num_run[p->pid]++;
80104206:	8b 46 10             	mov    0x10(%esi),%eax
      switchuvm(p);
80104209:	83 ec 0c             	sub    $0xc,%esp
      pstat_var.num_run[p->pid]++;
8010420c:	83 04 85 40 30 11 80 	addl   $0x1,-0x7feecfc0(,%eax,4)
80104213:	01 
      switchuvm(p);
80104214:	56                   	push   %esi
80104215:	e8 76 34 00 00       	call   80107690 <switchuvm>
      c->proc = p;
8010421a:	8b 45 b0             	mov    -0x50(%ebp),%eax
      p->state = RUNNING;
8010421d:	c7 46 0c 04 00 00 00 	movl   $0x4,0xc(%esi)
      c->proc = p;
80104224:	89 b0 ac 00 00 00    	mov    %esi,0xac(%eax)
      swtch(&(c->scheduler), p->context);
8010422a:	58                   	pop    %eax
8010422b:	5a                   	pop    %edx
8010422c:	ff 76 1c             	push   0x1c(%esi)
8010422f:	57                   	push   %edi
80104230:	e8 36 12 00 00       	call   8010546b <swtch>
      switchkvm();
80104235:	e8 46 34 00 00       	call   80107680 <switchkvm>
      pstat_var.ticks[p->pid][3] = pstat_var.num_run[p->pid];
8010423a:	8b 46 10             	mov    0x10(%esi),%eax
      for (j = i; j <= cxj[4] - 1; j++)
8010423d:	83 c4 10             	add    $0x10,%esp
      qxj[4][i] = 0;
80104240:	c7 04 9d 40 3b 11 80 	movl   $0x0,-0x7feec4c0(,%ebx,4)
80104247:	00 00 00 00 
      pstat_var.ticks[p->pid][3] = pstat_var.num_run[p->pid];
8010424b:	8d 14 80             	lea    (%eax,%eax,4),%edx
8010424e:	8b 04 85 40 30 11 80 	mov    -0x7feecfc0(,%eax,4),%eax
80104255:	89 04 95 4c 32 11 80 	mov    %eax,-0x7feecdb4(,%edx,4)
      for (j = i; j <= cxj[4] - 1; j++)
8010425c:	8b 15 18 b0 10 80    	mov    0x8010b018,%edx
80104262:	89 d8                	mov    %ebx,%eax
80104264:	39 da                	cmp    %ebx,%edx
80104266:	7e 1d                	jle    80104285 <MLFQ_scheduler+0x275>
80104268:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010426f:	00 
        qxj[4][j] = qxj[4][j + 1];
80104270:	83 c0 01             	add    $0x1,%eax
80104273:	8b 0c 85 40 3b 11 80 	mov    -0x7feec4c0(,%eax,4),%ecx
8010427a:	89 0c 85 3c 3b 11 80 	mov    %ecx,-0x7feec4c4(,%eax,4)
      for (j = i; j <= cxj[4] - 1; j++)
80104281:	39 d0                	cmp    %edx,%eax
80104283:	75 eb                	jne    80104270 <MLFQ_scheduler+0x260>
      c->proc = 0;
80104285:	8b 45 b0             	mov    -0x50(%ebp),%eax
    for (i = 0; i <= cxj[4]; i++)
80104288:	83 c3 01             	add    $0x1,%ebx
      qxj[4][cxj[4]] = p;
8010428b:	89 34 95 40 3b 11 80 	mov    %esi,-0x7feec4c0(,%edx,4)
      c->proc = 0;
80104292:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80104299:	00 00 00 
    for (i = 0; i <= cxj[4]; i++)
8010429c:	39 d3                	cmp    %edx,%ebx
8010429e:	0f 8e 55 ff ff ff    	jle    801041f9 <MLFQ_scheduler+0x1e9>
  release(&ptable.lock);
801042a4:	c7 45 08 40 3c 11 80 	movl   $0x80113c40,0x8(%ebp)
}
801042ab:	8d 65 f4             	lea    -0xc(%ebp),%esp
801042ae:	5b                   	pop    %ebx
801042af:	5e                   	pop    %esi
801042b0:	5f                   	pop    %edi
801042b1:	5d                   	pop    %ebp
  release(&ptable.lock);
801042b2:	e9 49 0e 00 00       	jmp    80105100 <release>
801042b7:	89 ce                	mov    %ecx,%esi
      for (i = 0; i <= cxj[t]; i++)
801042b9:	31 ff                	xor    %edi,%edi
801042bb:	c1 e6 08             	shl    $0x8,%esi
801042be:	81 c6 40 37 11 80    	add    $0x80113740,%esi
801042c4:	eb 1d                	jmp    801042e3 <MLFQ_scheduler+0x2d3>
801042c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801042cd:	00 
801042ce:	66 90                	xchg   %ax,%ax
801042d0:	83 c7 01             	add    $0x1,%edi
801042d3:	83 c6 04             	add    $0x4,%esi
801042d6:	39 3c 8d 08 b0 10 80 	cmp    %edi,-0x7fef4ff8(,%ecx,4)
801042dd:	0f 8c e3 fe ff ff    	jl     801041c6 <MLFQ_scheduler+0x1b6>
        if (qxj[t][i]->state != RUNNABLE)
801042e3:	8b 1e                	mov    (%esi),%ebx
801042e5:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
801042e9:	75 e5                	jne    801042d0 <MLFQ_scheduler+0x2c0>
        pstat_var.num_run[p->pid]++;
801042eb:	8b 43 10             	mov    0x10(%ebx),%eax
        switchuvm(p);
801042ee:	83 ec 0c             	sub    $0xc,%esp
801042f1:	89 4d c0             	mov    %ecx,-0x40(%ebp)
        pstat_var.num_run[p->pid]++;
801042f4:	83 04 85 40 30 11 80 	addl   $0x1,-0x7feecfc0(,%eax,4)
801042fb:	01 
        switchuvm(p);
801042fc:	53                   	push   %ebx
801042fd:	e8 8e 33 00 00       	call   80107690 <switchuvm>
        c->proc = p;
80104302:	8b 45 b0             	mov    -0x50(%ebp),%eax
        p->state = RUNNING;
80104305:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
        c->proc = p;
8010430c:	89 98 ac 00 00 00    	mov    %ebx,0xac(%eax)
        swtch(&(c->scheduler), p->context);
80104312:	58                   	pop    %eax
80104313:	5a                   	pop    %edx
80104314:	ff 73 1c             	push   0x1c(%ebx)
80104317:	ff 75 bc             	push   -0x44(%ebp)
8010431a:	e8 4c 11 00 00       	call   8010546b <swtch>
        switchkvm();
8010431f:	e8 5c 33 00 00       	call   80107680 <switchkvm>
        pstat_var.ticks[p->pid][t] = pstat_var.num_run[p->pid];
80104324:	8b 43 10             	mov    0x10(%ebx),%eax
80104327:	8b 4d c0             	mov    -0x40(%ebp),%ecx
        if (pstat_var.num_run[p->pid] == timedur[t])
8010432a:	83 c4 10             	add    $0x10,%esp
        pstat_var.ticks[p->pid][t] = pstat_var.num_run[p->pid];
8010432d:	8d 14 80             	lea    (%eax,%eax,4),%edx
80104330:	8b 04 85 40 30 11 80 	mov    -0x7feecfc0(,%eax,4),%eax
80104337:	8d 94 11 40 01 00 00 	lea    0x140(%ecx,%edx,1),%edx
8010433e:	89 04 95 40 2d 11 80 	mov    %eax,-0x7feed2c0(,%edx,4)
        if (pstat_var.num_run[p->pid] == timedur[t])
80104345:	8b 43 10             	mov    0x10(%ebx),%eax
80104348:	8b 54 8d d4          	mov    -0x2c(%ebp,%ecx,4),%edx
8010434c:	39 14 85 40 30 11 80 	cmp    %edx,-0x7feecfc0(,%eax,4)
80104353:	74 12                	je     80104367 <MLFQ_scheduler+0x357>
        c->proc = 0;
80104355:	8b 45 b0             	mov    -0x50(%ebp),%eax
80104358:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
8010435f:	00 00 00 
80104362:	e9 69 ff ff ff       	jmp    801042d0 <MLFQ_scheduler+0x2c0>
          cxj[t + 1]++;
80104367:	8b 04 8d 0c b0 10 80 	mov    -0x7fef4ff4(,%ecx,4),%eax
8010436e:	83 c0 01             	add    $0x1,%eax
80104371:	89 45 c0             	mov    %eax,-0x40(%ebp)
80104374:	89 04 8d 0c b0 10 80 	mov    %eax,-0x7fef4ff4(,%ecx,4)
          pstat_var.current_queue[p->pid] = t + 1;
8010437b:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010437e:	8b 53 10             	mov    0x10(%ebx),%edx
80104381:	89 04 95 40 31 11 80 	mov    %eax,-0x7feecec0(,%edx,4)
          pstat_var.runtime[p->pid] = ticks;
80104388:	a1 80 5f 11 80       	mov    0x80115f80,%eax
8010438d:	8b 53 10             	mov    0x10(%ebx),%edx
80104390:	89 04 95 40 2f 11 80 	mov    %eax,-0x7feed0c0(,%edx,4)
          qxj[t + 1][cxj[t + 1]] = p;
80104397:	8b 55 c4             	mov    -0x3c(%ebp),%edx
8010439a:	8b 45 c0             	mov    -0x40(%ebp),%eax
8010439d:	c1 e2 06             	shl    $0x6,%edx
801043a0:	01 c2                	add    %eax,%edx
          for (j = i; j <= cxj[t] - 1; j++)
801043a2:	8b 04 8d 08 b0 10 80 	mov    -0x7fef4ff8(,%ecx,4),%eax
          qxj[t + 1][cxj[t + 1]] = p;
801043a9:	89 1c 95 40 37 11 80 	mov    %ebx,-0x7feec8c0(,%edx,4)
          for (j = i; j <= cxj[t] - 1; j++)
801043b0:	89 45 c0             	mov    %eax,-0x40(%ebp)
          qxj[t][i] = 0;
801043b3:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
          for (j = i; j <= cxj[t] - 1; j++)
801043b9:	39 f8                	cmp    %edi,%eax
801043bb:	7e 2b                	jle    801043e8 <MLFQ_scheduler+0x3d8>
801043bd:	8b 55 c0             	mov    -0x40(%ebp),%edx
801043c0:	89 c8                	mov    %ecx,%eax
801043c2:	89 4d b8             	mov    %ecx,-0x48(%ebp)
801043c5:	c1 e0 06             	shl    $0x6,%eax
801043c8:	01 d0                	add    %edx,%eax
801043ca:	8d 14 85 40 37 11 80 	lea    -0x7feec8c0(,%eax,4),%edx
801043d1:	89 f0                	mov    %esi,%eax
801043d3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
            qxj[t][j] = qxj[t][j + 1];
801043d8:	8b 48 04             	mov    0x4(%eax),%ecx
          for (j = i; j <= cxj[t] - 1; j++)
801043db:	83 c0 04             	add    $0x4,%eax
            qxj[t][j] = qxj[t][j + 1];
801043de:	89 48 fc             	mov    %ecx,-0x4(%eax)
          for (j = i; j <= cxj[t] - 1; j++)
801043e1:	39 c2                	cmp    %eax,%edx
801043e3:	75 f3                	jne    801043d8 <MLFQ_scheduler+0x3c8>
801043e5:	8b 4d b8             	mov    -0x48(%ebp),%ecx
          qxj[t][cxj[t]] = 0;
801043e8:	8b 55 c0             	mov    -0x40(%ebp),%edx
801043eb:	89 c8                	mov    %ecx,%eax
801043ed:	c1 e0 06             	shl    $0x6,%eax
801043f0:	01 d0                	add    %edx,%eax
801043f2:	c7 04 85 40 37 11 80 	movl   $0x0,-0x7feec8c0(,%eax,4)
801043f9:	00 00 00 00 
          pstat_var.num_run[p->pid] = 0;
801043fd:	8b 43 10             	mov    0x10(%ebx),%eax
80104400:	c7 04 85 40 30 11 80 	movl   $0x0,-0x7feecfc0(,%eax,4)
80104407:	00 00 00 00 
          cxj[t]--;
8010440b:	8d 42 ff             	lea    -0x1(%edx),%eax
8010440e:	89 04 8d 08 b0 10 80 	mov    %eax,-0x7fef4ff8(,%ecx,4)
80104415:	e9 3b ff ff ff       	jmp    80104355 <MLFQ_scheduler+0x345>
8010441a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104420 <scheduler>:
{
80104420:	55                   	push   %ebp
80104421:	89 e5                	mov    %esp,%ebp
80104423:	53                   	push   %ebx
80104424:	83 ec 04             	sub    $0x4,%esp
  struct cpu *c = mycpu();
80104427:	e8 34 f6 ff ff       	call   80103a60 <mycpu>
  c->proc = 0;
8010442c:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80104433:	00 00 00 
  struct cpu *c = mycpu();
80104436:	89 c3                	mov    %eax,%ebx
  c->proc = 0;
80104438:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010443f:	00 
  asm volatile("sti");
80104440:	fb                   	sti
    if (clj == 0)
80104441:	a1 20 2d 11 80       	mov    0x80112d20,%eax
80104446:	85 c0                	test   %eax,%eax
80104448:	75 17                	jne    80104461 <scheduler+0x41>
      cprintf("SCHEDULER: Default\n");
8010444a:	83 ec 0c             	sub    $0xc,%esp
8010444d:	68 c3 80 10 80       	push   $0x801080c3
80104452:	e8 59 c2 ff ff       	call   801006b0 <cprintf>
      clj++;
80104457:	83 05 20 2d 11 80 01 	addl   $0x1,0x80112d20
8010445e:	83 c4 10             	add    $0x10,%esp
    default_scheduler(c);
80104461:	83 ec 0c             	sub    $0xc,%esp
80104464:	53                   	push   %ebx
80104465:	e8 36 f9 ff ff       	call   80103da0 <default_scheduler>
    sti();
8010446a:	83 c4 10             	add    $0x10,%esp
8010446d:	eb d1                	jmp    80104440 <scheduler+0x20>
8010446f:	90                   	nop

80104470 <sched>:
{
80104470:	55                   	push   %ebp
80104471:	89 e5                	mov    %esp,%ebp
80104473:	56                   	push   %esi
80104474:	53                   	push   %ebx
  pushcli();
80104475:	e8 96 0b 00 00       	call   80105010 <pushcli>
  c = mycpu();
8010447a:	e8 e1 f5 ff ff       	call   80103a60 <mycpu>
  p = c->proc;
8010447f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104485:	e8 d6 0b 00 00       	call   80105060 <popcli>
  if (!holding(&ptable.lock))
8010448a:	83 ec 0c             	sub    $0xc,%esp
8010448d:	68 40 3c 11 80       	push   $0x80113c40
80104492:	e8 29 0c 00 00       	call   801050c0 <holding>
80104497:	83 c4 10             	add    $0x10,%esp
8010449a:	85 c0                	test   %eax,%eax
8010449c:	74 4f                	je     801044ed <sched+0x7d>
  if (mycpu()->ncli != 1)
8010449e:	e8 bd f5 ff ff       	call   80103a60 <mycpu>
801044a3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
801044aa:	75 68                	jne    80104514 <sched+0xa4>
  if (p->state == RUNNING)
801044ac:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
801044b0:	74 55                	je     80104507 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801044b2:	9c                   	pushf
801044b3:	58                   	pop    %eax
  if (readeflags() & FL_IF)
801044b4:	f6 c4 02             	test   $0x2,%ah
801044b7:	75 41                	jne    801044fa <sched+0x8a>
  intena = mycpu()->intena;
801044b9:	e8 a2 f5 ff ff       	call   80103a60 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
801044be:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
801044c1:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
801044c7:	e8 94 f5 ff ff       	call   80103a60 <mycpu>
801044cc:	83 ec 08             	sub    $0x8,%esp
801044cf:	ff 70 04             	push   0x4(%eax)
801044d2:	53                   	push   %ebx
801044d3:	e8 93 0f 00 00       	call   8010546b <swtch>
  mycpu()->intena = intena;
801044d8:	e8 83 f5 ff ff       	call   80103a60 <mycpu>
}
801044dd:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
801044e0:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
801044e6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801044e9:	5b                   	pop    %ebx
801044ea:	5e                   	pop    %esi
801044eb:	5d                   	pop    %ebp
801044ec:	c3                   	ret
    panic("sched ptable.lock");
801044ed:	83 ec 0c             	sub    $0xc,%esp
801044f0:	68 d7 80 10 80       	push   $0x801080d7
801044f5:	e8 86 be ff ff       	call   80100380 <panic>
    panic("sched interruptible");
801044fa:	83 ec 0c             	sub    $0xc,%esp
801044fd:	68 03 81 10 80       	push   $0x80108103
80104502:	e8 79 be ff ff       	call   80100380 <panic>
    panic("sched running");
80104507:	83 ec 0c             	sub    $0xc,%esp
8010450a:	68 f5 80 10 80       	push   $0x801080f5
8010450f:	e8 6c be ff ff       	call   80100380 <panic>
    panic("sched locks");
80104514:	83 ec 0c             	sub    $0xc,%esp
80104517:	68 e9 80 10 80       	push   $0x801080e9
8010451c:	e8 5f be ff ff       	call   80100380 <panic>
80104521:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104528:	00 
80104529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104530 <exit>:
{
80104530:	55                   	push   %ebp
80104531:	89 e5                	mov    %esp,%ebp
80104533:	57                   	push   %edi
80104534:	56                   	push   %esi
80104535:	53                   	push   %ebx
80104536:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
80104539:	e8 a2 f5 ff ff       	call   80103ae0 <myproc>
  if (curproc == initproc)
8010453e:	39 05 74 5f 11 80    	cmp    %eax,0x80115f74
80104544:	0f 84 17 01 00 00    	je     80104661 <exit+0x131>
8010454a:	89 c3                	mov    %eax,%ebx
8010454c:	8d 70 28             	lea    0x28(%eax),%esi
8010454f:	8d 78 68             	lea    0x68(%eax),%edi
80104552:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if (curproc->ofile[fd])
80104558:	8b 06                	mov    (%esi),%eax
8010455a:	85 c0                	test   %eax,%eax
8010455c:	74 12                	je     80104570 <exit+0x40>
      fileclose(curproc->ofile[fd]);
8010455e:	83 ec 0c             	sub    $0xc,%esp
80104561:	50                   	push   %eax
80104562:	e8 b9 c9 ff ff       	call   80100f20 <fileclose>
      curproc->ofile[fd] = 0;
80104567:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010456d:	83 c4 10             	add    $0x10,%esp
  for (fd = 0; fd < NOFILE; fd++)
80104570:	83 c6 04             	add    $0x4,%esi
80104573:	39 f7                	cmp    %esi,%edi
80104575:	75 e1                	jne    80104558 <exit+0x28>
  begin_op();
80104577:	e8 d4 e7 ff ff       	call   80102d50 <begin_op>
  iput(curproc->cwd);
8010457c:	83 ec 0c             	sub    $0xc,%esp
8010457f:	ff 73 68             	push   0x68(%ebx)
80104582:	e8 59 d3 ff ff       	call   801018e0 <iput>
  end_op();
80104587:	e8 34 e8 ff ff       	call   80102dc0 <end_op>
  curproc->etime = ticks;
8010458c:	a1 80 5f 11 80       	mov    0x80115f80,%eax
  curproc->cwd = 0;
80104591:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  curproc->etime = ticks;
80104598:	89 83 84 00 00 00    	mov    %eax,0x84(%ebx)
  acquire(&ptable.lock);
8010459e:	c7 04 24 40 3c 11 80 	movl   $0x80113c40,(%esp)
801045a5:	e8 b6 0b 00 00       	call   80105160 <acquire>
  wakeup1(curproc->parent);
801045aa:	8b 53 14             	mov    0x14(%ebx),%edx
801045ad:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801045b0:	b8 74 3c 11 80       	mov    $0x80113c74,%eax
801045b5:	eb 15                	jmp    801045cc <exit+0x9c>
801045b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801045be:	00 
801045bf:	90                   	nop
801045c0:	05 8c 00 00 00       	add    $0x8c,%eax
801045c5:	3d 74 5f 11 80       	cmp    $0x80115f74,%eax
801045ca:	74 1e                	je     801045ea <exit+0xba>
    if (p->state == SLEEPING && p->chan == chan)
801045cc:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801045d0:	75 ee                	jne    801045c0 <exit+0x90>
801045d2:	3b 50 20             	cmp    0x20(%eax),%edx
801045d5:	75 e9                	jne    801045c0 <exit+0x90>
      p->state = RUNNABLE;
801045d7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801045de:	05 8c 00 00 00       	add    $0x8c,%eax
801045e3:	3d 74 5f 11 80       	cmp    $0x80115f74,%eax
801045e8:	75 e2                	jne    801045cc <exit+0x9c>
      p->parent = initproc;
801045ea:	8b 0d 74 5f 11 80    	mov    0x80115f74,%ecx
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801045f0:	ba 74 3c 11 80       	mov    $0x80113c74,%edx
801045f5:	eb 17                	jmp    8010460e <exit+0xde>
801045f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801045fe:	00 
801045ff:	90                   	nop
80104600:	81 c2 8c 00 00 00    	add    $0x8c,%edx
80104606:	81 fa 74 5f 11 80    	cmp    $0x80115f74,%edx
8010460c:	74 3a                	je     80104648 <exit+0x118>
    if (p->parent == curproc)
8010460e:	39 5a 14             	cmp    %ebx,0x14(%edx)
80104611:	75 ed                	jne    80104600 <exit+0xd0>
      if (p->state == ZOMBIE)
80104613:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80104617:	89 4a 14             	mov    %ecx,0x14(%edx)
      if (p->state == ZOMBIE)
8010461a:	75 e4                	jne    80104600 <exit+0xd0>
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010461c:	b8 74 3c 11 80       	mov    $0x80113c74,%eax
80104621:	eb 11                	jmp    80104634 <exit+0x104>
80104623:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104628:	05 8c 00 00 00       	add    $0x8c,%eax
8010462d:	3d 74 5f 11 80       	cmp    $0x80115f74,%eax
80104632:	74 cc                	je     80104600 <exit+0xd0>
    if (p->state == SLEEPING && p->chan == chan)
80104634:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104638:	75 ee                	jne    80104628 <exit+0xf8>
8010463a:	3b 48 20             	cmp    0x20(%eax),%ecx
8010463d:	75 e9                	jne    80104628 <exit+0xf8>
      p->state = RUNNABLE;
8010463f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104646:	eb e0                	jmp    80104628 <exit+0xf8>
  curproc->state = ZOMBIE;
80104648:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
8010464f:	e8 1c fe ff ff       	call   80104470 <sched>
  panic("zombie exit");
80104654:	83 ec 0c             	sub    $0xc,%esp
80104657:	68 24 81 10 80       	push   $0x80108124
8010465c:	e8 1f bd ff ff       	call   80100380 <panic>
    panic("init exiting");
80104661:	83 ec 0c             	sub    $0xc,%esp
80104664:	68 17 81 10 80       	push   $0x80108117
80104669:	e8 12 bd ff ff       	call   80100380 <panic>
8010466e:	66 90                	xchg   %ax,%ax

80104670 <wait>:
{
80104670:	55                   	push   %ebp
80104671:	89 e5                	mov    %esp,%ebp
80104673:	56                   	push   %esi
80104674:	53                   	push   %ebx
  pushcli();
80104675:	e8 96 09 00 00       	call   80105010 <pushcli>
  c = mycpu();
8010467a:	e8 e1 f3 ff ff       	call   80103a60 <mycpu>
  p = c->proc;
8010467f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104685:	e8 d6 09 00 00       	call   80105060 <popcli>
  acquire(&ptable.lock);
8010468a:	83 ec 0c             	sub    $0xc,%esp
8010468d:	68 40 3c 11 80       	push   $0x80113c40
80104692:	e8 c9 0a 00 00       	call   80105160 <acquire>
80104697:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010469a:	31 c0                	xor    %eax,%eax
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010469c:	bb 74 3c 11 80       	mov    $0x80113c74,%ebx
801046a1:	eb 13                	jmp    801046b6 <wait+0x46>
801046a3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801046a8:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
801046ae:	81 fb 74 5f 11 80    	cmp    $0x80115f74,%ebx
801046b4:	74 1e                	je     801046d4 <wait+0x64>
      if (p->parent != curproc)
801046b6:	39 73 14             	cmp    %esi,0x14(%ebx)
801046b9:	75 ed                	jne    801046a8 <wait+0x38>
      if (p->state == ZOMBIE)
801046bb:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
801046bf:	74 5f                	je     80104720 <wait+0xb0>
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801046c1:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
      havekids = 1;
801046c7:	b8 01 00 00 00       	mov    $0x1,%eax
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801046cc:	81 fb 74 5f 11 80    	cmp    $0x80115f74,%ebx
801046d2:	75 e2                	jne    801046b6 <wait+0x46>
    if (!havekids || curproc->killed)
801046d4:	85 c0                	test   %eax,%eax
801046d6:	0f 84 b8 00 00 00    	je     80104794 <wait+0x124>
801046dc:	8b 46 24             	mov    0x24(%esi),%eax
801046df:	85 c0                	test   %eax,%eax
801046e1:	0f 85 ad 00 00 00    	jne    80104794 <wait+0x124>
  pushcli();
801046e7:	e8 24 09 00 00       	call   80105010 <pushcli>
  c = mycpu();
801046ec:	e8 6f f3 ff ff       	call   80103a60 <mycpu>
  p = c->proc;
801046f1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801046f7:	e8 64 09 00 00       	call   80105060 <popcli>
  if (p == 0)
801046fc:	85 db                	test   %ebx,%ebx
801046fe:	0f 84 a7 00 00 00    	je     801047ab <wait+0x13b>
  p->chan = chan;
80104704:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
80104707:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
8010470e:	e8 5d fd ff ff       	call   80104470 <sched>
  p->chan = 0;
80104713:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
8010471a:	e9 7b ff ff ff       	jmp    8010469a <wait+0x2a>
8010471f:	90                   	nop
        kfree(p->kstack);
80104720:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
80104723:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104726:	ff 73 08             	push   0x8(%ebx)
80104729:	e8 82 dd ff ff       	call   801024b0 <kfree>
        p->kstack = 0;
8010472e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104735:	5a                   	pop    %edx
80104736:	ff 73 04             	push   0x4(%ebx)
80104739:	e8 02 33 00 00       	call   80107a40 <freevm>
        p->pid = 0;
8010473e:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104745:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
8010474c:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104750:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104757:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        p->etime = 0; //*
8010475e:	c7 83 84 00 00 00 00 	movl   $0x0,0x84(%ebx)
80104765:	00 00 00 
        p->ctime = 0; //*
80104768:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
8010476f:	00 00 00 
        p->rtime = 0; //*
80104772:	c7 83 88 00 00 00 00 	movl   $0x0,0x88(%ebx)
80104779:	00 00 00 
        release(&ptable.lock);
8010477c:	c7 04 24 40 3c 11 80 	movl   $0x80113c40,(%esp)
80104783:	e8 78 09 00 00       	call   80105100 <release>
        return pid;
80104788:	83 c4 10             	add    $0x10,%esp
}
8010478b:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010478e:	89 f0                	mov    %esi,%eax
80104790:	5b                   	pop    %ebx
80104791:	5e                   	pop    %esi
80104792:	5d                   	pop    %ebp
80104793:	c3                   	ret
      release(&ptable.lock);
80104794:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104797:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
8010479c:	68 40 3c 11 80       	push   $0x80113c40
801047a1:	e8 5a 09 00 00       	call   80105100 <release>
      return -1;
801047a6:	83 c4 10             	add    $0x10,%esp
801047a9:	eb e0                	jmp    8010478b <wait+0x11b>
    panic("sleep");
801047ab:	83 ec 0c             	sub    $0xc,%esp
801047ae:	68 30 81 10 80       	push   $0x80108130
801047b3:	e8 c8 bb ff ff       	call   80100380 <panic>
801047b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801047bf:	00 

801047c0 <waitx>:
{
801047c0:	55                   	push   %ebp
801047c1:	89 e5                	mov    %esp,%ebp
801047c3:	56                   	push   %esi
801047c4:	53                   	push   %ebx
  pushcli();
801047c5:	e8 46 08 00 00       	call   80105010 <pushcli>
  c = mycpu();
801047ca:	e8 91 f2 ff ff       	call   80103a60 <mycpu>
  p = c->proc;
801047cf:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801047d5:	e8 86 08 00 00       	call   80105060 <popcli>
  acquire(&ptable.lock);
801047da:	83 ec 0c             	sub    $0xc,%esp
801047dd:	68 40 3c 11 80       	push   $0x80113c40
801047e2:	e8 79 09 00 00       	call   80105160 <acquire>
801047e7:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
801047ea:	31 c0                	xor    %eax,%eax
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801047ec:	bb 74 3c 11 80       	mov    $0x80113c74,%ebx
801047f1:	eb 13                	jmp    80104806 <waitx+0x46>
801047f3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801047f8:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
801047fe:	81 fb 74 5f 11 80    	cmp    $0x80115f74,%ebx
80104804:	74 1e                	je     80104824 <waitx+0x64>
      if (p->parent != curproc)
80104806:	39 73 14             	cmp    %esi,0x14(%ebx)
80104809:	75 ed                	jne    801047f8 <waitx+0x38>
      if (p->state == ZOMBIE)
8010480b:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010480f:	74 5f                	je     80104870 <waitx+0xb0>
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104811:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
      havekids = 1;
80104817:	b8 01 00 00 00       	mov    $0x1,%eax
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010481c:	81 fb 74 5f 11 80    	cmp    $0x80115f74,%ebx
80104822:	75 e2                	jne    80104806 <waitx+0x46>
    if (!havekids || curproc->killed)
80104824:	85 c0                	test   %eax,%eax
80104826:	0f 84 da 00 00 00    	je     80104906 <waitx+0x146>
8010482c:	8b 46 24             	mov    0x24(%esi),%eax
8010482f:	85 c0                	test   %eax,%eax
80104831:	0f 85 cf 00 00 00    	jne    80104906 <waitx+0x146>
  pushcli();
80104837:	e8 d4 07 00 00       	call   80105010 <pushcli>
  c = mycpu();
8010483c:	e8 1f f2 ff ff       	call   80103a60 <mycpu>
  p = c->proc;
80104841:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104847:	e8 14 08 00 00       	call   80105060 <popcli>
  if (p == 0)
8010484c:	85 db                	test   %ebx,%ebx
8010484e:	0f 84 c9 00 00 00    	je     8010491d <waitx+0x15d>
  p->chan = chan;
80104854:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
80104857:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
8010485e:	e8 0d fc ff ff       	call   80104470 <sched>
  p->chan = 0;
80104863:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
8010486a:	e9 7b ff ff ff       	jmp    801047ea <waitx+0x2a>
8010486f:	90                   	nop
        kfree(p->kstack);
80104870:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
80104873:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104876:	ff 73 08             	push   0x8(%ebx)
80104879:	e8 32 dc ff ff       	call   801024b0 <kfree>
        p->kstack = 0;
8010487e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104885:	5a                   	pop    %edx
80104886:	ff 73 04             	push   0x4(%ebx)
80104889:	e8 b2 31 00 00       	call   80107a40 <freevm>
        *wtime = p->etime - p->ctime - p->rtime;
8010488e:	8b 55 08             	mov    0x8(%ebp),%edx
        p->name[0] = 0;
80104891:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        *wtime = p->etime - p->ctime - p->rtime;
80104895:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
8010489b:	2b 83 80 00 00 00    	sub    0x80(%ebx),%eax
        p->pid = 0;
801048a1:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        *wtime = p->etime - p->ctime - p->rtime;
801048a8:	2b 83 88 00 00 00    	sub    0x88(%ebx),%eax
        p->parent = 0;
801048ae:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->killed = 0;
801048b5:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
801048bc:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        *wtime = p->etime - p->ctime - p->rtime;
801048c3:	89 02                	mov    %eax,(%edx)
        *rtime = p->rtime;
801048c5:	8b 45 0c             	mov    0xc(%ebp),%eax
801048c8:	8b 93 88 00 00 00    	mov    0x88(%ebx),%edx
801048ce:	89 10                	mov    %edx,(%eax)
        p->etime = 0; //*
801048d0:	c7 83 84 00 00 00 00 	movl   $0x0,0x84(%ebx)
801048d7:	00 00 00 
        p->ctime = 0; //*
801048da:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
801048e1:	00 00 00 
        p->rtime = 0; //*
801048e4:	c7 83 88 00 00 00 00 	movl   $0x0,0x88(%ebx)
801048eb:	00 00 00 
        release(&ptable.lock);
801048ee:	c7 04 24 40 3c 11 80 	movl   $0x80113c40,(%esp)
801048f5:	e8 06 08 00 00       	call   80105100 <release>
        return pid;
801048fa:	83 c4 10             	add    $0x10,%esp
}
801048fd:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104900:	89 f0                	mov    %esi,%eax
80104902:	5b                   	pop    %ebx
80104903:	5e                   	pop    %esi
80104904:	5d                   	pop    %ebp
80104905:	c3                   	ret
      release(&ptable.lock);
80104906:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104909:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
8010490e:	68 40 3c 11 80       	push   $0x80113c40
80104913:	e8 e8 07 00 00       	call   80105100 <release>
      return -1;
80104918:	83 c4 10             	add    $0x10,%esp
8010491b:	eb e0                	jmp    801048fd <waitx+0x13d>
    panic("sleep");
8010491d:	83 ec 0c             	sub    $0xc,%esp
80104920:	68 30 81 10 80       	push   $0x80108130
80104925:	e8 56 ba ff ff       	call   80100380 <panic>
8010492a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104930 <yield>:
{
80104930:	55                   	push   %ebp
80104931:	89 e5                	mov    %esp,%ebp
80104933:	53                   	push   %ebx
80104934:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock); //DOC: yieldlock
80104937:	68 40 3c 11 80       	push   $0x80113c40
8010493c:	e8 1f 08 00 00       	call   80105160 <acquire>
  pushcli();
80104941:	e8 ca 06 00 00       	call   80105010 <pushcli>
  c = mycpu();
80104946:	e8 15 f1 ff ff       	call   80103a60 <mycpu>
  p = c->proc;
8010494b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104951:	e8 0a 07 00 00       	call   80105060 <popcli>
  myproc()->state = RUNNABLE;
80104956:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
8010495d:	e8 0e fb ff ff       	call   80104470 <sched>
  release(&ptable.lock);
80104962:	c7 04 24 40 3c 11 80 	movl   $0x80113c40,(%esp)
80104969:	e8 92 07 00 00       	call   80105100 <release>
}
8010496e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104971:	83 c4 10             	add    $0x10,%esp
80104974:	c9                   	leave
80104975:	c3                   	ret
80104976:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010497d:	00 
8010497e:	66 90                	xchg   %ax,%ax

80104980 <sleep>:
{
80104980:	55                   	push   %ebp
80104981:	89 e5                	mov    %esp,%ebp
80104983:	57                   	push   %edi
80104984:	56                   	push   %esi
80104985:	53                   	push   %ebx
80104986:	83 ec 0c             	sub    $0xc,%esp
80104989:	8b 7d 08             	mov    0x8(%ebp),%edi
8010498c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
8010498f:	e8 7c 06 00 00       	call   80105010 <pushcli>
  c = mycpu();
80104994:	e8 c7 f0 ff ff       	call   80103a60 <mycpu>
  p = c->proc;
80104999:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010499f:	e8 bc 06 00 00       	call   80105060 <popcli>
  if (p == 0)
801049a4:	85 db                	test   %ebx,%ebx
801049a6:	0f 84 87 00 00 00    	je     80104a33 <sleep+0xb3>
  if (lk == 0)
801049ac:	85 f6                	test   %esi,%esi
801049ae:	74 76                	je     80104a26 <sleep+0xa6>
  if (lk != &ptable.lock)
801049b0:	81 fe 40 3c 11 80    	cmp    $0x80113c40,%esi
801049b6:	74 50                	je     80104a08 <sleep+0x88>
    acquire(&ptable.lock); //DOC: sleeplock1
801049b8:	83 ec 0c             	sub    $0xc,%esp
801049bb:	68 40 3c 11 80       	push   $0x80113c40
801049c0:	e8 9b 07 00 00       	call   80105160 <acquire>
    release(lk);
801049c5:	89 34 24             	mov    %esi,(%esp)
801049c8:	e8 33 07 00 00       	call   80105100 <release>
  p->chan = chan;
801049cd:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801049d0:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801049d7:	e8 94 fa ff ff       	call   80104470 <sched>
  p->chan = 0;
801049dc:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
801049e3:	c7 04 24 40 3c 11 80 	movl   $0x80113c40,(%esp)
801049ea:	e8 11 07 00 00       	call   80105100 <release>
    acquire(lk);
801049ef:	83 c4 10             	add    $0x10,%esp
801049f2:	89 75 08             	mov    %esi,0x8(%ebp)
}
801049f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801049f8:	5b                   	pop    %ebx
801049f9:	5e                   	pop    %esi
801049fa:	5f                   	pop    %edi
801049fb:	5d                   	pop    %ebp
    acquire(lk);
801049fc:	e9 5f 07 00 00       	jmp    80105160 <acquire>
80104a01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80104a08:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104a0b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104a12:	e8 59 fa ff ff       	call   80104470 <sched>
  p->chan = 0;
80104a17:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80104a1e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104a21:	5b                   	pop    %ebx
80104a22:	5e                   	pop    %esi
80104a23:	5f                   	pop    %edi
80104a24:	5d                   	pop    %ebp
80104a25:	c3                   	ret
    panic("sleep without lk");
80104a26:	83 ec 0c             	sub    $0xc,%esp
80104a29:	68 36 81 10 80       	push   $0x80108136
80104a2e:	e8 4d b9 ff ff       	call   80100380 <panic>
    panic("sleep");
80104a33:	83 ec 0c             	sub    $0xc,%esp
80104a36:	68 30 81 10 80       	push   $0x80108130
80104a3b:	e8 40 b9 ff ff       	call   80100380 <panic>

80104a40 <wakeup>:
}

// Wake up all processes sleeping on chan.
void wakeup(void *chan)
{
80104a40:	55                   	push   %ebp
80104a41:	89 e5                	mov    %esp,%ebp
80104a43:	53                   	push   %ebx
80104a44:	83 ec 10             	sub    $0x10,%esp
80104a47:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80104a4a:	68 40 3c 11 80       	push   $0x80113c40
80104a4f:	e8 0c 07 00 00       	call   80105160 <acquire>
80104a54:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104a57:	b8 74 3c 11 80       	mov    $0x80113c74,%eax
80104a5c:	eb 0e                	jmp    80104a6c <wakeup+0x2c>
80104a5e:	66 90                	xchg   %ax,%ax
80104a60:	05 8c 00 00 00       	add    $0x8c,%eax
80104a65:	3d 74 5f 11 80       	cmp    $0x80115f74,%eax
80104a6a:	74 1e                	je     80104a8a <wakeup+0x4a>
    if (p->state == SLEEPING && p->chan == chan)
80104a6c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104a70:	75 ee                	jne    80104a60 <wakeup+0x20>
80104a72:	3b 58 20             	cmp    0x20(%eax),%ebx
80104a75:	75 e9                	jne    80104a60 <wakeup+0x20>
      p->state = RUNNABLE;
80104a77:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104a7e:	05 8c 00 00 00       	add    $0x8c,%eax
80104a83:	3d 74 5f 11 80       	cmp    $0x80115f74,%eax
80104a88:	75 e2                	jne    80104a6c <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
80104a8a:	c7 45 08 40 3c 11 80 	movl   $0x80113c40,0x8(%ebp)
}
80104a91:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a94:	c9                   	leave
  release(&ptable.lock);
80104a95:	e9 66 06 00 00       	jmp    80105100 <release>
80104a9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104aa0 <kill>:

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int kill(int pid)
{
80104aa0:	55                   	push   %ebp
80104aa1:	89 e5                	mov    %esp,%ebp
80104aa3:	53                   	push   %ebx
80104aa4:	83 ec 10             	sub    $0x10,%esp
80104aa7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80104aaa:	68 40 3c 11 80       	push   $0x80113c40
80104aaf:	e8 ac 06 00 00       	call   80105160 <acquire>
80104ab4:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104ab7:	b8 74 3c 11 80       	mov    $0x80113c74,%eax
80104abc:	eb 0e                	jmp    80104acc <kill+0x2c>
80104abe:	66 90                	xchg   %ax,%ax
80104ac0:	05 8c 00 00 00       	add    $0x8c,%eax
80104ac5:	3d 74 5f 11 80       	cmp    $0x80115f74,%eax
80104aca:	74 34                	je     80104b00 <kill+0x60>
  {
    if (p->pid == pid)
80104acc:	39 58 10             	cmp    %ebx,0x10(%eax)
80104acf:	75 ef                	jne    80104ac0 <kill+0x20>
    {
      p->killed = 1;
      // Wake process from sleep if necessary.
      if (p->state == SLEEPING)
80104ad1:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104ad5:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if (p->state == SLEEPING)
80104adc:	75 07                	jne    80104ae5 <kill+0x45>
        p->state = RUNNABLE;
80104ade:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104ae5:	83 ec 0c             	sub    $0xc,%esp
80104ae8:	68 40 3c 11 80       	push   $0x80113c40
80104aed:	e8 0e 06 00 00       	call   80105100 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80104af2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
80104af5:	83 c4 10             	add    $0x10,%esp
80104af8:	31 c0                	xor    %eax,%eax
}
80104afa:	c9                   	leave
80104afb:	c3                   	ret
80104afc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104b00:	83 ec 0c             	sub    $0xc,%esp
80104b03:	68 40 3c 11 80       	push   $0x80113c40
80104b08:	e8 f3 05 00 00       	call   80105100 <release>
}
80104b0d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80104b10:	83 c4 10             	add    $0x10,%esp
80104b13:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104b18:	c9                   	leave
80104b19:	c3                   	ret
80104b1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104b20 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.

void procdump(void)
{
80104b20:	55                   	push   %ebp
80104b21:	89 e5                	mov    %esp,%ebp
80104b23:	57                   	push   %edi
80104b24:	56                   	push   %esi
80104b25:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104b28:	53                   	push   %ebx
80104b29:	bb e0 3c 11 80       	mov    $0x80113ce0,%ebx
80104b2e:	83 ec 3c             	sub    $0x3c,%esp
80104b31:	eb 27                	jmp    80104b5a <procdump+0x3a>
80104b33:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    {
      getcallerpcs((uint *)p->context->ebp + 2, pc);
      for (i = 0; i < 10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104b38:	83 ec 0c             	sub    $0xc,%esp
80104b3b:	68 f5 82 10 80       	push   $0x801082f5
80104b40:	e8 6b bb ff ff       	call   801006b0 <cprintf>
80104b45:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104b48:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
80104b4e:	81 fb e0 5f 11 80    	cmp    $0x80115fe0,%ebx
80104b54:	0f 84 7e 00 00 00    	je     80104bd8 <procdump+0xb8>
    if (p->state == UNUSED)
80104b5a:	8b 43 a0             	mov    -0x60(%ebx),%eax
80104b5d:	85 c0                	test   %eax,%eax
80104b5f:	74 e7                	je     80104b48 <procdump+0x28>
      state = "???";
80104b61:	ba 47 81 10 80       	mov    $0x80108147,%edx
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104b66:	83 f8 05             	cmp    $0x5,%eax
80104b69:	77 11                	ja     80104b7c <procdump+0x5c>
80104b6b:	8b 14 85 40 88 10 80 	mov    -0x7fef77c0(,%eax,4),%edx
      state = "???";
80104b72:	b8 47 81 10 80       	mov    $0x80108147,%eax
80104b77:	85 d2                	test   %edx,%edx
80104b79:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104b7c:	53                   	push   %ebx
80104b7d:	52                   	push   %edx
80104b7e:	ff 73 a4             	push   -0x5c(%ebx)
80104b81:	68 4b 81 10 80       	push   $0x8010814b
80104b86:	e8 25 bb ff ff       	call   801006b0 <cprintf>
    if (p->state == SLEEPING)
80104b8b:	83 c4 10             	add    $0x10,%esp
80104b8e:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80104b92:	75 a4                	jne    80104b38 <procdump+0x18>
      getcallerpcs((uint *)p->context->ebp + 2, pc);
80104b94:	83 ec 08             	sub    $0x8,%esp
80104b97:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104b9a:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104b9d:	50                   	push   %eax
80104b9e:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104ba1:	8b 40 0c             	mov    0xc(%eax),%eax
80104ba4:	83 c0 08             	add    $0x8,%eax
80104ba7:	50                   	push   %eax
80104ba8:	e8 e3 03 00 00       	call   80104f90 <getcallerpcs>
      for (i = 0; i < 10 && pc[i] != 0; i++)
80104bad:	83 c4 10             	add    $0x10,%esp
80104bb0:	8b 17                	mov    (%edi),%edx
80104bb2:	85 d2                	test   %edx,%edx
80104bb4:	74 82                	je     80104b38 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104bb6:	83 ec 08             	sub    $0x8,%esp
      for (i = 0; i < 10 && pc[i] != 0; i++)
80104bb9:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
80104bbc:	52                   	push   %edx
80104bbd:	68 41 7e 10 80       	push   $0x80107e41
80104bc2:	e8 e9 ba ff ff       	call   801006b0 <cprintf>
      for (i = 0; i < 10 && pc[i] != 0; i++)
80104bc7:	83 c4 10             	add    $0x10,%esp
80104bca:	39 f7                	cmp    %esi,%edi
80104bcc:	75 e2                	jne    80104bb0 <procdump+0x90>
80104bce:	e9 65 ff ff ff       	jmp    80104b38 <procdump+0x18>
80104bd3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  }
}
80104bd8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104bdb:	5b                   	pop    %ebx
80104bdc:	5e                   	pop    %esi
80104bdd:	5f                   	pop    %edi
80104bde:	5d                   	pop    %ebp
80104bdf:	c3                   	ret

80104be0 <chprty>:

//Change priority of a process **syscall
int chprty(int pid, int priority)
{
80104be0:	55                   	push   %ebp
80104be1:	89 e5                	mov    %esp,%ebp
80104be3:	53                   	push   %ebx
80104be4:	83 ec 10             	sub    $0x10,%esp
80104be7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;
  acquire(&ptable.lock);
80104bea:	68 40 3c 11 80       	push   $0x80113c40
80104bef:	e8 6c 05 00 00       	call   80105160 <acquire>
80104bf4:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104bf7:	b8 74 3c 11 80       	mov    $0x80113c74,%eax
80104bfc:	eb 0e                	jmp    80104c0c <chprty+0x2c>
80104bfe:	66 90                	xchg   %ax,%ax
80104c00:	05 8c 00 00 00       	add    $0x8c,%eax
80104c05:	3d 74 5f 11 80       	cmp    $0x80115f74,%eax
80104c0a:	74 0b                	je     80104c17 <chprty+0x37>
  {
    if (p->pid == pid)
80104c0c:	39 58 10             	cmp    %ebx,0x10(%eax)
80104c0f:	75 ef                	jne    80104c00 <chprty+0x20>
    {
      p->priority = priority;
80104c11:	8b 55 0c             	mov    0xc(%ebp),%edx
80104c14:	89 50 7c             	mov    %edx,0x7c(%eax)
      break;
    }
  }
  release(&ptable.lock);
80104c17:	83 ec 0c             	sub    $0xc,%esp
80104c1a:	68 40 3c 11 80       	push   $0x80113c40
80104c1f:	e8 dc 04 00 00       	call   80105100 <release>

  return pid;
}
80104c24:	89 d8                	mov    %ebx,%eax
80104c26:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c29:	c9                   	leave
80104c2a:	c3                   	ret
80104c2b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104c30 <cps>:

//Current process status **syscall
int cps()
{
80104c30:	55                   	push   %ebp
80104c31:	89 e5                	mov    %esp,%ebp
80104c33:	53                   	push   %ebx
80104c34:	83 ec 10             	sub    $0x10,%esp
  asm volatile("sti");
80104c37:	fb                   	sti

  // Enable interrupts on this processor.
  sti();

  // Loop over process table looking for process with pid.
  acquire(&ptable.lock);
80104c38:	68 40 3c 11 80       	push   $0x80113c40
80104c3d:	bb e0 3c 11 80       	mov    $0x80113ce0,%ebx
80104c42:	e8 19 05 00 00       	call   80105160 <acquire>
  cprintf("name \t pid \t state \t\t priority \t ctime \n");
80104c47:	c7 04 24 d0 84 10 80 	movl   $0x801084d0,(%esp)
80104c4e:	e8 5d ba ff ff       	call   801006b0 <cprintf>
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104c53:	83 c4 10             	add    $0x10,%esp
80104c56:	eb 24                	jmp    80104c7c <cps+0x4c>
80104c58:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104c5f:	00 
  {
    if (p->state == SLEEPING)
      cprintf("%s \t %d  \t SLEEPING \t %d \t\t %d\n ", p->name, p->pid, p->priority, p->ctime);
    else if (p->state == RUNNING)
80104c60:	83 f8 04             	cmp    $0x4,%eax
80104c63:	74 6b                	je     80104cd0 <cps+0xa0>
      cprintf("%s \t %d  \t RUNNING \t %d \t\t %d\n ", p->name, p->pid, p->priority, p->ctime);
    else if (p->state == RUNNABLE)
80104c65:	83 f8 03             	cmp    $0x3,%eax
80104c68:	0f 84 92 00 00 00    	je     80104d00 <cps+0xd0>
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104c6e:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
80104c74:	81 fb e0 5f 11 80    	cmp    $0x80115fe0,%ebx
80104c7a:	74 3b                	je     80104cb7 <cps+0x87>
    if (p->state == SLEEPING)
80104c7c:	8b 43 a0             	mov    -0x60(%ebx),%eax
80104c7f:	83 f8 02             	cmp    $0x2,%eax
80104c82:	75 dc                	jne    80104c60 <cps+0x30>
      cprintf("%s \t %d  \t SLEEPING \t %d \t\t %d\n ", p->name, p->pid, p->priority, p->ctime);
80104c84:	8b 53 a8             	mov    -0x58(%ebx),%edx
80104c87:	8b 4b 14             	mov    0x14(%ebx),%ecx
80104c8a:	31 c0                	xor    %eax,%eax
80104c8c:	85 d2                	test   %edx,%edx
80104c8e:	74 03                	je     80104c93 <cps+0x63>
80104c90:	8b 42 10             	mov    0x10(%edx),%eax
80104c93:	83 ec 0c             	sub    $0xc,%esp
80104c96:	51                   	push   %ecx
80104c97:	50                   	push   %eax
80104c98:	ff 73 a4             	push   -0x5c(%ebx)
80104c9b:	53                   	push   %ebx
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104c9c:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
      cprintf("%s \t %d  \t SLEEPING \t %d \t\t %d\n ", p->name, p->pid, p->priority, p->ctime);
80104ca2:	68 f8 84 10 80       	push   $0x801084f8
80104ca7:	e8 04 ba ff ff       	call   801006b0 <cprintf>
80104cac:	83 c4 20             	add    $0x20,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104caf:	81 fb e0 5f 11 80    	cmp    $0x80115fe0,%ebx
80104cb5:	75 c5                	jne    80104c7c <cps+0x4c>
      cprintf("%s \t %d  \t RUNNABLE \t %d \t\t %d\n ", p->name, p->pid, p->priority, p->ctime);
  }

  release(&ptable.lock);
80104cb7:	83 ec 0c             	sub    $0xc,%esp
80104cba:	68 40 3c 11 80       	push   $0x80113c40
80104cbf:	e8 3c 04 00 00       	call   80105100 <release>

  return 23;
}
80104cc4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104cc7:	b8 17 00 00 00       	mov    $0x17,%eax
80104ccc:	c9                   	leave
80104ccd:	c3                   	ret
80104cce:	66 90                	xchg   %ax,%ax
      cprintf("%s \t %d  \t RUNNING \t %d \t\t %d\n ", p->name, p->pid, p->priority, p->ctime);
80104cd0:	8b 53 a8             	mov    -0x58(%ebx),%edx
80104cd3:	8b 4b 14             	mov    0x14(%ebx),%ecx
80104cd6:	31 c0                	xor    %eax,%eax
80104cd8:	85 d2                	test   %edx,%edx
80104cda:	74 03                	je     80104cdf <cps+0xaf>
80104cdc:	8b 42 10             	mov    0x10(%edx),%eax
80104cdf:	83 ec 0c             	sub    $0xc,%esp
80104ce2:	51                   	push   %ecx
80104ce3:	50                   	push   %eax
80104ce4:	ff 73 a4             	push   -0x5c(%ebx)
80104ce7:	53                   	push   %ebx
80104ce8:	68 18 85 10 80       	push   $0x80108518
80104ced:	e8 be b9 ff ff       	call   801006b0 <cprintf>
80104cf2:	83 c4 20             	add    $0x20,%esp
80104cf5:	e9 74 ff ff ff       	jmp    80104c6e <cps+0x3e>
80104cfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("%s \t %d  \t RUNNABLE \t %d \t\t %d\n ", p->name, p->pid, p->priority, p->ctime);
80104d00:	8b 53 a8             	mov    -0x58(%ebx),%edx
80104d03:	8b 4b 14             	mov    0x14(%ebx),%ecx
80104d06:	31 c0                	xor    %eax,%eax
80104d08:	85 d2                	test   %edx,%edx
80104d0a:	74 03                	je     80104d0f <cps+0xdf>
80104d0c:	8b 42 10             	mov    0x10(%edx),%eax
80104d0f:	83 ec 0c             	sub    $0xc,%esp
80104d12:	51                   	push   %ecx
80104d13:	50                   	push   %eax
80104d14:	ff 73 a4             	push   -0x5c(%ebx)
80104d17:	53                   	push   %ebx
80104d18:	68 38 85 10 80       	push   $0x80108538
80104d1d:	e8 8e b9 ff ff       	call   801006b0 <cprintf>
80104d22:	83 c4 20             	add    $0x20,%esp
80104d25:	e9 44 ff ff ff       	jmp    80104c6e <cps+0x3e>
80104d2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104d30 <updatestatistics>:

/*
  This method will run every clock tick and update the statistic fields for each proc
*/
void updatestatistics()
{
80104d30:	55                   	push   %ebp
80104d31:	89 e5                	mov    %esp,%ebp
80104d33:	83 ec 14             	sub    $0x14,%esp
  struct proc *p;
  acquire(&ptable.lock);
80104d36:	68 40 3c 11 80       	push   $0x80113c40
80104d3b:	e8 20 04 00 00       	call   80105160 <acquire>
80104d40:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104d43:	b8 74 3c 11 80       	mov    $0x80113c74,%eax
80104d48:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104d4f:	00 
  {
    if (p->state == RUNNING)
80104d50:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80104d54:	75 07                	jne    80104d5d <updatestatistics+0x2d>
      p->rtime++;
80104d56:	83 80 88 00 00 00 01 	addl   $0x1,0x88(%eax)
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104d5d:	05 8c 00 00 00       	add    $0x8c,%eax
80104d62:	3d 74 5f 11 80       	cmp    $0x80115f74,%eax
80104d67:	75 e7                	jne    80104d50 <updatestatistics+0x20>
  }
  release(&ptable.lock);
80104d69:	83 ec 0c             	sub    $0xc,%esp
80104d6c:	68 40 3c 11 80       	push   $0x80113c40
80104d71:	e8 8a 03 00 00       	call   80105100 <release>
}
80104d76:	83 c4 10             	add    $0x10,%esp
80104d79:	c9                   	leave
80104d7a:	c3                   	ret
80104d7b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104d80 <getpinfo>:

//Print process status **syscall**
int getpinfo(struct proc_stat *pstat)
{
80104d80:	55                   	push   %ebp
80104d81:	89 e5                	mov    %esp,%ebp
80104d83:	57                   	push   %edi
80104d84:	56                   	push   %esi
  int i, j;
  if (argptr(0, (void *)&pstat, sizeof(*pstat)) < 0)
80104d85:	8d 45 08             	lea    0x8(%ebp),%eax
{
80104d88:	53                   	push   %ebx
80104d89:	83 ec 10             	sub    $0x10,%esp
  if (argptr(0, (void *)&pstat, sizeof(*pstat)) < 0)
80104d8c:	68 00 0a 00 00       	push   $0xa00
80104d91:	50                   	push   %eax
80104d92:	6a 00                	push   $0x0
80104d94:	e8 c7 07 00 00       	call   80105560 <argptr>
80104d99:	83 c4 10             	add    $0x10,%esp
80104d9c:	85 c0                	test   %eax,%eax
80104d9e:	0f 88 95 00 00 00    	js     80104e39 <getpinfo+0xb9>
    return -1;

  for (i = 0; i < 64; i++)
  {
    pstat->inuse[i] = pstat_var.inuse[i];
80104da4:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104da7:	ba 40 32 11 80       	mov    $0x80113240,%edx
  for (i = 0; i < 64; i++)
80104dac:	31 c0                	xor    %eax,%eax
80104dae:	66 90                	xchg   %ax,%ax
    pstat->inuse[i] = pstat_var.inuse[i];
80104db0:	8b 0c 85 40 2d 11 80 	mov    -0x7feed2c0(,%eax,4),%ecx
  for (i = 0; i < 64; i++)
80104db7:	83 c2 14             	add    $0x14,%edx
    pstat->inuse[i] = pstat_var.inuse[i];
80104dba:	89 0c 83             	mov    %ecx,(%ebx,%eax,4)
    pstat->pid[i] = pstat_var.pid[i];
80104dbd:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104dc0:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
80104dc7:	8b 3c 85 40 2e 11 80 	mov    -0x7feed1c0(,%eax,4),%edi
80104dce:	8d 34 0b             	lea    (%ebx,%ecx,1),%esi
    pstat->num_run[i] = pstat_var.num_run[i];
    pstat->current_queue[i] = pstat_var.current_queue[i];
    pstat->runtime[i] = pstat_var.runtime[i];
    for (j = 0; j < 4; j++)
    {
      pstat->ticks[i][j] = pstat_var.ticks[i][j];
80104dd1:	01 c1                	add    %eax,%ecx
    pstat->pid[i] = pstat_var.pid[i];
80104dd3:	89 be 00 01 00 00    	mov    %edi,0x100(%esi)
    pstat->num_run[i] = pstat_var.num_run[i];
80104dd9:	8b 3c 85 40 30 11 80 	mov    -0x7feecfc0(,%eax,4),%edi
      pstat->ticks[i][j] = pstat_var.ticks[i][j];
80104de0:	8d 0c 8b             	lea    (%ebx,%ecx,4),%ecx
    pstat->num_run[i] = pstat_var.num_run[i];
80104de3:	89 be 00 03 00 00    	mov    %edi,0x300(%esi)
    pstat->current_queue[i] = pstat_var.current_queue[i];
80104de9:	8b 3c 85 40 31 11 80 	mov    -0x7feecec0(,%eax,4),%edi
80104df0:	89 be 00 04 00 00    	mov    %edi,0x400(%esi)
    pstat->runtime[i] = pstat_var.runtime[i];
80104df6:	8b 3c 85 40 2f 11 80 	mov    -0x7feed0c0(,%eax,4),%edi
  for (i = 0; i < 64; i++)
80104dfd:	83 c0 01             	add    $0x1,%eax
    pstat->runtime[i] = pstat_var.runtime[i];
80104e00:	89 be 00 02 00 00    	mov    %edi,0x200(%esi)
      pstat->ticks[i][j] = pstat_var.ticks[i][j];
80104e06:	8b 7a ec             	mov    -0x14(%edx),%edi
80104e09:	89 b9 00 05 00 00    	mov    %edi,0x500(%ecx)
80104e0f:	8b 72 f0             	mov    -0x10(%edx),%esi
80104e12:	89 b1 04 05 00 00    	mov    %esi,0x504(%ecx)
80104e18:	8b 72 f4             	mov    -0xc(%edx),%esi
80104e1b:	89 b1 08 05 00 00    	mov    %esi,0x508(%ecx)
80104e21:	8b 72 f8             	mov    -0x8(%edx),%esi
80104e24:	89 b1 0c 05 00 00    	mov    %esi,0x50c(%ecx)
  for (i = 0; i < 64; i++)
80104e2a:	83 f8 40             	cmp    $0x40,%eax
80104e2d:	75 81                	jne    80104db0 <getpinfo+0x30>
    }
  }

  return 0;
80104e2f:	31 c0                	xor    %eax,%eax
80104e31:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104e34:	5b                   	pop    %ebx
80104e35:	5e                   	pop    %esi
80104e36:	5f                   	pop    %edi
80104e37:	5d                   	pop    %ebp
80104e38:	c3                   	ret
    return -1;
80104e39:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e3e:	eb f1                	jmp    80104e31 <getpinfo+0xb1>

80104e40 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104e40:	55                   	push   %ebp
80104e41:	89 e5                	mov    %esp,%ebp
80104e43:	53                   	push   %ebx
80104e44:	83 ec 0c             	sub    $0xc,%esp
80104e47:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80104e4a:	68 7e 81 10 80       	push   $0x8010817e
80104e4f:	8d 43 04             	lea    0x4(%ebx),%eax
80104e52:	50                   	push   %eax
80104e53:	e8 18 01 00 00       	call   80104f70 <initlock>
  lk->name = name;
80104e58:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80104e5b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104e61:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104e64:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
80104e6b:	89 43 38             	mov    %eax,0x38(%ebx)
}
80104e6e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e71:	c9                   	leave
80104e72:	c3                   	ret
80104e73:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104e7a:	00 
80104e7b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104e80 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104e80:	55                   	push   %ebp
80104e81:	89 e5                	mov    %esp,%ebp
80104e83:	56                   	push   %esi
80104e84:	53                   	push   %ebx
80104e85:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104e88:	8d 73 04             	lea    0x4(%ebx),%esi
80104e8b:	83 ec 0c             	sub    $0xc,%esp
80104e8e:	56                   	push   %esi
80104e8f:	e8 cc 02 00 00       	call   80105160 <acquire>
  while (lk->locked) {
80104e94:	8b 13                	mov    (%ebx),%edx
80104e96:	83 c4 10             	add    $0x10,%esp
80104e99:	85 d2                	test   %edx,%edx
80104e9b:	74 16                	je     80104eb3 <acquiresleep+0x33>
80104e9d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104ea0:	83 ec 08             	sub    $0x8,%esp
80104ea3:	56                   	push   %esi
80104ea4:	53                   	push   %ebx
80104ea5:	e8 d6 fa ff ff       	call   80104980 <sleep>
  while (lk->locked) {
80104eaa:	8b 03                	mov    (%ebx),%eax
80104eac:	83 c4 10             	add    $0x10,%esp
80104eaf:	85 c0                	test   %eax,%eax
80104eb1:	75 ed                	jne    80104ea0 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104eb3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104eb9:	e8 22 ec ff ff       	call   80103ae0 <myproc>
80104ebe:	8b 40 10             	mov    0x10(%eax),%eax
80104ec1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104ec4:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104ec7:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104eca:	5b                   	pop    %ebx
80104ecb:	5e                   	pop    %esi
80104ecc:	5d                   	pop    %ebp
  release(&lk->lk);
80104ecd:	e9 2e 02 00 00       	jmp    80105100 <release>
80104ed2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104ed9:	00 
80104eda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104ee0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104ee0:	55                   	push   %ebp
80104ee1:	89 e5                	mov    %esp,%ebp
80104ee3:	56                   	push   %esi
80104ee4:	53                   	push   %ebx
80104ee5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104ee8:	8d 73 04             	lea    0x4(%ebx),%esi
80104eeb:	83 ec 0c             	sub    $0xc,%esp
80104eee:	56                   	push   %esi
80104eef:	e8 6c 02 00 00       	call   80105160 <acquire>
  lk->locked = 0;
80104ef4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104efa:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104f01:	89 1c 24             	mov    %ebx,(%esp)
80104f04:	e8 37 fb ff ff       	call   80104a40 <wakeup>
  release(&lk->lk);
80104f09:	83 c4 10             	add    $0x10,%esp
80104f0c:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104f0f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104f12:	5b                   	pop    %ebx
80104f13:	5e                   	pop    %esi
80104f14:	5d                   	pop    %ebp
  release(&lk->lk);
80104f15:	e9 e6 01 00 00       	jmp    80105100 <release>
80104f1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104f20 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104f20:	55                   	push   %ebp
80104f21:	89 e5                	mov    %esp,%ebp
80104f23:	57                   	push   %edi
80104f24:	31 ff                	xor    %edi,%edi
80104f26:	56                   	push   %esi
80104f27:	53                   	push   %ebx
80104f28:	83 ec 18             	sub    $0x18,%esp
80104f2b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80104f2e:	8d 73 04             	lea    0x4(%ebx),%esi
80104f31:	56                   	push   %esi
80104f32:	e8 29 02 00 00       	call   80105160 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104f37:	8b 03                	mov    (%ebx),%eax
80104f39:	83 c4 10             	add    $0x10,%esp
80104f3c:	85 c0                	test   %eax,%eax
80104f3e:	75 18                	jne    80104f58 <holdingsleep+0x38>
  release(&lk->lk);
80104f40:	83 ec 0c             	sub    $0xc,%esp
80104f43:	56                   	push   %esi
80104f44:	e8 b7 01 00 00       	call   80105100 <release>
  return r;
}
80104f49:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f4c:	89 f8                	mov    %edi,%eax
80104f4e:	5b                   	pop    %ebx
80104f4f:	5e                   	pop    %esi
80104f50:	5f                   	pop    %edi
80104f51:	5d                   	pop    %ebp
80104f52:	c3                   	ret
80104f53:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  r = lk->locked && (lk->pid == myproc()->pid);
80104f58:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104f5b:	e8 80 eb ff ff       	call   80103ae0 <myproc>
80104f60:	39 58 10             	cmp    %ebx,0x10(%eax)
80104f63:	0f 94 c0             	sete   %al
80104f66:	0f b6 c0             	movzbl %al,%eax
80104f69:	89 c7                	mov    %eax,%edi
80104f6b:	eb d3                	jmp    80104f40 <holdingsleep+0x20>
80104f6d:	66 90                	xchg   %ax,%ax
80104f6f:	90                   	nop

80104f70 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104f70:	55                   	push   %ebp
80104f71:	89 e5                	mov    %esp,%ebp
80104f73:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104f76:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104f79:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80104f7f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104f82:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104f89:	5d                   	pop    %ebp
80104f8a:	c3                   	ret
80104f8b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104f90 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104f90:	55                   	push   %ebp
80104f91:	89 e5                	mov    %esp,%ebp
80104f93:	53                   	push   %ebx
80104f94:	8b 45 08             	mov    0x8(%ebp),%eax
80104f97:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80104f9a:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104f9d:	05 f8 ff ff 7f       	add    $0x7ffffff8,%eax
80104fa2:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
  for(i = 0; i < 10; i++){
80104fa7:	b8 00 00 00 00       	mov    $0x0,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104fac:	76 10                	jbe    80104fbe <getcallerpcs+0x2e>
80104fae:	eb 28                	jmp    80104fd8 <getcallerpcs+0x48>
80104fb0:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104fb6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104fbc:	77 1a                	ja     80104fd8 <getcallerpcs+0x48>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104fbe:	8b 5a 04             	mov    0x4(%edx),%ebx
80104fc1:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
80104fc4:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80104fc7:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
80104fc9:	83 f8 0a             	cmp    $0xa,%eax
80104fcc:	75 e2                	jne    80104fb0 <getcallerpcs+0x20>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80104fce:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104fd1:	c9                   	leave
80104fd2:	c3                   	ret
80104fd3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104fd8:	8d 04 81             	lea    (%ecx,%eax,4),%eax
80104fdb:	83 c1 28             	add    $0x28,%ecx
80104fde:	89 ca                	mov    %ecx,%edx
80104fe0:	29 c2                	sub    %eax,%edx
80104fe2:	83 e2 04             	and    $0x4,%edx
80104fe5:	74 11                	je     80104ff8 <getcallerpcs+0x68>
    pcs[i] = 0;
80104fe7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104fed:	83 c0 04             	add    $0x4,%eax
80104ff0:	39 c1                	cmp    %eax,%ecx
80104ff2:	74 da                	je     80104fce <getcallerpcs+0x3e>
80104ff4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pcs[i] = 0;
80104ff8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104ffe:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
80105001:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
80105008:	39 c1                	cmp    %eax,%ecx
8010500a:	75 ec                	jne    80104ff8 <getcallerpcs+0x68>
8010500c:	eb c0                	jmp    80104fce <getcallerpcs+0x3e>
8010500e:	66 90                	xchg   %ax,%ax

80105010 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80105010:	55                   	push   %ebp
80105011:	89 e5                	mov    %esp,%ebp
80105013:	53                   	push   %ebx
80105014:	83 ec 04             	sub    $0x4,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80105017:	9c                   	pushf
80105018:	5b                   	pop    %ebx
  asm volatile("cli");
80105019:	fa                   	cli
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010501a:	e8 41 ea ff ff       	call   80103a60 <mycpu>
8010501f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80105025:	85 c0                	test   %eax,%eax
80105027:	74 17                	je     80105040 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80105029:	e8 32 ea ff ff       	call   80103a60 <mycpu>
8010502e:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80105035:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105038:	c9                   	leave
80105039:	c3                   	ret
8010503a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
80105040:	e8 1b ea ff ff       	call   80103a60 <mycpu>
80105045:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010504b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80105051:	eb d6                	jmp    80105029 <pushcli+0x19>
80105053:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010505a:	00 
8010505b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105060 <popcli>:

void
popcli(void)
{
80105060:	55                   	push   %ebp
80105061:	89 e5                	mov    %esp,%ebp
80105063:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80105066:	9c                   	pushf
80105067:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80105068:	f6 c4 02             	test   $0x2,%ah
8010506b:	75 35                	jne    801050a2 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010506d:	e8 ee e9 ff ff       	call   80103a60 <mycpu>
80105072:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80105079:	78 34                	js     801050af <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010507b:	e8 e0 e9 ff ff       	call   80103a60 <mycpu>
80105080:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80105086:	85 d2                	test   %edx,%edx
80105088:	74 06                	je     80105090 <popcli+0x30>
    sti();
}
8010508a:	c9                   	leave
8010508b:	c3                   	ret
8010508c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105090:	e8 cb e9 ff ff       	call   80103a60 <mycpu>
80105095:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010509b:	85 c0                	test   %eax,%eax
8010509d:	74 eb                	je     8010508a <popcli+0x2a>
  asm volatile("sti");
8010509f:	fb                   	sti
}
801050a0:	c9                   	leave
801050a1:	c3                   	ret
    panic("popcli - interruptible");
801050a2:	83 ec 0c             	sub    $0xc,%esp
801050a5:	68 89 81 10 80       	push   $0x80108189
801050aa:	e8 d1 b2 ff ff       	call   80100380 <panic>
    panic("popcli");
801050af:	83 ec 0c             	sub    $0xc,%esp
801050b2:	68 a0 81 10 80       	push   $0x801081a0
801050b7:	e8 c4 b2 ff ff       	call   80100380 <panic>
801050bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801050c0 <holding>:
{
801050c0:	55                   	push   %ebp
801050c1:	89 e5                	mov    %esp,%ebp
801050c3:	56                   	push   %esi
801050c4:	53                   	push   %ebx
801050c5:	8b 75 08             	mov    0x8(%ebp),%esi
801050c8:	31 db                	xor    %ebx,%ebx
  pushcli();
801050ca:	e8 41 ff ff ff       	call   80105010 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801050cf:	8b 06                	mov    (%esi),%eax
801050d1:	85 c0                	test   %eax,%eax
801050d3:	75 0b                	jne    801050e0 <holding+0x20>
  popcli();
801050d5:	e8 86 ff ff ff       	call   80105060 <popcli>
}
801050da:	89 d8                	mov    %ebx,%eax
801050dc:	5b                   	pop    %ebx
801050dd:	5e                   	pop    %esi
801050de:	5d                   	pop    %ebp
801050df:	c3                   	ret
  r = lock->locked && lock->cpu == mycpu();
801050e0:	8b 5e 08             	mov    0x8(%esi),%ebx
801050e3:	e8 78 e9 ff ff       	call   80103a60 <mycpu>
801050e8:	39 c3                	cmp    %eax,%ebx
801050ea:	0f 94 c3             	sete   %bl
  popcli();
801050ed:	e8 6e ff ff ff       	call   80105060 <popcli>
  r = lock->locked && lock->cpu == mycpu();
801050f2:	0f b6 db             	movzbl %bl,%ebx
}
801050f5:	89 d8                	mov    %ebx,%eax
801050f7:	5b                   	pop    %ebx
801050f8:	5e                   	pop    %esi
801050f9:	5d                   	pop    %ebp
801050fa:	c3                   	ret
801050fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105100 <release>:
{
80105100:	55                   	push   %ebp
80105101:	89 e5                	mov    %esp,%ebp
80105103:	56                   	push   %esi
80105104:	53                   	push   %ebx
80105105:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80105108:	e8 03 ff ff ff       	call   80105010 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010510d:	8b 03                	mov    (%ebx),%eax
8010510f:	85 c0                	test   %eax,%eax
80105111:	75 15                	jne    80105128 <release+0x28>
  popcli();
80105113:	e8 48 ff ff ff       	call   80105060 <popcli>
    panic("release");
80105118:	83 ec 0c             	sub    $0xc,%esp
8010511b:	68 a7 81 10 80       	push   $0x801081a7
80105120:	e8 5b b2 ff ff       	call   80100380 <panic>
80105125:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80105128:	8b 73 08             	mov    0x8(%ebx),%esi
8010512b:	e8 30 e9 ff ff       	call   80103a60 <mycpu>
80105130:	39 c6                	cmp    %eax,%esi
80105132:	75 df                	jne    80105113 <release+0x13>
  popcli();
80105134:	e8 27 ff ff ff       	call   80105060 <popcli>
  lk->pcs[0] = 0;
80105139:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80105140:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80105147:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010514c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80105152:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105155:	5b                   	pop    %ebx
80105156:	5e                   	pop    %esi
80105157:	5d                   	pop    %ebp
  popcli();
80105158:	e9 03 ff ff ff       	jmp    80105060 <popcli>
8010515d:	8d 76 00             	lea    0x0(%esi),%esi

80105160 <acquire>:
{
80105160:	55                   	push   %ebp
80105161:	89 e5                	mov    %esp,%ebp
80105163:	53                   	push   %ebx
80105164:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80105167:	e8 a4 fe ff ff       	call   80105010 <pushcli>
  if(holding(lk))
8010516c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
8010516f:	e8 9c fe ff ff       	call   80105010 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80105174:	8b 03                	mov    (%ebx),%eax
80105176:	85 c0                	test   %eax,%eax
80105178:	0f 85 b2 00 00 00    	jne    80105230 <acquire+0xd0>
  popcli();
8010517e:	e8 dd fe ff ff       	call   80105060 <popcli>
  asm volatile("lock; xchgl %0, %1" :
80105183:	b9 01 00 00 00       	mov    $0x1,%ecx
80105188:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010518f:	00 
  while(xchg(&lk->locked, 1) != 0)
80105190:	8b 55 08             	mov    0x8(%ebp),%edx
80105193:	89 c8                	mov    %ecx,%eax
80105195:	f0 87 02             	lock xchg %eax,(%edx)
80105198:	85 c0                	test   %eax,%eax
8010519a:	75 f4                	jne    80105190 <acquire+0x30>
  __sync_synchronize();
8010519c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
801051a1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801051a4:	e8 b7 e8 ff ff       	call   80103a60 <mycpu>
  getcallerpcs(&lk, lk->pcs);
801051a9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  for(i = 0; i < 10; i++){
801051ac:	31 d2                	xor    %edx,%edx
  lk->cpu = mycpu();
801051ae:	89 43 08             	mov    %eax,0x8(%ebx)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801051b1:	8d 85 00 00 00 80    	lea    -0x80000000(%ebp),%eax
801051b7:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
801051bc:	77 32                	ja     801051f0 <acquire+0x90>
  ebp = (uint*)v - 2;
801051be:	89 e8                	mov    %ebp,%eax
801051c0:	eb 14                	jmp    801051d6 <acquire+0x76>
801051c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801051c8:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
801051ce:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801051d4:	77 1a                	ja     801051f0 <acquire+0x90>
    pcs[i] = ebp[1];     // saved %eip
801051d6:	8b 58 04             	mov    0x4(%eax),%ebx
801051d9:	89 5c 91 0c          	mov    %ebx,0xc(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
801051dd:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
801051e0:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801051e2:	83 fa 0a             	cmp    $0xa,%edx
801051e5:	75 e1                	jne    801051c8 <acquire+0x68>
}
801051e7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801051ea:	c9                   	leave
801051eb:	c3                   	ret
801051ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801051f0:	8d 44 91 0c          	lea    0xc(%ecx,%edx,4),%eax
801051f4:	83 c1 34             	add    $0x34,%ecx
801051f7:	89 ca                	mov    %ecx,%edx
801051f9:	29 c2                	sub    %eax,%edx
801051fb:	83 e2 04             	and    $0x4,%edx
801051fe:	74 10                	je     80105210 <acquire+0xb0>
    pcs[i] = 0;
80105200:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80105206:	83 c0 04             	add    $0x4,%eax
80105209:	39 c1                	cmp    %eax,%ecx
8010520b:	74 da                	je     801051e7 <acquire+0x87>
8010520d:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
80105210:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80105216:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
80105219:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
80105220:	39 c1                	cmp    %eax,%ecx
80105222:	75 ec                	jne    80105210 <acquire+0xb0>
80105224:	eb c1                	jmp    801051e7 <acquire+0x87>
80105226:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010522d:	00 
8010522e:	66 90                	xchg   %ax,%ax
  r = lock->locked && lock->cpu == mycpu();
80105230:	8b 5b 08             	mov    0x8(%ebx),%ebx
80105233:	e8 28 e8 ff ff       	call   80103a60 <mycpu>
80105238:	39 c3                	cmp    %eax,%ebx
8010523a:	0f 85 3e ff ff ff    	jne    8010517e <acquire+0x1e>
  popcli();
80105240:	e8 1b fe ff ff       	call   80105060 <popcli>
    panic("acquire");
80105245:	83 ec 0c             	sub    $0xc,%esp
80105248:	68 af 81 10 80       	push   $0x801081af
8010524d:	e8 2e b1 ff ff       	call   80100380 <panic>
80105252:	66 90                	xchg   %ax,%ax
80105254:	66 90                	xchg   %ax,%ax
80105256:	66 90                	xchg   %ax,%ax
80105258:	66 90                	xchg   %ax,%ax
8010525a:	66 90                	xchg   %ax,%ax
8010525c:	66 90                	xchg   %ax,%ax
8010525e:	66 90                	xchg   %ax,%ax

80105260 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80105260:	55                   	push   %ebp
80105261:	89 e5                	mov    %esp,%ebp
80105263:	57                   	push   %edi
80105264:	8b 55 08             	mov    0x8(%ebp),%edx
80105267:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
8010526a:	89 d0                	mov    %edx,%eax
8010526c:	09 c8                	or     %ecx,%eax
8010526e:	a8 03                	test   $0x3,%al
80105270:	75 1e                	jne    80105290 <memset+0x30>
    c &= 0xFF;
80105272:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80105276:	c1 e9 02             	shr    $0x2,%ecx
  asm volatile("cld; rep stosl" :
80105279:	89 d7                	mov    %edx,%edi
8010527b:	69 c0 01 01 01 01    	imul   $0x1010101,%eax,%eax
80105281:	fc                   	cld
80105282:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80105284:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105287:	89 d0                	mov    %edx,%eax
80105289:	c9                   	leave
8010528a:	c3                   	ret
8010528b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
80105290:	8b 45 0c             	mov    0xc(%ebp),%eax
80105293:	89 d7                	mov    %edx,%edi
80105295:	fc                   	cld
80105296:	f3 aa                	rep stos %al,%es:(%edi)
80105298:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010529b:	89 d0                	mov    %edx,%eax
8010529d:	c9                   	leave
8010529e:	c3                   	ret
8010529f:	90                   	nop

801052a0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801052a0:	55                   	push   %ebp
801052a1:	89 e5                	mov    %esp,%ebp
801052a3:	56                   	push   %esi
801052a4:	8b 75 10             	mov    0x10(%ebp),%esi
801052a7:	8b 45 08             	mov    0x8(%ebp),%eax
801052aa:	53                   	push   %ebx
801052ab:	8b 55 0c             	mov    0xc(%ebp),%edx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801052ae:	85 f6                	test   %esi,%esi
801052b0:	74 2e                	je     801052e0 <memcmp+0x40>
801052b2:	01 c6                	add    %eax,%esi
801052b4:	eb 14                	jmp    801052ca <memcmp+0x2a>
801052b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801052bd:	00 
801052be:	66 90                	xchg   %ax,%ax
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
801052c0:	83 c0 01             	add    $0x1,%eax
801052c3:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
801052c6:	39 f0                	cmp    %esi,%eax
801052c8:	74 16                	je     801052e0 <memcmp+0x40>
    if(*s1 != *s2)
801052ca:	0f b6 08             	movzbl (%eax),%ecx
801052cd:	0f b6 1a             	movzbl (%edx),%ebx
801052d0:	38 d9                	cmp    %bl,%cl
801052d2:	74 ec                	je     801052c0 <memcmp+0x20>
      return *s1 - *s2;
801052d4:	0f b6 c1             	movzbl %cl,%eax
801052d7:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
801052d9:	5b                   	pop    %ebx
801052da:	5e                   	pop    %esi
801052db:	5d                   	pop    %ebp
801052dc:	c3                   	ret
801052dd:	8d 76 00             	lea    0x0(%esi),%esi
801052e0:	5b                   	pop    %ebx
  return 0;
801052e1:	31 c0                	xor    %eax,%eax
}
801052e3:	5e                   	pop    %esi
801052e4:	5d                   	pop    %ebp
801052e5:	c3                   	ret
801052e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801052ed:	00 
801052ee:	66 90                	xchg   %ax,%ax

801052f0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
801052f0:	55                   	push   %ebp
801052f1:	89 e5                	mov    %esp,%ebp
801052f3:	57                   	push   %edi
801052f4:	8b 55 08             	mov    0x8(%ebp),%edx
801052f7:	8b 45 10             	mov    0x10(%ebp),%eax
801052fa:	56                   	push   %esi
801052fb:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
801052fe:	39 d6                	cmp    %edx,%esi
80105300:	73 26                	jae    80105328 <memmove+0x38>
80105302:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
80105305:	39 ca                	cmp    %ecx,%edx
80105307:	73 1f                	jae    80105328 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80105309:	85 c0                	test   %eax,%eax
8010530b:	74 0f                	je     8010531c <memmove+0x2c>
8010530d:	83 e8 01             	sub    $0x1,%eax
      *--d = *--s;
80105310:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80105314:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80105317:	83 e8 01             	sub    $0x1,%eax
8010531a:	73 f4                	jae    80105310 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010531c:	5e                   	pop    %esi
8010531d:	89 d0                	mov    %edx,%eax
8010531f:	5f                   	pop    %edi
80105320:	5d                   	pop    %ebp
80105321:	c3                   	ret
80105322:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
80105328:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
8010532b:	89 d7                	mov    %edx,%edi
8010532d:	85 c0                	test   %eax,%eax
8010532f:	74 eb                	je     8010531c <memmove+0x2c>
80105331:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80105338:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80105339:	39 ce                	cmp    %ecx,%esi
8010533b:	75 fb                	jne    80105338 <memmove+0x48>
}
8010533d:	5e                   	pop    %esi
8010533e:	89 d0                	mov    %edx,%eax
80105340:	5f                   	pop    %edi
80105341:	5d                   	pop    %ebp
80105342:	c3                   	ret
80105343:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010534a:	00 
8010534b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105350 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80105350:	eb 9e                	jmp    801052f0 <memmove>
80105352:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105359:	00 
8010535a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105360 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80105360:	55                   	push   %ebp
80105361:	89 e5                	mov    %esp,%ebp
80105363:	53                   	push   %ebx
80105364:	8b 55 10             	mov    0x10(%ebp),%edx
80105367:	8b 45 08             	mov    0x8(%ebp),%eax
8010536a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(n > 0 && *p && *p == *q)
8010536d:	85 d2                	test   %edx,%edx
8010536f:	75 16                	jne    80105387 <strncmp+0x27>
80105371:	eb 2d                	jmp    801053a0 <strncmp+0x40>
80105373:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80105378:	3a 19                	cmp    (%ecx),%bl
8010537a:	75 12                	jne    8010538e <strncmp+0x2e>
    n--, p++, q++;
8010537c:	83 c0 01             	add    $0x1,%eax
8010537f:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80105382:	83 ea 01             	sub    $0x1,%edx
80105385:	74 19                	je     801053a0 <strncmp+0x40>
80105387:	0f b6 18             	movzbl (%eax),%ebx
8010538a:	84 db                	test   %bl,%bl
8010538c:	75 ea                	jne    80105378 <strncmp+0x18>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
8010538e:	0f b6 00             	movzbl (%eax),%eax
80105391:	0f b6 11             	movzbl (%ecx),%edx
}
80105394:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105397:	c9                   	leave
  return (uchar)*p - (uchar)*q;
80105398:	29 d0                	sub    %edx,%eax
}
8010539a:	c3                   	ret
8010539b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801053a0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
801053a3:	31 c0                	xor    %eax,%eax
}
801053a5:	c9                   	leave
801053a6:	c3                   	ret
801053a7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801053ae:	00 
801053af:	90                   	nop

801053b0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801053b0:	55                   	push   %ebp
801053b1:	89 e5                	mov    %esp,%ebp
801053b3:	57                   	push   %edi
801053b4:	56                   	push   %esi
801053b5:	8b 75 08             	mov    0x8(%ebp),%esi
801053b8:	53                   	push   %ebx
801053b9:	8b 55 10             	mov    0x10(%ebp),%edx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801053bc:	89 f0                	mov    %esi,%eax
801053be:	eb 15                	jmp    801053d5 <strncpy+0x25>
801053c0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
801053c4:	8b 7d 0c             	mov    0xc(%ebp),%edi
801053c7:	83 c0 01             	add    $0x1,%eax
801053ca:	0f b6 4f ff          	movzbl -0x1(%edi),%ecx
801053ce:	88 48 ff             	mov    %cl,-0x1(%eax)
801053d1:	84 c9                	test   %cl,%cl
801053d3:	74 13                	je     801053e8 <strncpy+0x38>
801053d5:	89 d3                	mov    %edx,%ebx
801053d7:	83 ea 01             	sub    $0x1,%edx
801053da:	85 db                	test   %ebx,%ebx
801053dc:	7f e2                	jg     801053c0 <strncpy+0x10>
    ;
  while(n-- > 0)
    *s++ = 0;
  return os;
}
801053de:	5b                   	pop    %ebx
801053df:	89 f0                	mov    %esi,%eax
801053e1:	5e                   	pop    %esi
801053e2:	5f                   	pop    %edi
801053e3:	5d                   	pop    %ebp
801053e4:	c3                   	ret
801053e5:	8d 76 00             	lea    0x0(%esi),%esi
  while(n-- > 0)
801053e8:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
801053eb:	83 e9 01             	sub    $0x1,%ecx
801053ee:	85 d2                	test   %edx,%edx
801053f0:	74 ec                	je     801053de <strncpy+0x2e>
801053f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *s++ = 0;
801053f8:	83 c0 01             	add    $0x1,%eax
801053fb:	89 ca                	mov    %ecx,%edx
801053fd:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  while(n-- > 0)
80105401:	29 c2                	sub    %eax,%edx
80105403:	85 d2                	test   %edx,%edx
80105405:	7f f1                	jg     801053f8 <strncpy+0x48>
}
80105407:	5b                   	pop    %ebx
80105408:	89 f0                	mov    %esi,%eax
8010540a:	5e                   	pop    %esi
8010540b:	5f                   	pop    %edi
8010540c:	5d                   	pop    %ebp
8010540d:	c3                   	ret
8010540e:	66 90                	xchg   %ax,%ax

80105410 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105410:	55                   	push   %ebp
80105411:	89 e5                	mov    %esp,%ebp
80105413:	56                   	push   %esi
80105414:	8b 55 10             	mov    0x10(%ebp),%edx
80105417:	8b 75 08             	mov    0x8(%ebp),%esi
8010541a:	53                   	push   %ebx
8010541b:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
8010541e:	85 d2                	test   %edx,%edx
80105420:	7e 25                	jle    80105447 <safestrcpy+0x37>
80105422:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80105426:	89 f2                	mov    %esi,%edx
80105428:	eb 16                	jmp    80105440 <safestrcpy+0x30>
8010542a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80105430:	0f b6 08             	movzbl (%eax),%ecx
80105433:	83 c0 01             	add    $0x1,%eax
80105436:	83 c2 01             	add    $0x1,%edx
80105439:	88 4a ff             	mov    %cl,-0x1(%edx)
8010543c:	84 c9                	test   %cl,%cl
8010543e:	74 04                	je     80105444 <safestrcpy+0x34>
80105440:	39 d8                	cmp    %ebx,%eax
80105442:	75 ec                	jne    80105430 <safestrcpy+0x20>
    ;
  *s = 0;
80105444:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80105447:	89 f0                	mov    %esi,%eax
80105449:	5b                   	pop    %ebx
8010544a:	5e                   	pop    %esi
8010544b:	5d                   	pop    %ebp
8010544c:	c3                   	ret
8010544d:	8d 76 00             	lea    0x0(%esi),%esi

80105450 <strlen>:

int
strlen(const char *s)
{
80105450:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80105451:	31 c0                	xor    %eax,%eax
{
80105453:	89 e5                	mov    %esp,%ebp
80105455:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80105458:	80 3a 00             	cmpb   $0x0,(%edx)
8010545b:	74 0c                	je     80105469 <strlen+0x19>
8010545d:	8d 76 00             	lea    0x0(%esi),%esi
80105460:	83 c0 01             	add    $0x1,%eax
80105463:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80105467:	75 f7                	jne    80105460 <strlen+0x10>
    ;
  return n;
}
80105469:	5d                   	pop    %ebp
8010546a:	c3                   	ret

8010546b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010546b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010546f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80105473:	55                   	push   %ebp
  pushl %ebx
80105474:	53                   	push   %ebx
  pushl %esi
80105475:	56                   	push   %esi
  pushl %edi
80105476:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80105477:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80105479:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
8010547b:	5f                   	pop    %edi
  popl %esi
8010547c:	5e                   	pop    %esi
  popl %ebx
8010547d:	5b                   	pop    %ebx
  popl %ebp
8010547e:	5d                   	pop    %ebp
  ret
8010547f:	c3                   	ret

80105480 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105480:	55                   	push   %ebp
80105481:	89 e5                	mov    %esp,%ebp
80105483:	53                   	push   %ebx
80105484:	83 ec 04             	sub    $0x4,%esp
80105487:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010548a:	e8 51 e6 ff ff       	call   80103ae0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010548f:	8b 00                	mov    (%eax),%eax
80105491:	39 c3                	cmp    %eax,%ebx
80105493:	73 1b                	jae    801054b0 <fetchint+0x30>
80105495:	8d 53 04             	lea    0x4(%ebx),%edx
80105498:	39 d0                	cmp    %edx,%eax
8010549a:	72 14                	jb     801054b0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010549c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010549f:	8b 13                	mov    (%ebx),%edx
801054a1:	89 10                	mov    %edx,(%eax)
  return 0;
801054a3:	31 c0                	xor    %eax,%eax
}
801054a5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801054a8:	c9                   	leave
801054a9:	c3                   	ret
801054aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801054b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054b5:	eb ee                	jmp    801054a5 <fetchint+0x25>
801054b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801054be:	00 
801054bf:	90                   	nop

801054c0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801054c0:	55                   	push   %ebp
801054c1:	89 e5                	mov    %esp,%ebp
801054c3:	53                   	push   %ebx
801054c4:	83 ec 04             	sub    $0x4,%esp
801054c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
801054ca:	e8 11 e6 ff ff       	call   80103ae0 <myproc>

  if(addr >= curproc->sz)
801054cf:	3b 18                	cmp    (%eax),%ebx
801054d1:	73 2d                	jae    80105500 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
801054d3:	8b 55 0c             	mov    0xc(%ebp),%edx
801054d6:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
801054d8:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
801054da:	39 d3                	cmp    %edx,%ebx
801054dc:	73 22                	jae    80105500 <fetchstr+0x40>
801054de:	89 d8                	mov    %ebx,%eax
801054e0:	eb 0d                	jmp    801054ef <fetchstr+0x2f>
801054e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801054e8:	83 c0 01             	add    $0x1,%eax
801054eb:	39 d0                	cmp    %edx,%eax
801054ed:	73 11                	jae    80105500 <fetchstr+0x40>
    if(*s == 0)
801054ef:	80 38 00             	cmpb   $0x0,(%eax)
801054f2:	75 f4                	jne    801054e8 <fetchstr+0x28>
      return s - *pp;
801054f4:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
801054f6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801054f9:	c9                   	leave
801054fa:	c3                   	ret
801054fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80105500:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80105503:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105508:	c9                   	leave
80105509:	c3                   	ret
8010550a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105510 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105510:	55                   	push   %ebp
80105511:	89 e5                	mov    %esp,%ebp
80105513:	56                   	push   %esi
80105514:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105515:	e8 c6 e5 ff ff       	call   80103ae0 <myproc>
8010551a:	8b 55 08             	mov    0x8(%ebp),%edx
8010551d:	8b 40 18             	mov    0x18(%eax),%eax
80105520:	8b 40 44             	mov    0x44(%eax),%eax
80105523:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105526:	e8 b5 e5 ff ff       	call   80103ae0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010552b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010552e:	8b 00                	mov    (%eax),%eax
80105530:	39 c6                	cmp    %eax,%esi
80105532:	73 1c                	jae    80105550 <argint+0x40>
80105534:	8d 53 08             	lea    0x8(%ebx),%edx
80105537:	39 d0                	cmp    %edx,%eax
80105539:	72 15                	jb     80105550 <argint+0x40>
  *ip = *(int*)(addr);
8010553b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010553e:	8b 53 04             	mov    0x4(%ebx),%edx
80105541:	89 10                	mov    %edx,(%eax)
  return 0;
80105543:	31 c0                	xor    %eax,%eax
}
80105545:	5b                   	pop    %ebx
80105546:	5e                   	pop    %esi
80105547:	5d                   	pop    %ebp
80105548:	c3                   	ret
80105549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105550:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105555:	eb ee                	jmp    80105545 <argint+0x35>
80105557:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010555e:	00 
8010555f:	90                   	nop

80105560 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105560:	55                   	push   %ebp
80105561:	89 e5                	mov    %esp,%ebp
80105563:	57                   	push   %edi
80105564:	56                   	push   %esi
80105565:	53                   	push   %ebx
80105566:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
80105569:	e8 72 e5 ff ff       	call   80103ae0 <myproc>
8010556e:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105570:	e8 6b e5 ff ff       	call   80103ae0 <myproc>
80105575:	8b 55 08             	mov    0x8(%ebp),%edx
80105578:	8b 40 18             	mov    0x18(%eax),%eax
8010557b:	8b 40 44             	mov    0x44(%eax),%eax
8010557e:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105581:	e8 5a e5 ff ff       	call   80103ae0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105586:	8d 7b 04             	lea    0x4(%ebx),%edi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105589:	8b 00                	mov    (%eax),%eax
8010558b:	39 c7                	cmp    %eax,%edi
8010558d:	73 31                	jae    801055c0 <argptr+0x60>
8010558f:	8d 4b 08             	lea    0x8(%ebx),%ecx
80105592:	39 c8                	cmp    %ecx,%eax
80105594:	72 2a                	jb     801055c0 <argptr+0x60>
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80105596:	8b 55 10             	mov    0x10(%ebp),%edx
  *ip = *(int*)(addr);
80105599:	8b 43 04             	mov    0x4(%ebx),%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
8010559c:	85 d2                	test   %edx,%edx
8010559e:	78 20                	js     801055c0 <argptr+0x60>
801055a0:	8b 16                	mov    (%esi),%edx
801055a2:	39 d0                	cmp    %edx,%eax
801055a4:	73 1a                	jae    801055c0 <argptr+0x60>
801055a6:	8b 5d 10             	mov    0x10(%ebp),%ebx
801055a9:	01 c3                	add    %eax,%ebx
801055ab:	39 da                	cmp    %ebx,%edx
801055ad:	72 11                	jb     801055c0 <argptr+0x60>
    return -1;
  *pp = (char*)i;
801055af:	8b 55 0c             	mov    0xc(%ebp),%edx
801055b2:	89 02                	mov    %eax,(%edx)
  return 0;
801055b4:	31 c0                	xor    %eax,%eax
}
801055b6:	83 c4 0c             	add    $0xc,%esp
801055b9:	5b                   	pop    %ebx
801055ba:	5e                   	pop    %esi
801055bb:	5f                   	pop    %edi
801055bc:	5d                   	pop    %ebp
801055bd:	c3                   	ret
801055be:	66 90                	xchg   %ax,%ax
    return -1;
801055c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055c5:	eb ef                	jmp    801055b6 <argptr+0x56>
801055c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801055ce:	00 
801055cf:	90                   	nop

801055d0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801055d0:	55                   	push   %ebp
801055d1:	89 e5                	mov    %esp,%ebp
801055d3:	56                   	push   %esi
801055d4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801055d5:	e8 06 e5 ff ff       	call   80103ae0 <myproc>
801055da:	8b 55 08             	mov    0x8(%ebp),%edx
801055dd:	8b 40 18             	mov    0x18(%eax),%eax
801055e0:	8b 40 44             	mov    0x44(%eax),%eax
801055e3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
801055e6:	e8 f5 e4 ff ff       	call   80103ae0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801055eb:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801055ee:	8b 00                	mov    (%eax),%eax
801055f0:	39 c6                	cmp    %eax,%esi
801055f2:	73 44                	jae    80105638 <argstr+0x68>
801055f4:	8d 53 08             	lea    0x8(%ebx),%edx
801055f7:	39 d0                	cmp    %edx,%eax
801055f9:	72 3d                	jb     80105638 <argstr+0x68>
  *ip = *(int*)(addr);
801055fb:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
801055fe:	e8 dd e4 ff ff       	call   80103ae0 <myproc>
  if(addr >= curproc->sz)
80105603:	3b 18                	cmp    (%eax),%ebx
80105605:	73 31                	jae    80105638 <argstr+0x68>
  *pp = (char*)addr;
80105607:	8b 55 0c             	mov    0xc(%ebp),%edx
8010560a:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
8010560c:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
8010560e:	39 d3                	cmp    %edx,%ebx
80105610:	73 26                	jae    80105638 <argstr+0x68>
80105612:	89 d8                	mov    %ebx,%eax
80105614:	eb 11                	jmp    80105627 <argstr+0x57>
80105616:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010561d:	00 
8010561e:	66 90                	xchg   %ax,%ax
80105620:	83 c0 01             	add    $0x1,%eax
80105623:	39 d0                	cmp    %edx,%eax
80105625:	73 11                	jae    80105638 <argstr+0x68>
    if(*s == 0)
80105627:	80 38 00             	cmpb   $0x0,(%eax)
8010562a:	75 f4                	jne    80105620 <argstr+0x50>
      return s - *pp;
8010562c:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
8010562e:	5b                   	pop    %ebx
8010562f:	5e                   	pop    %esi
80105630:	5d                   	pop    %ebp
80105631:	c3                   	ret
80105632:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105638:	5b                   	pop    %ebx
    return -1;
80105639:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010563e:	5e                   	pop    %esi
8010563f:	5d                   	pop    %ebp
80105640:	c3                   	ret
80105641:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105648:	00 
80105649:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105650 <syscall>:
[SYS_cps]      sys_cps,
};

void
syscall(void)
{
80105650:	55                   	push   %ebp
80105651:	89 e5                	mov    %esp,%ebp
80105653:	53                   	push   %ebx
80105654:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80105657:	e8 84 e4 ff ff       	call   80103ae0 <myproc>
8010565c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
8010565e:	8b 40 18             	mov    0x18(%eax),%eax
80105661:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105664:	8d 50 ff             	lea    -0x1(%eax),%edx
80105667:	83 fa 18             	cmp    $0x18,%edx
8010566a:	77 24                	ja     80105690 <syscall+0x40>
8010566c:	8b 14 85 60 88 10 80 	mov    -0x7fef77a0(,%eax,4),%edx
80105673:	85 d2                	test   %edx,%edx
80105675:	74 19                	je     80105690 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
80105677:	ff d2                	call   *%edx
80105679:	89 c2                	mov    %eax,%edx
8010567b:	8b 43 18             	mov    0x18(%ebx),%eax
8010567e:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80105681:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105684:	c9                   	leave
80105685:	c3                   	ret
80105686:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010568d:	00 
8010568e:	66 90                	xchg   %ax,%ax
    cprintf("%d %s: unknown sys call %d\n",
80105690:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80105691:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80105694:	50                   	push   %eax
80105695:	ff 73 10             	push   0x10(%ebx)
80105698:	68 b7 81 10 80       	push   $0x801081b7
8010569d:	e8 0e b0 ff ff       	call   801006b0 <cprintf>
    curproc->tf->eax = -1;
801056a2:	8b 43 18             	mov    0x18(%ebx),%eax
801056a5:	83 c4 10             	add    $0x10,%esp
801056a8:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
801056af:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801056b2:	c9                   	leave
801056b3:	c3                   	ret
801056b4:	66 90                	xchg   %ax,%ax
801056b6:	66 90                	xchg   %ax,%ax
801056b8:	66 90                	xchg   %ax,%ax
801056ba:	66 90                	xchg   %ax,%ax
801056bc:	66 90                	xchg   %ax,%ax
801056be:	66 90                	xchg   %ax,%ax

801056c0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
801056c0:	55                   	push   %ebp
801056c1:	89 e5                	mov    %esp,%ebp
801056c3:	57                   	push   %edi
801056c4:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801056c5:	8d 7d da             	lea    -0x26(%ebp),%edi
{
801056c8:	53                   	push   %ebx
801056c9:	83 ec 34             	sub    $0x34,%esp
801056cc:	89 4d d0             	mov    %ecx,-0x30(%ebp)
801056cf:	8b 4d 08             	mov    0x8(%ebp),%ecx
801056d2:	89 55 d4             	mov    %edx,-0x2c(%ebp)
801056d5:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
801056d8:	57                   	push   %edi
801056d9:	50                   	push   %eax
801056da:	e8 d1 c9 ff ff       	call   801020b0 <nameiparent>
801056df:	83 c4 10             	add    $0x10,%esp
801056e2:	85 c0                	test   %eax,%eax
801056e4:	74 5e                	je     80105744 <create+0x84>
    return 0;
  ilock(dp);
801056e6:	83 ec 0c             	sub    $0xc,%esp
801056e9:	89 c3                	mov    %eax,%ebx
801056eb:	50                   	push   %eax
801056ec:	e8 bf c0 ff ff       	call   801017b0 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
801056f1:	83 c4 0c             	add    $0xc,%esp
801056f4:	6a 00                	push   $0x0
801056f6:	57                   	push   %edi
801056f7:	53                   	push   %ebx
801056f8:	e8 03 c6 ff ff       	call   80101d00 <dirlookup>
801056fd:	83 c4 10             	add    $0x10,%esp
80105700:	89 c6                	mov    %eax,%esi
80105702:	85 c0                	test   %eax,%eax
80105704:	74 4a                	je     80105750 <create+0x90>
    iunlockput(dp);
80105706:	83 ec 0c             	sub    $0xc,%esp
80105709:	53                   	push   %ebx
8010570a:	e8 31 c3 ff ff       	call   80101a40 <iunlockput>
    ilock(ip);
8010570f:	89 34 24             	mov    %esi,(%esp)
80105712:	e8 99 c0 ff ff       	call   801017b0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80105717:	83 c4 10             	add    $0x10,%esp
8010571a:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
8010571f:	75 17                	jne    80105738 <create+0x78>
80105721:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80105726:	75 10                	jne    80105738 <create+0x78>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80105728:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010572b:	89 f0                	mov    %esi,%eax
8010572d:	5b                   	pop    %ebx
8010572e:	5e                   	pop    %esi
8010572f:	5f                   	pop    %edi
80105730:	5d                   	pop    %ebp
80105731:	c3                   	ret
80105732:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(ip);
80105738:	83 ec 0c             	sub    $0xc,%esp
8010573b:	56                   	push   %esi
8010573c:	e8 ff c2 ff ff       	call   80101a40 <iunlockput>
    return 0;
80105741:	83 c4 10             	add    $0x10,%esp
}
80105744:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80105747:	31 f6                	xor    %esi,%esi
}
80105749:	5b                   	pop    %ebx
8010574a:	89 f0                	mov    %esi,%eax
8010574c:	5e                   	pop    %esi
8010574d:	5f                   	pop    %edi
8010574e:	5d                   	pop    %ebp
8010574f:	c3                   	ret
  if((ip = ialloc(dp->dev, type)) == 0)
80105750:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80105754:	83 ec 08             	sub    $0x8,%esp
80105757:	50                   	push   %eax
80105758:	ff 33                	push   (%ebx)
8010575a:	e8 e1 be ff ff       	call   80101640 <ialloc>
8010575f:	83 c4 10             	add    $0x10,%esp
80105762:	89 c6                	mov    %eax,%esi
80105764:	85 c0                	test   %eax,%eax
80105766:	0f 84 bc 00 00 00    	je     80105828 <create+0x168>
  ilock(ip);
8010576c:	83 ec 0c             	sub    $0xc,%esp
8010576f:	50                   	push   %eax
80105770:	e8 3b c0 ff ff       	call   801017b0 <ilock>
  ip->major = major;
80105775:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80105779:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
8010577d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80105781:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80105785:	b8 01 00 00 00       	mov    $0x1,%eax
8010578a:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
8010578e:	89 34 24             	mov    %esi,(%esp)
80105791:	e8 6a bf ff ff       	call   80101700 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80105796:	83 c4 10             	add    $0x10,%esp
80105799:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
8010579e:	74 30                	je     801057d0 <create+0x110>
  if(dirlink(dp, name, ip->inum) < 0)
801057a0:	83 ec 04             	sub    $0x4,%esp
801057a3:	ff 76 04             	push   0x4(%esi)
801057a6:	57                   	push   %edi
801057a7:	53                   	push   %ebx
801057a8:	e8 23 c8 ff ff       	call   80101fd0 <dirlink>
801057ad:	83 c4 10             	add    $0x10,%esp
801057b0:	85 c0                	test   %eax,%eax
801057b2:	78 67                	js     8010581b <create+0x15b>
  iunlockput(dp);
801057b4:	83 ec 0c             	sub    $0xc,%esp
801057b7:	53                   	push   %ebx
801057b8:	e8 83 c2 ff ff       	call   80101a40 <iunlockput>
  return ip;
801057bd:	83 c4 10             	add    $0x10,%esp
}
801057c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801057c3:	89 f0                	mov    %esi,%eax
801057c5:	5b                   	pop    %ebx
801057c6:	5e                   	pop    %esi
801057c7:	5f                   	pop    %edi
801057c8:	5d                   	pop    %ebp
801057c9:	c3                   	ret
801057ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
801057d0:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
801057d3:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
801057d8:	53                   	push   %ebx
801057d9:	e8 22 bf ff ff       	call   80101700 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801057de:	83 c4 0c             	add    $0xc,%esp
801057e1:	ff 76 04             	push   0x4(%esi)
801057e4:	68 ef 81 10 80       	push   $0x801081ef
801057e9:	56                   	push   %esi
801057ea:	e8 e1 c7 ff ff       	call   80101fd0 <dirlink>
801057ef:	83 c4 10             	add    $0x10,%esp
801057f2:	85 c0                	test   %eax,%eax
801057f4:	78 18                	js     8010580e <create+0x14e>
801057f6:	83 ec 04             	sub    $0x4,%esp
801057f9:	ff 73 04             	push   0x4(%ebx)
801057fc:	68 ee 81 10 80       	push   $0x801081ee
80105801:	56                   	push   %esi
80105802:	e8 c9 c7 ff ff       	call   80101fd0 <dirlink>
80105807:	83 c4 10             	add    $0x10,%esp
8010580a:	85 c0                	test   %eax,%eax
8010580c:	79 92                	jns    801057a0 <create+0xe0>
      panic("create dots");
8010580e:	83 ec 0c             	sub    $0xc,%esp
80105811:	68 e2 81 10 80       	push   $0x801081e2
80105816:	e8 65 ab ff ff       	call   80100380 <panic>
    panic("create: dirlink");
8010581b:	83 ec 0c             	sub    $0xc,%esp
8010581e:	68 f1 81 10 80       	push   $0x801081f1
80105823:	e8 58 ab ff ff       	call   80100380 <panic>
    panic("create: ialloc");
80105828:	83 ec 0c             	sub    $0xc,%esp
8010582b:	68 d3 81 10 80       	push   $0x801081d3
80105830:	e8 4b ab ff ff       	call   80100380 <panic>
80105835:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010583c:	00 
8010583d:	8d 76 00             	lea    0x0(%esi),%esi

80105840 <sys_dup>:
{
80105840:	55                   	push   %ebp
80105841:	89 e5                	mov    %esp,%ebp
80105843:	56                   	push   %esi
80105844:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105845:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105848:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010584b:	50                   	push   %eax
8010584c:	6a 00                	push   $0x0
8010584e:	e8 bd fc ff ff       	call   80105510 <argint>
80105853:	83 c4 10             	add    $0x10,%esp
80105856:	85 c0                	test   %eax,%eax
80105858:	78 36                	js     80105890 <sys_dup+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010585a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010585e:	77 30                	ja     80105890 <sys_dup+0x50>
80105860:	e8 7b e2 ff ff       	call   80103ae0 <myproc>
80105865:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105868:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010586c:	85 f6                	test   %esi,%esi
8010586e:	74 20                	je     80105890 <sys_dup+0x50>
  struct proc *curproc = myproc();
80105870:	e8 6b e2 ff ff       	call   80103ae0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105875:	31 db                	xor    %ebx,%ebx
80105877:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010587e:	00 
8010587f:	90                   	nop
    if(curproc->ofile[fd] == 0){
80105880:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105884:	85 d2                	test   %edx,%edx
80105886:	74 18                	je     801058a0 <sys_dup+0x60>
  for(fd = 0; fd < NOFILE; fd++){
80105888:	83 c3 01             	add    $0x1,%ebx
8010588b:	83 fb 10             	cmp    $0x10,%ebx
8010588e:	75 f0                	jne    80105880 <sys_dup+0x40>
}
80105890:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80105893:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105898:	89 d8                	mov    %ebx,%eax
8010589a:	5b                   	pop    %ebx
8010589b:	5e                   	pop    %esi
8010589c:	5d                   	pop    %ebp
8010589d:	c3                   	ret
8010589e:	66 90                	xchg   %ax,%ax
  filedup(f);
801058a0:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
801058a3:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
801058a7:	56                   	push   %esi
801058a8:	e8 23 b6 ff ff       	call   80100ed0 <filedup>
  return fd;
801058ad:	83 c4 10             	add    $0x10,%esp
}
801058b0:	8d 65 f8             	lea    -0x8(%ebp),%esp
801058b3:	89 d8                	mov    %ebx,%eax
801058b5:	5b                   	pop    %ebx
801058b6:	5e                   	pop    %esi
801058b7:	5d                   	pop    %ebp
801058b8:	c3                   	ret
801058b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801058c0 <sys_read>:
{
801058c0:	55                   	push   %ebp
801058c1:	89 e5                	mov    %esp,%ebp
801058c3:	56                   	push   %esi
801058c4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801058c5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
801058c8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801058cb:	53                   	push   %ebx
801058cc:	6a 00                	push   $0x0
801058ce:	e8 3d fc ff ff       	call   80105510 <argint>
801058d3:	83 c4 10             	add    $0x10,%esp
801058d6:	85 c0                	test   %eax,%eax
801058d8:	78 5e                	js     80105938 <sys_read+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801058da:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801058de:	77 58                	ja     80105938 <sys_read+0x78>
801058e0:	e8 fb e1 ff ff       	call   80103ae0 <myproc>
801058e5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801058e8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801058ec:	85 f6                	test   %esi,%esi
801058ee:	74 48                	je     80105938 <sys_read+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801058f0:	83 ec 08             	sub    $0x8,%esp
801058f3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801058f6:	50                   	push   %eax
801058f7:	6a 02                	push   $0x2
801058f9:	e8 12 fc ff ff       	call   80105510 <argint>
801058fe:	83 c4 10             	add    $0x10,%esp
80105901:	85 c0                	test   %eax,%eax
80105903:	78 33                	js     80105938 <sys_read+0x78>
80105905:	83 ec 04             	sub    $0x4,%esp
80105908:	ff 75 f0             	push   -0x10(%ebp)
8010590b:	53                   	push   %ebx
8010590c:	6a 01                	push   $0x1
8010590e:	e8 4d fc ff ff       	call   80105560 <argptr>
80105913:	83 c4 10             	add    $0x10,%esp
80105916:	85 c0                	test   %eax,%eax
80105918:	78 1e                	js     80105938 <sys_read+0x78>
  return fileread(f, p, n);
8010591a:	83 ec 04             	sub    $0x4,%esp
8010591d:	ff 75 f0             	push   -0x10(%ebp)
80105920:	ff 75 f4             	push   -0xc(%ebp)
80105923:	56                   	push   %esi
80105924:	e8 27 b7 ff ff       	call   80101050 <fileread>
80105929:	83 c4 10             	add    $0x10,%esp
}
8010592c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010592f:	5b                   	pop    %ebx
80105930:	5e                   	pop    %esi
80105931:	5d                   	pop    %ebp
80105932:	c3                   	ret
80105933:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return -1;
80105938:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010593d:	eb ed                	jmp    8010592c <sys_read+0x6c>
8010593f:	90                   	nop

80105940 <sys_write>:
{
80105940:	55                   	push   %ebp
80105941:	89 e5                	mov    %esp,%ebp
80105943:	56                   	push   %esi
80105944:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105945:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105948:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010594b:	53                   	push   %ebx
8010594c:	6a 00                	push   $0x0
8010594e:	e8 bd fb ff ff       	call   80105510 <argint>
80105953:	83 c4 10             	add    $0x10,%esp
80105956:	85 c0                	test   %eax,%eax
80105958:	78 5e                	js     801059b8 <sys_write+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010595a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010595e:	77 58                	ja     801059b8 <sys_write+0x78>
80105960:	e8 7b e1 ff ff       	call   80103ae0 <myproc>
80105965:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105968:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010596c:	85 f6                	test   %esi,%esi
8010596e:	74 48                	je     801059b8 <sys_write+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105970:	83 ec 08             	sub    $0x8,%esp
80105973:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105976:	50                   	push   %eax
80105977:	6a 02                	push   $0x2
80105979:	e8 92 fb ff ff       	call   80105510 <argint>
8010597e:	83 c4 10             	add    $0x10,%esp
80105981:	85 c0                	test   %eax,%eax
80105983:	78 33                	js     801059b8 <sys_write+0x78>
80105985:	83 ec 04             	sub    $0x4,%esp
80105988:	ff 75 f0             	push   -0x10(%ebp)
8010598b:	53                   	push   %ebx
8010598c:	6a 01                	push   $0x1
8010598e:	e8 cd fb ff ff       	call   80105560 <argptr>
80105993:	83 c4 10             	add    $0x10,%esp
80105996:	85 c0                	test   %eax,%eax
80105998:	78 1e                	js     801059b8 <sys_write+0x78>
  return filewrite(f, p, n);
8010599a:	83 ec 04             	sub    $0x4,%esp
8010599d:	ff 75 f0             	push   -0x10(%ebp)
801059a0:	ff 75 f4             	push   -0xc(%ebp)
801059a3:	56                   	push   %esi
801059a4:	e8 37 b7 ff ff       	call   801010e0 <filewrite>
801059a9:	83 c4 10             	add    $0x10,%esp
}
801059ac:	8d 65 f8             	lea    -0x8(%ebp),%esp
801059af:	5b                   	pop    %ebx
801059b0:	5e                   	pop    %esi
801059b1:	5d                   	pop    %ebp
801059b2:	c3                   	ret
801059b3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return -1;
801059b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059bd:	eb ed                	jmp    801059ac <sys_write+0x6c>
801059bf:	90                   	nop

801059c0 <sys_close>:
{
801059c0:	55                   	push   %ebp
801059c1:	89 e5                	mov    %esp,%ebp
801059c3:	56                   	push   %esi
801059c4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801059c5:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801059c8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801059cb:	50                   	push   %eax
801059cc:	6a 00                	push   $0x0
801059ce:	e8 3d fb ff ff       	call   80105510 <argint>
801059d3:	83 c4 10             	add    $0x10,%esp
801059d6:	85 c0                	test   %eax,%eax
801059d8:	78 3e                	js     80105a18 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801059da:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801059de:	77 38                	ja     80105a18 <sys_close+0x58>
801059e0:	e8 fb e0 ff ff       	call   80103ae0 <myproc>
801059e5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801059e8:	8d 5a 08             	lea    0x8(%edx),%ebx
801059eb:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
801059ef:	85 f6                	test   %esi,%esi
801059f1:	74 25                	je     80105a18 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
801059f3:	e8 e8 e0 ff ff       	call   80103ae0 <myproc>
  fileclose(f);
801059f8:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
801059fb:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
80105a02:	00 
  fileclose(f);
80105a03:	56                   	push   %esi
80105a04:	e8 17 b5 ff ff       	call   80100f20 <fileclose>
  return 0;
80105a09:	83 c4 10             	add    $0x10,%esp
80105a0c:	31 c0                	xor    %eax,%eax
}
80105a0e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105a11:	5b                   	pop    %ebx
80105a12:	5e                   	pop    %esi
80105a13:	5d                   	pop    %ebp
80105a14:	c3                   	ret
80105a15:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105a18:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a1d:	eb ef                	jmp    80105a0e <sys_close+0x4e>
80105a1f:	90                   	nop

80105a20 <sys_fstat>:
{
80105a20:	55                   	push   %ebp
80105a21:	89 e5                	mov    %esp,%ebp
80105a23:	56                   	push   %esi
80105a24:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105a25:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105a28:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80105a2b:	53                   	push   %ebx
80105a2c:	6a 00                	push   $0x0
80105a2e:	e8 dd fa ff ff       	call   80105510 <argint>
80105a33:	83 c4 10             	add    $0x10,%esp
80105a36:	85 c0                	test   %eax,%eax
80105a38:	78 46                	js     80105a80 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80105a3a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105a3e:	77 40                	ja     80105a80 <sys_fstat+0x60>
80105a40:	e8 9b e0 ff ff       	call   80103ae0 <myproc>
80105a45:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105a48:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80105a4c:	85 f6                	test   %esi,%esi
80105a4e:	74 30                	je     80105a80 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105a50:	83 ec 04             	sub    $0x4,%esp
80105a53:	6a 14                	push   $0x14
80105a55:	53                   	push   %ebx
80105a56:	6a 01                	push   $0x1
80105a58:	e8 03 fb ff ff       	call   80105560 <argptr>
80105a5d:	83 c4 10             	add    $0x10,%esp
80105a60:	85 c0                	test   %eax,%eax
80105a62:	78 1c                	js     80105a80 <sys_fstat+0x60>
  return filestat(f, st);
80105a64:	83 ec 08             	sub    $0x8,%esp
80105a67:	ff 75 f4             	push   -0xc(%ebp)
80105a6a:	56                   	push   %esi
80105a6b:	e8 90 b5 ff ff       	call   80101000 <filestat>
80105a70:	83 c4 10             	add    $0x10,%esp
}
80105a73:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105a76:	5b                   	pop    %ebx
80105a77:	5e                   	pop    %esi
80105a78:	5d                   	pop    %ebp
80105a79:	c3                   	ret
80105a7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105a80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a85:	eb ec                	jmp    80105a73 <sys_fstat+0x53>
80105a87:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105a8e:	00 
80105a8f:	90                   	nop

80105a90 <sys_link>:
{
80105a90:	55                   	push   %ebp
80105a91:	89 e5                	mov    %esp,%ebp
80105a93:	57                   	push   %edi
80105a94:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105a95:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105a98:	53                   	push   %ebx
80105a99:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105a9c:	50                   	push   %eax
80105a9d:	6a 00                	push   $0x0
80105a9f:	e8 2c fb ff ff       	call   801055d0 <argstr>
80105aa4:	83 c4 10             	add    $0x10,%esp
80105aa7:	85 c0                	test   %eax,%eax
80105aa9:	0f 88 fb 00 00 00    	js     80105baa <sys_link+0x11a>
80105aaf:	83 ec 08             	sub    $0x8,%esp
80105ab2:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105ab5:	50                   	push   %eax
80105ab6:	6a 01                	push   $0x1
80105ab8:	e8 13 fb ff ff       	call   801055d0 <argstr>
80105abd:	83 c4 10             	add    $0x10,%esp
80105ac0:	85 c0                	test   %eax,%eax
80105ac2:	0f 88 e2 00 00 00    	js     80105baa <sys_link+0x11a>
  begin_op();
80105ac8:	e8 83 d2 ff ff       	call   80102d50 <begin_op>
  if((ip = namei(old)) == 0){
80105acd:	83 ec 0c             	sub    $0xc,%esp
80105ad0:	ff 75 d4             	push   -0x2c(%ebp)
80105ad3:	e8 b8 c5 ff ff       	call   80102090 <namei>
80105ad8:	83 c4 10             	add    $0x10,%esp
80105adb:	89 c3                	mov    %eax,%ebx
80105add:	85 c0                	test   %eax,%eax
80105adf:	0f 84 df 00 00 00    	je     80105bc4 <sys_link+0x134>
  ilock(ip);
80105ae5:	83 ec 0c             	sub    $0xc,%esp
80105ae8:	50                   	push   %eax
80105ae9:	e8 c2 bc ff ff       	call   801017b0 <ilock>
  if(ip->type == T_DIR){
80105aee:	83 c4 10             	add    $0x10,%esp
80105af1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105af6:	0f 84 b5 00 00 00    	je     80105bb1 <sys_link+0x121>
  iupdate(ip);
80105afc:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
80105aff:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80105b04:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105b07:	53                   	push   %ebx
80105b08:	e8 f3 bb ff ff       	call   80101700 <iupdate>
  iunlock(ip);
80105b0d:	89 1c 24             	mov    %ebx,(%esp)
80105b10:	e8 7b bd ff ff       	call   80101890 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105b15:	58                   	pop    %eax
80105b16:	5a                   	pop    %edx
80105b17:	57                   	push   %edi
80105b18:	ff 75 d0             	push   -0x30(%ebp)
80105b1b:	e8 90 c5 ff ff       	call   801020b0 <nameiparent>
80105b20:	83 c4 10             	add    $0x10,%esp
80105b23:	89 c6                	mov    %eax,%esi
80105b25:	85 c0                	test   %eax,%eax
80105b27:	74 5b                	je     80105b84 <sys_link+0xf4>
  ilock(dp);
80105b29:	83 ec 0c             	sub    $0xc,%esp
80105b2c:	50                   	push   %eax
80105b2d:	e8 7e bc ff ff       	call   801017b0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105b32:	8b 03                	mov    (%ebx),%eax
80105b34:	83 c4 10             	add    $0x10,%esp
80105b37:	39 06                	cmp    %eax,(%esi)
80105b39:	75 3d                	jne    80105b78 <sys_link+0xe8>
80105b3b:	83 ec 04             	sub    $0x4,%esp
80105b3e:	ff 73 04             	push   0x4(%ebx)
80105b41:	57                   	push   %edi
80105b42:	56                   	push   %esi
80105b43:	e8 88 c4 ff ff       	call   80101fd0 <dirlink>
80105b48:	83 c4 10             	add    $0x10,%esp
80105b4b:	85 c0                	test   %eax,%eax
80105b4d:	78 29                	js     80105b78 <sys_link+0xe8>
  iunlockput(dp);
80105b4f:	83 ec 0c             	sub    $0xc,%esp
80105b52:	56                   	push   %esi
80105b53:	e8 e8 be ff ff       	call   80101a40 <iunlockput>
  iput(ip);
80105b58:	89 1c 24             	mov    %ebx,(%esp)
80105b5b:	e8 80 bd ff ff       	call   801018e0 <iput>
  end_op();
80105b60:	e8 5b d2 ff ff       	call   80102dc0 <end_op>
  return 0;
80105b65:	83 c4 10             	add    $0x10,%esp
80105b68:	31 c0                	xor    %eax,%eax
}
80105b6a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b6d:	5b                   	pop    %ebx
80105b6e:	5e                   	pop    %esi
80105b6f:	5f                   	pop    %edi
80105b70:	5d                   	pop    %ebp
80105b71:	c3                   	ret
80105b72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105b78:	83 ec 0c             	sub    $0xc,%esp
80105b7b:	56                   	push   %esi
80105b7c:	e8 bf be ff ff       	call   80101a40 <iunlockput>
    goto bad;
80105b81:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105b84:	83 ec 0c             	sub    $0xc,%esp
80105b87:	53                   	push   %ebx
80105b88:	e8 23 bc ff ff       	call   801017b0 <ilock>
  ip->nlink--;
80105b8d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105b92:	89 1c 24             	mov    %ebx,(%esp)
80105b95:	e8 66 bb ff ff       	call   80101700 <iupdate>
  iunlockput(ip);
80105b9a:	89 1c 24             	mov    %ebx,(%esp)
80105b9d:	e8 9e be ff ff       	call   80101a40 <iunlockput>
  end_op();
80105ba2:	e8 19 d2 ff ff       	call   80102dc0 <end_op>
  return -1;
80105ba7:	83 c4 10             	add    $0x10,%esp
    return -1;
80105baa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105baf:	eb b9                	jmp    80105b6a <sys_link+0xda>
    iunlockput(ip);
80105bb1:	83 ec 0c             	sub    $0xc,%esp
80105bb4:	53                   	push   %ebx
80105bb5:	e8 86 be ff ff       	call   80101a40 <iunlockput>
    end_op();
80105bba:	e8 01 d2 ff ff       	call   80102dc0 <end_op>
    return -1;
80105bbf:	83 c4 10             	add    $0x10,%esp
80105bc2:	eb e6                	jmp    80105baa <sys_link+0x11a>
    end_op();
80105bc4:	e8 f7 d1 ff ff       	call   80102dc0 <end_op>
    return -1;
80105bc9:	eb df                	jmp    80105baa <sys_link+0x11a>
80105bcb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105bd0 <sys_unlink>:
{
80105bd0:	55                   	push   %ebp
80105bd1:	89 e5                	mov    %esp,%ebp
80105bd3:	57                   	push   %edi
80105bd4:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80105bd5:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105bd8:	53                   	push   %ebx
80105bd9:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
80105bdc:	50                   	push   %eax
80105bdd:	6a 00                	push   $0x0
80105bdf:	e8 ec f9 ff ff       	call   801055d0 <argstr>
80105be4:	83 c4 10             	add    $0x10,%esp
80105be7:	85 c0                	test   %eax,%eax
80105be9:	0f 88 54 01 00 00    	js     80105d43 <sys_unlink+0x173>
  begin_op();
80105bef:	e8 5c d1 ff ff       	call   80102d50 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105bf4:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80105bf7:	83 ec 08             	sub    $0x8,%esp
80105bfa:	53                   	push   %ebx
80105bfb:	ff 75 c0             	push   -0x40(%ebp)
80105bfe:	e8 ad c4 ff ff       	call   801020b0 <nameiparent>
80105c03:	83 c4 10             	add    $0x10,%esp
80105c06:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80105c09:	85 c0                	test   %eax,%eax
80105c0b:	0f 84 58 01 00 00    	je     80105d69 <sys_unlink+0x199>
  ilock(dp);
80105c11:	8b 7d b4             	mov    -0x4c(%ebp),%edi
80105c14:	83 ec 0c             	sub    $0xc,%esp
80105c17:	57                   	push   %edi
80105c18:	e8 93 bb ff ff       	call   801017b0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105c1d:	58                   	pop    %eax
80105c1e:	5a                   	pop    %edx
80105c1f:	68 ef 81 10 80       	push   $0x801081ef
80105c24:	53                   	push   %ebx
80105c25:	e8 b6 c0 ff ff       	call   80101ce0 <namecmp>
80105c2a:	83 c4 10             	add    $0x10,%esp
80105c2d:	85 c0                	test   %eax,%eax
80105c2f:	0f 84 fb 00 00 00    	je     80105d30 <sys_unlink+0x160>
80105c35:	83 ec 08             	sub    $0x8,%esp
80105c38:	68 ee 81 10 80       	push   $0x801081ee
80105c3d:	53                   	push   %ebx
80105c3e:	e8 9d c0 ff ff       	call   80101ce0 <namecmp>
80105c43:	83 c4 10             	add    $0x10,%esp
80105c46:	85 c0                	test   %eax,%eax
80105c48:	0f 84 e2 00 00 00    	je     80105d30 <sys_unlink+0x160>
  if((ip = dirlookup(dp, name, &off)) == 0)
80105c4e:	83 ec 04             	sub    $0x4,%esp
80105c51:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105c54:	50                   	push   %eax
80105c55:	53                   	push   %ebx
80105c56:	57                   	push   %edi
80105c57:	e8 a4 c0 ff ff       	call   80101d00 <dirlookup>
80105c5c:	83 c4 10             	add    $0x10,%esp
80105c5f:	89 c3                	mov    %eax,%ebx
80105c61:	85 c0                	test   %eax,%eax
80105c63:	0f 84 c7 00 00 00    	je     80105d30 <sys_unlink+0x160>
  ilock(ip);
80105c69:	83 ec 0c             	sub    $0xc,%esp
80105c6c:	50                   	push   %eax
80105c6d:	e8 3e bb ff ff       	call   801017b0 <ilock>
  if(ip->nlink < 1)
80105c72:	83 c4 10             	add    $0x10,%esp
80105c75:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105c7a:	0f 8e 0a 01 00 00    	jle    80105d8a <sys_unlink+0x1ba>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105c80:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105c85:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105c88:	74 66                	je     80105cf0 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80105c8a:	83 ec 04             	sub    $0x4,%esp
80105c8d:	6a 10                	push   $0x10
80105c8f:	6a 00                	push   $0x0
80105c91:	57                   	push   %edi
80105c92:	e8 c9 f5 ff ff       	call   80105260 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105c97:	6a 10                	push   $0x10
80105c99:	ff 75 c4             	push   -0x3c(%ebp)
80105c9c:	57                   	push   %edi
80105c9d:	ff 75 b4             	push   -0x4c(%ebp)
80105ca0:	e8 1b bf ff ff       	call   80101bc0 <writei>
80105ca5:	83 c4 20             	add    $0x20,%esp
80105ca8:	83 f8 10             	cmp    $0x10,%eax
80105cab:	0f 85 cc 00 00 00    	jne    80105d7d <sys_unlink+0x1ad>
  if(ip->type == T_DIR){
80105cb1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105cb6:	0f 84 94 00 00 00    	je     80105d50 <sys_unlink+0x180>
  iunlockput(dp);
80105cbc:	83 ec 0c             	sub    $0xc,%esp
80105cbf:	ff 75 b4             	push   -0x4c(%ebp)
80105cc2:	e8 79 bd ff ff       	call   80101a40 <iunlockput>
  ip->nlink--;
80105cc7:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105ccc:	89 1c 24             	mov    %ebx,(%esp)
80105ccf:	e8 2c ba ff ff       	call   80101700 <iupdate>
  iunlockput(ip);
80105cd4:	89 1c 24             	mov    %ebx,(%esp)
80105cd7:	e8 64 bd ff ff       	call   80101a40 <iunlockput>
  end_op();
80105cdc:	e8 df d0 ff ff       	call   80102dc0 <end_op>
  return 0;
80105ce1:	83 c4 10             	add    $0x10,%esp
80105ce4:	31 c0                	xor    %eax,%eax
}
80105ce6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ce9:	5b                   	pop    %ebx
80105cea:	5e                   	pop    %esi
80105ceb:	5f                   	pop    %edi
80105cec:	5d                   	pop    %ebp
80105ced:	c3                   	ret
80105cee:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105cf0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105cf4:	76 94                	jbe    80105c8a <sys_unlink+0xba>
80105cf6:	be 20 00 00 00       	mov    $0x20,%esi
80105cfb:	eb 0b                	jmp    80105d08 <sys_unlink+0x138>
80105cfd:	8d 76 00             	lea    0x0(%esi),%esi
80105d00:	83 c6 10             	add    $0x10,%esi
80105d03:	3b 73 58             	cmp    0x58(%ebx),%esi
80105d06:	73 82                	jae    80105c8a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105d08:	6a 10                	push   $0x10
80105d0a:	56                   	push   %esi
80105d0b:	57                   	push   %edi
80105d0c:	53                   	push   %ebx
80105d0d:	e8 ae bd ff ff       	call   80101ac0 <readi>
80105d12:	83 c4 10             	add    $0x10,%esp
80105d15:	83 f8 10             	cmp    $0x10,%eax
80105d18:	75 56                	jne    80105d70 <sys_unlink+0x1a0>
    if(de.inum != 0)
80105d1a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105d1f:	74 df                	je     80105d00 <sys_unlink+0x130>
    iunlockput(ip);
80105d21:	83 ec 0c             	sub    $0xc,%esp
80105d24:	53                   	push   %ebx
80105d25:	e8 16 bd ff ff       	call   80101a40 <iunlockput>
    goto bad;
80105d2a:	83 c4 10             	add    $0x10,%esp
80105d2d:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
80105d30:	83 ec 0c             	sub    $0xc,%esp
80105d33:	ff 75 b4             	push   -0x4c(%ebp)
80105d36:	e8 05 bd ff ff       	call   80101a40 <iunlockput>
  end_op();
80105d3b:	e8 80 d0 ff ff       	call   80102dc0 <end_op>
  return -1;
80105d40:	83 c4 10             	add    $0x10,%esp
    return -1;
80105d43:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d48:	eb 9c                	jmp    80105ce6 <sys_unlink+0x116>
80105d4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
80105d50:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
80105d53:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105d56:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
80105d5b:	50                   	push   %eax
80105d5c:	e8 9f b9 ff ff       	call   80101700 <iupdate>
80105d61:	83 c4 10             	add    $0x10,%esp
80105d64:	e9 53 ff ff ff       	jmp    80105cbc <sys_unlink+0xec>
    end_op();
80105d69:	e8 52 d0 ff ff       	call   80102dc0 <end_op>
    return -1;
80105d6e:	eb d3                	jmp    80105d43 <sys_unlink+0x173>
      panic("isdirempty: readi");
80105d70:	83 ec 0c             	sub    $0xc,%esp
80105d73:	68 13 82 10 80       	push   $0x80108213
80105d78:	e8 03 a6 ff ff       	call   80100380 <panic>
    panic("unlink: writei");
80105d7d:	83 ec 0c             	sub    $0xc,%esp
80105d80:	68 25 82 10 80       	push   $0x80108225
80105d85:	e8 f6 a5 ff ff       	call   80100380 <panic>
    panic("unlink: nlink < 1");
80105d8a:	83 ec 0c             	sub    $0xc,%esp
80105d8d:	68 01 82 10 80       	push   $0x80108201
80105d92:	e8 e9 a5 ff ff       	call   80100380 <panic>
80105d97:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105d9e:	00 
80105d9f:	90                   	nop

80105da0 <sys_open>:

int
sys_open(void)
{
80105da0:	55                   	push   %ebp
80105da1:	89 e5                	mov    %esp,%ebp
80105da3:	57                   	push   %edi
80105da4:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105da5:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105da8:	53                   	push   %ebx
80105da9:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105dac:	50                   	push   %eax
80105dad:	6a 00                	push   $0x0
80105daf:	e8 1c f8 ff ff       	call   801055d0 <argstr>
80105db4:	83 c4 10             	add    $0x10,%esp
80105db7:	85 c0                	test   %eax,%eax
80105db9:	0f 88 8e 00 00 00    	js     80105e4d <sys_open+0xad>
80105dbf:	83 ec 08             	sub    $0x8,%esp
80105dc2:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105dc5:	50                   	push   %eax
80105dc6:	6a 01                	push   $0x1
80105dc8:	e8 43 f7 ff ff       	call   80105510 <argint>
80105dcd:	83 c4 10             	add    $0x10,%esp
80105dd0:	85 c0                	test   %eax,%eax
80105dd2:	78 79                	js     80105e4d <sys_open+0xad>
    return -1;

  begin_op();
80105dd4:	e8 77 cf ff ff       	call   80102d50 <begin_op>

  if(omode & O_CREATE){
80105dd9:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105ddd:	75 79                	jne    80105e58 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105ddf:	83 ec 0c             	sub    $0xc,%esp
80105de2:	ff 75 e0             	push   -0x20(%ebp)
80105de5:	e8 a6 c2 ff ff       	call   80102090 <namei>
80105dea:	83 c4 10             	add    $0x10,%esp
80105ded:	89 c6                	mov    %eax,%esi
80105def:	85 c0                	test   %eax,%eax
80105df1:	0f 84 7e 00 00 00    	je     80105e75 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
80105df7:	83 ec 0c             	sub    $0xc,%esp
80105dfa:	50                   	push   %eax
80105dfb:	e8 b0 b9 ff ff       	call   801017b0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105e00:	83 c4 10             	add    $0x10,%esp
80105e03:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105e08:	0f 84 ba 00 00 00    	je     80105ec8 <sys_open+0x128>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105e0e:	e8 4d b0 ff ff       	call   80100e60 <filealloc>
80105e13:	89 c7                	mov    %eax,%edi
80105e15:	85 c0                	test   %eax,%eax
80105e17:	74 23                	je     80105e3c <sys_open+0x9c>
  struct proc *curproc = myproc();
80105e19:	e8 c2 dc ff ff       	call   80103ae0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105e1e:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80105e20:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105e24:	85 d2                	test   %edx,%edx
80105e26:	74 58                	je     80105e80 <sys_open+0xe0>
  for(fd = 0; fd < NOFILE; fd++){
80105e28:	83 c3 01             	add    $0x1,%ebx
80105e2b:	83 fb 10             	cmp    $0x10,%ebx
80105e2e:	75 f0                	jne    80105e20 <sys_open+0x80>
    if(f)
      fileclose(f);
80105e30:	83 ec 0c             	sub    $0xc,%esp
80105e33:	57                   	push   %edi
80105e34:	e8 e7 b0 ff ff       	call   80100f20 <fileclose>
80105e39:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80105e3c:	83 ec 0c             	sub    $0xc,%esp
80105e3f:	56                   	push   %esi
80105e40:	e8 fb bb ff ff       	call   80101a40 <iunlockput>
    end_op();
80105e45:	e8 76 cf ff ff       	call   80102dc0 <end_op>
    return -1;
80105e4a:	83 c4 10             	add    $0x10,%esp
    return -1;
80105e4d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105e52:	eb 65                	jmp    80105eb9 <sys_open+0x119>
80105e54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105e58:	83 ec 0c             	sub    $0xc,%esp
80105e5b:	31 c9                	xor    %ecx,%ecx
80105e5d:	ba 02 00 00 00       	mov    $0x2,%edx
80105e62:	6a 00                	push   $0x0
80105e64:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105e67:	e8 54 f8 ff ff       	call   801056c0 <create>
    if(ip == 0){
80105e6c:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
80105e6f:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105e71:	85 c0                	test   %eax,%eax
80105e73:	75 99                	jne    80105e0e <sys_open+0x6e>
      end_op();
80105e75:	e8 46 cf ff ff       	call   80102dc0 <end_op>
      return -1;
80105e7a:	eb d1                	jmp    80105e4d <sys_open+0xad>
80105e7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105e80:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105e83:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
80105e87:	56                   	push   %esi
80105e88:	e8 03 ba ff ff       	call   80101890 <iunlock>
  end_op();
80105e8d:	e8 2e cf ff ff       	call   80102dc0 <end_op>

  f->type = FD_INODE;
80105e92:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105e98:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105e9b:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105e9e:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80105ea1:	89 d0                	mov    %edx,%eax
  f->off = 0;
80105ea3:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105eaa:	f7 d0                	not    %eax
80105eac:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105eaf:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105eb2:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105eb5:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105eb9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ebc:	89 d8                	mov    %ebx,%eax
80105ebe:	5b                   	pop    %ebx
80105ebf:	5e                   	pop    %esi
80105ec0:	5f                   	pop    %edi
80105ec1:	5d                   	pop    %ebp
80105ec2:	c3                   	ret
80105ec3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105ec8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105ecb:	85 c9                	test   %ecx,%ecx
80105ecd:	0f 84 3b ff ff ff    	je     80105e0e <sys_open+0x6e>
80105ed3:	e9 64 ff ff ff       	jmp    80105e3c <sys_open+0x9c>
80105ed8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105edf:	00 

80105ee0 <sys_mkdir>:

int
sys_mkdir(void)
{
80105ee0:	55                   	push   %ebp
80105ee1:	89 e5                	mov    %esp,%ebp
80105ee3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105ee6:	e8 65 ce ff ff       	call   80102d50 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80105eeb:	83 ec 08             	sub    $0x8,%esp
80105eee:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105ef1:	50                   	push   %eax
80105ef2:	6a 00                	push   $0x0
80105ef4:	e8 d7 f6 ff ff       	call   801055d0 <argstr>
80105ef9:	83 c4 10             	add    $0x10,%esp
80105efc:	85 c0                	test   %eax,%eax
80105efe:	78 30                	js     80105f30 <sys_mkdir+0x50>
80105f00:	83 ec 0c             	sub    $0xc,%esp
80105f03:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f06:	31 c9                	xor    %ecx,%ecx
80105f08:	ba 01 00 00 00       	mov    $0x1,%edx
80105f0d:	6a 00                	push   $0x0
80105f0f:	e8 ac f7 ff ff       	call   801056c0 <create>
80105f14:	83 c4 10             	add    $0x10,%esp
80105f17:	85 c0                	test   %eax,%eax
80105f19:	74 15                	je     80105f30 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105f1b:	83 ec 0c             	sub    $0xc,%esp
80105f1e:	50                   	push   %eax
80105f1f:	e8 1c bb ff ff       	call   80101a40 <iunlockput>
  end_op();
80105f24:	e8 97 ce ff ff       	call   80102dc0 <end_op>
  return 0;
80105f29:	83 c4 10             	add    $0x10,%esp
80105f2c:	31 c0                	xor    %eax,%eax
}
80105f2e:	c9                   	leave
80105f2f:	c3                   	ret
    end_op();
80105f30:	e8 8b ce ff ff       	call   80102dc0 <end_op>
    return -1;
80105f35:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105f3a:	c9                   	leave
80105f3b:	c3                   	ret
80105f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105f40 <sys_mknod>:

int
sys_mknod(void)
{
80105f40:	55                   	push   %ebp
80105f41:	89 e5                	mov    %esp,%ebp
80105f43:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105f46:	e8 05 ce ff ff       	call   80102d50 <begin_op>
  if((argstr(0, &path)) < 0 ||
80105f4b:	83 ec 08             	sub    $0x8,%esp
80105f4e:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105f51:	50                   	push   %eax
80105f52:	6a 00                	push   $0x0
80105f54:	e8 77 f6 ff ff       	call   801055d0 <argstr>
80105f59:	83 c4 10             	add    $0x10,%esp
80105f5c:	85 c0                	test   %eax,%eax
80105f5e:	78 60                	js     80105fc0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105f60:	83 ec 08             	sub    $0x8,%esp
80105f63:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105f66:	50                   	push   %eax
80105f67:	6a 01                	push   $0x1
80105f69:	e8 a2 f5 ff ff       	call   80105510 <argint>
  if((argstr(0, &path)) < 0 ||
80105f6e:	83 c4 10             	add    $0x10,%esp
80105f71:	85 c0                	test   %eax,%eax
80105f73:	78 4b                	js     80105fc0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105f75:	83 ec 08             	sub    $0x8,%esp
80105f78:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105f7b:	50                   	push   %eax
80105f7c:	6a 02                	push   $0x2
80105f7e:	e8 8d f5 ff ff       	call   80105510 <argint>
     argint(1, &major) < 0 ||
80105f83:	83 c4 10             	add    $0x10,%esp
80105f86:	85 c0                	test   %eax,%eax
80105f88:	78 36                	js     80105fc0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80105f8a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80105f8e:	83 ec 0c             	sub    $0xc,%esp
80105f91:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105f95:	ba 03 00 00 00       	mov    $0x3,%edx
80105f9a:	50                   	push   %eax
80105f9b:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105f9e:	e8 1d f7 ff ff       	call   801056c0 <create>
     argint(2, &minor) < 0 ||
80105fa3:	83 c4 10             	add    $0x10,%esp
80105fa6:	85 c0                	test   %eax,%eax
80105fa8:	74 16                	je     80105fc0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105faa:	83 ec 0c             	sub    $0xc,%esp
80105fad:	50                   	push   %eax
80105fae:	e8 8d ba ff ff       	call   80101a40 <iunlockput>
  end_op();
80105fb3:	e8 08 ce ff ff       	call   80102dc0 <end_op>
  return 0;
80105fb8:	83 c4 10             	add    $0x10,%esp
80105fbb:	31 c0                	xor    %eax,%eax
}
80105fbd:	c9                   	leave
80105fbe:	c3                   	ret
80105fbf:	90                   	nop
    end_op();
80105fc0:	e8 fb cd ff ff       	call   80102dc0 <end_op>
    return -1;
80105fc5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105fca:	c9                   	leave
80105fcb:	c3                   	ret
80105fcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105fd0 <sys_chdir>:

int
sys_chdir(void)
{
80105fd0:	55                   	push   %ebp
80105fd1:	89 e5                	mov    %esp,%ebp
80105fd3:	56                   	push   %esi
80105fd4:	53                   	push   %ebx
80105fd5:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105fd8:	e8 03 db ff ff       	call   80103ae0 <myproc>
80105fdd:	89 c6                	mov    %eax,%esi
  
  begin_op();
80105fdf:	e8 6c cd ff ff       	call   80102d50 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105fe4:	83 ec 08             	sub    $0x8,%esp
80105fe7:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105fea:	50                   	push   %eax
80105feb:	6a 00                	push   $0x0
80105fed:	e8 de f5 ff ff       	call   801055d0 <argstr>
80105ff2:	83 c4 10             	add    $0x10,%esp
80105ff5:	85 c0                	test   %eax,%eax
80105ff7:	78 77                	js     80106070 <sys_chdir+0xa0>
80105ff9:	83 ec 0c             	sub    $0xc,%esp
80105ffc:	ff 75 f4             	push   -0xc(%ebp)
80105fff:	e8 8c c0 ff ff       	call   80102090 <namei>
80106004:	83 c4 10             	add    $0x10,%esp
80106007:	89 c3                	mov    %eax,%ebx
80106009:	85 c0                	test   %eax,%eax
8010600b:	74 63                	je     80106070 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010600d:	83 ec 0c             	sub    $0xc,%esp
80106010:	50                   	push   %eax
80106011:	e8 9a b7 ff ff       	call   801017b0 <ilock>
  if(ip->type != T_DIR){
80106016:	83 c4 10             	add    $0x10,%esp
80106019:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010601e:	75 30                	jne    80106050 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80106020:	83 ec 0c             	sub    $0xc,%esp
80106023:	53                   	push   %ebx
80106024:	e8 67 b8 ff ff       	call   80101890 <iunlock>
  iput(curproc->cwd);
80106029:	58                   	pop    %eax
8010602a:	ff 76 68             	push   0x68(%esi)
8010602d:	e8 ae b8 ff ff       	call   801018e0 <iput>
  end_op();
80106032:	e8 89 cd ff ff       	call   80102dc0 <end_op>
  curproc->cwd = ip;
80106037:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010603a:	83 c4 10             	add    $0x10,%esp
8010603d:	31 c0                	xor    %eax,%eax
}
8010603f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106042:	5b                   	pop    %ebx
80106043:	5e                   	pop    %esi
80106044:	5d                   	pop    %ebp
80106045:	c3                   	ret
80106046:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010604d:	00 
8010604e:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80106050:	83 ec 0c             	sub    $0xc,%esp
80106053:	53                   	push   %ebx
80106054:	e8 e7 b9 ff ff       	call   80101a40 <iunlockput>
    end_op();
80106059:	e8 62 cd ff ff       	call   80102dc0 <end_op>
    return -1;
8010605e:	83 c4 10             	add    $0x10,%esp
    return -1;
80106061:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106066:	eb d7                	jmp    8010603f <sys_chdir+0x6f>
80106068:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010606f:	00 
    end_op();
80106070:	e8 4b cd ff ff       	call   80102dc0 <end_op>
    return -1;
80106075:	eb ea                	jmp    80106061 <sys_chdir+0x91>
80106077:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010607e:	00 
8010607f:	90                   	nop

80106080 <sys_exec>:

int
sys_exec(void)
{
80106080:	55                   	push   %ebp
80106081:	89 e5                	mov    %esp,%ebp
80106083:	57                   	push   %edi
80106084:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106085:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010608b:	53                   	push   %ebx
8010608c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106092:	50                   	push   %eax
80106093:	6a 00                	push   $0x0
80106095:	e8 36 f5 ff ff       	call   801055d0 <argstr>
8010609a:	83 c4 10             	add    $0x10,%esp
8010609d:	85 c0                	test   %eax,%eax
8010609f:	0f 88 87 00 00 00    	js     8010612c <sys_exec+0xac>
801060a5:	83 ec 08             	sub    $0x8,%esp
801060a8:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801060ae:	50                   	push   %eax
801060af:	6a 01                	push   $0x1
801060b1:	e8 5a f4 ff ff       	call   80105510 <argint>
801060b6:	83 c4 10             	add    $0x10,%esp
801060b9:	85 c0                	test   %eax,%eax
801060bb:	78 6f                	js     8010612c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801060bd:	83 ec 04             	sub    $0x4,%esp
801060c0:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
801060c6:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
801060c8:	68 80 00 00 00       	push   $0x80
801060cd:	6a 00                	push   $0x0
801060cf:	56                   	push   %esi
801060d0:	e8 8b f1 ff ff       	call   80105260 <memset>
801060d5:	83 c4 10             	add    $0x10,%esp
801060d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801060df:	00 
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801060e0:	83 ec 08             	sub    $0x8,%esp
801060e3:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
801060e9:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
801060f0:	50                   	push   %eax
801060f1:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801060f7:	01 f8                	add    %edi,%eax
801060f9:	50                   	push   %eax
801060fa:	e8 81 f3 ff ff       	call   80105480 <fetchint>
801060ff:	83 c4 10             	add    $0x10,%esp
80106102:	85 c0                	test   %eax,%eax
80106104:	78 26                	js     8010612c <sys_exec+0xac>
      return -1;
    if(uarg == 0){
80106106:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010610c:	85 c0                	test   %eax,%eax
8010610e:	74 30                	je     80106140 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80106110:	83 ec 08             	sub    $0x8,%esp
80106113:	8d 14 3e             	lea    (%esi,%edi,1),%edx
80106116:	52                   	push   %edx
80106117:	50                   	push   %eax
80106118:	e8 a3 f3 ff ff       	call   801054c0 <fetchstr>
8010611d:	83 c4 10             	add    $0x10,%esp
80106120:	85 c0                	test   %eax,%eax
80106122:	78 08                	js     8010612c <sys_exec+0xac>
  for(i=0;; i++){
80106124:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80106127:	83 fb 20             	cmp    $0x20,%ebx
8010612a:	75 b4                	jne    801060e0 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010612c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010612f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106134:	5b                   	pop    %ebx
80106135:	5e                   	pop    %esi
80106136:	5f                   	pop    %edi
80106137:	5d                   	pop    %ebp
80106138:	c3                   	ret
80106139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
80106140:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80106147:	00 00 00 00 
  return exec(path, argv);
8010614b:	83 ec 08             	sub    $0x8,%esp
8010614e:	56                   	push   %esi
8010614f:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
80106155:	e8 56 a9 ff ff       	call   80100ab0 <exec>
8010615a:	83 c4 10             	add    $0x10,%esp
}
8010615d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106160:	5b                   	pop    %ebx
80106161:	5e                   	pop    %esi
80106162:	5f                   	pop    %edi
80106163:	5d                   	pop    %ebp
80106164:	c3                   	ret
80106165:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010616c:	00 
8010616d:	8d 76 00             	lea    0x0(%esi),%esi

80106170 <sys_pipe>:

int
sys_pipe(void)
{
80106170:	55                   	push   %ebp
80106171:	89 e5                	mov    %esp,%ebp
80106173:	57                   	push   %edi
80106174:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106175:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80106178:	53                   	push   %ebx
80106179:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010617c:	6a 08                	push   $0x8
8010617e:	50                   	push   %eax
8010617f:	6a 00                	push   $0x0
80106181:	e8 da f3 ff ff       	call   80105560 <argptr>
80106186:	83 c4 10             	add    $0x10,%esp
80106189:	85 c0                	test   %eax,%eax
8010618b:	0f 88 8b 00 00 00    	js     8010621c <sys_pipe+0xac>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80106191:	83 ec 08             	sub    $0x8,%esp
80106194:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106197:	50                   	push   %eax
80106198:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010619b:	50                   	push   %eax
8010619c:	e8 df d2 ff ff       	call   80103480 <pipealloc>
801061a1:	83 c4 10             	add    $0x10,%esp
801061a4:	85 c0                	test   %eax,%eax
801061a6:	78 74                	js     8010621c <sys_pipe+0xac>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801061a8:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
801061ab:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801061ad:	e8 2e d9 ff ff       	call   80103ae0 <myproc>
    if(curproc->ofile[fd] == 0){
801061b2:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801061b6:	85 f6                	test   %esi,%esi
801061b8:	74 16                	je     801061d0 <sys_pipe+0x60>
801061ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
801061c0:	83 c3 01             	add    $0x1,%ebx
801061c3:	83 fb 10             	cmp    $0x10,%ebx
801061c6:	74 3d                	je     80106205 <sys_pipe+0x95>
    if(curproc->ofile[fd] == 0){
801061c8:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801061cc:	85 f6                	test   %esi,%esi
801061ce:	75 f0                	jne    801061c0 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
801061d0:	8d 73 08             	lea    0x8(%ebx),%esi
801061d3:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801061d7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
801061da:	e8 01 d9 ff ff       	call   80103ae0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801061df:	31 d2                	xor    %edx,%edx
801061e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
801061e8:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801061ec:	85 c9                	test   %ecx,%ecx
801061ee:	74 38                	je     80106228 <sys_pipe+0xb8>
  for(fd = 0; fd < NOFILE; fd++){
801061f0:	83 c2 01             	add    $0x1,%edx
801061f3:	83 fa 10             	cmp    $0x10,%edx
801061f6:	75 f0                	jne    801061e8 <sys_pipe+0x78>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
801061f8:	e8 e3 d8 ff ff       	call   80103ae0 <myproc>
801061fd:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80106204:	00 
    fileclose(rf);
80106205:	83 ec 0c             	sub    $0xc,%esp
80106208:	ff 75 e0             	push   -0x20(%ebp)
8010620b:	e8 10 ad ff ff       	call   80100f20 <fileclose>
    fileclose(wf);
80106210:	58                   	pop    %eax
80106211:	ff 75 e4             	push   -0x1c(%ebp)
80106214:	e8 07 ad ff ff       	call   80100f20 <fileclose>
    return -1;
80106219:	83 c4 10             	add    $0x10,%esp
    return -1;
8010621c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106221:	eb 16                	jmp    80106239 <sys_pipe+0xc9>
80106223:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      curproc->ofile[fd] = f;
80106228:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
8010622c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010622f:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80106231:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106234:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80106237:	31 c0                	xor    %eax,%eax
}
80106239:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010623c:	5b                   	pop    %ebx
8010623d:	5e                   	pop    %esi
8010623e:	5f                   	pop    %edi
8010623f:	5d                   	pop    %ebp
80106240:	c3                   	ret
80106241:	66 90                	xchg   %ax,%ax
80106243:	66 90                	xchg   %ax,%ax
80106245:	66 90                	xchg   %ax,%ax
80106247:	66 90                	xchg   %ax,%ax
80106249:	66 90                	xchg   %ax,%ax
8010624b:	66 90                	xchg   %ax,%ax
8010624d:	66 90                	xchg   %ax,%ax
8010624f:	90                   	nop

80106250 <sys_fork>:
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80106250:	e9 3b da ff ff       	jmp    80103c90 <fork>
80106255:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010625c:	00 
8010625d:	8d 76 00             	lea    0x0(%esi),%esi

80106260 <sys_exit>:
}

int
sys_exit(void)
{
80106260:	55                   	push   %ebp
80106261:	89 e5                	mov    %esp,%ebp
80106263:	83 ec 08             	sub    $0x8,%esp
  exit();
80106266:	e8 c5 e2 ff ff       	call   80104530 <exit>
  return 0;  // not reached
}
8010626b:	31 c0                	xor    %eax,%eax
8010626d:	c9                   	leave
8010626e:	c3                   	ret
8010626f:	90                   	nop

80106270 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80106270:	e9 fb e3 ff ff       	jmp    80104670 <wait>
80106275:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010627c:	00 
8010627d:	8d 76 00             	lea    0x0(%esi),%esi

80106280 <sys_waitx>:
}

int sys_waitx(void)
{
80106280:	55                   	push   %ebp
80106281:	89 e5                	mov    %esp,%ebp
80106283:	83 ec 1c             	sub    $0x1c,%esp
  int *wtime;
  int *rtime;

  if(argptr(0, (char**)&wtime, sizeof(int)) < 0)
80106286:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106289:	6a 04                	push   $0x4
8010628b:	50                   	push   %eax
8010628c:	6a 00                	push   $0x0
8010628e:	e8 cd f2 ff ff       	call   80105560 <argptr>
80106293:	83 c4 10             	add    $0x10,%esp
80106296:	85 c0                	test   %eax,%eax
80106298:	78 2e                	js     801062c8 <sys_waitx+0x48>
    return -2;
  if(argptr(1, (char**)&rtime, sizeof(int)) < 0)
8010629a:	83 ec 04             	sub    $0x4,%esp
8010629d:	8d 45 f4             	lea    -0xc(%ebp),%eax
801062a0:	6a 04                	push   $0x4
801062a2:	50                   	push   %eax
801062a3:	6a 01                	push   $0x1
801062a5:	e8 b6 f2 ff ff       	call   80105560 <argptr>
801062aa:	83 c4 10             	add    $0x10,%esp
801062ad:	85 c0                	test   %eax,%eax
801062af:	78 17                	js     801062c8 <sys_waitx+0x48>
    return -2;

  return waitx(wtime, rtime);
801062b1:	83 ec 08             	sub    $0x8,%esp
801062b4:	ff 75 f4             	push   -0xc(%ebp)
801062b7:	ff 75 f0             	push   -0x10(%ebp)
801062ba:	e8 01 e5 ff ff       	call   801047c0 <waitx>
801062bf:	83 c4 10             	add    $0x10,%esp
}
801062c2:	c9                   	leave
801062c3:	c3                   	ret
801062c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801062c8:	c9                   	leave
    return -2;
801062c9:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
}
801062ce:	c3                   	ret
801062cf:	90                   	nop

801062d0 <sys_kill>:

int
sys_kill(void)
{
801062d0:	55                   	push   %ebp
801062d1:	89 e5                	mov    %esp,%ebp
801062d3:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
801062d6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801062d9:	50                   	push   %eax
801062da:	6a 00                	push   $0x0
801062dc:	e8 2f f2 ff ff       	call   80105510 <argint>
801062e1:	83 c4 10             	add    $0x10,%esp
801062e4:	85 c0                	test   %eax,%eax
801062e6:	78 18                	js     80106300 <sys_kill+0x30>
    return -1;
  return kill(pid);
801062e8:	83 ec 0c             	sub    $0xc,%esp
801062eb:	ff 75 f4             	push   -0xc(%ebp)
801062ee:	e8 ad e7 ff ff       	call   80104aa0 <kill>
801062f3:	83 c4 10             	add    $0x10,%esp
}
801062f6:	c9                   	leave
801062f7:	c3                   	ret
801062f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801062ff:	00 
80106300:	c9                   	leave
    return -1;
80106301:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106306:	c3                   	ret
80106307:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010630e:	00 
8010630f:	90                   	nop

80106310 <sys_getpid>:

int
sys_getpid(void)
{
80106310:	55                   	push   %ebp
80106311:	89 e5                	mov    %esp,%ebp
80106313:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80106316:	e8 c5 d7 ff ff       	call   80103ae0 <myproc>
8010631b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010631e:	c9                   	leave
8010631f:	c3                   	ret

80106320 <sys_sbrk>:

int
sys_sbrk(void)
{
80106320:	55                   	push   %ebp
80106321:	89 e5                	mov    %esp,%ebp
80106323:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106324:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106327:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010632a:	50                   	push   %eax
8010632b:	6a 00                	push   $0x0
8010632d:	e8 de f1 ff ff       	call   80105510 <argint>
80106332:	83 c4 10             	add    $0x10,%esp
80106335:	85 c0                	test   %eax,%eax
80106337:	78 27                	js     80106360 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80106339:	e8 a2 d7 ff ff       	call   80103ae0 <myproc>
  if(growproc(n) < 0)
8010633e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80106341:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80106343:	ff 75 f4             	push   -0xc(%ebp)
80106346:	e8 c5 d8 ff ff       	call   80103c10 <growproc>
8010634b:	83 c4 10             	add    $0x10,%esp
8010634e:	85 c0                	test   %eax,%eax
80106350:	78 0e                	js     80106360 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80106352:	89 d8                	mov    %ebx,%eax
80106354:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106357:	c9                   	leave
80106358:	c3                   	ret
80106359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106360:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106365:	eb eb                	jmp    80106352 <sys_sbrk+0x32>
80106367:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010636e:	00 
8010636f:	90                   	nop

80106370 <sys_sleep>:

int
sys_sleep(void)
{
80106370:	55                   	push   %ebp
80106371:	89 e5                	mov    %esp,%ebp
80106373:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80106374:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106377:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010637a:	50                   	push   %eax
8010637b:	6a 00                	push   $0x0
8010637d:	e8 8e f1 ff ff       	call   80105510 <argint>
80106382:	83 c4 10             	add    $0x10,%esp
80106385:	85 c0                	test   %eax,%eax
80106387:	78 64                	js     801063ed <sys_sleep+0x7d>
    return -1;
  acquire(&tickslock);
80106389:	83 ec 0c             	sub    $0xc,%esp
8010638c:	68 a0 5f 11 80       	push   $0x80115fa0
80106391:	e8 ca ed ff ff       	call   80105160 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80106396:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
80106399:	8b 1d 80 5f 11 80    	mov    0x80115f80,%ebx
  while(ticks - ticks0 < n){
8010639f:	83 c4 10             	add    $0x10,%esp
801063a2:	85 d2                	test   %edx,%edx
801063a4:	75 2b                	jne    801063d1 <sys_sleep+0x61>
801063a6:	eb 58                	jmp    80106400 <sys_sleep+0x90>
801063a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801063af:	00 
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
801063b0:	83 ec 08             	sub    $0x8,%esp
801063b3:	68 a0 5f 11 80       	push   $0x80115fa0
801063b8:	68 80 5f 11 80       	push   $0x80115f80
801063bd:	e8 be e5 ff ff       	call   80104980 <sleep>
  while(ticks - ticks0 < n){
801063c2:	a1 80 5f 11 80       	mov    0x80115f80,%eax
801063c7:	83 c4 10             	add    $0x10,%esp
801063ca:	29 d8                	sub    %ebx,%eax
801063cc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801063cf:	73 2f                	jae    80106400 <sys_sleep+0x90>
    if(myproc()->killed){
801063d1:	e8 0a d7 ff ff       	call   80103ae0 <myproc>
801063d6:	8b 40 24             	mov    0x24(%eax),%eax
801063d9:	85 c0                	test   %eax,%eax
801063db:	74 d3                	je     801063b0 <sys_sleep+0x40>
      release(&tickslock);
801063dd:	83 ec 0c             	sub    $0xc,%esp
801063e0:	68 a0 5f 11 80       	push   $0x80115fa0
801063e5:	e8 16 ed ff ff       	call   80105100 <release>
      return -1;
801063ea:	83 c4 10             	add    $0x10,%esp
  }
  release(&tickslock);
  return 0;
}
801063ed:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
801063f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801063f5:	c9                   	leave
801063f6:	c3                   	ret
801063f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801063fe:	00 
801063ff:	90                   	nop
  release(&tickslock);
80106400:	83 ec 0c             	sub    $0xc,%esp
80106403:	68 a0 5f 11 80       	push   $0x80115fa0
80106408:	e8 f3 ec ff ff       	call   80105100 <release>
}
8010640d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return 0;
80106410:	83 c4 10             	add    $0x10,%esp
80106413:	31 c0                	xor    %eax,%eax
}
80106415:	c9                   	leave
80106416:	c3                   	ret
80106417:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010641e:	00 
8010641f:	90                   	nop

80106420 <sys_chprty>:

int
sys_chprty(void)
{
80106420:	55                   	push   %ebp
80106421:	89 e5                	mov    %esp,%ebp
80106423:	83 ec 20             	sub    $0x20,%esp
  int pid, pr;
  if(argint(0, &pid) < 0)
80106426:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106429:	50                   	push   %eax
8010642a:	6a 00                	push   $0x0
8010642c:	e8 df f0 ff ff       	call   80105510 <argint>
80106431:	83 c4 10             	add    $0x10,%esp
80106434:	85 c0                	test   %eax,%eax
80106436:	78 28                	js     80106460 <sys_chprty+0x40>
    return -1;
  if(argint(1, &pr) < 0)
80106438:	83 ec 08             	sub    $0x8,%esp
8010643b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010643e:	50                   	push   %eax
8010643f:	6a 01                	push   $0x1
80106441:	e8 ca f0 ff ff       	call   80105510 <argint>
80106446:	83 c4 10             	add    $0x10,%esp
80106449:	85 c0                	test   %eax,%eax
8010644b:	78 13                	js     80106460 <sys_chprty+0x40>
    return -1;

  return chprty ( pid, pr );
8010644d:	83 ec 08             	sub    $0x8,%esp
80106450:	ff 75 f4             	push   -0xc(%ebp)
80106453:	ff 75 f0             	push   -0x10(%ebp)
80106456:	e8 85 e7 ff ff       	call   80104be0 <chprty>
8010645b:	83 c4 10             	add    $0x10,%esp
}
8010645e:	c9                   	leave
8010645f:	c3                   	ret
80106460:	c9                   	leave
    return -1;
80106461:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106466:	c3                   	ret
80106467:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010646e:	00 
8010646f:	90                   	nop

80106470 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106470:	55                   	push   %ebp
80106471:	89 e5                	mov    %esp,%ebp
80106473:	53                   	push   %ebx
80106474:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80106477:	68 a0 5f 11 80       	push   $0x80115fa0
8010647c:	e8 df ec ff ff       	call   80105160 <acquire>
  xticks = ticks;
80106481:	8b 1d 80 5f 11 80    	mov    0x80115f80,%ebx
  release(&tickslock);
80106487:	c7 04 24 a0 5f 11 80 	movl   $0x80115fa0,(%esp)
8010648e:	e8 6d ec ff ff       	call   80105100 <release>
  return xticks;
}
80106493:	89 d8                	mov    %ebx,%eax
80106495:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106498:	c9                   	leave
80106499:	c3                   	ret
8010649a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801064a0 <sys_cps>:


int
sys_cps ( void )
{
  return cps ();
801064a0:	e9 8b e7 ff ff       	jmp    80104c30 <cps>
801064a5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801064ac:	00 
801064ad:	8d 76 00             	lea    0x0(%esi),%esi

801064b0 <sys_getpinfo>:
}

int
sys_getpinfo (void)
{
801064b0:	55                   	push   %ebp
801064b1:	89 e5                	mov    %esp,%ebp
801064b3:	83 ec 14             	sub    $0x14,%esp
  struct proc_stat* px = 0;
  getpinfo(px);
801064b6:	6a 00                	push   $0x0
801064b8:	e8 c3 e8 ff ff       	call   80104d80 <getpinfo>
  return 0; 
801064bd:	31 c0                	xor    %eax,%eax
801064bf:	c9                   	leave
801064c0:	c3                   	ret

801064c1 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
801064c1:	1e                   	push   %ds
  pushl %es
801064c2:	06                   	push   %es
  pushl %fs
801064c3:	0f a0                	push   %fs
  pushl %gs
801064c5:	0f a8                	push   %gs
  pushal
801064c7:	60                   	pusha
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
801064c8:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
801064cc:	8e d8                	mov    %eax,%ds
  movw %ax, %es
801064ce:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
801064d0:	54                   	push   %esp
  call trap
801064d1:	e8 ca 00 00 00       	call   801065a0 <trap>
  addl $4, %esp
801064d6:	83 c4 04             	add    $0x4,%esp

801064d9 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
801064d9:	61                   	popa
  popl %gs
801064da:	0f a9                	pop    %gs
  popl %fs
801064dc:	0f a1                	pop    %fs
  popl %es
801064de:	07                   	pop    %es
  popl %ds
801064df:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
801064e0:	83 c4 08             	add    $0x8,%esp
  iret
801064e3:	cf                   	iret
801064e4:	66 90                	xchg   %ax,%ax
801064e6:	66 90                	xchg   %ax,%ax
801064e8:	66 90                	xchg   %ax,%ax
801064ea:	66 90                	xchg   %ax,%ax
801064ec:	66 90                	xchg   %ax,%ax
801064ee:	66 90                	xchg   %ax,%ax

801064f0 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
801064f0:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
801064f1:	31 c0                	xor    %eax,%eax
{
801064f3:	89 e5                	mov    %esp,%ebp
801064f5:	83 ec 08             	sub    $0x8,%esp
801064f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801064ff:	00 
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106500:	8b 14 85 1c b0 10 80 	mov    -0x7fef4fe4(,%eax,4),%edx
80106507:	c7 04 c5 e2 5f 11 80 	movl   $0x8e000008,-0x7feea01e(,%eax,8)
8010650e:	08 00 00 8e 
80106512:	66 89 14 c5 e0 5f 11 	mov    %dx,-0x7feea020(,%eax,8)
80106519:	80 
8010651a:	c1 ea 10             	shr    $0x10,%edx
8010651d:	66 89 14 c5 e6 5f 11 	mov    %dx,-0x7feea01a(,%eax,8)
80106524:	80 
  for(i = 0; i < 256; i++)
80106525:	83 c0 01             	add    $0x1,%eax
80106528:	3d 00 01 00 00       	cmp    $0x100,%eax
8010652d:	75 d1                	jne    80106500 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
8010652f:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106532:	a1 1c b1 10 80       	mov    0x8010b11c,%eax
80106537:	c7 05 e2 61 11 80 08 	movl   $0xef000008,0x801161e2
8010653e:	00 00 ef 
  initlock(&tickslock, "time");
80106541:	68 34 82 10 80       	push   $0x80108234
80106546:	68 a0 5f 11 80       	push   $0x80115fa0
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010654b:	66 a3 e0 61 11 80    	mov    %ax,0x801161e0
80106551:	c1 e8 10             	shr    $0x10,%eax
80106554:	66 a3 e6 61 11 80    	mov    %ax,0x801161e6
  initlock(&tickslock, "time");
8010655a:	e8 11 ea ff ff       	call   80104f70 <initlock>
}
8010655f:	83 c4 10             	add    $0x10,%esp
80106562:	c9                   	leave
80106563:	c3                   	ret
80106564:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010656b:	00 
8010656c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106570 <idtinit>:

void
idtinit(void)
{
80106570:	55                   	push   %ebp
  pd[0] = size-1;
80106571:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80106576:	89 e5                	mov    %esp,%ebp
80106578:	83 ec 10             	sub    $0x10,%esp
8010657b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010657f:	b8 e0 5f 11 80       	mov    $0x80115fe0,%eax
80106584:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106588:	c1 e8 10             	shr    $0x10,%eax
8010658b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
8010658f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106592:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106595:	c9                   	leave
80106596:	c3                   	ret
80106597:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010659e:	00 
8010659f:	90                   	nop

801065a0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801065a0:	55                   	push   %ebp
801065a1:	89 e5                	mov    %esp,%ebp
801065a3:	57                   	push   %edi
801065a4:	56                   	push   %esi
801065a5:	53                   	push   %ebx
801065a6:	83 ec 1c             	sub    $0x1c,%esp
801065a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
801065ac:	8b 43 30             	mov    0x30(%ebx),%eax
801065af:	83 f8 40             	cmp    $0x40,%eax
801065b2:	0f 84 58 01 00 00    	je     80106710 <trap+0x170>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
801065b8:	83 e8 20             	sub    $0x20,%eax
801065bb:	83 f8 1f             	cmp    $0x1f,%eax
801065be:	0f 87 7c 00 00 00    	ja     80106640 <trap+0xa0>
801065c4:	ff 24 85 c8 88 10 80 	jmp    *-0x7fef7738(,%eax,4)
801065cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
801065d0:	e8 6b bc ff ff       	call   80102240 <ideintr>
    lapiceoi();
801065d5:	e8 26 c3 ff ff       	call   80102900 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801065da:	e8 01 d5 ff ff       	call   80103ae0 <myproc>
801065df:	85 c0                	test   %eax,%eax
801065e1:	74 1a                	je     801065fd <trap+0x5d>
801065e3:	e8 f8 d4 ff ff       	call   80103ae0 <myproc>
801065e8:	8b 50 24             	mov    0x24(%eax),%edx
801065eb:	85 d2                	test   %edx,%edx
801065ed:	74 0e                	je     801065fd <trap+0x5d>
801065ef:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
801065f3:	f7 d0                	not    %eax
801065f5:	a8 03                	test   $0x3,%al
801065f7:	0f 84 e3 01 00 00    	je     801067e0 <trap+0x240>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
801065fd:	e8 de d4 ff ff       	call   80103ae0 <myproc>
80106602:	85 c0                	test   %eax,%eax
80106604:	74 0f                	je     80106615 <trap+0x75>
80106606:	e8 d5 d4 ff ff       	call   80103ae0 <myproc>
8010660b:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
8010660f:	0f 84 ab 00 00 00    	je     801066c0 <trap+0x120>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106615:	e8 c6 d4 ff ff       	call   80103ae0 <myproc>
8010661a:	85 c0                	test   %eax,%eax
8010661c:	74 1a                	je     80106638 <trap+0x98>
8010661e:	e8 bd d4 ff ff       	call   80103ae0 <myproc>
80106623:	8b 40 24             	mov    0x24(%eax),%eax
80106626:	85 c0                	test   %eax,%eax
80106628:	74 0e                	je     80106638 <trap+0x98>
8010662a:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
8010662e:	f7 d0                	not    %eax
80106630:	a8 03                	test   $0x3,%al
80106632:	0f 84 05 01 00 00    	je     8010673d <trap+0x19d>
    exit();
}
80106638:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010663b:	5b                   	pop    %ebx
8010663c:	5e                   	pop    %esi
8010663d:	5f                   	pop    %edi
8010663e:	5d                   	pop    %ebp
8010663f:	c3                   	ret
    if(myproc() == 0 || (tf->cs&3) == 0){
80106640:	e8 9b d4 ff ff       	call   80103ae0 <myproc>
80106645:	8b 7b 38             	mov    0x38(%ebx),%edi
80106648:	85 c0                	test   %eax,%eax
8010664a:	0f 84 aa 01 00 00    	je     801067fa <trap+0x25a>
80106650:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80106654:	0f 84 a0 01 00 00    	je     801067fa <trap+0x25a>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
8010665a:	0f 20 d1             	mov    %cr2,%ecx
8010665d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106660:	e8 5b d4 ff ff       	call   80103ac0 <cpuid>
80106665:	8b 73 30             	mov    0x30(%ebx),%esi
80106668:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010666b:	8b 43 34             	mov    0x34(%ebx),%eax
8010666e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
80106671:	e8 6a d4 ff ff       	call   80103ae0 <myproc>
80106676:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106679:	e8 62 d4 ff ff       	call   80103ae0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010667e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106681:	51                   	push   %ecx
80106682:	57                   	push   %edi
80106683:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106686:	52                   	push   %edx
80106687:	ff 75 e4             	push   -0x1c(%ebp)
8010668a:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
8010668b:	8b 75 e0             	mov    -0x20(%ebp),%esi
8010668e:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106691:	56                   	push   %esi
80106692:	ff 70 10             	push   0x10(%eax)
80106695:	68 b0 85 10 80       	push   $0x801085b0
8010669a:	e8 11 a0 ff ff       	call   801006b0 <cprintf>
    myproc()->killed = 1;
8010669f:	83 c4 20             	add    $0x20,%esp
801066a2:	e8 39 d4 ff ff       	call   80103ae0 <myproc>
801066a7:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801066ae:	e8 2d d4 ff ff       	call   80103ae0 <myproc>
801066b3:	85 c0                	test   %eax,%eax
801066b5:	0f 85 28 ff ff ff    	jne    801065e3 <trap+0x43>
801066bb:	e9 3d ff ff ff       	jmp    801065fd <trap+0x5d>
  if(myproc() && myproc()->state == RUNNING &&
801066c0:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
801066c4:	0f 85 4b ff ff ff    	jne    80106615 <trap+0x75>
    yield();
801066ca:	e8 61 e2 ff ff       	call   80104930 <yield>
801066cf:	e9 41 ff ff ff       	jmp    80106615 <trap+0x75>
801066d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801066d8:	8b 7b 38             	mov    0x38(%ebx),%edi
801066db:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
801066df:	e8 dc d3 ff ff       	call   80103ac0 <cpuid>
801066e4:	57                   	push   %edi
801066e5:	56                   	push   %esi
801066e6:	50                   	push   %eax
801066e7:	68 58 85 10 80       	push   $0x80108558
801066ec:	e8 bf 9f ff ff       	call   801006b0 <cprintf>
    lapiceoi();
801066f1:	e8 0a c2 ff ff       	call   80102900 <lapiceoi>
    break;
801066f6:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801066f9:	e8 e2 d3 ff ff       	call   80103ae0 <myproc>
801066fe:	85 c0                	test   %eax,%eax
80106700:	0f 85 dd fe ff ff    	jne    801065e3 <trap+0x43>
80106706:	e9 f2 fe ff ff       	jmp    801065fd <trap+0x5d>
8010670b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80106710:	e8 cb d3 ff ff       	call   80103ae0 <myproc>
80106715:	8b 70 24             	mov    0x24(%eax),%esi
80106718:	85 f6                	test   %esi,%esi
8010671a:	0f 85 d0 00 00 00    	jne    801067f0 <trap+0x250>
    myproc()->tf = tf;
80106720:	e8 bb d3 ff ff       	call   80103ae0 <myproc>
80106725:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80106728:	e8 23 ef ff ff       	call   80105650 <syscall>
    if(myproc()->killed)
8010672d:	e8 ae d3 ff ff       	call   80103ae0 <myproc>
80106732:	8b 48 24             	mov    0x24(%eax),%ecx
80106735:	85 c9                	test   %ecx,%ecx
80106737:	0f 84 fb fe ff ff    	je     80106638 <trap+0x98>
}
8010673d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106740:	5b                   	pop    %ebx
80106741:	5e                   	pop    %esi
80106742:	5f                   	pop    %edi
80106743:	5d                   	pop    %ebp
      exit();
80106744:	e9 e7 dd ff ff       	jmp    80104530 <exit>
80106749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80106750:	e8 5b 02 00 00       	call   801069b0 <uartintr>
    lapiceoi();
80106755:	e8 a6 c1 ff ff       	call   80102900 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010675a:	e8 81 d3 ff ff       	call   80103ae0 <myproc>
8010675f:	85 c0                	test   %eax,%eax
80106761:	0f 85 7c fe ff ff    	jne    801065e3 <trap+0x43>
80106767:	e9 91 fe ff ff       	jmp    801065fd <trap+0x5d>
8010676c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80106770:	e8 5b c0 ff ff       	call   801027d0 <kbdintr>
    lapiceoi();
80106775:	e8 86 c1 ff ff       	call   80102900 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010677a:	e8 61 d3 ff ff       	call   80103ae0 <myproc>
8010677f:	85 c0                	test   %eax,%eax
80106781:	0f 85 5c fe ff ff    	jne    801065e3 <trap+0x43>
80106787:	e9 71 fe ff ff       	jmp    801065fd <trap+0x5d>
8010678c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80106790:	e8 2b d3 ff ff       	call   80103ac0 <cpuid>
80106795:	85 c0                	test   %eax,%eax
80106797:	0f 85 38 fe ff ff    	jne    801065d5 <trap+0x35>
      acquire(&tickslock);
8010679d:	83 ec 0c             	sub    $0xc,%esp
801067a0:	68 a0 5f 11 80       	push   $0x80115fa0
801067a5:	e8 b6 e9 ff ff       	call   80105160 <acquire>
      ticks++;
801067aa:	83 05 80 5f 11 80 01 	addl   $0x1,0x80115f80
      updatestatistics();
801067b1:	e8 7a e5 ff ff       	call   80104d30 <updatestatistics>
      wakeup(&ticks);
801067b6:	c7 04 24 80 5f 11 80 	movl   $0x80115f80,(%esp)
801067bd:	e8 7e e2 ff ff       	call   80104a40 <wakeup>
      release(&tickslock);
801067c2:	c7 04 24 a0 5f 11 80 	movl   $0x80115fa0,(%esp)
801067c9:	e8 32 e9 ff ff       	call   80105100 <release>
801067ce:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
801067d1:	e9 ff fd ff ff       	jmp    801065d5 <trap+0x35>
801067d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801067dd:	00 
801067de:	66 90                	xchg   %ax,%ax
    exit();
801067e0:	e8 4b dd ff ff       	call   80104530 <exit>
801067e5:	e9 13 fe ff ff       	jmp    801065fd <trap+0x5d>
801067ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
801067f0:	e8 3b dd ff ff       	call   80104530 <exit>
801067f5:	e9 26 ff ff ff       	jmp    80106720 <trap+0x180>
801067fa:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801067fd:	e8 be d2 ff ff       	call   80103ac0 <cpuid>
80106802:	83 ec 0c             	sub    $0xc,%esp
80106805:	56                   	push   %esi
80106806:	57                   	push   %edi
80106807:	50                   	push   %eax
80106808:	ff 73 30             	push   0x30(%ebx)
8010680b:	68 7c 85 10 80       	push   $0x8010857c
80106810:	e8 9b 9e ff ff       	call   801006b0 <cprintf>
      panic("trap");
80106815:	83 c4 14             	add    $0x14,%esp
80106818:	68 39 82 10 80       	push   $0x80108239
8010681d:	e8 5e 9b ff ff       	call   80100380 <panic>
80106822:	66 90                	xchg   %ax,%ax
80106824:	66 90                	xchg   %ax,%ax
80106826:	66 90                	xchg   %ax,%ax
80106828:	66 90                	xchg   %ax,%ax
8010682a:	66 90                	xchg   %ax,%ax
8010682c:	66 90                	xchg   %ax,%ax
8010682e:	66 90                	xchg   %ax,%ax

80106830 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106830:	a1 e0 67 11 80       	mov    0x801167e0,%eax
80106835:	85 c0                	test   %eax,%eax
80106837:	74 17                	je     80106850 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106839:	ba fd 03 00 00       	mov    $0x3fd,%edx
8010683e:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
8010683f:	a8 01                	test   $0x1,%al
80106841:	74 0d                	je     80106850 <uartgetc+0x20>
80106843:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106848:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80106849:	0f b6 c0             	movzbl %al,%eax
8010684c:	c3                   	ret
8010684d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80106850:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106855:	c3                   	ret
80106856:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010685d:	00 
8010685e:	66 90                	xchg   %ax,%ax

80106860 <uartinit>:
{
80106860:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106861:	31 c9                	xor    %ecx,%ecx
80106863:	89 c8                	mov    %ecx,%eax
80106865:	89 e5                	mov    %esp,%ebp
80106867:	57                   	push   %edi
80106868:	bf fa 03 00 00       	mov    $0x3fa,%edi
8010686d:	56                   	push   %esi
8010686e:	89 fa                	mov    %edi,%edx
80106870:	53                   	push   %ebx
80106871:	83 ec 1c             	sub    $0x1c,%esp
80106874:	ee                   	out    %al,(%dx)
80106875:	be fb 03 00 00       	mov    $0x3fb,%esi
8010687a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
8010687f:	89 f2                	mov    %esi,%edx
80106881:	ee                   	out    %al,(%dx)
80106882:	b8 0c 00 00 00       	mov    $0xc,%eax
80106887:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010688c:	ee                   	out    %al,(%dx)
8010688d:	bb f9 03 00 00       	mov    $0x3f9,%ebx
80106892:	89 c8                	mov    %ecx,%eax
80106894:	89 da                	mov    %ebx,%edx
80106896:	ee                   	out    %al,(%dx)
80106897:	b8 03 00 00 00       	mov    $0x3,%eax
8010689c:	89 f2                	mov    %esi,%edx
8010689e:	ee                   	out    %al,(%dx)
8010689f:	ba fc 03 00 00       	mov    $0x3fc,%edx
801068a4:	89 c8                	mov    %ecx,%eax
801068a6:	ee                   	out    %al,(%dx)
801068a7:	b8 01 00 00 00       	mov    $0x1,%eax
801068ac:	89 da                	mov    %ebx,%edx
801068ae:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801068af:	ba fd 03 00 00       	mov    $0x3fd,%edx
801068b4:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
801068b5:	3c ff                	cmp    $0xff,%al
801068b7:	0f 84 7c 00 00 00    	je     80106939 <uartinit+0xd9>
  uart = 1;
801068bd:	c7 05 e0 67 11 80 01 	movl   $0x1,0x801167e0
801068c4:	00 00 00 
801068c7:	89 fa                	mov    %edi,%edx
801068c9:	ec                   	in     (%dx),%al
801068ca:	ba f8 03 00 00       	mov    $0x3f8,%edx
801068cf:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
801068d0:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
801068d3:	bf 3e 82 10 80       	mov    $0x8010823e,%edi
801068d8:	be fd 03 00 00       	mov    $0x3fd,%esi
  ioapicenable(IRQ_COM1, 0);
801068dd:	6a 00                	push   $0x0
801068df:	6a 04                	push   $0x4
801068e1:	e8 8a bb ff ff       	call   80102470 <ioapicenable>
801068e6:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
801068e9:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
801068ed:	8d 76 00             	lea    0x0(%esi),%esi
  if(!uart)
801068f0:	a1 e0 67 11 80       	mov    0x801167e0,%eax
801068f5:	85 c0                	test   %eax,%eax
801068f7:	74 32                	je     8010692b <uartinit+0xcb>
801068f9:	89 f2                	mov    %esi,%edx
801068fb:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801068fc:	a8 20                	test   $0x20,%al
801068fe:	75 21                	jne    80106921 <uartinit+0xc1>
80106900:	bb 80 00 00 00       	mov    $0x80,%ebx
80106905:	8d 76 00             	lea    0x0(%esi),%esi
    microdelay(10);
80106908:	83 ec 0c             	sub    $0xc,%esp
8010690b:	6a 0a                	push   $0xa
8010690d:	e8 0e c0 ff ff       	call   80102920 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106912:	83 c4 10             	add    $0x10,%esp
80106915:	83 eb 01             	sub    $0x1,%ebx
80106918:	74 07                	je     80106921 <uartinit+0xc1>
8010691a:	89 f2                	mov    %esi,%edx
8010691c:	ec                   	in     (%dx),%al
8010691d:	a8 20                	test   $0x20,%al
8010691f:	74 e7                	je     80106908 <uartinit+0xa8>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106921:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106926:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
8010692a:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
8010692b:	0f b6 47 01          	movzbl 0x1(%edi),%eax
8010692f:	83 c7 01             	add    $0x1,%edi
80106932:	88 45 e7             	mov    %al,-0x19(%ebp)
80106935:	84 c0                	test   %al,%al
80106937:	75 b7                	jne    801068f0 <uartinit+0x90>
}
80106939:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010693c:	5b                   	pop    %ebx
8010693d:	5e                   	pop    %esi
8010693e:	5f                   	pop    %edi
8010693f:	5d                   	pop    %ebp
80106940:	c3                   	ret
80106941:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106948:	00 
80106949:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106950 <uartputc>:
  if(!uart)
80106950:	a1 e0 67 11 80       	mov    0x801167e0,%eax
80106955:	85 c0                	test   %eax,%eax
80106957:	74 4f                	je     801069a8 <uartputc+0x58>
{
80106959:	55                   	push   %ebp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010695a:	ba fd 03 00 00       	mov    $0x3fd,%edx
8010695f:	89 e5                	mov    %esp,%ebp
80106961:	56                   	push   %esi
80106962:	53                   	push   %ebx
80106963:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106964:	a8 20                	test   $0x20,%al
80106966:	75 29                	jne    80106991 <uartputc+0x41>
80106968:	bb 80 00 00 00       	mov    $0x80,%ebx
8010696d:	be fd 03 00 00       	mov    $0x3fd,%esi
80106972:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    microdelay(10);
80106978:	83 ec 0c             	sub    $0xc,%esp
8010697b:	6a 0a                	push   $0xa
8010697d:	e8 9e bf ff ff       	call   80102920 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106982:	83 c4 10             	add    $0x10,%esp
80106985:	83 eb 01             	sub    $0x1,%ebx
80106988:	74 07                	je     80106991 <uartputc+0x41>
8010698a:	89 f2                	mov    %esi,%edx
8010698c:	ec                   	in     (%dx),%al
8010698d:	a8 20                	test   $0x20,%al
8010698f:	74 e7                	je     80106978 <uartputc+0x28>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106991:	8b 45 08             	mov    0x8(%ebp),%eax
80106994:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106999:	ee                   	out    %al,(%dx)
}
8010699a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010699d:	5b                   	pop    %ebx
8010699e:	5e                   	pop    %esi
8010699f:	5d                   	pop    %ebp
801069a0:	c3                   	ret
801069a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801069a8:	c3                   	ret
801069a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801069b0 <uartintr>:

void
uartintr(void)
{
801069b0:	55                   	push   %ebp
801069b1:	89 e5                	mov    %esp,%ebp
801069b3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
801069b6:	68 30 68 10 80       	push   $0x80106830
801069bb:	e8 e0 9e ff ff       	call   801008a0 <consoleintr>
}
801069c0:	83 c4 10             	add    $0x10,%esp
801069c3:	c9                   	leave
801069c4:	c3                   	ret

801069c5 <vector0>:
801069c5:	6a 00                	push   $0x0
801069c7:	6a 00                	push   $0x0
801069c9:	e9 f3 fa ff ff       	jmp    801064c1 <alltraps>

801069ce <vector1>:
801069ce:	6a 00                	push   $0x0
801069d0:	6a 01                	push   $0x1
801069d2:	e9 ea fa ff ff       	jmp    801064c1 <alltraps>

801069d7 <vector2>:
801069d7:	6a 00                	push   $0x0
801069d9:	6a 02                	push   $0x2
801069db:	e9 e1 fa ff ff       	jmp    801064c1 <alltraps>

801069e0 <vector3>:
801069e0:	6a 00                	push   $0x0
801069e2:	6a 03                	push   $0x3
801069e4:	e9 d8 fa ff ff       	jmp    801064c1 <alltraps>

801069e9 <vector4>:
801069e9:	6a 00                	push   $0x0
801069eb:	6a 04                	push   $0x4
801069ed:	e9 cf fa ff ff       	jmp    801064c1 <alltraps>

801069f2 <vector5>:
801069f2:	6a 00                	push   $0x0
801069f4:	6a 05                	push   $0x5
801069f6:	e9 c6 fa ff ff       	jmp    801064c1 <alltraps>

801069fb <vector6>:
801069fb:	6a 00                	push   $0x0
801069fd:	6a 06                	push   $0x6
801069ff:	e9 bd fa ff ff       	jmp    801064c1 <alltraps>

80106a04 <vector7>:
80106a04:	6a 00                	push   $0x0
80106a06:	6a 07                	push   $0x7
80106a08:	e9 b4 fa ff ff       	jmp    801064c1 <alltraps>

80106a0d <vector8>:
80106a0d:	6a 08                	push   $0x8
80106a0f:	e9 ad fa ff ff       	jmp    801064c1 <alltraps>

80106a14 <vector9>:
80106a14:	6a 00                	push   $0x0
80106a16:	6a 09                	push   $0x9
80106a18:	e9 a4 fa ff ff       	jmp    801064c1 <alltraps>

80106a1d <vector10>:
80106a1d:	6a 0a                	push   $0xa
80106a1f:	e9 9d fa ff ff       	jmp    801064c1 <alltraps>

80106a24 <vector11>:
80106a24:	6a 0b                	push   $0xb
80106a26:	e9 96 fa ff ff       	jmp    801064c1 <alltraps>

80106a2b <vector12>:
80106a2b:	6a 0c                	push   $0xc
80106a2d:	e9 8f fa ff ff       	jmp    801064c1 <alltraps>

80106a32 <vector13>:
80106a32:	6a 0d                	push   $0xd
80106a34:	e9 88 fa ff ff       	jmp    801064c1 <alltraps>

80106a39 <vector14>:
80106a39:	6a 0e                	push   $0xe
80106a3b:	e9 81 fa ff ff       	jmp    801064c1 <alltraps>

80106a40 <vector15>:
80106a40:	6a 00                	push   $0x0
80106a42:	6a 0f                	push   $0xf
80106a44:	e9 78 fa ff ff       	jmp    801064c1 <alltraps>

80106a49 <vector16>:
80106a49:	6a 00                	push   $0x0
80106a4b:	6a 10                	push   $0x10
80106a4d:	e9 6f fa ff ff       	jmp    801064c1 <alltraps>

80106a52 <vector17>:
80106a52:	6a 11                	push   $0x11
80106a54:	e9 68 fa ff ff       	jmp    801064c1 <alltraps>

80106a59 <vector18>:
80106a59:	6a 00                	push   $0x0
80106a5b:	6a 12                	push   $0x12
80106a5d:	e9 5f fa ff ff       	jmp    801064c1 <alltraps>

80106a62 <vector19>:
80106a62:	6a 00                	push   $0x0
80106a64:	6a 13                	push   $0x13
80106a66:	e9 56 fa ff ff       	jmp    801064c1 <alltraps>

80106a6b <vector20>:
80106a6b:	6a 00                	push   $0x0
80106a6d:	6a 14                	push   $0x14
80106a6f:	e9 4d fa ff ff       	jmp    801064c1 <alltraps>

80106a74 <vector21>:
80106a74:	6a 00                	push   $0x0
80106a76:	6a 15                	push   $0x15
80106a78:	e9 44 fa ff ff       	jmp    801064c1 <alltraps>

80106a7d <vector22>:
80106a7d:	6a 00                	push   $0x0
80106a7f:	6a 16                	push   $0x16
80106a81:	e9 3b fa ff ff       	jmp    801064c1 <alltraps>

80106a86 <vector23>:
80106a86:	6a 00                	push   $0x0
80106a88:	6a 17                	push   $0x17
80106a8a:	e9 32 fa ff ff       	jmp    801064c1 <alltraps>

80106a8f <vector24>:
80106a8f:	6a 00                	push   $0x0
80106a91:	6a 18                	push   $0x18
80106a93:	e9 29 fa ff ff       	jmp    801064c1 <alltraps>

80106a98 <vector25>:
80106a98:	6a 00                	push   $0x0
80106a9a:	6a 19                	push   $0x19
80106a9c:	e9 20 fa ff ff       	jmp    801064c1 <alltraps>

80106aa1 <vector26>:
80106aa1:	6a 00                	push   $0x0
80106aa3:	6a 1a                	push   $0x1a
80106aa5:	e9 17 fa ff ff       	jmp    801064c1 <alltraps>

80106aaa <vector27>:
80106aaa:	6a 00                	push   $0x0
80106aac:	6a 1b                	push   $0x1b
80106aae:	e9 0e fa ff ff       	jmp    801064c1 <alltraps>

80106ab3 <vector28>:
80106ab3:	6a 00                	push   $0x0
80106ab5:	6a 1c                	push   $0x1c
80106ab7:	e9 05 fa ff ff       	jmp    801064c1 <alltraps>

80106abc <vector29>:
80106abc:	6a 00                	push   $0x0
80106abe:	6a 1d                	push   $0x1d
80106ac0:	e9 fc f9 ff ff       	jmp    801064c1 <alltraps>

80106ac5 <vector30>:
80106ac5:	6a 00                	push   $0x0
80106ac7:	6a 1e                	push   $0x1e
80106ac9:	e9 f3 f9 ff ff       	jmp    801064c1 <alltraps>

80106ace <vector31>:
80106ace:	6a 00                	push   $0x0
80106ad0:	6a 1f                	push   $0x1f
80106ad2:	e9 ea f9 ff ff       	jmp    801064c1 <alltraps>

80106ad7 <vector32>:
80106ad7:	6a 00                	push   $0x0
80106ad9:	6a 20                	push   $0x20
80106adb:	e9 e1 f9 ff ff       	jmp    801064c1 <alltraps>

80106ae0 <vector33>:
80106ae0:	6a 00                	push   $0x0
80106ae2:	6a 21                	push   $0x21
80106ae4:	e9 d8 f9 ff ff       	jmp    801064c1 <alltraps>

80106ae9 <vector34>:
80106ae9:	6a 00                	push   $0x0
80106aeb:	6a 22                	push   $0x22
80106aed:	e9 cf f9 ff ff       	jmp    801064c1 <alltraps>

80106af2 <vector35>:
80106af2:	6a 00                	push   $0x0
80106af4:	6a 23                	push   $0x23
80106af6:	e9 c6 f9 ff ff       	jmp    801064c1 <alltraps>

80106afb <vector36>:
80106afb:	6a 00                	push   $0x0
80106afd:	6a 24                	push   $0x24
80106aff:	e9 bd f9 ff ff       	jmp    801064c1 <alltraps>

80106b04 <vector37>:
80106b04:	6a 00                	push   $0x0
80106b06:	6a 25                	push   $0x25
80106b08:	e9 b4 f9 ff ff       	jmp    801064c1 <alltraps>

80106b0d <vector38>:
80106b0d:	6a 00                	push   $0x0
80106b0f:	6a 26                	push   $0x26
80106b11:	e9 ab f9 ff ff       	jmp    801064c1 <alltraps>

80106b16 <vector39>:
80106b16:	6a 00                	push   $0x0
80106b18:	6a 27                	push   $0x27
80106b1a:	e9 a2 f9 ff ff       	jmp    801064c1 <alltraps>

80106b1f <vector40>:
80106b1f:	6a 00                	push   $0x0
80106b21:	6a 28                	push   $0x28
80106b23:	e9 99 f9 ff ff       	jmp    801064c1 <alltraps>

80106b28 <vector41>:
80106b28:	6a 00                	push   $0x0
80106b2a:	6a 29                	push   $0x29
80106b2c:	e9 90 f9 ff ff       	jmp    801064c1 <alltraps>

80106b31 <vector42>:
80106b31:	6a 00                	push   $0x0
80106b33:	6a 2a                	push   $0x2a
80106b35:	e9 87 f9 ff ff       	jmp    801064c1 <alltraps>

80106b3a <vector43>:
80106b3a:	6a 00                	push   $0x0
80106b3c:	6a 2b                	push   $0x2b
80106b3e:	e9 7e f9 ff ff       	jmp    801064c1 <alltraps>

80106b43 <vector44>:
80106b43:	6a 00                	push   $0x0
80106b45:	6a 2c                	push   $0x2c
80106b47:	e9 75 f9 ff ff       	jmp    801064c1 <alltraps>

80106b4c <vector45>:
80106b4c:	6a 00                	push   $0x0
80106b4e:	6a 2d                	push   $0x2d
80106b50:	e9 6c f9 ff ff       	jmp    801064c1 <alltraps>

80106b55 <vector46>:
80106b55:	6a 00                	push   $0x0
80106b57:	6a 2e                	push   $0x2e
80106b59:	e9 63 f9 ff ff       	jmp    801064c1 <alltraps>

80106b5e <vector47>:
80106b5e:	6a 00                	push   $0x0
80106b60:	6a 2f                	push   $0x2f
80106b62:	e9 5a f9 ff ff       	jmp    801064c1 <alltraps>

80106b67 <vector48>:
80106b67:	6a 00                	push   $0x0
80106b69:	6a 30                	push   $0x30
80106b6b:	e9 51 f9 ff ff       	jmp    801064c1 <alltraps>

80106b70 <vector49>:
80106b70:	6a 00                	push   $0x0
80106b72:	6a 31                	push   $0x31
80106b74:	e9 48 f9 ff ff       	jmp    801064c1 <alltraps>

80106b79 <vector50>:
80106b79:	6a 00                	push   $0x0
80106b7b:	6a 32                	push   $0x32
80106b7d:	e9 3f f9 ff ff       	jmp    801064c1 <alltraps>

80106b82 <vector51>:
80106b82:	6a 00                	push   $0x0
80106b84:	6a 33                	push   $0x33
80106b86:	e9 36 f9 ff ff       	jmp    801064c1 <alltraps>

80106b8b <vector52>:
80106b8b:	6a 00                	push   $0x0
80106b8d:	6a 34                	push   $0x34
80106b8f:	e9 2d f9 ff ff       	jmp    801064c1 <alltraps>

80106b94 <vector53>:
80106b94:	6a 00                	push   $0x0
80106b96:	6a 35                	push   $0x35
80106b98:	e9 24 f9 ff ff       	jmp    801064c1 <alltraps>

80106b9d <vector54>:
80106b9d:	6a 00                	push   $0x0
80106b9f:	6a 36                	push   $0x36
80106ba1:	e9 1b f9 ff ff       	jmp    801064c1 <alltraps>

80106ba6 <vector55>:
80106ba6:	6a 00                	push   $0x0
80106ba8:	6a 37                	push   $0x37
80106baa:	e9 12 f9 ff ff       	jmp    801064c1 <alltraps>

80106baf <vector56>:
80106baf:	6a 00                	push   $0x0
80106bb1:	6a 38                	push   $0x38
80106bb3:	e9 09 f9 ff ff       	jmp    801064c1 <alltraps>

80106bb8 <vector57>:
80106bb8:	6a 00                	push   $0x0
80106bba:	6a 39                	push   $0x39
80106bbc:	e9 00 f9 ff ff       	jmp    801064c1 <alltraps>

80106bc1 <vector58>:
80106bc1:	6a 00                	push   $0x0
80106bc3:	6a 3a                	push   $0x3a
80106bc5:	e9 f7 f8 ff ff       	jmp    801064c1 <alltraps>

80106bca <vector59>:
80106bca:	6a 00                	push   $0x0
80106bcc:	6a 3b                	push   $0x3b
80106bce:	e9 ee f8 ff ff       	jmp    801064c1 <alltraps>

80106bd3 <vector60>:
80106bd3:	6a 00                	push   $0x0
80106bd5:	6a 3c                	push   $0x3c
80106bd7:	e9 e5 f8 ff ff       	jmp    801064c1 <alltraps>

80106bdc <vector61>:
80106bdc:	6a 00                	push   $0x0
80106bde:	6a 3d                	push   $0x3d
80106be0:	e9 dc f8 ff ff       	jmp    801064c1 <alltraps>

80106be5 <vector62>:
80106be5:	6a 00                	push   $0x0
80106be7:	6a 3e                	push   $0x3e
80106be9:	e9 d3 f8 ff ff       	jmp    801064c1 <alltraps>

80106bee <vector63>:
80106bee:	6a 00                	push   $0x0
80106bf0:	6a 3f                	push   $0x3f
80106bf2:	e9 ca f8 ff ff       	jmp    801064c1 <alltraps>

80106bf7 <vector64>:
80106bf7:	6a 00                	push   $0x0
80106bf9:	6a 40                	push   $0x40
80106bfb:	e9 c1 f8 ff ff       	jmp    801064c1 <alltraps>

80106c00 <vector65>:
80106c00:	6a 00                	push   $0x0
80106c02:	6a 41                	push   $0x41
80106c04:	e9 b8 f8 ff ff       	jmp    801064c1 <alltraps>

80106c09 <vector66>:
80106c09:	6a 00                	push   $0x0
80106c0b:	6a 42                	push   $0x42
80106c0d:	e9 af f8 ff ff       	jmp    801064c1 <alltraps>

80106c12 <vector67>:
80106c12:	6a 00                	push   $0x0
80106c14:	6a 43                	push   $0x43
80106c16:	e9 a6 f8 ff ff       	jmp    801064c1 <alltraps>

80106c1b <vector68>:
80106c1b:	6a 00                	push   $0x0
80106c1d:	6a 44                	push   $0x44
80106c1f:	e9 9d f8 ff ff       	jmp    801064c1 <alltraps>

80106c24 <vector69>:
80106c24:	6a 00                	push   $0x0
80106c26:	6a 45                	push   $0x45
80106c28:	e9 94 f8 ff ff       	jmp    801064c1 <alltraps>

80106c2d <vector70>:
80106c2d:	6a 00                	push   $0x0
80106c2f:	6a 46                	push   $0x46
80106c31:	e9 8b f8 ff ff       	jmp    801064c1 <alltraps>

80106c36 <vector71>:
80106c36:	6a 00                	push   $0x0
80106c38:	6a 47                	push   $0x47
80106c3a:	e9 82 f8 ff ff       	jmp    801064c1 <alltraps>

80106c3f <vector72>:
80106c3f:	6a 00                	push   $0x0
80106c41:	6a 48                	push   $0x48
80106c43:	e9 79 f8 ff ff       	jmp    801064c1 <alltraps>

80106c48 <vector73>:
80106c48:	6a 00                	push   $0x0
80106c4a:	6a 49                	push   $0x49
80106c4c:	e9 70 f8 ff ff       	jmp    801064c1 <alltraps>

80106c51 <vector74>:
80106c51:	6a 00                	push   $0x0
80106c53:	6a 4a                	push   $0x4a
80106c55:	e9 67 f8 ff ff       	jmp    801064c1 <alltraps>

80106c5a <vector75>:
80106c5a:	6a 00                	push   $0x0
80106c5c:	6a 4b                	push   $0x4b
80106c5e:	e9 5e f8 ff ff       	jmp    801064c1 <alltraps>

80106c63 <vector76>:
80106c63:	6a 00                	push   $0x0
80106c65:	6a 4c                	push   $0x4c
80106c67:	e9 55 f8 ff ff       	jmp    801064c1 <alltraps>

80106c6c <vector77>:
80106c6c:	6a 00                	push   $0x0
80106c6e:	6a 4d                	push   $0x4d
80106c70:	e9 4c f8 ff ff       	jmp    801064c1 <alltraps>

80106c75 <vector78>:
80106c75:	6a 00                	push   $0x0
80106c77:	6a 4e                	push   $0x4e
80106c79:	e9 43 f8 ff ff       	jmp    801064c1 <alltraps>

80106c7e <vector79>:
80106c7e:	6a 00                	push   $0x0
80106c80:	6a 4f                	push   $0x4f
80106c82:	e9 3a f8 ff ff       	jmp    801064c1 <alltraps>

80106c87 <vector80>:
80106c87:	6a 00                	push   $0x0
80106c89:	6a 50                	push   $0x50
80106c8b:	e9 31 f8 ff ff       	jmp    801064c1 <alltraps>

80106c90 <vector81>:
80106c90:	6a 00                	push   $0x0
80106c92:	6a 51                	push   $0x51
80106c94:	e9 28 f8 ff ff       	jmp    801064c1 <alltraps>

80106c99 <vector82>:
80106c99:	6a 00                	push   $0x0
80106c9b:	6a 52                	push   $0x52
80106c9d:	e9 1f f8 ff ff       	jmp    801064c1 <alltraps>

80106ca2 <vector83>:
80106ca2:	6a 00                	push   $0x0
80106ca4:	6a 53                	push   $0x53
80106ca6:	e9 16 f8 ff ff       	jmp    801064c1 <alltraps>

80106cab <vector84>:
80106cab:	6a 00                	push   $0x0
80106cad:	6a 54                	push   $0x54
80106caf:	e9 0d f8 ff ff       	jmp    801064c1 <alltraps>

80106cb4 <vector85>:
80106cb4:	6a 00                	push   $0x0
80106cb6:	6a 55                	push   $0x55
80106cb8:	e9 04 f8 ff ff       	jmp    801064c1 <alltraps>

80106cbd <vector86>:
80106cbd:	6a 00                	push   $0x0
80106cbf:	6a 56                	push   $0x56
80106cc1:	e9 fb f7 ff ff       	jmp    801064c1 <alltraps>

80106cc6 <vector87>:
80106cc6:	6a 00                	push   $0x0
80106cc8:	6a 57                	push   $0x57
80106cca:	e9 f2 f7 ff ff       	jmp    801064c1 <alltraps>

80106ccf <vector88>:
80106ccf:	6a 00                	push   $0x0
80106cd1:	6a 58                	push   $0x58
80106cd3:	e9 e9 f7 ff ff       	jmp    801064c1 <alltraps>

80106cd8 <vector89>:
80106cd8:	6a 00                	push   $0x0
80106cda:	6a 59                	push   $0x59
80106cdc:	e9 e0 f7 ff ff       	jmp    801064c1 <alltraps>

80106ce1 <vector90>:
80106ce1:	6a 00                	push   $0x0
80106ce3:	6a 5a                	push   $0x5a
80106ce5:	e9 d7 f7 ff ff       	jmp    801064c1 <alltraps>

80106cea <vector91>:
80106cea:	6a 00                	push   $0x0
80106cec:	6a 5b                	push   $0x5b
80106cee:	e9 ce f7 ff ff       	jmp    801064c1 <alltraps>

80106cf3 <vector92>:
80106cf3:	6a 00                	push   $0x0
80106cf5:	6a 5c                	push   $0x5c
80106cf7:	e9 c5 f7 ff ff       	jmp    801064c1 <alltraps>

80106cfc <vector93>:
80106cfc:	6a 00                	push   $0x0
80106cfe:	6a 5d                	push   $0x5d
80106d00:	e9 bc f7 ff ff       	jmp    801064c1 <alltraps>

80106d05 <vector94>:
80106d05:	6a 00                	push   $0x0
80106d07:	6a 5e                	push   $0x5e
80106d09:	e9 b3 f7 ff ff       	jmp    801064c1 <alltraps>

80106d0e <vector95>:
80106d0e:	6a 00                	push   $0x0
80106d10:	6a 5f                	push   $0x5f
80106d12:	e9 aa f7 ff ff       	jmp    801064c1 <alltraps>

80106d17 <vector96>:
80106d17:	6a 00                	push   $0x0
80106d19:	6a 60                	push   $0x60
80106d1b:	e9 a1 f7 ff ff       	jmp    801064c1 <alltraps>

80106d20 <vector97>:
80106d20:	6a 00                	push   $0x0
80106d22:	6a 61                	push   $0x61
80106d24:	e9 98 f7 ff ff       	jmp    801064c1 <alltraps>

80106d29 <vector98>:
80106d29:	6a 00                	push   $0x0
80106d2b:	6a 62                	push   $0x62
80106d2d:	e9 8f f7 ff ff       	jmp    801064c1 <alltraps>

80106d32 <vector99>:
80106d32:	6a 00                	push   $0x0
80106d34:	6a 63                	push   $0x63
80106d36:	e9 86 f7 ff ff       	jmp    801064c1 <alltraps>

80106d3b <vector100>:
80106d3b:	6a 00                	push   $0x0
80106d3d:	6a 64                	push   $0x64
80106d3f:	e9 7d f7 ff ff       	jmp    801064c1 <alltraps>

80106d44 <vector101>:
80106d44:	6a 00                	push   $0x0
80106d46:	6a 65                	push   $0x65
80106d48:	e9 74 f7 ff ff       	jmp    801064c1 <alltraps>

80106d4d <vector102>:
80106d4d:	6a 00                	push   $0x0
80106d4f:	6a 66                	push   $0x66
80106d51:	e9 6b f7 ff ff       	jmp    801064c1 <alltraps>

80106d56 <vector103>:
80106d56:	6a 00                	push   $0x0
80106d58:	6a 67                	push   $0x67
80106d5a:	e9 62 f7 ff ff       	jmp    801064c1 <alltraps>

80106d5f <vector104>:
80106d5f:	6a 00                	push   $0x0
80106d61:	6a 68                	push   $0x68
80106d63:	e9 59 f7 ff ff       	jmp    801064c1 <alltraps>

80106d68 <vector105>:
80106d68:	6a 00                	push   $0x0
80106d6a:	6a 69                	push   $0x69
80106d6c:	e9 50 f7 ff ff       	jmp    801064c1 <alltraps>

80106d71 <vector106>:
80106d71:	6a 00                	push   $0x0
80106d73:	6a 6a                	push   $0x6a
80106d75:	e9 47 f7 ff ff       	jmp    801064c1 <alltraps>

80106d7a <vector107>:
80106d7a:	6a 00                	push   $0x0
80106d7c:	6a 6b                	push   $0x6b
80106d7e:	e9 3e f7 ff ff       	jmp    801064c1 <alltraps>

80106d83 <vector108>:
80106d83:	6a 00                	push   $0x0
80106d85:	6a 6c                	push   $0x6c
80106d87:	e9 35 f7 ff ff       	jmp    801064c1 <alltraps>

80106d8c <vector109>:
80106d8c:	6a 00                	push   $0x0
80106d8e:	6a 6d                	push   $0x6d
80106d90:	e9 2c f7 ff ff       	jmp    801064c1 <alltraps>

80106d95 <vector110>:
80106d95:	6a 00                	push   $0x0
80106d97:	6a 6e                	push   $0x6e
80106d99:	e9 23 f7 ff ff       	jmp    801064c1 <alltraps>

80106d9e <vector111>:
80106d9e:	6a 00                	push   $0x0
80106da0:	6a 6f                	push   $0x6f
80106da2:	e9 1a f7 ff ff       	jmp    801064c1 <alltraps>

80106da7 <vector112>:
80106da7:	6a 00                	push   $0x0
80106da9:	6a 70                	push   $0x70
80106dab:	e9 11 f7 ff ff       	jmp    801064c1 <alltraps>

80106db0 <vector113>:
80106db0:	6a 00                	push   $0x0
80106db2:	6a 71                	push   $0x71
80106db4:	e9 08 f7 ff ff       	jmp    801064c1 <alltraps>

80106db9 <vector114>:
80106db9:	6a 00                	push   $0x0
80106dbb:	6a 72                	push   $0x72
80106dbd:	e9 ff f6 ff ff       	jmp    801064c1 <alltraps>

80106dc2 <vector115>:
80106dc2:	6a 00                	push   $0x0
80106dc4:	6a 73                	push   $0x73
80106dc6:	e9 f6 f6 ff ff       	jmp    801064c1 <alltraps>

80106dcb <vector116>:
80106dcb:	6a 00                	push   $0x0
80106dcd:	6a 74                	push   $0x74
80106dcf:	e9 ed f6 ff ff       	jmp    801064c1 <alltraps>

80106dd4 <vector117>:
80106dd4:	6a 00                	push   $0x0
80106dd6:	6a 75                	push   $0x75
80106dd8:	e9 e4 f6 ff ff       	jmp    801064c1 <alltraps>

80106ddd <vector118>:
80106ddd:	6a 00                	push   $0x0
80106ddf:	6a 76                	push   $0x76
80106de1:	e9 db f6 ff ff       	jmp    801064c1 <alltraps>

80106de6 <vector119>:
80106de6:	6a 00                	push   $0x0
80106de8:	6a 77                	push   $0x77
80106dea:	e9 d2 f6 ff ff       	jmp    801064c1 <alltraps>

80106def <vector120>:
80106def:	6a 00                	push   $0x0
80106df1:	6a 78                	push   $0x78
80106df3:	e9 c9 f6 ff ff       	jmp    801064c1 <alltraps>

80106df8 <vector121>:
80106df8:	6a 00                	push   $0x0
80106dfa:	6a 79                	push   $0x79
80106dfc:	e9 c0 f6 ff ff       	jmp    801064c1 <alltraps>

80106e01 <vector122>:
80106e01:	6a 00                	push   $0x0
80106e03:	6a 7a                	push   $0x7a
80106e05:	e9 b7 f6 ff ff       	jmp    801064c1 <alltraps>

80106e0a <vector123>:
80106e0a:	6a 00                	push   $0x0
80106e0c:	6a 7b                	push   $0x7b
80106e0e:	e9 ae f6 ff ff       	jmp    801064c1 <alltraps>

80106e13 <vector124>:
80106e13:	6a 00                	push   $0x0
80106e15:	6a 7c                	push   $0x7c
80106e17:	e9 a5 f6 ff ff       	jmp    801064c1 <alltraps>

80106e1c <vector125>:
80106e1c:	6a 00                	push   $0x0
80106e1e:	6a 7d                	push   $0x7d
80106e20:	e9 9c f6 ff ff       	jmp    801064c1 <alltraps>

80106e25 <vector126>:
80106e25:	6a 00                	push   $0x0
80106e27:	6a 7e                	push   $0x7e
80106e29:	e9 93 f6 ff ff       	jmp    801064c1 <alltraps>

80106e2e <vector127>:
80106e2e:	6a 00                	push   $0x0
80106e30:	6a 7f                	push   $0x7f
80106e32:	e9 8a f6 ff ff       	jmp    801064c1 <alltraps>

80106e37 <vector128>:
80106e37:	6a 00                	push   $0x0
80106e39:	68 80 00 00 00       	push   $0x80
80106e3e:	e9 7e f6 ff ff       	jmp    801064c1 <alltraps>

80106e43 <vector129>:
80106e43:	6a 00                	push   $0x0
80106e45:	68 81 00 00 00       	push   $0x81
80106e4a:	e9 72 f6 ff ff       	jmp    801064c1 <alltraps>

80106e4f <vector130>:
80106e4f:	6a 00                	push   $0x0
80106e51:	68 82 00 00 00       	push   $0x82
80106e56:	e9 66 f6 ff ff       	jmp    801064c1 <alltraps>

80106e5b <vector131>:
80106e5b:	6a 00                	push   $0x0
80106e5d:	68 83 00 00 00       	push   $0x83
80106e62:	e9 5a f6 ff ff       	jmp    801064c1 <alltraps>

80106e67 <vector132>:
80106e67:	6a 00                	push   $0x0
80106e69:	68 84 00 00 00       	push   $0x84
80106e6e:	e9 4e f6 ff ff       	jmp    801064c1 <alltraps>

80106e73 <vector133>:
80106e73:	6a 00                	push   $0x0
80106e75:	68 85 00 00 00       	push   $0x85
80106e7a:	e9 42 f6 ff ff       	jmp    801064c1 <alltraps>

80106e7f <vector134>:
80106e7f:	6a 00                	push   $0x0
80106e81:	68 86 00 00 00       	push   $0x86
80106e86:	e9 36 f6 ff ff       	jmp    801064c1 <alltraps>

80106e8b <vector135>:
80106e8b:	6a 00                	push   $0x0
80106e8d:	68 87 00 00 00       	push   $0x87
80106e92:	e9 2a f6 ff ff       	jmp    801064c1 <alltraps>

80106e97 <vector136>:
80106e97:	6a 00                	push   $0x0
80106e99:	68 88 00 00 00       	push   $0x88
80106e9e:	e9 1e f6 ff ff       	jmp    801064c1 <alltraps>

80106ea3 <vector137>:
80106ea3:	6a 00                	push   $0x0
80106ea5:	68 89 00 00 00       	push   $0x89
80106eaa:	e9 12 f6 ff ff       	jmp    801064c1 <alltraps>

80106eaf <vector138>:
80106eaf:	6a 00                	push   $0x0
80106eb1:	68 8a 00 00 00       	push   $0x8a
80106eb6:	e9 06 f6 ff ff       	jmp    801064c1 <alltraps>

80106ebb <vector139>:
80106ebb:	6a 00                	push   $0x0
80106ebd:	68 8b 00 00 00       	push   $0x8b
80106ec2:	e9 fa f5 ff ff       	jmp    801064c1 <alltraps>

80106ec7 <vector140>:
80106ec7:	6a 00                	push   $0x0
80106ec9:	68 8c 00 00 00       	push   $0x8c
80106ece:	e9 ee f5 ff ff       	jmp    801064c1 <alltraps>

80106ed3 <vector141>:
80106ed3:	6a 00                	push   $0x0
80106ed5:	68 8d 00 00 00       	push   $0x8d
80106eda:	e9 e2 f5 ff ff       	jmp    801064c1 <alltraps>

80106edf <vector142>:
80106edf:	6a 00                	push   $0x0
80106ee1:	68 8e 00 00 00       	push   $0x8e
80106ee6:	e9 d6 f5 ff ff       	jmp    801064c1 <alltraps>

80106eeb <vector143>:
80106eeb:	6a 00                	push   $0x0
80106eed:	68 8f 00 00 00       	push   $0x8f
80106ef2:	e9 ca f5 ff ff       	jmp    801064c1 <alltraps>

80106ef7 <vector144>:
80106ef7:	6a 00                	push   $0x0
80106ef9:	68 90 00 00 00       	push   $0x90
80106efe:	e9 be f5 ff ff       	jmp    801064c1 <alltraps>

80106f03 <vector145>:
80106f03:	6a 00                	push   $0x0
80106f05:	68 91 00 00 00       	push   $0x91
80106f0a:	e9 b2 f5 ff ff       	jmp    801064c1 <alltraps>

80106f0f <vector146>:
80106f0f:	6a 00                	push   $0x0
80106f11:	68 92 00 00 00       	push   $0x92
80106f16:	e9 a6 f5 ff ff       	jmp    801064c1 <alltraps>

80106f1b <vector147>:
80106f1b:	6a 00                	push   $0x0
80106f1d:	68 93 00 00 00       	push   $0x93
80106f22:	e9 9a f5 ff ff       	jmp    801064c1 <alltraps>

80106f27 <vector148>:
80106f27:	6a 00                	push   $0x0
80106f29:	68 94 00 00 00       	push   $0x94
80106f2e:	e9 8e f5 ff ff       	jmp    801064c1 <alltraps>

80106f33 <vector149>:
80106f33:	6a 00                	push   $0x0
80106f35:	68 95 00 00 00       	push   $0x95
80106f3a:	e9 82 f5 ff ff       	jmp    801064c1 <alltraps>

80106f3f <vector150>:
80106f3f:	6a 00                	push   $0x0
80106f41:	68 96 00 00 00       	push   $0x96
80106f46:	e9 76 f5 ff ff       	jmp    801064c1 <alltraps>

80106f4b <vector151>:
80106f4b:	6a 00                	push   $0x0
80106f4d:	68 97 00 00 00       	push   $0x97
80106f52:	e9 6a f5 ff ff       	jmp    801064c1 <alltraps>

80106f57 <vector152>:
80106f57:	6a 00                	push   $0x0
80106f59:	68 98 00 00 00       	push   $0x98
80106f5e:	e9 5e f5 ff ff       	jmp    801064c1 <alltraps>

80106f63 <vector153>:
80106f63:	6a 00                	push   $0x0
80106f65:	68 99 00 00 00       	push   $0x99
80106f6a:	e9 52 f5 ff ff       	jmp    801064c1 <alltraps>

80106f6f <vector154>:
80106f6f:	6a 00                	push   $0x0
80106f71:	68 9a 00 00 00       	push   $0x9a
80106f76:	e9 46 f5 ff ff       	jmp    801064c1 <alltraps>

80106f7b <vector155>:
80106f7b:	6a 00                	push   $0x0
80106f7d:	68 9b 00 00 00       	push   $0x9b
80106f82:	e9 3a f5 ff ff       	jmp    801064c1 <alltraps>

80106f87 <vector156>:
80106f87:	6a 00                	push   $0x0
80106f89:	68 9c 00 00 00       	push   $0x9c
80106f8e:	e9 2e f5 ff ff       	jmp    801064c1 <alltraps>

80106f93 <vector157>:
80106f93:	6a 00                	push   $0x0
80106f95:	68 9d 00 00 00       	push   $0x9d
80106f9a:	e9 22 f5 ff ff       	jmp    801064c1 <alltraps>

80106f9f <vector158>:
80106f9f:	6a 00                	push   $0x0
80106fa1:	68 9e 00 00 00       	push   $0x9e
80106fa6:	e9 16 f5 ff ff       	jmp    801064c1 <alltraps>

80106fab <vector159>:
80106fab:	6a 00                	push   $0x0
80106fad:	68 9f 00 00 00       	push   $0x9f
80106fb2:	e9 0a f5 ff ff       	jmp    801064c1 <alltraps>

80106fb7 <vector160>:
80106fb7:	6a 00                	push   $0x0
80106fb9:	68 a0 00 00 00       	push   $0xa0
80106fbe:	e9 fe f4 ff ff       	jmp    801064c1 <alltraps>

80106fc3 <vector161>:
80106fc3:	6a 00                	push   $0x0
80106fc5:	68 a1 00 00 00       	push   $0xa1
80106fca:	e9 f2 f4 ff ff       	jmp    801064c1 <alltraps>

80106fcf <vector162>:
80106fcf:	6a 00                	push   $0x0
80106fd1:	68 a2 00 00 00       	push   $0xa2
80106fd6:	e9 e6 f4 ff ff       	jmp    801064c1 <alltraps>

80106fdb <vector163>:
80106fdb:	6a 00                	push   $0x0
80106fdd:	68 a3 00 00 00       	push   $0xa3
80106fe2:	e9 da f4 ff ff       	jmp    801064c1 <alltraps>

80106fe7 <vector164>:
80106fe7:	6a 00                	push   $0x0
80106fe9:	68 a4 00 00 00       	push   $0xa4
80106fee:	e9 ce f4 ff ff       	jmp    801064c1 <alltraps>

80106ff3 <vector165>:
80106ff3:	6a 00                	push   $0x0
80106ff5:	68 a5 00 00 00       	push   $0xa5
80106ffa:	e9 c2 f4 ff ff       	jmp    801064c1 <alltraps>

80106fff <vector166>:
80106fff:	6a 00                	push   $0x0
80107001:	68 a6 00 00 00       	push   $0xa6
80107006:	e9 b6 f4 ff ff       	jmp    801064c1 <alltraps>

8010700b <vector167>:
8010700b:	6a 00                	push   $0x0
8010700d:	68 a7 00 00 00       	push   $0xa7
80107012:	e9 aa f4 ff ff       	jmp    801064c1 <alltraps>

80107017 <vector168>:
80107017:	6a 00                	push   $0x0
80107019:	68 a8 00 00 00       	push   $0xa8
8010701e:	e9 9e f4 ff ff       	jmp    801064c1 <alltraps>

80107023 <vector169>:
80107023:	6a 00                	push   $0x0
80107025:	68 a9 00 00 00       	push   $0xa9
8010702a:	e9 92 f4 ff ff       	jmp    801064c1 <alltraps>

8010702f <vector170>:
8010702f:	6a 00                	push   $0x0
80107031:	68 aa 00 00 00       	push   $0xaa
80107036:	e9 86 f4 ff ff       	jmp    801064c1 <alltraps>

8010703b <vector171>:
8010703b:	6a 00                	push   $0x0
8010703d:	68 ab 00 00 00       	push   $0xab
80107042:	e9 7a f4 ff ff       	jmp    801064c1 <alltraps>

80107047 <vector172>:
80107047:	6a 00                	push   $0x0
80107049:	68 ac 00 00 00       	push   $0xac
8010704e:	e9 6e f4 ff ff       	jmp    801064c1 <alltraps>

80107053 <vector173>:
80107053:	6a 00                	push   $0x0
80107055:	68 ad 00 00 00       	push   $0xad
8010705a:	e9 62 f4 ff ff       	jmp    801064c1 <alltraps>

8010705f <vector174>:
8010705f:	6a 00                	push   $0x0
80107061:	68 ae 00 00 00       	push   $0xae
80107066:	e9 56 f4 ff ff       	jmp    801064c1 <alltraps>

8010706b <vector175>:
8010706b:	6a 00                	push   $0x0
8010706d:	68 af 00 00 00       	push   $0xaf
80107072:	e9 4a f4 ff ff       	jmp    801064c1 <alltraps>

80107077 <vector176>:
80107077:	6a 00                	push   $0x0
80107079:	68 b0 00 00 00       	push   $0xb0
8010707e:	e9 3e f4 ff ff       	jmp    801064c1 <alltraps>

80107083 <vector177>:
80107083:	6a 00                	push   $0x0
80107085:	68 b1 00 00 00       	push   $0xb1
8010708a:	e9 32 f4 ff ff       	jmp    801064c1 <alltraps>

8010708f <vector178>:
8010708f:	6a 00                	push   $0x0
80107091:	68 b2 00 00 00       	push   $0xb2
80107096:	e9 26 f4 ff ff       	jmp    801064c1 <alltraps>

8010709b <vector179>:
8010709b:	6a 00                	push   $0x0
8010709d:	68 b3 00 00 00       	push   $0xb3
801070a2:	e9 1a f4 ff ff       	jmp    801064c1 <alltraps>

801070a7 <vector180>:
801070a7:	6a 00                	push   $0x0
801070a9:	68 b4 00 00 00       	push   $0xb4
801070ae:	e9 0e f4 ff ff       	jmp    801064c1 <alltraps>

801070b3 <vector181>:
801070b3:	6a 00                	push   $0x0
801070b5:	68 b5 00 00 00       	push   $0xb5
801070ba:	e9 02 f4 ff ff       	jmp    801064c1 <alltraps>

801070bf <vector182>:
801070bf:	6a 00                	push   $0x0
801070c1:	68 b6 00 00 00       	push   $0xb6
801070c6:	e9 f6 f3 ff ff       	jmp    801064c1 <alltraps>

801070cb <vector183>:
801070cb:	6a 00                	push   $0x0
801070cd:	68 b7 00 00 00       	push   $0xb7
801070d2:	e9 ea f3 ff ff       	jmp    801064c1 <alltraps>

801070d7 <vector184>:
801070d7:	6a 00                	push   $0x0
801070d9:	68 b8 00 00 00       	push   $0xb8
801070de:	e9 de f3 ff ff       	jmp    801064c1 <alltraps>

801070e3 <vector185>:
801070e3:	6a 00                	push   $0x0
801070e5:	68 b9 00 00 00       	push   $0xb9
801070ea:	e9 d2 f3 ff ff       	jmp    801064c1 <alltraps>

801070ef <vector186>:
801070ef:	6a 00                	push   $0x0
801070f1:	68 ba 00 00 00       	push   $0xba
801070f6:	e9 c6 f3 ff ff       	jmp    801064c1 <alltraps>

801070fb <vector187>:
801070fb:	6a 00                	push   $0x0
801070fd:	68 bb 00 00 00       	push   $0xbb
80107102:	e9 ba f3 ff ff       	jmp    801064c1 <alltraps>

80107107 <vector188>:
80107107:	6a 00                	push   $0x0
80107109:	68 bc 00 00 00       	push   $0xbc
8010710e:	e9 ae f3 ff ff       	jmp    801064c1 <alltraps>

80107113 <vector189>:
80107113:	6a 00                	push   $0x0
80107115:	68 bd 00 00 00       	push   $0xbd
8010711a:	e9 a2 f3 ff ff       	jmp    801064c1 <alltraps>

8010711f <vector190>:
8010711f:	6a 00                	push   $0x0
80107121:	68 be 00 00 00       	push   $0xbe
80107126:	e9 96 f3 ff ff       	jmp    801064c1 <alltraps>

8010712b <vector191>:
8010712b:	6a 00                	push   $0x0
8010712d:	68 bf 00 00 00       	push   $0xbf
80107132:	e9 8a f3 ff ff       	jmp    801064c1 <alltraps>

80107137 <vector192>:
80107137:	6a 00                	push   $0x0
80107139:	68 c0 00 00 00       	push   $0xc0
8010713e:	e9 7e f3 ff ff       	jmp    801064c1 <alltraps>

80107143 <vector193>:
80107143:	6a 00                	push   $0x0
80107145:	68 c1 00 00 00       	push   $0xc1
8010714a:	e9 72 f3 ff ff       	jmp    801064c1 <alltraps>

8010714f <vector194>:
8010714f:	6a 00                	push   $0x0
80107151:	68 c2 00 00 00       	push   $0xc2
80107156:	e9 66 f3 ff ff       	jmp    801064c1 <alltraps>

8010715b <vector195>:
8010715b:	6a 00                	push   $0x0
8010715d:	68 c3 00 00 00       	push   $0xc3
80107162:	e9 5a f3 ff ff       	jmp    801064c1 <alltraps>

80107167 <vector196>:
80107167:	6a 00                	push   $0x0
80107169:	68 c4 00 00 00       	push   $0xc4
8010716e:	e9 4e f3 ff ff       	jmp    801064c1 <alltraps>

80107173 <vector197>:
80107173:	6a 00                	push   $0x0
80107175:	68 c5 00 00 00       	push   $0xc5
8010717a:	e9 42 f3 ff ff       	jmp    801064c1 <alltraps>

8010717f <vector198>:
8010717f:	6a 00                	push   $0x0
80107181:	68 c6 00 00 00       	push   $0xc6
80107186:	e9 36 f3 ff ff       	jmp    801064c1 <alltraps>

8010718b <vector199>:
8010718b:	6a 00                	push   $0x0
8010718d:	68 c7 00 00 00       	push   $0xc7
80107192:	e9 2a f3 ff ff       	jmp    801064c1 <alltraps>

80107197 <vector200>:
80107197:	6a 00                	push   $0x0
80107199:	68 c8 00 00 00       	push   $0xc8
8010719e:	e9 1e f3 ff ff       	jmp    801064c1 <alltraps>

801071a3 <vector201>:
801071a3:	6a 00                	push   $0x0
801071a5:	68 c9 00 00 00       	push   $0xc9
801071aa:	e9 12 f3 ff ff       	jmp    801064c1 <alltraps>

801071af <vector202>:
801071af:	6a 00                	push   $0x0
801071b1:	68 ca 00 00 00       	push   $0xca
801071b6:	e9 06 f3 ff ff       	jmp    801064c1 <alltraps>

801071bb <vector203>:
801071bb:	6a 00                	push   $0x0
801071bd:	68 cb 00 00 00       	push   $0xcb
801071c2:	e9 fa f2 ff ff       	jmp    801064c1 <alltraps>

801071c7 <vector204>:
801071c7:	6a 00                	push   $0x0
801071c9:	68 cc 00 00 00       	push   $0xcc
801071ce:	e9 ee f2 ff ff       	jmp    801064c1 <alltraps>

801071d3 <vector205>:
801071d3:	6a 00                	push   $0x0
801071d5:	68 cd 00 00 00       	push   $0xcd
801071da:	e9 e2 f2 ff ff       	jmp    801064c1 <alltraps>

801071df <vector206>:
801071df:	6a 00                	push   $0x0
801071e1:	68 ce 00 00 00       	push   $0xce
801071e6:	e9 d6 f2 ff ff       	jmp    801064c1 <alltraps>

801071eb <vector207>:
801071eb:	6a 00                	push   $0x0
801071ed:	68 cf 00 00 00       	push   $0xcf
801071f2:	e9 ca f2 ff ff       	jmp    801064c1 <alltraps>

801071f7 <vector208>:
801071f7:	6a 00                	push   $0x0
801071f9:	68 d0 00 00 00       	push   $0xd0
801071fe:	e9 be f2 ff ff       	jmp    801064c1 <alltraps>

80107203 <vector209>:
80107203:	6a 00                	push   $0x0
80107205:	68 d1 00 00 00       	push   $0xd1
8010720a:	e9 b2 f2 ff ff       	jmp    801064c1 <alltraps>

8010720f <vector210>:
8010720f:	6a 00                	push   $0x0
80107211:	68 d2 00 00 00       	push   $0xd2
80107216:	e9 a6 f2 ff ff       	jmp    801064c1 <alltraps>

8010721b <vector211>:
8010721b:	6a 00                	push   $0x0
8010721d:	68 d3 00 00 00       	push   $0xd3
80107222:	e9 9a f2 ff ff       	jmp    801064c1 <alltraps>

80107227 <vector212>:
80107227:	6a 00                	push   $0x0
80107229:	68 d4 00 00 00       	push   $0xd4
8010722e:	e9 8e f2 ff ff       	jmp    801064c1 <alltraps>

80107233 <vector213>:
80107233:	6a 00                	push   $0x0
80107235:	68 d5 00 00 00       	push   $0xd5
8010723a:	e9 82 f2 ff ff       	jmp    801064c1 <alltraps>

8010723f <vector214>:
8010723f:	6a 00                	push   $0x0
80107241:	68 d6 00 00 00       	push   $0xd6
80107246:	e9 76 f2 ff ff       	jmp    801064c1 <alltraps>

8010724b <vector215>:
8010724b:	6a 00                	push   $0x0
8010724d:	68 d7 00 00 00       	push   $0xd7
80107252:	e9 6a f2 ff ff       	jmp    801064c1 <alltraps>

80107257 <vector216>:
80107257:	6a 00                	push   $0x0
80107259:	68 d8 00 00 00       	push   $0xd8
8010725e:	e9 5e f2 ff ff       	jmp    801064c1 <alltraps>

80107263 <vector217>:
80107263:	6a 00                	push   $0x0
80107265:	68 d9 00 00 00       	push   $0xd9
8010726a:	e9 52 f2 ff ff       	jmp    801064c1 <alltraps>

8010726f <vector218>:
8010726f:	6a 00                	push   $0x0
80107271:	68 da 00 00 00       	push   $0xda
80107276:	e9 46 f2 ff ff       	jmp    801064c1 <alltraps>

8010727b <vector219>:
8010727b:	6a 00                	push   $0x0
8010727d:	68 db 00 00 00       	push   $0xdb
80107282:	e9 3a f2 ff ff       	jmp    801064c1 <alltraps>

80107287 <vector220>:
80107287:	6a 00                	push   $0x0
80107289:	68 dc 00 00 00       	push   $0xdc
8010728e:	e9 2e f2 ff ff       	jmp    801064c1 <alltraps>

80107293 <vector221>:
80107293:	6a 00                	push   $0x0
80107295:	68 dd 00 00 00       	push   $0xdd
8010729a:	e9 22 f2 ff ff       	jmp    801064c1 <alltraps>

8010729f <vector222>:
8010729f:	6a 00                	push   $0x0
801072a1:	68 de 00 00 00       	push   $0xde
801072a6:	e9 16 f2 ff ff       	jmp    801064c1 <alltraps>

801072ab <vector223>:
801072ab:	6a 00                	push   $0x0
801072ad:	68 df 00 00 00       	push   $0xdf
801072b2:	e9 0a f2 ff ff       	jmp    801064c1 <alltraps>

801072b7 <vector224>:
801072b7:	6a 00                	push   $0x0
801072b9:	68 e0 00 00 00       	push   $0xe0
801072be:	e9 fe f1 ff ff       	jmp    801064c1 <alltraps>

801072c3 <vector225>:
801072c3:	6a 00                	push   $0x0
801072c5:	68 e1 00 00 00       	push   $0xe1
801072ca:	e9 f2 f1 ff ff       	jmp    801064c1 <alltraps>

801072cf <vector226>:
801072cf:	6a 00                	push   $0x0
801072d1:	68 e2 00 00 00       	push   $0xe2
801072d6:	e9 e6 f1 ff ff       	jmp    801064c1 <alltraps>

801072db <vector227>:
801072db:	6a 00                	push   $0x0
801072dd:	68 e3 00 00 00       	push   $0xe3
801072e2:	e9 da f1 ff ff       	jmp    801064c1 <alltraps>

801072e7 <vector228>:
801072e7:	6a 00                	push   $0x0
801072e9:	68 e4 00 00 00       	push   $0xe4
801072ee:	e9 ce f1 ff ff       	jmp    801064c1 <alltraps>

801072f3 <vector229>:
801072f3:	6a 00                	push   $0x0
801072f5:	68 e5 00 00 00       	push   $0xe5
801072fa:	e9 c2 f1 ff ff       	jmp    801064c1 <alltraps>

801072ff <vector230>:
801072ff:	6a 00                	push   $0x0
80107301:	68 e6 00 00 00       	push   $0xe6
80107306:	e9 b6 f1 ff ff       	jmp    801064c1 <alltraps>

8010730b <vector231>:
8010730b:	6a 00                	push   $0x0
8010730d:	68 e7 00 00 00       	push   $0xe7
80107312:	e9 aa f1 ff ff       	jmp    801064c1 <alltraps>

80107317 <vector232>:
80107317:	6a 00                	push   $0x0
80107319:	68 e8 00 00 00       	push   $0xe8
8010731e:	e9 9e f1 ff ff       	jmp    801064c1 <alltraps>

80107323 <vector233>:
80107323:	6a 00                	push   $0x0
80107325:	68 e9 00 00 00       	push   $0xe9
8010732a:	e9 92 f1 ff ff       	jmp    801064c1 <alltraps>

8010732f <vector234>:
8010732f:	6a 00                	push   $0x0
80107331:	68 ea 00 00 00       	push   $0xea
80107336:	e9 86 f1 ff ff       	jmp    801064c1 <alltraps>

8010733b <vector235>:
8010733b:	6a 00                	push   $0x0
8010733d:	68 eb 00 00 00       	push   $0xeb
80107342:	e9 7a f1 ff ff       	jmp    801064c1 <alltraps>

80107347 <vector236>:
80107347:	6a 00                	push   $0x0
80107349:	68 ec 00 00 00       	push   $0xec
8010734e:	e9 6e f1 ff ff       	jmp    801064c1 <alltraps>

80107353 <vector237>:
80107353:	6a 00                	push   $0x0
80107355:	68 ed 00 00 00       	push   $0xed
8010735a:	e9 62 f1 ff ff       	jmp    801064c1 <alltraps>

8010735f <vector238>:
8010735f:	6a 00                	push   $0x0
80107361:	68 ee 00 00 00       	push   $0xee
80107366:	e9 56 f1 ff ff       	jmp    801064c1 <alltraps>

8010736b <vector239>:
8010736b:	6a 00                	push   $0x0
8010736d:	68 ef 00 00 00       	push   $0xef
80107372:	e9 4a f1 ff ff       	jmp    801064c1 <alltraps>

80107377 <vector240>:
80107377:	6a 00                	push   $0x0
80107379:	68 f0 00 00 00       	push   $0xf0
8010737e:	e9 3e f1 ff ff       	jmp    801064c1 <alltraps>

80107383 <vector241>:
80107383:	6a 00                	push   $0x0
80107385:	68 f1 00 00 00       	push   $0xf1
8010738a:	e9 32 f1 ff ff       	jmp    801064c1 <alltraps>

8010738f <vector242>:
8010738f:	6a 00                	push   $0x0
80107391:	68 f2 00 00 00       	push   $0xf2
80107396:	e9 26 f1 ff ff       	jmp    801064c1 <alltraps>

8010739b <vector243>:
8010739b:	6a 00                	push   $0x0
8010739d:	68 f3 00 00 00       	push   $0xf3
801073a2:	e9 1a f1 ff ff       	jmp    801064c1 <alltraps>

801073a7 <vector244>:
801073a7:	6a 00                	push   $0x0
801073a9:	68 f4 00 00 00       	push   $0xf4
801073ae:	e9 0e f1 ff ff       	jmp    801064c1 <alltraps>

801073b3 <vector245>:
801073b3:	6a 00                	push   $0x0
801073b5:	68 f5 00 00 00       	push   $0xf5
801073ba:	e9 02 f1 ff ff       	jmp    801064c1 <alltraps>

801073bf <vector246>:
801073bf:	6a 00                	push   $0x0
801073c1:	68 f6 00 00 00       	push   $0xf6
801073c6:	e9 f6 f0 ff ff       	jmp    801064c1 <alltraps>

801073cb <vector247>:
801073cb:	6a 00                	push   $0x0
801073cd:	68 f7 00 00 00       	push   $0xf7
801073d2:	e9 ea f0 ff ff       	jmp    801064c1 <alltraps>

801073d7 <vector248>:
801073d7:	6a 00                	push   $0x0
801073d9:	68 f8 00 00 00       	push   $0xf8
801073de:	e9 de f0 ff ff       	jmp    801064c1 <alltraps>

801073e3 <vector249>:
801073e3:	6a 00                	push   $0x0
801073e5:	68 f9 00 00 00       	push   $0xf9
801073ea:	e9 d2 f0 ff ff       	jmp    801064c1 <alltraps>

801073ef <vector250>:
801073ef:	6a 00                	push   $0x0
801073f1:	68 fa 00 00 00       	push   $0xfa
801073f6:	e9 c6 f0 ff ff       	jmp    801064c1 <alltraps>

801073fb <vector251>:
801073fb:	6a 00                	push   $0x0
801073fd:	68 fb 00 00 00       	push   $0xfb
80107402:	e9 ba f0 ff ff       	jmp    801064c1 <alltraps>

80107407 <vector252>:
80107407:	6a 00                	push   $0x0
80107409:	68 fc 00 00 00       	push   $0xfc
8010740e:	e9 ae f0 ff ff       	jmp    801064c1 <alltraps>

80107413 <vector253>:
80107413:	6a 00                	push   $0x0
80107415:	68 fd 00 00 00       	push   $0xfd
8010741a:	e9 a2 f0 ff ff       	jmp    801064c1 <alltraps>

8010741f <vector254>:
8010741f:	6a 00                	push   $0x0
80107421:	68 fe 00 00 00       	push   $0xfe
80107426:	e9 96 f0 ff ff       	jmp    801064c1 <alltraps>

8010742b <vector255>:
8010742b:	6a 00                	push   $0x0
8010742d:	68 ff 00 00 00       	push   $0xff
80107432:	e9 8a f0 ff ff       	jmp    801064c1 <alltraps>
80107437:	66 90                	xchg   %ax,%ax
80107439:	66 90                	xchg   %ax,%ax
8010743b:	66 90                	xchg   %ax,%ax
8010743d:	66 90                	xchg   %ax,%ax
8010743f:	90                   	nop

80107440 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107440:	55                   	push   %ebp
80107441:	89 e5                	mov    %esp,%ebp
80107443:	57                   	push   %edi
80107444:	56                   	push   %esi
80107445:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80107446:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
8010744c:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107452:	83 ec 1c             	sub    $0x1c,%esp
  for(; a  < oldsz; a += PGSIZE){
80107455:	39 d3                	cmp    %edx,%ebx
80107457:	73 56                	jae    801074af <deallocuvm.part.0+0x6f>
80107459:	89 4d e0             	mov    %ecx,-0x20(%ebp)
8010745c:	89 c6                	mov    %eax,%esi
8010745e:	89 d7                	mov    %edx,%edi
80107460:	eb 12                	jmp    80107474 <deallocuvm.part.0+0x34>
80107462:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80107468:	83 c2 01             	add    $0x1,%edx
8010746b:	89 d3                	mov    %edx,%ebx
8010746d:	c1 e3 16             	shl    $0x16,%ebx
  for(; a  < oldsz; a += PGSIZE){
80107470:	39 fb                	cmp    %edi,%ebx
80107472:	73 38                	jae    801074ac <deallocuvm.part.0+0x6c>
  pde = &pgdir[PDX(va)];
80107474:	89 da                	mov    %ebx,%edx
80107476:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
80107479:	8b 04 96             	mov    (%esi,%edx,4),%eax
8010747c:	a8 01                	test   $0x1,%al
8010747e:	74 e8                	je     80107468 <deallocuvm.part.0+0x28>
  return &pgtab[PTX(va)];
80107480:	89 d9                	mov    %ebx,%ecx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107482:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107487:	c1 e9 0a             	shr    $0xa,%ecx
8010748a:	81 e1 fc 0f 00 00    	and    $0xffc,%ecx
80107490:	8d 84 08 00 00 00 80 	lea    -0x80000000(%eax,%ecx,1),%eax
    if(!pte)
80107497:	85 c0                	test   %eax,%eax
80107499:	74 cd                	je     80107468 <deallocuvm.part.0+0x28>
    else if((*pte & PTE_P) != 0){
8010749b:	8b 10                	mov    (%eax),%edx
8010749d:	f6 c2 01             	test   $0x1,%dl
801074a0:	75 1e                	jne    801074c0 <deallocuvm.part.0+0x80>
  for(; a  < oldsz; a += PGSIZE){
801074a2:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801074a8:	39 fb                	cmp    %edi,%ebx
801074aa:	72 c8                	jb     80107474 <deallocuvm.part.0+0x34>
801074ac:	8b 4d e0             	mov    -0x20(%ebp),%ecx
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
801074af:	8d 65 f4             	lea    -0xc(%ebp),%esp
801074b2:	89 c8                	mov    %ecx,%eax
801074b4:	5b                   	pop    %ebx
801074b5:	5e                   	pop    %esi
801074b6:	5f                   	pop    %edi
801074b7:	5d                   	pop    %ebp
801074b8:	c3                   	ret
801074b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(pa == 0)
801074c0:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
801074c6:	74 26                	je     801074ee <deallocuvm.part.0+0xae>
      kfree(v);
801074c8:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
801074cb:	81 c2 00 00 00 80    	add    $0x80000000,%edx
801074d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
801074d4:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
801074da:	52                   	push   %edx
801074db:	e8 d0 af ff ff       	call   801024b0 <kfree>
      *pte = 0;
801074e0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  for(; a  < oldsz; a += PGSIZE){
801074e3:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
801074e6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801074ec:	eb 82                	jmp    80107470 <deallocuvm.part.0+0x30>
        panic("kfree");
801074ee:	83 ec 0c             	sub    $0xc,%esp
801074f1:	68 cc 7f 10 80       	push   $0x80107fcc
801074f6:	e8 85 8e ff ff       	call   80100380 <panic>
801074fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80107500 <mappages>:
{
80107500:	55                   	push   %ebp
80107501:	89 e5                	mov    %esp,%ebp
80107503:	57                   	push   %edi
80107504:	56                   	push   %esi
80107505:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80107506:	89 d3                	mov    %edx,%ebx
80107508:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
8010750e:	83 ec 1c             	sub    $0x1c,%esp
80107511:	89 45 e0             	mov    %eax,-0x20(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107514:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80107518:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010751d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107520:	8b 45 08             	mov    0x8(%ebp),%eax
80107523:	29 d8                	sub    %ebx,%eax
80107525:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107528:	eb 3f                	jmp    80107569 <mappages+0x69>
8010752a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107530:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107532:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107537:	c1 ea 0a             	shr    $0xa,%edx
8010753a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107540:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107547:	85 c0                	test   %eax,%eax
80107549:	74 75                	je     801075c0 <mappages+0xc0>
    if(*pte & PTE_P)
8010754b:	f6 00 01             	testb  $0x1,(%eax)
8010754e:	0f 85 86 00 00 00    	jne    801075da <mappages+0xda>
    *pte = pa | perm | PTE_P;
80107554:	0b 75 0c             	or     0xc(%ebp),%esi
80107557:	83 ce 01             	or     $0x1,%esi
8010755a:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010755c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010755f:	39 c3                	cmp    %eax,%ebx
80107561:	74 6d                	je     801075d0 <mappages+0xd0>
    a += PGSIZE;
80107563:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
80107569:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  pde = &pgdir[PDX(va)];
8010756c:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010756f:	8d 34 03             	lea    (%ebx,%eax,1),%esi
80107572:	89 d8                	mov    %ebx,%eax
80107574:	c1 e8 16             	shr    $0x16,%eax
80107577:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
8010757a:	8b 07                	mov    (%edi),%eax
8010757c:	a8 01                	test   $0x1,%al
8010757e:	75 b0                	jne    80107530 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107580:	e8 eb b0 ff ff       	call   80102670 <kalloc>
80107585:	85 c0                	test   %eax,%eax
80107587:	74 37                	je     801075c0 <mappages+0xc0>
    memset(pgtab, 0, PGSIZE);
80107589:	83 ec 04             	sub    $0x4,%esp
8010758c:	68 00 10 00 00       	push   $0x1000
80107591:	6a 00                	push   $0x0
80107593:	50                   	push   %eax
80107594:	89 45 d8             	mov    %eax,-0x28(%ebp)
80107597:	e8 c4 dc ff ff       	call   80105260 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010759c:	8b 55 d8             	mov    -0x28(%ebp),%edx
  return &pgtab[PTX(va)];
8010759f:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801075a2:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
801075a8:	83 c8 07             	or     $0x7,%eax
801075ab:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
801075ad:	89 d8                	mov    %ebx,%eax
801075af:	c1 e8 0a             	shr    $0xa,%eax
801075b2:	25 fc 0f 00 00       	and    $0xffc,%eax
801075b7:	01 d0                	add    %edx,%eax
801075b9:	eb 90                	jmp    8010754b <mappages+0x4b>
801075bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
}
801075c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801075c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801075c8:	5b                   	pop    %ebx
801075c9:	5e                   	pop    %esi
801075ca:	5f                   	pop    %edi
801075cb:	5d                   	pop    %ebp
801075cc:	c3                   	ret
801075cd:	8d 76 00             	lea    0x0(%esi),%esi
801075d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801075d3:	31 c0                	xor    %eax,%eax
}
801075d5:	5b                   	pop    %ebx
801075d6:	5e                   	pop    %esi
801075d7:	5f                   	pop    %edi
801075d8:	5d                   	pop    %ebp
801075d9:	c3                   	ret
      panic("remap");
801075da:	83 ec 0c             	sub    $0xc,%esp
801075dd:	68 46 82 10 80       	push   $0x80108246
801075e2:	e8 99 8d ff ff       	call   80100380 <panic>
801075e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801075ee:	00 
801075ef:	90                   	nop

801075f0 <seginit>:
{
801075f0:	55                   	push   %ebp
801075f1:	89 e5                	mov    %esp,%ebp
801075f3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
801075f6:	e8 c5 c4 ff ff       	call   80103ac0 <cpuid>
  pd[0] = size-1;
801075fb:	ba 2f 00 00 00       	mov    $0x2f,%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107600:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80107606:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
8010760a:	c7 80 18 28 11 80 ff 	movl   $0xffff,-0x7feed7e8(%eax)
80107611:	ff 00 00 
80107614:	c7 80 1c 28 11 80 00 	movl   $0xcf9a00,-0x7feed7e4(%eax)
8010761b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010761e:	c7 80 20 28 11 80 ff 	movl   $0xffff,-0x7feed7e0(%eax)
80107625:	ff 00 00 
80107628:	c7 80 24 28 11 80 00 	movl   $0xcf9200,-0x7feed7dc(%eax)
8010762f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107632:	c7 80 28 28 11 80 ff 	movl   $0xffff,-0x7feed7d8(%eax)
80107639:	ff 00 00 
8010763c:	c7 80 2c 28 11 80 00 	movl   $0xcffa00,-0x7feed7d4(%eax)
80107643:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107646:	c7 80 30 28 11 80 ff 	movl   $0xffff,-0x7feed7d0(%eax)
8010764d:	ff 00 00 
80107650:	c7 80 34 28 11 80 00 	movl   $0xcff200,-0x7feed7cc(%eax)
80107657:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
8010765a:	05 10 28 11 80       	add    $0x80112810,%eax
  pd[1] = (uint)p;
8010765f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80107663:	c1 e8 10             	shr    $0x10,%eax
80107666:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
8010766a:	8d 45 f2             	lea    -0xe(%ebp),%eax
8010766d:	0f 01 10             	lgdtl  (%eax)
}
80107670:	c9                   	leave
80107671:	c3                   	ret
80107672:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107679:	00 
8010767a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107680 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107680:	a1 e4 67 11 80       	mov    0x801167e4,%eax
80107685:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010768a:	0f 22 d8             	mov    %eax,%cr3
}
8010768d:	c3                   	ret
8010768e:	66 90                	xchg   %ax,%ax

80107690 <switchuvm>:
{
80107690:	55                   	push   %ebp
80107691:	89 e5                	mov    %esp,%ebp
80107693:	57                   	push   %edi
80107694:	56                   	push   %esi
80107695:	53                   	push   %ebx
80107696:	83 ec 1c             	sub    $0x1c,%esp
80107699:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
8010769c:	85 f6                	test   %esi,%esi
8010769e:	0f 84 cb 00 00 00    	je     8010776f <switchuvm+0xdf>
  if(p->kstack == 0)
801076a4:	8b 46 08             	mov    0x8(%esi),%eax
801076a7:	85 c0                	test   %eax,%eax
801076a9:	0f 84 da 00 00 00    	je     80107789 <switchuvm+0xf9>
  if(p->pgdir == 0)
801076af:	8b 46 04             	mov    0x4(%esi),%eax
801076b2:	85 c0                	test   %eax,%eax
801076b4:	0f 84 c2 00 00 00    	je     8010777c <switchuvm+0xec>
  pushcli();
801076ba:	e8 51 d9 ff ff       	call   80105010 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801076bf:	e8 9c c3 ff ff       	call   80103a60 <mycpu>
801076c4:	89 c3                	mov    %eax,%ebx
801076c6:	e8 95 c3 ff ff       	call   80103a60 <mycpu>
801076cb:	89 c7                	mov    %eax,%edi
801076cd:	e8 8e c3 ff ff       	call   80103a60 <mycpu>
801076d2:	83 c7 08             	add    $0x8,%edi
801076d5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801076d8:	e8 83 c3 ff ff       	call   80103a60 <mycpu>
801076dd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801076e0:	ba 67 00 00 00       	mov    $0x67,%edx
801076e5:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
801076ec:	83 c0 08             	add    $0x8,%eax
801076ef:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801076f6:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801076fb:	83 c1 08             	add    $0x8,%ecx
801076fe:	c1 e8 18             	shr    $0x18,%eax
80107701:	c1 e9 10             	shr    $0x10,%ecx
80107704:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
8010770a:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80107710:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107715:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010771c:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80107721:	e8 3a c3 ff ff       	call   80103a60 <mycpu>
80107726:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010772d:	e8 2e c3 ff ff       	call   80103a60 <mycpu>
80107732:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80107736:	8b 5e 08             	mov    0x8(%esi),%ebx
80107739:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010773f:	e8 1c c3 ff ff       	call   80103a60 <mycpu>
80107744:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107747:	e8 14 c3 ff ff       	call   80103a60 <mycpu>
8010774c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80107750:	b8 28 00 00 00       	mov    $0x28,%eax
80107755:	0f 00 d8             	ltr    %eax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80107758:	8b 46 04             	mov    0x4(%esi),%eax
8010775b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107760:	0f 22 d8             	mov    %eax,%cr3
}
80107763:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107766:	5b                   	pop    %ebx
80107767:	5e                   	pop    %esi
80107768:	5f                   	pop    %edi
80107769:	5d                   	pop    %ebp
  popcli();
8010776a:	e9 f1 d8 ff ff       	jmp    80105060 <popcli>
    panic("switchuvm: no process");
8010776f:	83 ec 0c             	sub    $0xc,%esp
80107772:	68 4c 82 10 80       	push   $0x8010824c
80107777:	e8 04 8c ff ff       	call   80100380 <panic>
    panic("switchuvm: no pgdir");
8010777c:	83 ec 0c             	sub    $0xc,%esp
8010777f:	68 77 82 10 80       	push   $0x80108277
80107784:	e8 f7 8b ff ff       	call   80100380 <panic>
    panic("switchuvm: no kstack");
80107789:	83 ec 0c             	sub    $0xc,%esp
8010778c:	68 62 82 10 80       	push   $0x80108262
80107791:	e8 ea 8b ff ff       	call   80100380 <panic>
80107796:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010779d:	00 
8010779e:	66 90                	xchg   %ax,%ax

801077a0 <inituvm>:
{
801077a0:	55                   	push   %ebp
801077a1:	89 e5                	mov    %esp,%ebp
801077a3:	57                   	push   %edi
801077a4:	56                   	push   %esi
801077a5:	53                   	push   %ebx
801077a6:	83 ec 1c             	sub    $0x1c,%esp
801077a9:	8b 45 08             	mov    0x8(%ebp),%eax
801077ac:	8b 75 10             	mov    0x10(%ebp),%esi
801077af:	8b 7d 0c             	mov    0xc(%ebp),%edi
801077b2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
801077b5:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
801077bb:	77 49                	ja     80107806 <inituvm+0x66>
  mem = kalloc();
801077bd:	e8 ae ae ff ff       	call   80102670 <kalloc>
  memset(mem, 0, PGSIZE);
801077c2:	83 ec 04             	sub    $0x4,%esp
801077c5:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
801077ca:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
801077cc:	6a 00                	push   $0x0
801077ce:	50                   	push   %eax
801077cf:	e8 8c da ff ff       	call   80105260 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
801077d4:	58                   	pop    %eax
801077d5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801077db:	5a                   	pop    %edx
801077dc:	6a 06                	push   $0x6
801077de:	b9 00 10 00 00       	mov    $0x1000,%ecx
801077e3:	31 d2                	xor    %edx,%edx
801077e5:	50                   	push   %eax
801077e6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801077e9:	e8 12 fd ff ff       	call   80107500 <mappages>
  memmove(mem, init, sz);
801077ee:	83 c4 10             	add    $0x10,%esp
801077f1:	89 75 10             	mov    %esi,0x10(%ebp)
801077f4:	89 7d 0c             	mov    %edi,0xc(%ebp)
801077f7:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801077fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801077fd:	5b                   	pop    %ebx
801077fe:	5e                   	pop    %esi
801077ff:	5f                   	pop    %edi
80107800:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107801:	e9 ea da ff ff       	jmp    801052f0 <memmove>
    panic("inituvm: more than a page");
80107806:	83 ec 0c             	sub    $0xc,%esp
80107809:	68 8b 82 10 80       	push   $0x8010828b
8010780e:	e8 6d 8b ff ff       	call   80100380 <panic>
80107813:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010781a:	00 
8010781b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80107820 <loaduvm>:
{
80107820:	55                   	push   %ebp
80107821:	89 e5                	mov    %esp,%ebp
80107823:	57                   	push   %edi
80107824:	56                   	push   %esi
80107825:	53                   	push   %ebx
80107826:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80107829:	8b 75 0c             	mov    0xc(%ebp),%esi
{
8010782c:	8b 7d 18             	mov    0x18(%ebp),%edi
  if((uint) addr % PGSIZE != 0)
8010782f:	81 e6 ff 0f 00 00    	and    $0xfff,%esi
80107835:	0f 85 a2 00 00 00    	jne    801078dd <loaduvm+0xbd>
  for(i = 0; i < sz; i += PGSIZE){
8010783b:	85 ff                	test   %edi,%edi
8010783d:	74 7d                	je     801078bc <loaduvm+0x9c>
8010783f:	90                   	nop
  pde = &pgdir[PDX(va)];
80107840:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107843:	8b 55 08             	mov    0x8(%ebp),%edx
80107846:	01 f0                	add    %esi,%eax
  pde = &pgdir[PDX(va)];
80107848:	89 c1                	mov    %eax,%ecx
8010784a:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
8010784d:	8b 0c 8a             	mov    (%edx,%ecx,4),%ecx
80107850:	f6 c1 01             	test   $0x1,%cl
80107853:	75 13                	jne    80107868 <loaduvm+0x48>
      panic("loaduvm: address should exist");
80107855:	83 ec 0c             	sub    $0xc,%esp
80107858:	68 a5 82 10 80       	push   $0x801082a5
8010785d:	e8 1e 8b ff ff       	call   80100380 <panic>
80107862:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107868:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010786b:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80107871:	25 fc 0f 00 00       	and    $0xffc,%eax
80107876:	8d 8c 01 00 00 00 80 	lea    -0x80000000(%ecx,%eax,1),%ecx
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
8010787d:	85 c9                	test   %ecx,%ecx
8010787f:	74 d4                	je     80107855 <loaduvm+0x35>
    if(sz - i < PGSIZE)
80107881:	89 fb                	mov    %edi,%ebx
80107883:	b8 00 10 00 00       	mov    $0x1000,%eax
80107888:	29 f3                	sub    %esi,%ebx
8010788a:	39 c3                	cmp    %eax,%ebx
8010788c:	0f 47 d8             	cmova  %eax,%ebx
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010788f:	53                   	push   %ebx
80107890:	8b 45 14             	mov    0x14(%ebp),%eax
80107893:	01 f0                	add    %esi,%eax
80107895:	50                   	push   %eax
    pa = PTE_ADDR(*pte);
80107896:	8b 01                	mov    (%ecx),%eax
80107898:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010789d:	05 00 00 00 80       	add    $0x80000000,%eax
801078a2:	50                   	push   %eax
801078a3:	ff 75 10             	push   0x10(%ebp)
801078a6:	e8 15 a2 ff ff       	call   80101ac0 <readi>
801078ab:	83 c4 10             	add    $0x10,%esp
801078ae:	39 d8                	cmp    %ebx,%eax
801078b0:	75 1e                	jne    801078d0 <loaduvm+0xb0>
  for(i = 0; i < sz; i += PGSIZE){
801078b2:	81 c6 00 10 00 00    	add    $0x1000,%esi
801078b8:	39 fe                	cmp    %edi,%esi
801078ba:	72 84                	jb     80107840 <loaduvm+0x20>
}
801078bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801078bf:	31 c0                	xor    %eax,%eax
}
801078c1:	5b                   	pop    %ebx
801078c2:	5e                   	pop    %esi
801078c3:	5f                   	pop    %edi
801078c4:	5d                   	pop    %ebp
801078c5:	c3                   	ret
801078c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801078cd:	00 
801078ce:	66 90                	xchg   %ax,%ax
801078d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801078d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801078d8:	5b                   	pop    %ebx
801078d9:	5e                   	pop    %esi
801078da:	5f                   	pop    %edi
801078db:	5d                   	pop    %ebp
801078dc:	c3                   	ret
    panic("loaduvm: addr must be page aligned");
801078dd:	83 ec 0c             	sub    $0xc,%esp
801078e0:	68 f4 85 10 80       	push   $0x801085f4
801078e5:	e8 96 8a ff ff       	call   80100380 <panic>
801078ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801078f0 <allocuvm>:
{
801078f0:	55                   	push   %ebp
801078f1:	89 e5                	mov    %esp,%ebp
801078f3:	57                   	push   %edi
801078f4:	56                   	push   %esi
801078f5:	53                   	push   %ebx
801078f6:	83 ec 1c             	sub    $0x1c,%esp
801078f9:	8b 75 10             	mov    0x10(%ebp),%esi
  if(newsz >= KERNBASE)
801078fc:	85 f6                	test   %esi,%esi
801078fe:	0f 88 98 00 00 00    	js     8010799c <allocuvm+0xac>
80107904:	89 f2                	mov    %esi,%edx
  if(newsz < oldsz)
80107906:	3b 75 0c             	cmp    0xc(%ebp),%esi
80107909:	0f 82 a1 00 00 00    	jb     801079b0 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
8010790f:	8b 45 0c             	mov    0xc(%ebp),%eax
80107912:	05 ff 0f 00 00       	add    $0xfff,%eax
80107917:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010791c:	89 c7                	mov    %eax,%edi
  for(; a < newsz; a += PGSIZE){
8010791e:	39 f0                	cmp    %esi,%eax
80107920:	0f 83 8d 00 00 00    	jae    801079b3 <allocuvm+0xc3>
80107926:	89 75 e4             	mov    %esi,-0x1c(%ebp)
80107929:	eb 44                	jmp    8010796f <allocuvm+0x7f>
8010792b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    memset(mem, 0, PGSIZE);
80107930:	83 ec 04             	sub    $0x4,%esp
80107933:	68 00 10 00 00       	push   $0x1000
80107938:	6a 00                	push   $0x0
8010793a:	50                   	push   %eax
8010793b:	e8 20 d9 ff ff       	call   80105260 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107940:	58                   	pop    %eax
80107941:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107947:	5a                   	pop    %edx
80107948:	6a 06                	push   $0x6
8010794a:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010794f:	89 fa                	mov    %edi,%edx
80107951:	50                   	push   %eax
80107952:	8b 45 08             	mov    0x8(%ebp),%eax
80107955:	e8 a6 fb ff ff       	call   80107500 <mappages>
8010795a:	83 c4 10             	add    $0x10,%esp
8010795d:	85 c0                	test   %eax,%eax
8010795f:	78 5f                	js     801079c0 <allocuvm+0xd0>
  for(; a < newsz; a += PGSIZE){
80107961:	81 c7 00 10 00 00    	add    $0x1000,%edi
80107967:	39 f7                	cmp    %esi,%edi
80107969:	0f 83 89 00 00 00    	jae    801079f8 <allocuvm+0x108>
    mem = kalloc();
8010796f:	e8 fc ac ff ff       	call   80102670 <kalloc>
80107974:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80107976:	85 c0                	test   %eax,%eax
80107978:	75 b6                	jne    80107930 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
8010797a:	83 ec 0c             	sub    $0xc,%esp
8010797d:	68 c3 82 10 80       	push   $0x801082c3
80107982:	e8 29 8d ff ff       	call   801006b0 <cprintf>
  if(newsz >= oldsz)
80107987:	83 c4 10             	add    $0x10,%esp
8010798a:	3b 75 0c             	cmp    0xc(%ebp),%esi
8010798d:	74 0d                	je     8010799c <allocuvm+0xac>
8010798f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107992:	8b 45 08             	mov    0x8(%ebp),%eax
80107995:	89 f2                	mov    %esi,%edx
80107997:	e8 a4 fa ff ff       	call   80107440 <deallocuvm.part.0>
    return 0;
8010799c:	31 d2                	xor    %edx,%edx
}
8010799e:	8d 65 f4             	lea    -0xc(%ebp),%esp
801079a1:	89 d0                	mov    %edx,%eax
801079a3:	5b                   	pop    %ebx
801079a4:	5e                   	pop    %esi
801079a5:	5f                   	pop    %edi
801079a6:	5d                   	pop    %ebp
801079a7:	c3                   	ret
801079a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801079af:	00 
    return oldsz;
801079b0:	8b 55 0c             	mov    0xc(%ebp),%edx
}
801079b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801079b6:	89 d0                	mov    %edx,%eax
801079b8:	5b                   	pop    %ebx
801079b9:	5e                   	pop    %esi
801079ba:	5f                   	pop    %edi
801079bb:	5d                   	pop    %ebp
801079bc:	c3                   	ret
801079bd:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
801079c0:	83 ec 0c             	sub    $0xc,%esp
801079c3:	68 db 82 10 80       	push   $0x801082db
801079c8:	e8 e3 8c ff ff       	call   801006b0 <cprintf>
  if(newsz >= oldsz)
801079cd:	83 c4 10             	add    $0x10,%esp
801079d0:	3b 75 0c             	cmp    0xc(%ebp),%esi
801079d3:	74 0d                	je     801079e2 <allocuvm+0xf2>
801079d5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801079d8:	8b 45 08             	mov    0x8(%ebp),%eax
801079db:	89 f2                	mov    %esi,%edx
801079dd:	e8 5e fa ff ff       	call   80107440 <deallocuvm.part.0>
      kfree(mem);
801079e2:	83 ec 0c             	sub    $0xc,%esp
801079e5:	53                   	push   %ebx
801079e6:	e8 c5 aa ff ff       	call   801024b0 <kfree>
      return 0;
801079eb:	83 c4 10             	add    $0x10,%esp
    return 0;
801079ee:	31 d2                	xor    %edx,%edx
801079f0:	eb ac                	jmp    8010799e <allocuvm+0xae>
801079f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801079f8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
}
801079fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801079fe:	5b                   	pop    %ebx
801079ff:	5e                   	pop    %esi
80107a00:	89 d0                	mov    %edx,%eax
80107a02:	5f                   	pop    %edi
80107a03:	5d                   	pop    %ebp
80107a04:	c3                   	ret
80107a05:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107a0c:	00 
80107a0d:	8d 76 00             	lea    0x0(%esi),%esi

80107a10 <deallocuvm>:
{
80107a10:	55                   	push   %ebp
80107a11:	89 e5                	mov    %esp,%ebp
80107a13:	8b 55 0c             	mov    0xc(%ebp),%edx
80107a16:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107a19:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80107a1c:	39 d1                	cmp    %edx,%ecx
80107a1e:	73 10                	jae    80107a30 <deallocuvm+0x20>
}
80107a20:	5d                   	pop    %ebp
80107a21:	e9 1a fa ff ff       	jmp    80107440 <deallocuvm.part.0>
80107a26:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107a2d:	00 
80107a2e:	66 90                	xchg   %ax,%ax
80107a30:	89 d0                	mov    %edx,%eax
80107a32:	5d                   	pop    %ebp
80107a33:	c3                   	ret
80107a34:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107a3b:	00 
80107a3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107a40 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107a40:	55                   	push   %ebp
80107a41:	89 e5                	mov    %esp,%ebp
80107a43:	57                   	push   %edi
80107a44:	56                   	push   %esi
80107a45:	53                   	push   %ebx
80107a46:	83 ec 0c             	sub    $0xc,%esp
80107a49:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80107a4c:	85 f6                	test   %esi,%esi
80107a4e:	74 59                	je     80107aa9 <freevm+0x69>
  if(newsz >= oldsz)
80107a50:	31 c9                	xor    %ecx,%ecx
80107a52:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107a57:	89 f0                	mov    %esi,%eax
80107a59:	89 f3                	mov    %esi,%ebx
80107a5b:	e8 e0 f9 ff ff       	call   80107440 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107a60:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107a66:	eb 0f                	jmp    80107a77 <freevm+0x37>
80107a68:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107a6f:	00 
80107a70:	83 c3 04             	add    $0x4,%ebx
80107a73:	39 fb                	cmp    %edi,%ebx
80107a75:	74 23                	je     80107a9a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107a77:	8b 03                	mov    (%ebx),%eax
80107a79:	a8 01                	test   $0x1,%al
80107a7b:	74 f3                	je     80107a70 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107a7d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107a82:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107a85:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107a88:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80107a8d:	50                   	push   %eax
80107a8e:	e8 1d aa ff ff       	call   801024b0 <kfree>
80107a93:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107a96:	39 fb                	cmp    %edi,%ebx
80107a98:	75 dd                	jne    80107a77 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80107a9a:	89 75 08             	mov    %esi,0x8(%ebp)
}
80107a9d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107aa0:	5b                   	pop    %ebx
80107aa1:	5e                   	pop    %esi
80107aa2:	5f                   	pop    %edi
80107aa3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107aa4:	e9 07 aa ff ff       	jmp    801024b0 <kfree>
    panic("freevm: no pgdir");
80107aa9:	83 ec 0c             	sub    $0xc,%esp
80107aac:	68 f7 82 10 80       	push   $0x801082f7
80107ab1:	e8 ca 88 ff ff       	call   80100380 <panic>
80107ab6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107abd:	00 
80107abe:	66 90                	xchg   %ax,%ax

80107ac0 <setupkvm>:
{
80107ac0:	55                   	push   %ebp
80107ac1:	89 e5                	mov    %esp,%ebp
80107ac3:	56                   	push   %esi
80107ac4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107ac5:	e8 a6 ab ff ff       	call   80102670 <kalloc>
80107aca:	85 c0                	test   %eax,%eax
80107acc:	74 5e                	je     80107b2c <setupkvm+0x6c>
  memset(pgdir, 0, PGSIZE);
80107ace:	83 ec 04             	sub    $0x4,%esp
80107ad1:	89 c6                	mov    %eax,%esi
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107ad3:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
80107ad8:	68 00 10 00 00       	push   $0x1000
80107add:	6a 00                	push   $0x0
80107adf:	50                   	push   %eax
80107ae0:	e8 7b d7 ff ff       	call   80105260 <memset>
80107ae5:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80107ae8:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80107aeb:	83 ec 08             	sub    $0x8,%esp
80107aee:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107af1:	8b 13                	mov    (%ebx),%edx
80107af3:	ff 73 0c             	push   0xc(%ebx)
80107af6:	50                   	push   %eax
80107af7:	29 c1                	sub    %eax,%ecx
80107af9:	89 f0                	mov    %esi,%eax
80107afb:	e8 00 fa ff ff       	call   80107500 <mappages>
80107b00:	83 c4 10             	add    $0x10,%esp
80107b03:	85 c0                	test   %eax,%eax
80107b05:	78 19                	js     80107b20 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107b07:	83 c3 10             	add    $0x10,%ebx
80107b0a:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107b10:	75 d6                	jne    80107ae8 <setupkvm+0x28>
}
80107b12:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107b15:	89 f0                	mov    %esi,%eax
80107b17:	5b                   	pop    %ebx
80107b18:	5e                   	pop    %esi
80107b19:	5d                   	pop    %ebp
80107b1a:	c3                   	ret
80107b1b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80107b20:	83 ec 0c             	sub    $0xc,%esp
80107b23:	56                   	push   %esi
80107b24:	e8 17 ff ff ff       	call   80107a40 <freevm>
      return 0;
80107b29:	83 c4 10             	add    $0x10,%esp
}
80107b2c:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
80107b2f:	31 f6                	xor    %esi,%esi
}
80107b31:	89 f0                	mov    %esi,%eax
80107b33:	5b                   	pop    %ebx
80107b34:	5e                   	pop    %esi
80107b35:	5d                   	pop    %ebp
80107b36:	c3                   	ret
80107b37:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107b3e:	00 
80107b3f:	90                   	nop

80107b40 <kvmalloc>:
{
80107b40:	55                   	push   %ebp
80107b41:	89 e5                	mov    %esp,%ebp
80107b43:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107b46:	e8 75 ff ff ff       	call   80107ac0 <setupkvm>
80107b4b:	a3 e4 67 11 80       	mov    %eax,0x801167e4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107b50:	05 00 00 00 80       	add    $0x80000000,%eax
80107b55:	0f 22 d8             	mov    %eax,%cr3
}
80107b58:	c9                   	leave
80107b59:	c3                   	ret
80107b5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107b60 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107b60:	55                   	push   %ebp
80107b61:	89 e5                	mov    %esp,%ebp
80107b63:	83 ec 08             	sub    $0x8,%esp
80107b66:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107b69:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80107b6c:	89 c1                	mov    %eax,%ecx
80107b6e:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107b71:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107b74:	f6 c2 01             	test   $0x1,%dl
80107b77:	75 17                	jne    80107b90 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80107b79:	83 ec 0c             	sub    $0xc,%esp
80107b7c:	68 08 83 10 80       	push   $0x80108308
80107b81:	e8 fa 87 ff ff       	call   80100380 <panic>
80107b86:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107b8d:	00 
80107b8e:	66 90                	xchg   %ax,%ax
  return &pgtab[PTX(va)];
80107b90:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107b93:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80107b99:	25 fc 0f 00 00       	and    $0xffc,%eax
80107b9e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
80107ba5:	85 c0                	test   %eax,%eax
80107ba7:	74 d0                	je     80107b79 <clearpteu+0x19>
  *pte &= ~PTE_U;
80107ba9:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80107bac:	c9                   	leave
80107bad:	c3                   	ret
80107bae:	66 90                	xchg   %ax,%ax

80107bb0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107bb0:	55                   	push   %ebp
80107bb1:	89 e5                	mov    %esp,%ebp
80107bb3:	57                   	push   %edi
80107bb4:	56                   	push   %esi
80107bb5:	53                   	push   %ebx
80107bb6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107bb9:	e8 02 ff ff ff       	call   80107ac0 <setupkvm>
80107bbe:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107bc1:	85 c0                	test   %eax,%eax
80107bc3:	0f 84 e9 00 00 00    	je     80107cb2 <copyuvm+0x102>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107bc9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107bcc:	85 c9                	test   %ecx,%ecx
80107bce:	0f 84 b2 00 00 00    	je     80107c86 <copyuvm+0xd6>
80107bd4:	31 f6                	xor    %esi,%esi
80107bd6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107bdd:	00 
80107bde:	66 90                	xchg   %ax,%ax
  if(*pde & PTE_P){
80107be0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
80107be3:	89 f0                	mov    %esi,%eax
80107be5:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80107be8:	8b 04 81             	mov    (%ecx,%eax,4),%eax
80107beb:	a8 01                	test   $0x1,%al
80107bed:	75 11                	jne    80107c00 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
80107bef:	83 ec 0c             	sub    $0xc,%esp
80107bf2:	68 12 83 10 80       	push   $0x80108312
80107bf7:	e8 84 87 ff ff       	call   80100380 <panic>
80107bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
80107c00:	89 f2                	mov    %esi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107c02:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107c07:	c1 ea 0a             	shr    $0xa,%edx
80107c0a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107c10:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107c17:	85 c0                	test   %eax,%eax
80107c19:	74 d4                	je     80107bef <copyuvm+0x3f>
    if(!(*pte & PTE_P))
80107c1b:	8b 00                	mov    (%eax),%eax
80107c1d:	a8 01                	test   $0x1,%al
80107c1f:	0f 84 9f 00 00 00    	je     80107cc4 <copyuvm+0x114>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107c25:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
80107c27:	25 ff 0f 00 00       	and    $0xfff,%eax
80107c2c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
80107c2f:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
80107c35:	e8 36 aa ff ff       	call   80102670 <kalloc>
80107c3a:	89 c3                	mov    %eax,%ebx
80107c3c:	85 c0                	test   %eax,%eax
80107c3e:	74 64                	je     80107ca4 <copyuvm+0xf4>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107c40:	83 ec 04             	sub    $0x4,%esp
80107c43:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107c49:	68 00 10 00 00       	push   $0x1000
80107c4e:	57                   	push   %edi
80107c4f:	50                   	push   %eax
80107c50:	e8 9b d6 ff ff       	call   801052f0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107c55:	58                   	pop    %eax
80107c56:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107c5c:	5a                   	pop    %edx
80107c5d:	ff 75 e4             	push   -0x1c(%ebp)
80107c60:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107c65:	89 f2                	mov    %esi,%edx
80107c67:	50                   	push   %eax
80107c68:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107c6b:	e8 90 f8 ff ff       	call   80107500 <mappages>
80107c70:	83 c4 10             	add    $0x10,%esp
80107c73:	85 c0                	test   %eax,%eax
80107c75:	78 21                	js     80107c98 <copyuvm+0xe8>
  for(i = 0; i < sz; i += PGSIZE){
80107c77:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107c7d:	3b 75 0c             	cmp    0xc(%ebp),%esi
80107c80:	0f 82 5a ff ff ff    	jb     80107be0 <copyuvm+0x30>
  return d;

bad:
  freevm(d);
  return 0;
}
80107c86:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107c89:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107c8c:	5b                   	pop    %ebx
80107c8d:	5e                   	pop    %esi
80107c8e:	5f                   	pop    %edi
80107c8f:	5d                   	pop    %ebp
80107c90:	c3                   	ret
80107c91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80107c98:	83 ec 0c             	sub    $0xc,%esp
80107c9b:	53                   	push   %ebx
80107c9c:	e8 0f a8 ff ff       	call   801024b0 <kfree>
      goto bad;
80107ca1:	83 c4 10             	add    $0x10,%esp
  freevm(d);
80107ca4:	83 ec 0c             	sub    $0xc,%esp
80107ca7:	ff 75 e0             	push   -0x20(%ebp)
80107caa:	e8 91 fd ff ff       	call   80107a40 <freevm>
  return 0;
80107caf:	83 c4 10             	add    $0x10,%esp
    return 0;
80107cb2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80107cb9:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107cbc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107cbf:	5b                   	pop    %ebx
80107cc0:	5e                   	pop    %esi
80107cc1:	5f                   	pop    %edi
80107cc2:	5d                   	pop    %ebp
80107cc3:	c3                   	ret
      panic("copyuvm: page not present");
80107cc4:	83 ec 0c             	sub    $0xc,%esp
80107cc7:	68 2c 83 10 80       	push   $0x8010832c
80107ccc:	e8 af 86 ff ff       	call   80100380 <panic>
80107cd1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107cd8:	00 
80107cd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107ce0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107ce0:	55                   	push   %ebp
80107ce1:	89 e5                	mov    %esp,%ebp
80107ce3:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107ce6:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80107ce9:	89 c1                	mov    %eax,%ecx
80107ceb:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107cee:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107cf1:	f6 c2 01             	test   $0x1,%dl
80107cf4:	0f 84 f8 00 00 00    	je     80107df2 <uva2ka.cold>
  return &pgtab[PTX(va)];
80107cfa:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107cfd:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107d03:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
80107d04:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
80107d09:	8b 94 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107d10:	89 d0                	mov    %edx,%eax
80107d12:	f7 d2                	not    %edx
80107d14:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107d19:	05 00 00 00 80       	add    $0x80000000,%eax
80107d1e:	83 e2 05             	and    $0x5,%edx
80107d21:	ba 00 00 00 00       	mov    $0x0,%edx
80107d26:	0f 45 c2             	cmovne %edx,%eax
}
80107d29:	c3                   	ret
80107d2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107d30 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107d30:	55                   	push   %ebp
80107d31:	89 e5                	mov    %esp,%ebp
80107d33:	57                   	push   %edi
80107d34:	56                   	push   %esi
80107d35:	53                   	push   %ebx
80107d36:	83 ec 0c             	sub    $0xc,%esp
80107d39:	8b 75 14             	mov    0x14(%ebp),%esi
80107d3c:	8b 45 0c             	mov    0xc(%ebp),%eax
80107d3f:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107d42:	85 f6                	test   %esi,%esi
80107d44:	75 51                	jne    80107d97 <copyout+0x67>
80107d46:	e9 9d 00 00 00       	jmp    80107de8 <copyout+0xb8>
80107d4b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  return (char*)P2V(PTE_ADDR(*pte));
80107d50:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80107d56:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
80107d5c:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
80107d62:	74 74                	je     80107dd8 <copyout+0xa8>
      return -1;
    n = PGSIZE - (va - va0);
80107d64:	89 fb                	mov    %edi,%ebx
80107d66:	29 c3                	sub    %eax,%ebx
80107d68:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
80107d6e:	39 f3                	cmp    %esi,%ebx
80107d70:	0f 47 de             	cmova  %esi,%ebx
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107d73:	29 f8                	sub    %edi,%eax
80107d75:	83 ec 04             	sub    $0x4,%esp
80107d78:	01 c1                	add    %eax,%ecx
80107d7a:	53                   	push   %ebx
80107d7b:	52                   	push   %edx
80107d7c:	89 55 10             	mov    %edx,0x10(%ebp)
80107d7f:	51                   	push   %ecx
80107d80:	e8 6b d5 ff ff       	call   801052f0 <memmove>
    len -= n;
    buf += n;
80107d85:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
80107d88:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
  while(len > 0){
80107d8e:	83 c4 10             	add    $0x10,%esp
    buf += n;
80107d91:	01 da                	add    %ebx,%edx
  while(len > 0){
80107d93:	29 de                	sub    %ebx,%esi
80107d95:	74 51                	je     80107de8 <copyout+0xb8>
  if(*pde & PTE_P){
80107d97:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
80107d9a:	89 c1                	mov    %eax,%ecx
    va0 = (uint)PGROUNDDOWN(va);
80107d9c:	89 c7                	mov    %eax,%edi
  pde = &pgdir[PDX(va)];
80107d9e:	c1 e9 16             	shr    $0x16,%ecx
    va0 = (uint)PGROUNDDOWN(va);
80107da1:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
80107da7:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
80107daa:	f6 c1 01             	test   $0x1,%cl
80107dad:	0f 84 46 00 00 00    	je     80107df9 <copyout.cold>
  return &pgtab[PTX(va)];
80107db3:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107db5:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80107dbb:	c1 eb 0c             	shr    $0xc,%ebx
80107dbe:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
80107dc4:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
  if((*pte & PTE_U) == 0)
80107dcb:	89 d9                	mov    %ebx,%ecx
80107dcd:	f7 d1                	not    %ecx
80107dcf:	83 e1 05             	and    $0x5,%ecx
80107dd2:	0f 84 78 ff ff ff    	je     80107d50 <copyout+0x20>
  }
  return 0;
}
80107dd8:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107ddb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107de0:	5b                   	pop    %ebx
80107de1:	5e                   	pop    %esi
80107de2:	5f                   	pop    %edi
80107de3:	5d                   	pop    %ebp
80107de4:	c3                   	ret
80107de5:	8d 76 00             	lea    0x0(%esi),%esi
80107de8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107deb:	31 c0                	xor    %eax,%eax
}
80107ded:	5b                   	pop    %ebx
80107dee:	5e                   	pop    %esi
80107def:	5f                   	pop    %edi
80107df0:	5d                   	pop    %ebp
80107df1:	c3                   	ret

80107df2 <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
80107df2:	a1 00 00 00 00       	mov    0x0,%eax
80107df7:	0f 0b                	ud2

80107df9 <copyout.cold>:
80107df9:	a1 00 00 00 00       	mov    0x0,%eax
80107dfe:	0f 0b                	ud2
