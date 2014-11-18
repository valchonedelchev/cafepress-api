package Cafepress::Api;

use strict;
use warnings;
use XML::Hash;
use LWP::Simple;

sub new {
  my $class = shift;
  my $this  = {@_};

  die 'usage: ->new( key => CPKEY )'
    unless $this->{key};

  $this->{url}     ||= 'http://open-api.cafepress.com';
  $this->{version} ||= 3;

  bless $this, $class;
}

sub call {
  my ( $self, $method, %args ) = @_;

  my $url = sprintf( '%s/%s?v=%s&appKey=%s',
    $self->{url}, $method, $self->{version}, $self->{key} );

  map { $url .= sprintf( '&%s=%s', $_, $args{$_} ) } keys %args
    if scalar keys %args;

  my $xml = get($url) or die 'Failed to get XML.';

  return XML::Hash->new->fromXMLStringtoHash($xml);
}

1;
