package IMS::Include::XML::Node;
use Moose;

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

no Moose;
__PACKAGE__->meta->make_immutable();

1;
