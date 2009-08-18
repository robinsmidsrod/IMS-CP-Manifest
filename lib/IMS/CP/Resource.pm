package IMS::CP::Resource;
use Moose;
extends 'IMS::Include::XML::Node';

has 'href' => (
    is          => 'ro',
    isa         => 'Str',
    traits      => [qw/XPathValue/],
    xpath_query => './@href',
);

has 'title' => (
    is          => 'ro',
    isa         => 'IMS::LOM::LangString',
    traits      => [qw/XPathObject/],
    xpath_query => './cp:metadata/lom:lom/lom:general/lom:title',
);

has 'files' => (
    is          => 'ro',
    isa         => 'ArrayRef[IMS::CP::Resource::File]',
    traits      => [qw/XPathObjectList/],
    xpath_query => './cp:file',
);

no Moose;
__PACKAGE__->meta->make_immutable();

1;
