package IMS::CP::Manifest;
use Moose;
extends 'IMS::CP::XML::RootNode';

use 5.008; # According to Perl::MinimumVersion

our $VERSION = '0.01';

use IMS::LOM::LangString;
use IMS::CP::Organization;

with 'IMS::Include::find';
with 'IMS::Include::findnodes';

has 'title' => (
    is         => 'ro',
    isa        => 'IMS::LOM::LangString',
    lazy_build => 1,
);

sub _build_title {
    my ( $self ) = @_;
    return $self->find(
        './cp:metadata/lom:lom/lom:general/lom:title',
        'IMS::LOM::LangString'
    );
}

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
