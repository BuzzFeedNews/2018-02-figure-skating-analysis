.PHONY: default reproduce

default:

reproduce:
	cd notebooks && find . -type f -maxdepth 1 -exec jupyter nbconvert \
		--ExecutePreprocessor.timeout=-1 \
		--ExecutePreprocessor.kernel_name=python3 \
		--to notebook \
		--output {} \
		--execute {} \;
