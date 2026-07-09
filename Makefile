TOOLCHAIN_PREFIX := arm-none-eabi

CC := ${TOOLCHAIN_PREFIX}-gcc
DBG := ${TOOLCHAIN_PREFIX}-gdb
OBJCOPY := ${TOOLCHAIN_PREFIX}-objcopy

LINKERSCRIPT := stm32f446.ld

TARGET := out

SRC_DIR := core
BUILD_DIR := build
INC_DIRS := ${filter %/inc, ${shell find ${SRC_DIR} -type d}}
INC_FLAGS := ${addprefix -I,${INC_DIRS}}

CFLAGS := -mcpu=cortex-m4 -ffreestanding -fno-builtin -Wall -Werror ${INC_FLAGS} -std=c11 -mfloat-abi=hard -mthumb -g3
ASFLAGS := -mcpu=cortex-m4 -g3
LDFLAGS := -nostartfiles -nostdlib -T ${LINKERSCRIPT}


CSRCS := ${shell find ${SRC_DIR} -name '*.c'}
ASRCS := ${shell find ${SRC_DIR} -name '*.s'}
APSRCS := ${shell find ${SRC_DIR} -name '*.S'}

OBJECTS := ${CSRCS:%=${BUILD_DIR}/%.o} ${ASRCS:%=${BUILD_DIR}/%.o} ${APSRCS:%=${BUILD_DIR}/%.o}

all:
	bear -- make build

build: ${BUILD_DIR}/${TARGET}.bin

${BUILD_DIR}/${TARGET}.bin: ${BUILD_DIR}/${TARGET}
	${OBJCOPY} -O binary $< $@

${BUILD_DIR}/${TARGET}: ${OBJECTS}
	${CC} ${OBJECTS} -o $@ ${LDFLAGS}

${BUILD_DIR}/%.c.o: %.c 
	mkdir -p ${dir $@}
	${CC} ${CFLAGS} -c $< -o $@

${BUILD_DIR}/%.s.o: %.s
	mkdir -p ${dir ${@}}
	${CC} ${ASFLAGS} -c $< -o $@

${BUILD_DIR}/%.S.o: %.S
	mkdir -p ${dir ${@}}
	${CC} ${ASFLAGS} -c $< -o $@

clean:
	rm -rf ${BUILD_DIR}/**

upload_wsl: all
	


