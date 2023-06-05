#!/usr/bin/perl -w 

use Bio::SeqIO;

if (scalar(@ARGV) == 0) {
    print "No se pasaron argumentos al programa!\n";
    exit
}

foreach my $i(0 .. $#ARGV) {
    if (!($ARGV[$i] =~ /\.gb$/)) {
        print "No tiene formato GenBank: $ARGV[$i]\n";
        exit
    }
}

foreach my $i(0 .. $#ARGV) {
    foreach my $frame(0 .. 2) {
        to_fasta($ARGV[$i], $frame)
    }
}

print "Transcripcion finalizada!\n";

sub to_fasta {

    my ($origin) = $_[0];
    my ($frame) = $_[1];

    my $result_file_name = substr($origin, 0, -3)."_frame_".$frame.".fsa";

    my $input = Bio::SeqIO->new(-file => $origin, -format => 'genbank');
    my $output = Bio::SeqIO->new(-file => ">$result_file_name", -format => 'fasta');

    foreach my $seq($input->next_seq) {
        my $translated = $seq->translate(-frame => $frame);
        $output->write_seq($translated);
    }

}