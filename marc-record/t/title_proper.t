# $Id: title_proper.t,v 1.2 2003/01/30 03:28:06 petdance Exp $

use strict;
use integer;
eval 'use warnings' if $] >= 5.006;

use Test::More tests=>14;

BEGIN {
    use_ok( 'MARC::File::USMARC' );
}

my @titles = (
    'Current population reports. Series P-20, Population characteristics.',
    'Current population reports. Series P-60, Consumer income.',
    'Physical review. A, Atomic, molecular, and optical physics',
    'Physical review. B, Condensed matter',
    'America and the British Labour Party :',
);

my $file = MARC::File::USMARC->in( 't/title_proper.usmarc' );
isa_ok( $file, 'MARC::File::USMARC', 'USMARC file' );

while ( my $marc = $file->next() ) {
    isa_ok( $marc, 'MARC::Record', 'Got a record' );

    my $title = shift @titles;
    is( $marc->title_proper, $title );
}
ok( !$MARC::File::Error, "Should have no error" );
is( scalar @titles, 0, "no titles left to check" );

$file->close;
