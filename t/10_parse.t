#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 41;

use utf8;
use IMS::CP::Manifest;

my $manifest = IMS::CP::Manifest->new( file => 't/data/10_parse/imsmanifest.xml' );
isa_ok($manifest,'IMS::CP::Manifest');

# Verify that xmlns prefixes are present
ok($manifest->xpc->lookupNs('cp') eq 'http://www.imsglobal.org/xsd/imscp_v1p1', "IMS CP namespace mismatch");
ok($manifest->xpc->lookupNs('lom') eq 'http://www.imsglobal.org/xsd/imsmd_v1p2', "IMS LOM namespace mismatch");

isa_ok($manifest->title, 'IMS::LOM::LangString');
my $title_dump = <<'XML';
<imsmd:title>
  <imsmd:langstring xml:lang="no">Oppsummering</imsmd:langstring>
</imsmd:title>
XML
chomp($title_dump);
#diag($manifest->title->dump);
ok($manifest->title->dump eq $title_dump, "title XML dump mismatch");
ok($manifest->title->language eq 'no', "manifest title language mismatch");
ok($manifest->title->text eq 'Oppsummering', "manifest title text mismatch");

isa_ok($manifest->organizations,'ARRAY');
my $org = $manifest->organizations->[0];
isa_ok($org, 'IMS::CP::Organization');

ok($org->title eq 'Oppsummering','organization title mismatch');

isa_ok($org->items, 'ARRAY');
ok( @{ $org->items } == 5, 'organization item count is not 5');

my $item0 = $org->items->[0];
isa_ok( $item0, 'IMS::CP::Organization::Item' );
ok( $item0->id eq '722716', "item0 id mismatch");
ok( $item0->title->language eq 'no', "item0 title language mismatch");
ok( $item0->title->text eq '8.1-XTRA Virkemiddel: Musikk, tempo og rytme', "item0 title text mismatch");

my $item4 = $org->items->[4];
isa_ok( $item4, 'IMS::CP::Organization::Item' );
ok( $item4->id eq '722762', "item4 id mismatch");
ok( $item4->title->language eq 'no', "item4 title language mismatch");
ok( $item4->title->text eq '8.5-XTRA Fra deler til helhet', "item4 title text mismatch");

my $res0 = $item0->resource;
isa_ok($res0, 'IMS::CP::Resource');
ok( $res0->href eq '8.1-XTRA Virkemiddel: Musikk, tempo og rytme/8.1 Virkemiddel: Musikk, tempo og rytme.html', "res0 href mismatch");
ok( $res0->title->language eq 'no', "res0 title language mismatch");
ok( $res0->title->text eq '8.1 Virkemiddel: Musikk, tempo og rytme', "res0 title text mismatch");
ok( @{ $res0->files } == 1, 'res0 file count is not 1');

my $res4 = $item4->resource;
isa_ok($res4, 'IMS::CP::Resource');
ok( $res4->href eq '8.5-XTRA Fra deler til helhet/8.5 Fra deler til helhet.html', "res4 href mismatch");
ok( $res4->title->language eq 'no', "res4 title language mismatch");
ok( $res4->title->text eq '8.5 Fra deler til helhet', "res4 title text mismatch");
ok( @{ $res4->files } == 1, 'res4 file count is not 1');

my $file0 = $res0->files->[0];
isa_ok( $file0, 'IMS::CP::Resource::File');
ok( $file0->id eq 'Stromgren-Gorri_Gorr', "file0 id mismatch");
ok( $file0->href eq 'resources/Gorri Gorri med Jo Stroemgren Co..flv', "file0 href mismatch");
ok( $file0->title->language eq 'no', "file0 title language mismatch");
ok( $file0->title->text eq 'Gorri Gorri med Jo Strømgren Co.', "file0 title text mismatch");

my $file4 = $res4->files->[0];
isa_ok( $file4, 'IMS::CP::Resource::File');
ok( $file4->id eq 'Stromgren-Tok_Pisin', "file4 id mismatch");
ok( $file4->href eq 'resources/Tok Pisin med Jo Stroemgren Co..flv', "file4 href mismatch");
ok( $file4->title->language eq 'no', "file4 title language mismatch");
ok( $file4->title->text eq 'Tok Pisin med Jo Strømgren Co.', "file4 title text mismatch");
my $file4_title_dump = <<'XML';
<imsmd:title>
  <imsmd:langstring xml:lang="no">Tok Pisin med Jo Strømgren Co.</imsmd:langstring>
</imsmd:title>
XML
chomp($file4_title_dump);
#diag($file4->title->dump);
ok($file4->title->dump eq $file4_title_dump, "file4 title XML dump mismatch");
    
exit;

1;
