package IMS::CP::Resource;
use Moose;
extends 'Rabbit::Node';

has 'href' => (
    isa         => 'Str',
    traits      => [qw/XPathValue/],
    xpath_query => './@href',
);

has 'title' => (
    isa         => 'IMS::LOM::LangString',
    traits      => [qw/XPathObject/],
    xpath_query => './cp:metadata/lom:lom/lom:general/lom:title',
);

has 'files' => (
    isa         => 'ArrayRef[IMS::CP::Resource::File]',
    traits      => [qw/XPathObjectList/],
    xpath_query => './cp:file',
);

no Moose;
__PACKAGE__->meta->make_immutable();

1;
