use strict;
use warnings;

package IMS::CP::Resource::File;
use Moose;
with 'XML::Rabbit::Node';

# ABSTRACT: One file inside a resource

=attr href

The URI associated with the file.

=cut

has 'href' => (
    isa         => 'Str',
    traits      => [qw/XPathValue/],
    xpath_query => './@href',
);

=attr id

The identifier for the file.

=cut

has 'id' => (
    isa         => 'Str',
    traits      => [qw/XPathValue/],
    xpath_query => './cp:metadata/lom:lom/lom:general/lom:identifier',
);

=attr title

The title of the file.

=cut

has 'title' => (
    isa         => 'IMS::LOM::LangString',
    traits      => [qw/XPathObject/],
    xpath_query => './cp:metadata/lom:lom/lom:general/lom:title',
);

no Moose;
__PACKAGE__->meta->make_immutable();

1;
