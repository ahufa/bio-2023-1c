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

to_fasta($file, 1);

print "Transcripcion finalizada!\n";

sub to_fasta{
    my ($origin) = $_[0];
    my ($frame) = $_[1];

    my $result_file_name = substr($origin, 0, -3)."_frame_".$frame.".fsa";

    my $input = Bio::SeqIO->new(-file => $origin, -format => 'genbank');
    my $output = Bio::SeqIO->new(-file => ">$result_file_name", -format => 'fasta');

    while (my $seq = $input->next_seq) {
        my $translated = $seq->translate(-frame => $frame);
        $output->write_seq($translated);
    }
}