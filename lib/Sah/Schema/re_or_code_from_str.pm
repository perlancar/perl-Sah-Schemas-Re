package Sah::Schema::re_or_code_from_str;

use strict;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = [any => {
    summary => 'Regex (convertable from string of the form `/.../`) or coderef (convertable from string of the form `sub { ... }`)',
    description => <<'_',

Either Regexp object or coderef is accepted.

Coercion from string for Regexp is available if string is of the form of `/.../`
or `qr(...)`; it will be compiled into a Regexp object. If the regex pattern
inside `/.../` or `qr(...)` is invalid, value will be rejected. Currently,
unlike in normal Perl, for the `qr(...)` form, only parentheses `(` and `)` are
allowed as the delimiter. Currently modifiers `i`, `m`, and `s` after the second
`/` are allowed.

Coercion from string for coderef is available if string matches the regex
`qr/\Asub\s*\{.*\}\z/s`, then it will be eval'ed into a coderef. If the code
fails to compile, the value will be rejected. Note that this means you accept
arbitrary code from the user to execute! Please make sure first and foremost
that this is acceptable in your case. Currently string is eval'ed in the `main`
package, without `use strict` or `use warnings`.

Unlike the default behavior of the `re` Sah type, coercion from other string not
in the form of `/.../` or `qr(...)` is not available. Thus, such values will be
rejected.

This schema is handy if you want to accept regex or coderef from the
command-line.

_
    of => [
        ['obj::re'],
        ['code'],
    ],

    prefilters => [
        'Str::maybe_convert_to_re',
        'Str::maybe_eval',
    ],

    examples => [
        {value=>'', valid=>0, summary=>'Not to regex or code'},
        {value=>'a', valid=>0, summary=>'Not a regex or code'},
        {value=>{}, valid=>0, summary=>'Not a regex or code'},
        {value=>qr//, valid=>1},
        {value=>sub{}, valid=>1},

        # re
        {value=>'//', valid=>1, validated_value=>qr//},
        {value=>'/foo', valid=>0, summary=>'Not converted to regex'},
        {value=>'qr(foo', valid=>0, summary=>'Not converted to regex'},
        {value=>'qr(foo(', valid=>0, summary=>'Not converted to regex'},
        {value=>'qr/foo/', valid=>0, summary=>'Not converted to regex'},

        {value=>'/foo.*/', valid=>1, validated_value=>qr/foo.*/},
        {value=>'qr(foo.*)', valid=>1, validated_value=>qr/foo.*/},
        {value=>'/foo/is', valid=>1, validated_value=>qr/foo/is},
        {value=>'qr(foo)is', valid=>1, validated_value=>qr/foo/is},

        {value=>'/foo[/', valid=>0, summary=>'Invalid regex'},

        # code
        {value=>'sub {}', valid=>1, code_validate=>sub { ref($_[0]) eq 'CODE' & !defined($_[0]->()) }},
        {value=>'sub{"foo"}', valid=>1, code_validate=>sub { ref($_[0]) eq 'CODE' && $_[0]->() eq 'foo' }},
        {value=>'sub {', valid=>0, summary=>'Not converted to code'},

        {value=>'sub {1=2}', valid=>0, summary=>'Code does not compile'},
    ],

}];

1;
# ABSTRACT:

=head1 SEE ALSO

L<Sah::Schema::str_or_re>

L<Sah::Schema::str_or_code>

L<Sah::Schema::str_or_re_or_code>
