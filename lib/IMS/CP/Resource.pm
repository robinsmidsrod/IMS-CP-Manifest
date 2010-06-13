use strict;
use warnings;

package IMS::CP::Resource;
use Moose;
with 'XML::Rabbit::Node';

# ABSTRACT: A specific package resource

=attr id

The identifier for the resource.

=cut

has 'id' => (
    isa         => 'Str',
    traits      => ['XPathValue'],
    xpath_query => './cp:metadata/lom:lom/lom:general/lom:identifier',
);

=attr href

The URI for the resource.

=cut

has 'href' => (
    isa         => 'Str',
    traits      => [qw/XPathValue/],
    xpath_query => './@href',
);

=attr title

The title of the resource.

=cut

has 'title' => (
    isa         => 'IMS::LOM::LangString',
    traits      => [qw/XPathObject/],
    xpath_query => './cp:metadata/lom:lom/lom:general/lom:title',
);

=attr files

The files associated with the resource.

=cut

has 'files' => (
    isa         => 'ArrayRef[IMS::CP::Resource::File]',
    traits      => [qw/XPathObjectList/],
    xpath_query => './cp:file',
);

no Moose;
__PACKAGE__->meta->make_immutable();

1;
