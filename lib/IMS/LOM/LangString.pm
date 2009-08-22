package IMS::LOM::LangString;
use Moose;
with 'Rabbit::Node';

has 'language' => (
    isa         => 'Str',
    traits      => [qw/XPathValue/],
    xpath_query => './lom:langstring/@xml:lang',
);

has 'text' => (
    isa         => 'Str',
    traits      => [qw/XPathValue/],
    xpath_query => './lom:langstring',
);

no Moose;
__PACKAGE__->meta->make_immutable();

1;
