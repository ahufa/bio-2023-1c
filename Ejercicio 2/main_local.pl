#!/usr/bin/perl -w 

use Bio::SeqIO;
use Bio::Tools::Run::StandAloneBlast;
use File::Path;

if (scalar(@ARGV) == 0) {
    print "No se pasaron argumentos al programa!\n";
    exit
}

foreach my $i(0 .. $#ARGV) {
    if (!($ARGV[$i] =~ /\.fsa$/)) {
        print "No tiene formato Fasta: $ARGV[$i]\n";
        exit
    }
}

system("sh init_local.sh");

system("sh ../Utils/create_dir_result.sh");

foreach my $i(0 .. $#ARGV) {
    to_blast($ARGV[$i])
}

sub to_blast {
    my ($origin) = @_;

    my $sequence = get_secuense_from_fasta($origin);

    my $result_dir_name = "result/";
    my $result_file_name = substr($origin, 0, -4);

    if (scalar(@ARGV) > 1) {
        $result_dir_name = $result_dir_name.$result_file_name;
        File::Path::make_path($result_dir_name);
    }

    my $factory = Bio::Tools::Run::StandAloneBlast->new(
        -program  => 'blastp',
        -database => 'database/swissprot',
        -outfile  => "result/$result_file_name/$result_file_name.blast.out"
    );

    my $report = $factory->blastall($sequence);

    $report->close();
}

sub get_secuense_from_fasta {

    my ($file) = @_;
    
    my $input = Bio::SeqIO->new(-file => $file, -format => 'fasta');
    
    return $input->next_seq;
}