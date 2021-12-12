CC			= riscv64-linux-gnu-gcc
LD			= riscv64-linux-gnu-ld
UNAME := $(shell uname -s)
ifeq ($(UNAME), Darwin)
	CC		= riscv64-unknown-elf-gcc
	LD		= riscv64-unknown-elf-ld
endif
CFLAGS		= -g -c -fno-builtin -DBUILDER='"$(shell whoami)"'
SYSTEMMAP	= System.map
KERNELBIN	= KERNEL.BIN
LINKSCRIPT	= scripts/link.ld

SRC_DIRS = boot kernel
INC_DIRS = include

CFLAGS += ${INC_DIRS:%=-I%}

SOURCE_FILES := $(foreach DIR, $(SRC_DIRS), $(wildcard $(DIR)/*.[cS]))
HEADER_FILES := $(foreach DIR, $(INC_DIRS), $(wildcard $(DIR)/*.h))

OBJS := $(patsubst %,%.o,$(SOURCE_FILES))

${KERNELBIN}: ${OBJS}
	${LD} -M -T$(LINKSCRIPT) $(OBJS) -o $@ > $(SYSTEMMAP)
	nm -a $@ > kernel.sym

%.S.o: %.S ${HEADER_FILES}
	${CC} ${CFLAGS} $< -o $@

%.c.o: %.c ${HEADER_FILES}
	${CC} ${CFLAGS} $< -o $@

c:
	rm -f $(KERNELBIN)

clean:
	rm -f $(OBJS)
	rm -f $(KERNELBIN) $(SYSTEMMAP)