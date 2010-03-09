
package Math::ContinuedFraction::Rational;
use Carp 'croak';

our $VERSION = "0.01";

sub gcd {
    my ($a, $b) = @_;
    ($a, $b) = ($b, $a % $b) while $b;
    return $a;
}

sub new {
    my ($base, $n, $d) = @_;
    my $class = ref($base) || $base;
    croak "Usage: $class\->new(numerator, denominator)"
	unless defined $d;
    my $self = bless [$n, $d] => $class;
    return $self->normalize();
}

sub normalize {
    my $self = shift;
    my ($n, $d) = @$self;
    if ($d < 0) {
	$n *= -1;
	$d *= -1;
    }
    my $g = gcd($n, $d);
    if ($g > 1) {
	$n /= $g;
	$d /= $g;
    }
    @$self = ($n, $d);
    return $self;
}

sub copy {
    my $self = shift;
    $self->new($self->num, $self->den);
}

sub num { $_[0][0] }
sub den { $_[0][1] }

sub as_string {
    my $self = shift;
    join "/", $self->num, $self->den;
}

sub recip {
    my $self = shift;
    $self->new($self->den, $sel->num);
}

sub negate {
    my $self = shift;
    $self->new(- $self->num, $sel->den);
}

sub add {
    my ($self, $add) = @_;
    $self->new($self->num * $add->den + $self->den * $add->num,
	       $self->den * $add->den);
}

sub sub {
    my ($self, $sub) = @_;
    return $self->add($sub->negate);
}

sub mul {
    my ($self, $mul) = @_;
    $self->new($self->num * $mul->num,
	       $self->den * $mul->den
	);
}

sub div {
    my ($self, $div) = @_;
    return $self->mul($div->recip);
}

sub as_float {
    my $self = shift;
    return $self->num / $self->den;
}

1;
