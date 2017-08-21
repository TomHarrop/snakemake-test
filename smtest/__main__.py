#!/usr/bin/env python3

import io
import subprocess
import sys
import snakemake


def print_graph(snakefile, dag_file):
    # store old stdout
    stdout = sys.stdout
    # call snakemake api and capture output
    sys.stdout = io.StringIO()
    snakemake.snakemake(
        snakefile,
        dryrun=True,
        printdag=True)
    output = sys.stdout.getvalue()
    # restore sys.stdout
    sys.stdout = stdout
    # pipe the output to dot
    with open(dag_file, 'wb') as svg:
        dot_process = subprocess.Popen(
            ['dot', '-Tsvg'],
            stdin=subprocess.PIPE,
            stdout=svg)
        dot_process.communicate(input=output.encode())


def main():
    snakefile = 'Snakefile'
    # run the pipeline
    snakemake.snakemake(snakefile)

    # print the graph
    print_graph(snakefile, 'dag.svg')


if __name__ == '__main__':
    main()
    