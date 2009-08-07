package IMS::Include::XMLDocument;
use Moose;
extends 'IMS::Include::XMLParser';

use Encode ();
use XML::LibXML::XPathContext ();

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

sub dump {
    my ( $self ) = @_;
    return Encode::decode(
        $self->output_encoding,
        $self->document->toString(1),
    );
}

no Moose;
__PACKAGE__->meta->make_immutable();

1;
