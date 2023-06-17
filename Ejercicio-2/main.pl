#!/usr/bin/perl -w 

use Bio::SeqIO;
use Bio::Tools::Run::StandAloneBlast;
use File::Path;

if (scalar(@ARGV) < 2) {
    print "No se pasaron todos los argumentos al programa!\n";
    exit
}

if (!($ARGV[0] =~ /local|remote/)) {
    print "No se especifico si el blast se hara de forma local o remota [local|remote]!\n";
    exit
}

foreach my $i(1 .. $#ARGV) {
    if (!($ARGV[$i] =~ /\.fsa$/)) {
        print "No tiene formato Fasta: $ARGV[$i]\n";
        exit
    }
}

File::Path::make_path("result");

foreach my $i(1 .. $#ARGV) {
    to_blast($ARGV[$i])
}

sub to_blast {
    my ($origin) = @_;

    my $result_dir_name = "result/";
    my $result_file_name = substr($origin, 0, -4);

    if (scalar(@ARGV) > 2) {
        $result_dir_name = "$result_dir_name$result_file_name/";
        File::Path::make_path($result_dir_name);
    }

    if ($ARGV[0] eq 'local'){
        to_local_blast($origin, $result_dir_name, $result_file_name);
    } else{
        to_remote_blast($origin, $result_dir_name, $result_file_name);
    }

}

sub to_local_blast {
    my ($origin, $result_dir_name, $result_file_name) = @_;

    my $sequence = get_secuense_from_fasta($origin);    

    system("sh ../Utils/init_local_blast.sh");

    my $factory = Bio::Tools::Run::StandAloneBlast->new(
        -program  => 'blastp',
        -database => 'database/swissprot',
        -outfile  => "$result_dir_name/$result_file_name.local.blast.out"
    );

    my $report = $factory->blastall($sequence);

    $report->close();
}

sub to_remote_blast {
    my ($origin, $result_dir_name, $result_file_name) = @_;

    system("sh ../Utils/init_remote_blast.sh");

    my $result = "$result_dir_name$result_file_name.remote.blast.out";

    exec("ncbi-blast-2.14.0+/bin/blastp -query $origin -db swissprot -out $result -remote");
}

sub get_secuense_from_fasta {

    my ($file) = @_;
    
    my $input = Bio::SeqIO->new(-file => $file, -format => 'fasta');
    
    return $input->next_seq;
}