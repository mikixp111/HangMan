package Models::Player;

use strict;
use warnings;

# use DataBase;
use Data::Dumper;

sub new {
    my $class = shift;
    my $attributes = shift || {};

    my $self = {
        attributes => $attributes,
        columns => [
            'id',
            'user_id',
            'username',
            'wins',
            'losses',
            'current_theme_id',
            'current_skin_id',
            'current_hat_id',
            'coins'
        ],
    };
    bless($self, $class);

    return $self;
}

sub getId {
    my $self = shift;

    return $self->{attributes}->{id};
}

sub getUserId {
    my $self = shift;

    return $self->{attributes}->{user_id};
}

sub getUsername {
    my $self = shift;

    return $self->{attributes}->{username};
}

sub getWins {
    my $self = shift;
    
    return $self->{attributes}->{wins};
}

sub getLosses {
    my $self = shift;
    
    return $self->{attributes}->{losses};
}

sub getThemes {
    my $self = shift;
    
    return $self->{attributes}->{current_theme_id};
}

sub getSkins {
    my $self = shift;
    
    return $self->{attributes}->{current_skin_id};
}

sub getHats {
    my $self = shift;
    
    return $self->{attributes}->{current_hat_id};
}

sub getCoins {
    my $self = shift;

    return $self->{attributes}->{coins};
}

sub save {
    my $self = shift;

    my %columns = map {
        $_ => 1
    } @{$self->{columns}};
    my $attributes = $self->{attributes};

    my @saveData;
    my @dataType;


    foreach my $key (keys %$attributes) {
        my $value = $attributes->{$key};
        unless ($columns{$key}) {
            next;
        }
        push(@saveData, $value);
        push(@dataType, $key);
    }

    my @insertData = join ', ', @dataType;

    my @duplicateData = map {$_ . ' = ?'} @dataType;
    @duplicateData = join ', ', @duplicateData;

    my $dataCount = @saveData;

    my $placeholder = join ', ', ('?') x $dataCount;

    my $sql = (
        "INSERT INTO players (id, @insertData)
        VALUES (NULL, $placeholder) 
        ON DUPLICATE KEY UPDATE @duplicateData;"
    );

    my $dbh = &_::app()->database();

    my $sth = $dbh->prepare($sql);

    $sth->execute(@saveData, @saveData) or die $dbh->errstr;

    return;
}

1;