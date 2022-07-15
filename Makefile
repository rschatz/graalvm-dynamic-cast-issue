VARIANTS=native managed gcc

.PHONY:: default
default: ${VARIANTS}

.PHONY:: clean
clean:
	rm -f */*.so */main */*.class

.PHONY:: ${VARIANTS}
${VARIANTS}: %:
	${MAKE} -C $@
