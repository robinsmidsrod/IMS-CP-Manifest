package IMS::CP::XML::RootNode;
use Moose;
extends 'IMS::Include::XMLDocument';

use XML::LibXML::XPathContext ();

has 'xpc' => (
    is         => 'ro',
    isa        => 'XML::LibXML::XPathContext',
    lazy_build => 1,
);

sub _build_xpc {
    my ($self) = @_;
    my $xpc = XML::LibXML::XPathContext->new( $self->document );
    $xpc->registerNs('cp',  'http://www.imsglobal.org/xsd/imscp_v1p1');
    $xpc->registerNs('lom', 'http://www.imsglobal.org/xsd/imsmd_v1p2');
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
