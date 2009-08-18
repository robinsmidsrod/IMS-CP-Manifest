package IMS::LOM::LangString;
use Moose;
extends 'Rabbit::Node';

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
