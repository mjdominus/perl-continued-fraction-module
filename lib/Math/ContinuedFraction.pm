
package Math::ContinuedFraction;
our $VERSION = "0.01";

sub rationalFactory { 
    require Math::ContinuedFraction::Rational; 
    return "Math::ContinuedFraction::Rational";
}

sub frac { 
    return rationalFactory()->new($_[0], $_[1]);
}

1;
