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

create_dir();

foreach my $i(0 .. $#ARGV) {
    foreach my $frame(0 .. 2) {
        to_fasta($ARGV[$i], $frame)
    }
}

print "Transcripcion finalizada!\n";

sub create_dir {

    my $folder_path = "result";

    if (-e $folder_path && -d $folder_path) {
        File::Path::remove_tree($folder_path, { keep_root => 1 });
    } else {
        File::Path::make_path($folder_path);
    }
}

sub to_fasta {
    
    my ($origin, $frame) = @_;

    my $origin_sequence = get_secuense_from_genbank($_[0]);
    my $rev_sequence = $origin_sequence->revcom;

    my $result_file_name = substr($origin, 0, -3)."_frame_".$frame;

    save_sequence_to_fasta($origin_sequence, $frame, $result_file_name);
    save_sequence_to_fasta($rev_sequence, $frame, $result_file_name."_rev");
}

sub get_secuense_from_genbank {

    my ($file) = @_;
    
    my $input = Bio::SeqIO->new(-file => $file, -format => 'genbank');
    
    return $input->next_seq;
}

sub save_sequence_to_fasta {

    my ($secuence, $frame, $result_name) = @_;

    my $translated = $secuence->translate(-frame => $frame);
    my $output = Bio::SeqIO->new(-file => ">result/$result_name.fsa", -format => 'fasta');

    $output->write_seq($translated);
}