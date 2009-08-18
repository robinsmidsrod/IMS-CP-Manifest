package IMS::Include::XML::RootNode;
use Moose;
extends 'IMS::Include::XML::Document';

use XML::LibXML::XPathContext ();

has 'xpc' => (
    is         => 'ro',
    isa        => 'XML::LibXML::XPathContext',
    lazy_build => 1,
);

sub _build_xpc {
    my ($self) = @_;
    my $xpc = XML::LibXML::XPathContext->new( $self->document );
    if ( $self->can('namespace_map') ) {
        foreach my $prefix ( keys %{ $self->namespace_map } ) {
            $xpc->registerNs($prefix, $self->namespace_map->{$prefix});
        }
    }
    return $xpc;
}

has 'node' => (
    is         => 'ro',
    isa        => 'XML::LibXML::Node',
    lazy_build => 1,
);

sub _build_node {
    my ($self) = @_;
    return $self->document->documentElement();
}

no Moose;
__PACKAGE__->meta->make_immutable();

1;
