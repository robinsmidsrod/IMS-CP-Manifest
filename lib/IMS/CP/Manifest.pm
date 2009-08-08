package IMS::CP::Manifest;
use Moose;
extends 'IMS::CP::XML::RootNode';

use 5.008; # According to Perl::MinimumVersion

our $VERSION = '0.01';

use IMS::CP::Organization;

with 'IMS::Include::findnodes';

use IMS::Include::Attribute::XPathObject;

has 'title' => (
    is          => 'ro',
    isa         => 'IMS::LOM::LangString',
    traits      => [qw/XPathObject/],
    xpath_query => './cp:metadata/lom:lom/lom:general/lom:title',
);

has 'organizations' => (
    is         => 'ro',
    isa        => 'ArrayRef[IMS::CP::Organization]',
    lazy_build => 1,
);

sub _build_organizations {
    my ( $self ) = @_;
    return $self->findnodes(
        '/cp:manifest/cp:organizations/*',
        'IMS::CP::Organization',
    );
}

no Moose;
__PACKAGE__->meta->make_immutable();

1;
