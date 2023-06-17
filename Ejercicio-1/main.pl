#!/usr/bin/perl -w 

use Bio::SeqIO;
use File::Path;

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

File::Path::make_path("result");

foreach my $i(0 .. $#ARGV) {
    foreach my $frame(0 .. 2) {
        to_fasta($ARGV[$i], $frame)
    }
}

print "Transcripcion finalizada!\n";

sub to_fasta {

    my ($origin, $frame) = @_;

    my $origin_sequence = get_secuense_from_genbank($origin);
    my $rev_sequence = $origin_sequence->revcom;

    my $result_dir_name = "result/";
    my $result_file_name = substr($origin, 0, -3)."_frame_".$frame;

    if (scalar(@ARGV) > 1) {
        $result_dir_name = $result_dir_name.substr($origin, 0, -3);
        File::Path::make_path($result_dir_name);
    }

    save_sequence_to_fasta($origin_sequence, $frame, $result_dir_name, $result_file_name);
    save_sequence_to_fasta($rev_sequence, $frame, $result_dir_name, $result_file_name."_rev");
}

sub get_secuense_from_genbank {

    my ($file) = @_;
    
    my $input = Bio::SeqIO->new(-file => $file, -format => 'genbank');
    
    return $input->next_seq;
}

sub save_sequence_to_fasta {

    my ($secuence, $frame, $result_dir_name, $result_file_name) = @_;

    my $translated = $secuence->translate(-frame => $frame);
    my $output = Bio::SeqIO->new(-file => ">$result_dir_name/$result_file_name.fsa", -format => 'fasta');

    $output->write_seq($translated);
}