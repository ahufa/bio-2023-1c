#!/usr/bin/perl -w 

#use Bio::Perl;
use Bio::SeqIO;


if (scalar(@ARGV) == 0) {
    print "No se pasaron argumentos al programa!\n";
    exit
} 

my $file = $ARGV[0];

if (!($file =~ /\.gb$/)){
    print "El archivo $file no cumple con el tipo requerido!\n";
	exit;
}

my $input = Bio::SeqIO->new(-file => $file, -format => 'genbank');
my $output = Bio::SeqIO->new(-file => ">result.fsa", -format => 'fasta');

while (my $seq = $input->next_seq) {
    $output->write_seq($seq);
}

print "Transcripcion finalizada!\n";
