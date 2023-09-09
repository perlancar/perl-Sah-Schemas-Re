package Sah::Schema::obj::re;

use strict;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = [
    obj => {
        summary => 'Regexp object',
        description => <<'MARKDOWN',

This schema can be used as a stricter version of the `re` type. Unlike `re`,
this schema only accepts `Regexp` object and not string.

MARKDOWN

        isa => 'Regexp',

        examples => [
            {value=>qr//, valid=>1},
            {value=>qr(^abc$)i, valid=>1},
            {value=>'^abc$', valid=>0, summary=>'Not a Regexp object'},
        ],
    },
];

1;
# ABSTRACT: Regexp object

=for Pod::Coverage ^(.+)$

=head1 SEE ALSO

're' in L<Sah::Type>

L<Sah::Schema::re_from_str>
