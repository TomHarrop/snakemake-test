#!/usr/bin/env python3

import snakemake

my_pipeline = snakemake.snakemake('Snakefile',
    dryrun=True,
    printdag=True)
