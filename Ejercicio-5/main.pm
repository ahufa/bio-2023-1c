#!/usr/bin/perl -w

use strict;
use Bio::Factory::EMBOSS;
use Bio::SeqIO;

my $embossFactory = Bio::Factory::EMBOSS -> new();

my $getorf = $embossFactory->program('getorf') || die "Program not found!\n";

File::Path::make_path("result");

my $orf = $getorf->run({
    -sequence => $ARGV[0],
    -outseq => "result/ORF_Emboss.fsa",
    -osformat => "text"
});

my $patmatmotifs = $embossFactory->program('patmatmotifs') || die "Program not found!\n";

my $result_domains = $patmatmotifs->run({
    -sequence => $ARGV[0],
    -outfile => "result/domains_emboss.fsa"
});

exit;