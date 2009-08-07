package IMS::CP::Resource::File;
use Moose;

use Encode ();

use IMS::LOM::LangString;

with 'IMS::Include::XMLNode',
     'IMS::Include::XPathContext';

has 'href' => (
    is         => 'ro',
    isa        => 'Str',
    lazy_build => 1,
);

sub _build_href {
    my ($self) = @_;
    my $href = $self->xpc->findvalue( './@href', $self->node );
    return $href;
}

sub found {
    my ($self) = @_;
    my $filename = Encode::encode_utf8( $self->href );
    return -r $filename; 
}

has 'id' => (
    is         => 'ro',
    isa        => 'Str',
    lazy_build => 1,
);

sub _build_id {
    my ($self) = @_;
    my $id = $self->xpc->findvalue( './cp:metadata/lom:lom/lom:general/lom:identifier', $self->node );
    return $id;
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

no Moose;
__PACKAGE__->meta->make_immutable();

1;
