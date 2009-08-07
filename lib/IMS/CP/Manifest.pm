package IMS::CP::Manifest;
use Moose;

use 5.008; # According to Perl::MinimumVersion

our $VERSION = '0.01';

use IMS::LOM::LangString;
use IMS::CP::Organization;

extends 'IMS::CP::XML::RootNode';

has 'title' => (
    is         => 'ro',
    isa        => 'IMS::LOM::LangString',
    lazy_build => 1,
);

sub _build_title {
    my ( $self ) = @_;

    my $node = $self->xpc->find(
        './cp:metadata/lom:lom/lom:general/lom:title',
        $self->node
    )->shift();

    my $title = IMS::LOM::LangString->new(
        xpc   => $self->xpc,
        node  => $node,
    );
    
    return $title;    
}

has 'organizations' => (
    is         => 'ro',
    isa        => 'ArrayRef[IMS::CP::Organization]',
    lazy_build => 1,
);

sub _build_organizations {
    my ( $self ) = @_;
    my @orgs;
    foreach my $node ( $self->xpc->findnodes( '/cp:manifest/cp:organizations/*' ) ) {
        my $instance = IMS::CP::Organization->new(
            node => $node,
            xpc => $self->xpc
        );
        push @orgs, $instance;
    }
    return \@orgs;
}

no Moose;
__PACKAGE__->meta->make_immutable();

1;
