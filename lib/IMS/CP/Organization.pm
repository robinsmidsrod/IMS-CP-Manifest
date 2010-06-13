use strict;
use warnings;

package IMS::CP::Organization;
use Moose;
with 'XML::Rabbit::Node';

# ABSTRACT: A way to organize content in the package

=attr title

The title of this organization of items.

=cut

has 'title' => (
    isa         => 'Str',
    traits      => [qw/XPathValue/],
    xpath_query => './cp:title',
);

=attr items

The items in this particular organization.

=cut

has 'items' => (
    isa         => 'ArrayRef[IMS::CP::Organization::Item]',
    traits      => [qw/XPathObjectList/],
    xpath_query => './cp:item',
);

no Moose;
__PACKAGE__->meta->make_immutable();

1;
