
CC = $(shell which gcc > /dev/null && echo gcc || echo clang)
CCBASE = $(notdir $(CC))
OPTFLAGS = -O3

# Check for gcc and add libquadmath if we are using it.
# Relies on compilers announcing the target in the same way.
# gcc and clang do...
TARGET = $(shell $(CC) -v 2>&1 | grep "gcc version")
ifneq "$(TARGET)" ""
  # $(info *** x86_64 target, adding -lquadmath to the link flags. ***)
  LDFLAGS += -lquadmath
endif

CFLAGS += $(OPTFLAGS)

testPFP128_$(CCBASE):

%_$(CCBASE).o: %.c pfp128.h Makefile
	$(CC) -o $@ -c $(CFLAGS) $<

%: %.o
	$(CC) -o $@ $< -lm  $(LDFLAGS)

clean:
	rm -f testPFP128_* *.o
