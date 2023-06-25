#!/usr/bin/perl -w

use Bio::SeqIO;
use Bio::AlignIO;
use Bio::Tools::Run::Alignment::Clustalw;

if (scalar(@ARGV) < 2) {
    print "No se pasaron todos los argumentos al programa!\n";
    exit
}

foreach my $i(0 .. $#ARGV) {
    if (!($ARGV[$i] =~ /\.fsa$/)) {
        print "No tiene formato Fasta: $ARGV[$i]\n";
        exit
    }
}

File::Path::make_path("result");

save_sequence_to_fasta();
to_alignment();
unlink 'result/temporary_fasta_concatenation.fsa';

sub save_sequence_to_fasta {

    my $output = Bio::SeqIO->new(-file => ">result/temporary_fasta_concatenation.fsa", -format => 'fasta');

    foreach my $i(0 .. $#ARGV) {
        $input = Bio::SeqIO->new(-file => $ARGV[$i], -format => 'fasta')->next_seq;
        $output->write_seq($input);
    }
}

sub to_alignment {

    my $in = Bio::AlignIO->new(-file => "result/temporary_fasta_concatenation.fsa" , -format => 'fasta');
    my $response = Bio::AlignIO->new(-file => ">result/alignment.msa", -format => 'clustalw');

    while ( my $aln = $in->next_aln ) {
        $response->write_aln($aln);
    }
}

