package Repositories::HatsRepository;

use strict;
use warnings;

use Models::Hats;
use Data::Dumper;

sub new {
    my $class = shift;

    my $self = {};
    bless($self, $class);
    return $self;
}

sub findById {
    my $self = shift;
    my $id = shift;
    my $searchFor = shift;

    my $sql = "SELECT * FROM hats WHERE id = ? ;";

    my $dbh = &_::app()->database();

    my $sth = $dbh->prepare($sql);

    $sth->execute($id) or die $dbh->errstr;

    my $fields = $sth->fetchrow_hashref;

    unless ($fields) {
        return;
    }

    my $hats = Models::Hats->new($fields);

    return $hats->$searchFor();
}

sub selectHats {
    my $self = shift;

    my $sql = "SELECT id FROM hats ;";

    my $dbh = &_::app()->database();

    my $sth = $dbh->prepare($sql);

    $sth->execute() or die $dbh->errstr;

    my $hats = $sth->fetchall_arrayref(0);

    return $hats;
}

# sub create {
#     my $self = shift;    
#     my $attributes = shift;

#     my $hats = Models::Hats->new($attributes);

#     return $hats->save();
# }

1;