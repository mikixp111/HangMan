package Repositories::SkinsRepository;

use strict;
use warnings;

use Models::Skins;
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

    my $sql = "SELECT * FROM skins WHERE id = ? ;";

    my $dbh = &_::app()->database();

    my $sth = $dbh->prepare($sql);

    $sth->execute($id) or die $dbh->errstr;

    my $fields = $sth->fetchrow_hashref;

    unless ($fields) {
        return;
    }

    my $skins = Models::Skins->new($fields);

    return $skins->$searchFor();
}

sub findByName {
    my $self = shift;
    my $name = shift;
    my $searchFor = shift;

    my $sql = "SELECT * FROM skins WHERE name = ? ;";

    my $dbh = &_::app()->database();

    my $sth = $dbh->prepare($sql);

    $sth->execute($name) or die $dbh->errstr;

    my $fields = $sth->fetchrow_hashref;

    unless ($fields) {
        return;
    }

    my $skins = Models::Skins->new($fields);

    return $skins->$searchFor();
}

sub selectSkins {
    my $self = shift;

    my $sql = "SELECT name FROM skins ;";

    my $dbh = &_::app()->database();

    my $sth = $dbh->prepare($sql);

    $sth->execute() or die $dbh->errstr;

    my $skins = $sth->fetchall_arrayref(0);

    return $skins;
}

# sub create {
#     my $self = shift;    
#     my $attributes = shift;

#     my $skins = Models::Skins->new($attributes);

#     return $skins->save();
# }

1;