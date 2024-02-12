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

sub findByUsername {
    my $self = shift;
    my $username = shift;
    my $searchFor = shift;

    my $sql = "SELECT * FROM player_skins WHERE username = ? ;";

    my $dbh = &_::app()->database();

    my $sth = $dbh->prepare($sql);

    $sth->execute($username) or die $dbh->errstr;

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
    my $username = shift;

    my $sql = "SELECT id_1, id_2, id_3, id_4, id_5, id_6 FROM player_skins WHERE username = ? ;";

    my $dbh = &_::app()->database();

    my $sth = $dbh->prepare($sql);

    $sth->execute($username) or die $dbh->errstr;

    my $total = $sth->fetchrow_arrayref();

    return $total;
}


1;