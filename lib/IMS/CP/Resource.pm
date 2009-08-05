package IMS::CP::Resource;
use Moose;

use Encode ();

use IMS::LOM::LangString;
use IMS::CP::Resource::File;

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

has 'href' => (
    is => 'ro',
    isa => 'Str',
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

has 'files' => (
    is         => 'ro',
    isa        => 'ArrayRef[IMS::CP::Resource::File]',
    lazy_build => 1,
);

sub _build_files {
    my ($self) = @_;
    my @files;
    foreach my $file ( $self->xpc->findnodes( './cp:file', $self->node ) ) {
        push @files, IMS::CP::Resource::File->new( node => $file, xpc => $self->xpc );
    }
    return \@files;
}

no Moose;
__PACKAGE__->meta->make_immutable();

1;
