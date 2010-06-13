use strict;
use warnings;

package IMS::LOM::LangString;
use Moose;
with 'XML::Rabbit::Node';

# ABSTRACT: A string of text in the specified language

=attr language

The language identifier for the text. Specified in W3C xml:lang syntax.

=cut

has 'language' => (
    isa         => 'Str',
    traits      => [qw/XPathValue/],
    xpath_query => './lom:langstring/@xml:lang',
);

=attr text

The actual string of text.

=cut

has 'text' => (
    isa         => 'Str',
    traits      => [qw/XPathValue/],
    xpath_query => './lom:langstring',
);

no Moose;
__PACKAGE__->meta->make_immutable();

1;
