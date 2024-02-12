package Models::PlayerHats;

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
            'username',
            'id_0',
            'id_1',
            'id_2',
            'id_3',
            'id_4',
            'id_5',
            'id_6'
        ],
    };
    bless($self, $class);

    return $self;
}

sub getUsername {
    my $self = shift;

    return $self->{attributes}->{username};
}

sub getIdZero {
    my $self = shift;

    return $self->{attributes}->{id_0};
}

sub getIdOne {
    my $self = shift;

    return $self->{attributes}->{id_1};
}

sub getIdTwo {
    my $self = shift;
    
    return $self->{attributes}->{id_2};
}

sub getIdThree {
    my $self = shift;
    
    return $self->{attributes}->{id_3};
}

sub getIdFour {
    my $self = shift;
    
    return $self->{attributes}->{id_4};
}

sub getIdFive {
    my $self = shift;
    
    return $self->{attributes}->{id_5};
}

sub getIdSix {
    my $self = shift;
    
    return $self->{attributes}->{id_6};
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
        "INSERT INTO player_hats (@insertData)
        VALUES ($placeholder) 
        ON DUPLICATE KEY UPDATE @duplicateData;"
    );

    my $dbh = &_::app()->database();

    my $sth = $dbh->prepare($sql);

    $sth->execute(@saveData, @saveData) or die $dbh->errstr;

    return;
}

1;