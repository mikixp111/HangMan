package Repositories::PlayerThemesRepository;

use strict;
use warnings;

use Models::PlayerThemes;
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
    my $themeId = shift;
    my $searchFor = shift;

    my $sql = "SELECT * FROM player_themes WHERE user_id = ? and theme_id = ?;";

    my $dbh = &_::app()->database();

    my $sth = $dbh->prepare($sql);

    $sth->execute($userId, $themeId) or die $dbh->errstr;

    my $fields = $sth->fetchrow_hashref;

    unless ($fields) {
        return;
    }

    my $playerThemes = Models::PlayerThemes->new($fields);

    return $playerThemes->$searchFor();
}

sub create {
    my $self = shift;    
    my $attributes = shift;

    my $playerThemes = Models::PlayerThemes->new($attributes);

    return $playerThemes->save();
}

sub total {
    my $self = shift;
    my $userId = shift;

    my $sql = "SELECT theme_id FROM player_themes WHERE user_id = ?;";

    my $dbh = &_::app()->database();

    my $sth = $dbh->prepare($sql);

    $sth->execute($userId) or die $dbh->errstr;

    my $total = $sth->fetchall_arrayref();

    return $total;
}

1;