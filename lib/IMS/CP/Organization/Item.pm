use strict;
use warnings;

package IMS::CP::Organization::Item;
use Moose;
with 'XML::Rabbit::Node';

# ABSTRACT: A specific item in an organization of items

=attr id

The identifier for the item.

=cut

has 'id' => (
    isa         => 'Str',
    traits      => [qw/XPathValue/],
    xpath_query => './cp:metadata/lom:lom/lom:general/lom:identifier',
);

=attr title

The title for the item.

=cut

has 'title' => (
    isa         => 'IMS::LOM::LangString',
    traits      => [qw/XPathObject/],
    xpath_query => './cp:metadata/lom:lom/lom:general/lom:title',
);

=attr resource

The associated resource for the item.

=cut

has 'resource' => (
    isa        => 'IMS::CP::Resource',
    traits      => [qw/XPathObject/],
    xpath_query => sub {
        my ($self) = @_;
        return '/cp:manifest/cp:resources/cp:resource[@identifier=' . $self->id . ']';
    },
);

no Moose;
__PACKAGE__->meta->make_immutable();

1;
