use strict;
use warnings;

package IMS::CP::Manifest;
use Moose;
with 'XML::Rabbit::RootNode';

use 5.008; # According to Perl::MinimumVersion

# ABSTRACT: IMS Content Packaging Manifest XML parser

=attr namespace_map

The prefixes C<cp> and C<lom> are declared for use in XPath queries.

=cut

has '+namespace_map' => (
    default => sub { {
        'cp'  => 'http://www.imsglobal.org/xsd/imscp_v1p1',
        'lom' => 'http://www.imsglobal.org/xsd/imsmd_v1p2',
    } },
);

=attr title

The main title of the manifest.

=cut

has 'title' => (
    isa         => 'IMS::LOM::LangString',
    traits      => [qw/XPathObject/],
    xpath_query => './cp:metadata/lom:lom/lom:general/lom:title',
);

=attr organizations

A list of organizations of content. Organizations are basically different
ways to organize the content in the package, e.g. linear or hierarchial.

=cut

has 'organizations' => (
    isa         => 'ArrayRef[IMS::CP::Organization]',
    traits      => [qw/XPathObjectList/],
    xpath_query => '/cp:manifest/cp:organizations/*',
);

no Moose;
__PACKAGE__->meta->make_immutable();

1;

=head1 DESCRIPTION

This is a simple (read-only) parser for IMS Content Packaging manifest XML
files. The specification is available from
L<http://www.imsglobal.org/content/packaging/index.html>. It is still
incomplete, but it enables you to get access to the organization of all the
resources in the manifest and their associated files (and titles).
