package Cafepress::Api;

use Moose;
use XML::Hash;
use LWP::UserAgent;
use Params::Validate;

our $VERSION = 0.02;

has key => ( is => 'rw', isa => 'Str', required => 1 );

has url => ( is => 'rw', isa => 'Str' );

has api_version => ( is => 'rw', isa => 'Int', default => 3 );

has response => (
  is      => 'rw',
  isa     => 'HTTP::Response',
  default => sub { return HTTP::Response->new(418) },
);

has ua => (
  is      => 'ro',
  isa     => 'LWP::UserAgent',
  default => sub { LWP::UserAgent->new },
);

has api_base => (
  is       => 'rw',
  isa      => 'Str',
  required => 1,
  default  => 'http://open-api.cafepress.com'
);

sub call {
  my ( $self, $method, %args ) = @_;

  my $url = sprintf( '%s/%s?v=%s&appKey=%s',
    $self->api_base, $method, $self->api_version, $self->key );

  map { $url .= sprintf( '&%s=%s', $_, $args{$_} ) } keys %args
    if scalar keys %args;

  $self->url($url);
  $self->response( $self->ua->get( $self->url ) );

  return $self->response->is_success
    && XML::Hash->new->fromXMLStringtoHash( $self->response->decoded_content );
}

sub error {
  my $self = shift;

  if ( $self->response->content =~ m{<\?xml}i ) {
    my $href = XML::Hash->new->fromXMLStringtoHash( $self->response->content );
    return $self->response->status_line . ' - '
      . $href->{'help'}->{'exception-message'}->{text};
  }
  else {
    return $self->response->status_line;
  }

}

__PACKAGE__->meta->make_immutable;
