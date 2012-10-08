use strict; use warnings;

BEGIN {
    binmode STDERR, ':utf8';
}

use MARC::Charset qw/marc8_to_utf8 utf8_to_marc8/;
use Test::More tests => 4;

use utf8;

my $marc8     = "Ha\xFAn\xFBgin Il\xEBi\xECushin";
my $expected  = 'Han͠gin Ili͡ushin';
my $incorrect = 'Han͠g︣in Ili͡u︡shin';

# check conversion from MARC-8 to UTF-8
my $utf8 = marc8_to_utf8($marc8);
is($utf8, $expected,   'successful conversion of double diacritics');
if ($utf8 eq $incorrect) {
    fail('not doing old, incorrect double diacritic conversion');
} else {
    pass('not doing old, incorrect double diacritic conversion');
};

# check conversion in the other direction
my $marc8_back = utf8_to_marc8($expected);
is($marc8_back, $marc8, 'successful conversion back to MARC-8');

# ... including back from bogus conversion of the double diacritics
# generated by earlier versions of MARC::Charset
my $marc8_back2 = utf8_to_marc8($incorrect);
is($marc8_back2, $marc8, 'successful conversion back to MARC-8 from incorrect UTF-8');