package IMS::CP::Organization;
use Moose;
with 'XML::Rabbit::Node';

has 'title' => (
    isa         => 'Str',
    traits      => [qw/XPathValue/],
    xpath_query => './cp:title',
);

has 'items' => (
    isa         => 'ArrayRef[IMS::CP::Organization::Item]',
    traits      => [qw/XPathObjectList/],
    xpath_query => './cp:item',
);

no Moose;
__PACKAGE__->meta->make_immutable();

1;
