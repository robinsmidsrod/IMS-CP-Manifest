package IMS::CP::Organization;
use Moose;

use IMS::CP::Organization::Item;

with 'IMS::Include::XMLNode';
with 'IMS::Include::XPathContext';

use IMS::Include::Attribute::XPathValue;
use IMS::Include::Attribute::XPathObjectList;

has 'title' => (
    is          => 'ro',
    isa         => 'Str',
    traits      => [qw/XPathValue/],
    xpath_query => './cp:title',
);

has 'items' => (
    is          => 'ro',
    isa         => 'ArrayRef[IMS::CP::Organization::Item]',
    traits      => [qw/XPathObjectList/],
    xpath_query => './cp:item',
);

no Moose;
__PACKAGE__->meta->make_immutable();

1;
