package Repositories::PlayerSkinsRepository;

use strict;
use warnings;

use Models::PlayerSkins;
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
    my $skinId = shift;
    my $searchFor = shift;

    my $sql = "SELECT * FROM player_skins WHERE user_id = ? and skin_id = ?;";

    my $dbh = &_::app()->database();

    my $sth = $dbh->prepare($sql);

    $sth->execute($userId, $skinId) or die $dbh->errstr;

    my $fields = $sth->fetchrow_hashref;

    unless ($fields) {
        return;
    }

    my $playerSkins = Models::PlayerSkins->new($fields);

    return $playerSkins->$searchFor();
}

sub create {
    my $self = shift;    
    my $attributes = shift;

    my $playerSkins = Models::PlayerSkins->new($attributes);

    return $playerSkins->save();
}

sub total {
    my $self = shift;
    my $userId = shift;

    my $sql = "SELECT skin_id FROM player_skins WHERE user_id = ?;";

    my $dbh = &_::app()->database();

    my $sth = $dbh->prepare($sql);

    $sth->execute($userId) or die $dbh->errstr;

    my $total = $sth->fetchall_arrayref();

    return $total;
}

1;