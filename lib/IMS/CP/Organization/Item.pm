package IMS::CP::Organization::Item;
use Moose;

use IMS::LOM::LangString;
use IMS::CP::Resource;

with 'IMS::Include::XMLNode';
with 'IMS::Include::XPathContext';
with 'IMS::Include::find';

use IMS::Include::Attribute::XPathValue;

has 'id' => (
    is          => 'ro',
    isa         => 'Str',
    traits      => [qw/XPathValue/],
    xpath_query => './cp:metadata/lom:lom/lom:general/lom:identifier',
);

has 'title' => (
    is         => 'ro',
    isa        => 'IMS::LOM::LangString',
    lazy_build => 1,
);

sub _build_title {
    my ( $self ) = @_;
    return $self->find(
        './cp:metadata/lom:lom/lom:general/lom:title',
        'IMS::LOM::LangString',
    );
}

has 'resource' => (
    is         => 'ro',
    isa        => 'IMS::CP::Resource',
    lazy_build => 1,
);

sub _build_resource {
    my ($self) = @_;
    return $self->find(
        '/cp:manifest/cp:resources/cp:resource[@identifier=' . $self->id . ']',
        'IMS::CP::Resource',
    );
}

no Moose;
__PACKAGE__->meta->make_immutable();

1;
