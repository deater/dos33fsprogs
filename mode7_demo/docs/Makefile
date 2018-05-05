all:	mode7_demo.pdf dram_notes.pdf

mode7_demo.pdf:	mode7_demo.tex
	pdflatex mode7_demo.tex
	pdflatex mode7_demo.tex
	pdflatex mode7_demo.tex

dram_notes.pdf:	dram_notes.tex table.tex
	pdflatex dram_notes.tex
	pdflatex dram_notes.tex
	pdflatex dram_notes.tex

table.tex:	make_table
	./make_table > table.tex

make_table:	make_table.c
	gcc -O2 -Wall -o make_table make_table.c

clean:
	rm -f *~ *.bak *.aux *.log *.out mode7_demo.pdf \
			dram_notes.pdf table.tex make_table
