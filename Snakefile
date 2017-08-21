#!/usr/bin/env python3

trinity_fasta = 'data/Trinity.fasta'
boilerplate_db = 'data/Trinotate.sqlite'

transdecoder_output = 'output/transdecoder/Trinity.fasta.transdecoder.pep'
blastx_output = 'output/blastx/blastx.outfmt6'
blastp_output = 'output/blastp/blastp.outfmt6'
hmmer_output = 'output/hmmer/TrinotatePFAM.out'
signalp_output = 'output/signalp/signalp.out'
tmhmm_output = 'output/tmhmm/tmhmm.out'
rnammer_output = 'output/rnammer/Trinity.fasta.rnammer.gff'

trinotate_db = 'output/trinotate/Trinotate.sqlite'
transcripts_to_genes = 'output/trinotate/Trinity.fasta.gene_trans_map'
trinotate_annotation_report = ('output/trinotate/'
                               'trinotate_annotation_report.txt')

rule all:
    input:
        trinotate_annotation_report

rule generate_trinotate_db:
    input:
        boilerplate_db
    output:
        trinotate_db
    shell:
        'cp "$(readlink -f {input})" {output}'

rule transdecoder:
    input:
        trinity_fasta
    output:
        touch(transdecoder_output)
    shell:
        'printf "i:\t%s\no:\t%s\n" {input} {output}'

rule blastx:
    input:
        trinity_fasta
    output:
        touch(blastx_output)
    shell:
        'printf "i:\t%s\no:\t%s\n" {input} {output}'

rule blastp:
    input:
        transdecoder_output
    output:
        touch(blastp_output)
    shell:
        'printf "i:\t%s\no:\t%s\n" {input} {output}'

rule hmmer:
    input:
        transdecoder_output
    output:
        touch(hmmer_output)
    shell:
        'printf "i:\t%s\no:\t%s\n" {input} {output}'

rule signalp:
    input:
        transdecoder_output
    output:
        touch(signalp_output)
    shell:
        'printf "i:\t%s\no:\t%s\n" {input} {output}'

rule rnammer:
    input:
        transdecoder_output
    output:
        touch(rnammer_output)
    shell:
        'printf "i:\t%s\no:\t%s\n" {input} {output}'

rule tmhmm:
    input:
        transdecoder_output
    output:
        touch(tmhmm_output)
    shell:
        'printf "i:\t%s\no:\t%s\n" {input} {output}'

rule generate_transcripts_to_genes_map:
    input:
        trinity_fasta
    output:
        touch(transcripts_to_genes)
    shell:
        'printf "i:\t%s\no:\t%s\n" {input} {output}'

rule annotate_trinotate_db:
    input:
        blastp_output,
        blastx_output,
        hmmer_output,
        tmhmm_output,
        signalp_output,
        trinotate_db,
        transcripts_to_genes
    output:
        touch(trinotate_annotation_report)
    shell:
        'printf "i:\t%s\no:\t%s\n" {input} {output}'
