package Repositories::HatsPlayerRepository;

use strict;
use warnings;

use Models::HatsPlayer;
use Data::Dumper;

sub new {
    my $class = shift;

    my $self = {};
    bless($self, $class);
    return $self;
}

sub findByUserId {
    my $self = shift;
    my $userId = shift;
    my $hatId = shift;
    my $searchFor = shift;

    my $sql = "SELECT * FROM hats_player WHERE user_id = ? and hat_id = ?;";

    my $dbh = &_::app()->database();

    my $sth = $dbh->prepare($sql);

    $sth->execute($userId, $hatId) or die $dbh->errstr;

    my $fields = $sth->fetchrow_hashref;

    unless ($fields) {
        return;
    }

    my $playerHats = Models::HatsPlayer->new($fields);

    return $playerHats->$searchFor();
}

sub create {
    my $self = shift;    
    my $attributes = shift;

    my $playerHats = Models::HatsPlayer->new($attributes);

    return $playerHats->save();
}

sub total {
    my $self = shift;
    my $userId = shift;

    my $sql = "SELECT hat_id FROM hats_player WHERE user_id = ?;";

    my $dbh = &_::app()->database();

    my $sth = $dbh->prepare($sql);

    $sth->execute($userId) or die $dbh->errstr;

    my $total = $sth->fetchall_arrayref();

    return $total;
}

1;