package IMS::CP::Organization;
use Moose;

use IMS::CP::Organization::Item;

with 'IMS::Include::XMLNode';
with 'IMS::Include::XPathContext';
with 'IMS::Include::findnodes';

use IMS::Include::Attribute::XPathValue;

has 'title' => (
    is          => 'ro',
    isa         => 'Str',
    traits      => [qw/XPathValue/],
    xpath_query => './cp:title',
);

has 'items' => (
    is         => 'ro',
    isa        => 'ArrayRef[IMS::CP::Organization::Item]',
    lazy_build => 1,
);

sub _build_items {
    my ($self) = @_;
    return $self->findnodes(
        './cp:item',
        'IMS::CP::Organization::Item',
    );
}

no Moose;
__PACKAGE__->meta->make_immutable();

1;
