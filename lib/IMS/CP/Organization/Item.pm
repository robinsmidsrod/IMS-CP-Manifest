package IMS::CP::Organization::Item;
use Moose;

use IMS::LOM::LangString;
use IMS::CP::Resource;

has 'node' => (
    is       => 'ro',
    isa      => 'XML::LibXML::Node',
    required => 1,
);

has 'xpc' => (
    is       => 'ro',
    isa      => 'XML::LibXML::XPathContext',
    required => 1,
);

has 'id' => (
    is         => 'ro',
    isa        => 'Str',
    lazy_build => 1,
);

sub _build_id {
    my ($self) = @_;
    my $id = $self->xpc->findvalue( './cp:metadata/lom:lom/lom:general/lom:identifier', $self->node )
}

has 'title' => (
    is         => 'ro',
    isa        => 'IMS::LOM::LangString',
    lazy_build => 1,
);

sub _build_title {
    my ( $self ) = @_;

    my $node = $self->xpc->find( './cp:metadata/lom:lom/lom:general/lom:title', $self->node )->shift();

    my $title = IMS::LOM::LangString->new(
        xpc   => $self->xpc,
        node  => $node,
    );
    
    return $title;    
}

has 'resource' => (
    is         => 'ro',
    isa        => 'IMS::CP::Resource',
    lazy_build => 1,
);

sub _build_resource {
    my ($self) = @_;
    
    my $res = $self->xpc->find( '/cp:manifest/cp:resources/cp:resource[@identifier=' . $self->id . ']' )->shift();

    return IMS::CP::Resource->new(
        node => $res,
        xpc  => $self->xpc,
    );
    
}

no Moose;
__PACKAGE__->meta->make_immutable();

1;
