package IMS::CP::Resource::File;
use Moose;
extends 'IMS::Include::XML::Node';

use IMS::Include::Attribute::XPathValue;
use IMS::Include::Attribute::XPathObject;

has 'href' => (
    is          => 'ro',
    isa         => 'Str',
    traits      => [qw/XPathValue/],
    xpath_query => './@href',
);

has 'id' => (
    is          => 'ro',
    isa         => 'Str',
    traits      => [qw/XPathValue/],
    xpath_query => './cp:metadata/lom:lom/lom:general/lom:identifier',
);

has 'title' => (
    is          => 'ro',
    isa         => 'IMS::LOM::LangString',
    traits      => [qw/XPathObject/],
    xpath_query => './cp:metadata/lom:lom/lom:general/lom:title',
);

no Moose;
__PACKAGE__->meta->make_immutable();

1;
