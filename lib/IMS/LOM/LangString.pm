package IMS::LOM::LangString;
use Moose;
extends 'IMS::Include::XML::Node';

use IMS::Include::Attribute::XPathValue;

has 'language' => (
    is          => 'ro',
    isa         => 'Str',
    traits      => [qw/XPathValue/],
    xpath_query => './lom:langstring/@xml:lang',
);

has 'text' => (
    is          => 'ro',
    isa         => 'Str',
    traits      => [qw/XPathValue/],
    xpath_query => './lom:langstring',
);

no Moose;
__PACKAGE__->meta->make_immutable();

1;
