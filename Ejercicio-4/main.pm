#!/usr/bin/perl -w
use strict;
use Bio::SearchIO;
use Bio::DB::GenBank;
use Bio::SeqIO;

my $gb = Bio::DB::GenBank->new();

my $searchio = new Bio::SearchIO(
    -format => 'blast',
    -file   => $ARGV[0]);

my $pattern = $ARGV[1];

my $file = '>result/blast_report_hits.fsa';
my $seqout = Bio::SeqIO->new(-file => $file,
                             -format => 'Fasta');

print "Patrón ingresado: " . $pattern;
print "\n\n";

while ( my $result = $searchio->next_result() ) {
    while( my $hit = $result->next_hit ) {
    # process the Bio::Search::Hit::HitI object
        print "un hit: " . $hit->name . "\n";
        while( my $hsp = $hit->next_hsp ) {
            print "entre a un hsp"."\n";
            print "hit description:". $hit->description . "\n";
        # process the Bio::Search::HSP::HSPI object
            if (index($hit->description, $pattern) != -1) {
                print "Secuencia: " . $hit->name . "\n";
                print $hit->description . "\n";
                print "Hits: " . $hit->raw_score . "\n \n";

                my $accession = $hit->accession();
                # get a stream via a query string
                my $query = Bio::DB::Query::GenBank->new
                    (-query   => $accession,
                     -format     => 'Fasta',
                     -reldate => '30',
                     -db      => 'protein');
                my $seqio = $gb->get_Stream_by_query($query);

                while( my $seq =  $seqio->next_seq ) {
                    $seqout->write_seq($seq);
                }

            }
        }
    }
}
