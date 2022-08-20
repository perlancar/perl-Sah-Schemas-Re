package Sah::Schema::re_from_str;

use strict;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = [
    re => {
        summary => 'Regexp object from string using Regexp::From::String\'s str_to_re()',
        description => <<'_',

This schema accepts Regexp object or string which will be coerced to Regexp object
using <pm:Regexp::From::String>'s `str_to_re()` function.

Basically, if string is of the form of `/.../` or `qr(...)`, then you could
specify metacharacters as if you are writing a literal regexp pattern in Perl.
Otherwise, your string will be `quotemeta()`-ed first then compiled to Regexp
object. This means in the second case you cannot specify metacharacters.

_

        prefilters => [ ['Re::re_from_str'=>{}] ],

        examples => [
        ],
    },
];

1;
# ABSTRACT: Regexp object from string

=for Pod::Coverage ^(.+)$

=head1 SEE ALSO

L<Sah::PSchema::re_from_str> a parameterized version of this schema.

L<Regexp::From::String>
