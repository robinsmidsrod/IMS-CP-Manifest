package IMS::CP::Organization::Item;
use Moose;
extends 'Rabbit::Node';

has 'id' => (
    isa         => 'Str',
    traits      => [qw/XPathValue/],
    xpath_query => './cp:metadata/lom:lom/lom:general/lom:identifier',
);

has 'title' => (
    isa         => 'IMS::LOM::LangString',
    traits      => [qw/XPathObject/],
    xpath_query => './cp:metadata/lom:lom/lom:general/lom:title',
);

has 'resource' => (
    isa        => 'IMS::CP::Resource',
    traits      => [qw/XPathObject/],
    xpath_query => sub {
        my ($self) = @_;
        return '/cp:manifest/cp:resources/cp:resource[@identifier=' . $self->id . ']';
    },
);

no Moose;
__PACKAGE__->meta->make_immutable();

1;
