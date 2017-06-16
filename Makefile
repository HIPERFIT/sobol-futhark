
.PHONY: all
all: sobol-dir-21201.fut sobol-dir-50.fut sobol-dir-1000.fut

sobol-dir-21201.fut: new-joe-kuo-6.21201 sobol_conv
	./sobol_conv < new-joe-kuo-6.21201 > sobol-dir-21201.fut

sobol-dir-50.fut: new-joe-kuo-6.21201 sobol_conv
	./sobol_conv 50 < new-joe-kuo-6.21201 > sobol-dir-50.fut

sobol-dir-1000.fut: new-joe-kuo-6.21201 sobol_conv
	./sobol_conv 1000 < new-joe-kuo-6.21201 > sobol-dir-1000.fut

sobol_conv: sobol_conv.sml
	mlkit -o $@ $<

.PHONY: clean
clean:
	rm -rf *~ MLB sobol_conv *.fut
