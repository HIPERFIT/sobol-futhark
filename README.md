# sobol-futhark

Tool for generating Futhark modules with direction vectors based on the file reported on
http://web.maths.unsw.edu.au/~fkuo/sobol/

## Usage

A Standard ML compiler, such as the [MLKit](https://github.com/melsman/mlkit), is needed.

To compile the tool and generate Futhark modules based on the Joe and
Kuo data sets, simply use `make` in a terminal:

````
bash-3.2$ make
mlkit -o sobol_conv sobol_conv.sml
[reading source file:	sobol_conv.sml]
[wrote X86 code file:	MLB/RI_GC/sobol_conv.sml.s]
[wrote X86 code file:	MLB/RI_GC/base-link_objects.s]
[wrote executable file:	sobol_conv]
./sobol_conv < new-joe-kuo-6.21201 > new-joe-kuo-6.21201.fut
./sobol_conv 50 < new-joe-kuo-6.21201 > new-joe-kuo-6.50.fut
./sobol_conv 1000 < new-joe-kuo-6.21201 > new-joe-kuo-6.1000.fut
bash-3.2$
````

To generate Futhark-modules of different sizes, you may choose to
alter the `Makefile`.

## License

MIT License.
