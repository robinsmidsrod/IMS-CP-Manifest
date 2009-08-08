package IMS::CP::Manifest;
use Moose;
extends 'IMS::CP::XML::RootNode';

use 5.008; # According to Perl::MinimumVersion

our $VERSION = '0.01';

use IMS::Include::Attribute::XPathObject;
use IMS::Include::Attribute::XPathObjectList;

has 'title' => (
    is          => 'ro',
    isa         => 'IMS::LOM::LangString',
    traits      => [qw/XPathObject/],
    xpath_query => './cp:metadata/lom:lom/lom:general/lom:title',
);

has 'organizations' => (
    is          => 'ro',
    isa         => 'ArrayRef[IMS::CP::Organization]',
    traits      => [qw/XPathObjectList/],
    xpath_query => '/cp:manifest/cp:organizations/*',
);

no Moose;
__PACKAGE__->meta->make_immutable();

1;
