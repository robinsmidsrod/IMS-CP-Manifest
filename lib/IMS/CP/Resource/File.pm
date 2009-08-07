package IMS::CP::Resource::File;
use Moose;

use Encode ();

use IMS::LOM::LangString;

with 'IMS::Include::XMLNode';
with 'IMS::Include::XPathContext';
with 'IMS::Include::find';

use IMS::Include::Attribute::XPathValue;

has 'href' => (
    is          => 'ro',
    isa         => 'Str',
    traits      => [qw/XPathValue/],
    xpath_query => './@href',
);

sub found {
    my ($self) = @_;
    my $filename = Encode::encode_utf8( $self->href );
    return -r $filename; 
}

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

no Moose;
__PACKAGE__->meta->make_immutable();

1;
