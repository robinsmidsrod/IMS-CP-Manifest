package IMS::CP::Organization;
use Moose;

use IMS::CP::Organization::Item;

has 'node' => (
    is       => 'ro',
    isa      => 'XML::LibXML::Node',
    required => 1,
);

has 'xpc' => (
    is       => 'ro',
    isa      => 'XML::LibXML::XPathContext',
    required => 1,
);

has 'title' => (
    is         => 'ro',
    isa        => 'Str',
    lazy_build => 1,
);

sub _build_title {
    my ($self) = @_;
    my $title = $self->xpc->findvalue( './cp:title', $self->node );
    return $title;
}

has 'items' => (
    is         => 'ro',
    isa        => 'ArrayRef[IMS::CP::Organization::Item]',
    lazy_build => 1,
);

sub _build_items {
    my ($self) = @_;
    my @items;
    foreach my $item ( $self->xpc->findnodes( './cp:item', $self->node ) ) {
        push @items, IMS::CP::Organization::Item->new( node => $item, xpc => $self->xpc );
    }
    return \@items;
}

no Moose;
__PACKAGE__->meta->make_immutable();

1;
