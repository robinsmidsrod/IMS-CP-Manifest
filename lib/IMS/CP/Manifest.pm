package IMS::CP::Manifest;
use Moose;

use 5.008; # According to Perl::MinimumVersion

our $VERSION = '0.01';

use XML::LibXML ();
use Encode ();

use IMS::LOM::LangString;
use IMS::CP::Organization;

has 'file' => (
    is  => 'ro',
    isa => 'Str',
);

has 'document' => (
    is         => 'ro',
    isa        => 'XML::LibXML::Document',
    lazy_build => 1,
);

sub _build_document {
    my ( $self ) = @_;
    
    my $doc = $self->parser->parse_file( $self->file );

    die("No input file specified.\n") unless $doc;
    
    $doc->setEncoding( $self->output_encoding );

    return $doc;
}

has 'output_encoding' => (
    is      => 'ro',
    isa     => 'Str',
    lazy    => 1,
    default => 'UTF-8',
);

has 'parser' => (
    is         => 'ro',
    isa        => 'XML::LibXML',
    lazy_build => 1,
);

sub _build_parser {
    my ($self) = @_;
    return XML::LibXML->new();
}

has 'xpc' => (
    is         => 'ro',
    isa        => 'XML::LibXML::XPathContext',
    lazy_build => 1,
);

sub _build_xpc {
    my ($self) = @_;
    my $xpc = XML::LibXML::XPathContext->new( $self->document );
    $xpc->registerNs('cp', 'http://www.imsglobal.org/xsd/imscp_v1p1');
    $xpc->registerNs('lom', 'http://www.imsglobal.org/xsd/imsmd_v1p2');
    return $xpc;
}

sub dump {
    my ( $self ) = @_;
    return Encode::decode(
        $self->output_encoding,
        $self->document->toString(1),
    );
}

has 'node' => (
    is => 'ro',
    isa => 'XML::LibXML::Node',
    lazy_build => 1,
);

sub _build_node {
    my ($self) = @_;
    return $self->document->documentElement();
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

has 'organizations' => (
    is         => 'ro',
    isa        => 'ArrayRef[IMS::CP::Organization]',
    lazy_build => 1,
);

sub _build_organizations {
    my ( $self ) = @_;
    my @orgs;
    foreach my $org ( $self->xpc->findnodes( '/cp:manifest/cp:organizations/*' ) ) {
        push @orgs, IMS::CP::Organization->new( node => $org, xpc => $self->xpc );
    }
    return \@orgs;
}

no Moose;
__PACKAGE__->meta->make_immutable();

1;
