package IMS::Include::XPathContext;
use Moose::Role;

has 'xpc' => (
    is       => 'ro',
    isa      => 'XML::LibXML::XPathContext',
    required => 1,
);

1;
