package IMS::Include::XMLNode;
use Moose::Role;

has 'node' => (
    is       => 'ro',
    isa      => 'XML::LibXML::Node',
    required => 1,
);

1;
