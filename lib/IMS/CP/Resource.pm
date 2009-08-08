package IMS::CP::Resource;
use Moose;

use Encode ();

use IMS::CP::Resource::File;

with 'IMS::Include::XMLNode';
with 'IMS::Include::XPathContext';
with 'IMS::Include::findnodes';

use IMS::Include::Attribute::XPathValue;
use IMS::Include::Attribute::XPathObject;

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

has 'title' => (
    is          => 'ro',
    isa         => 'IMS::LOM::LangString',
    traits      => [qw/XPathObject/],
    xpath_query => './cp:metadata/lom:lom/lom:general/lom:title',
);

has 'files' => (
    is         => 'ro',
    isa        => 'ArrayRef[IMS::CP::Resource::File]',
    lazy_build => 1,
);

sub _build_files {
    my ($self) = @_;
    return $self->findnodes(
        './cp:file',
        'IMS::CP::Resource::File',
    );
}

no Moose;
__PACKAGE__->meta->make_immutable();

1;
