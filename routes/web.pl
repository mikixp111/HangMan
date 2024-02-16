#!/usr/bin/perl

use strict;
use warnings;

use Http::Route;
use Hangman::Http::Controllers::Controller;
use Foundation::Appify;
use Repositories::PlayerRepository;
use Repositories::PlayerThemesRepository;
use Repositories::PlayerSkinsRepository;
use Repositories::HatsPlayerRepository;
use Repositories::HatsRepository;
use Repositories::SkinsRepository;
use Repositories::ThemesRepository;


Http::Route::group({

    middlewares => [

        # Check if the visitor is signed in.
        'Http::Middlewares::Auth',
        
        # TODO: Implement service middleware classes instead of only using
        # TODO: closures.
        sub {
            my $request = shift;
            my $next = shift;
            
            # Player
            my $playerRepository = Repositories::PlayerRepository->new();
            
            my $userId = user()->get('id');
            my $username = $playerRepository->findByUserId($userId, 'getUsername');
            my $wins = $playerRepository->findByUserId($userId, 'getWins');
            my $losses = $playerRepository->findByUserId($userId, 'getLosses');
            my $themes = $playerRepository->findByUserId($userId, 'getThemes');
            my $skins = $playerRepository->findByUserId($userId, 'getSkins');
            my $hats = $playerRepository->findByUserId($userId, 'getHats');
            my $coins = $playerRepository->findByUserId($userId, 'getCoins');
            my $rank = $playerRepository->getRank($username);
            my $highscores = $playerRepository->sortByWins();
            my $player = {
                'user_id' => $userId,
                'username' => $username,
                'wins' => $wins,
                'losses' => $losses,
                'current_theme_id' => $themes,
                'current_skin_id' => $skins,
                'current_hat_id' => $hats,
                'coins' => $coins,
            };
            my $skinColor = 'black';
            if ($skins eq 1) {
                $skinColor = 'red';
            };
            if ($skins eq 2) {
                $skinColor = 'blue';
            };
            if ($skins eq 3) {
                $skinColor = 'yellow';
            };
            if ($skins eq 4) {
                $skinColor = 'green';
            };
            if ($skins eq 5) {
                $skinColor = 'orange';
            };
            if ($skins eq 6) {
                $skinColor = 'purple';
            };

            $request->{skinColor} = $skinColor;
            $request->{wins} = $wins;
            $request->{losses} = $losses;
            $request->{username} = $username;
            $request->{highscores} = $highscores;
            $request->{coins} = $coins;
            $request->{rank} = $rank->{ranking};
            $request->{player} = $player;
            $request->{skins} = $skins;
            $request->{hats} = $hats;
            $request->{themes} = $themes;


            # Player Themes
            my $playerThemesRepository = Repositories::PlayerThemesRepository->new();

            my $themesIdZero = 1;
            my $themesIdOne = $playerThemesRepository->findByUserId($userId, 1, 'getThemeId');
            my $themesIdTwo = $playerThemesRepository->findByUserId($userId, 2, 'getThemeId');
            my $themesIdThree = $playerThemesRepository->findByUserId($userId, 3, 'getThemeId');
            my $themesIdFour = $playerThemesRepository->findByUserId($userId, 4, 'getThemeId');
            my $themesIdFive = $playerThemesRepository->findByUserId($userId, 5, 'getThemeId');
            my $themesIdSix = $playerThemesRepository->findByUserId($userId, 6, 'getThemeId');

            $request->{themesIdOne} = $themesIdOne;
            $request->{themesIdTwo} = $themesIdTwo;
            $request->{themesIdThree} = $themesIdThree;
            $request->{themesIdFour} = $themesIdFour;
            $request->{themesIdFive} = $themesIdFive;
            $request->{themesIdSix} = $themesIdSix;

            my $totalThemes = $playerThemesRepository->total($userId);
            my $themesCollection = @$totalThemes;
            $request->{themesCollection} = $themesCollection;


            # Player Skins
            my $playerSkinsRepository = Repositories::PlayerSkinsRepository->new();

            my $skinsIdZero = 1;
            my $skinsIdOne = $playerSkinsRepository->findByUserId($userId, 1, 'getSkinId');
            my $skinsIdTwo = $playerSkinsRepository->findByUserId($userId, 2, 'getSkinId');
            my $skinsIdThree = $playerSkinsRepository->findByUserId($userId, 3, 'getSkinId');
            my $skinsIdFour = $playerSkinsRepository->findByUserId($userId, 4, 'getSkinId');
            my $skinsIdFive = $playerSkinsRepository->findByUserId($userId, 5, 'getSkinId');
            my $skinsIdSix = $playerSkinsRepository->findByUserId($userId, 6, 'getSkinId');

            $request->{skinsIdOne} = $skinsIdOne;
            $request->{skinsIdTwo} = $skinsIdTwo;
            $request->{skinsIdThree} = $skinsIdThree;
            $request->{skinsIdFour} = $skinsIdFour;
            $request->{skinsIdFive} = $skinsIdFive;
            $request->{skinsIdSix} = $skinsIdSix;

            my $totalSkins = $playerSkinsRepository->total($userId);
            my $skinsCollection = @$totalSkins;
            $request->{skinsCollection} = $skinsCollection;

            # Player Hats
            my $hatsPlayerRepository = Repositories::HatsPlayerRepository->new();
                    
            my $hatsIdZero = 1;
            my $hatsIdOne = $hatsPlayerRepository->findByUserId($userId, 1, 'getHatId');
            my $hatsIdTwo = $hatsPlayerRepository->findByUserId($userId, 2, 'getHatId');
            my $hatsIdThree = $hatsPlayerRepository->findByUserId($userId, 3, 'getHatId');
            my $hatsIdFour = $hatsPlayerRepository->findByUserId($userId, 4, 'getHatId');
            my $hatsIdFive = $hatsPlayerRepository->findByUserId($userId, 5, 'getHatId');
            my $hatsIdSix = $hatsPlayerRepository->findByUserId($userId, 6, 'getHatId');

            $request->{hatsIdOne} = $hatsIdOne;
            $request->{hatsIdTwo} = $hatsIdTwo;
            $request->{hatsIdThree} = $hatsIdThree;
            $request->{hatsIdFour} = $hatsIdFour;
            $request->{hatsIdFive} = $hatsIdFive;
            $request->{hatsIdSix} = $hatsIdSix;

            my $totalHats = $hatsPlayerRepository->total($userId);
            my $hatsCollection = @$totalHats;
            $request->{hatsCollection} = $hatsCollection;


            # Skins
            my $skinsRepository = Repositories::SkinsRepository->new();
            # my $skinId = 1;
            # my $skinsId = $skinsRepository->findById($skinId, 'getId');
            # my $skinsName = $skinsRepository->findById($skinId, 'getName');
            # my $skinsPrice = $skinsRepository->findById($skinId, 'getPrice');

            # $request->{skinsId} = $skinsId;
            # $request->{skinsName} = $skinsName;
            # $request->{skinsPrice} = $skinsPrice;
            # my $skins = {
            #     'id' => $skinsId,
            #     'name' => $skinsName,
            #     'price' => $skinsPrice,
            # };


            # Themes
            my $themesRepository = Repositories::ThemesRepository->new();
            # my $themeId = 1;
            # my $themesId = $themesRepository->findById($themeId, 'getId');
            # my $themesName = $themesRepository->findById($themeId, 'getName');
            # my $themesPrice = $themesRepository->findById($themeId, 'getPrice');

            # $request->{themesId} = $themesId;
            # $request->{themesName} = $themesName;
            # $request->{themesPrice} = $themesPrice;
            # my $themes = {
            #     'id' => $themesId,
            #     'name' => $themesName,
            #     'price' => $themesPrice,
            # };


            # Hats
            my $hatsRepository = Repositories::HatsRepository->new();
            # my $hatId = 1;
            # my $hatsId = $hatsRepository->findById($hatId, 'getId');
            # my $hatsName = $hatsRepository->findById($hatId, 'getName');
            # my $hatsPrice = $hatsRepository->findById($hatId, 'getPrice');

            # $request->{hatsId} = $hatsId;
            # $request->{hatsName} = $hatsName;
            # $request->{hatsPrice} = $hatsPrice;
            # my $hats = {
            #     'id' => $hatsId,
            #     'name' => $hatsName,
            #     'price' => $hatsPrice,
            # };


            # Create Player and Players Inventory
            my $usernameExists = $playerRepository->findByUsername($request->param('username'), 'getUsername');

            $request->{usernameExists} = $usernameExists;

            my $playerCreate = {
                'user_id' => $userId,
                'username' => $request->param('username'),
                'wins' => 0,
                'losses' => 0,
                'themes' => 0,
                'skins' => 0,
                'hats' => 0,
                'coins' => 0,
            };

            if ($request->param('username') ne undef) {
                unless ($usernameExists) {
                    $playerRepository->create($playerCreate);
                    $request->{tutorial} = 1;
                    print $request->redirect('https://apps.test/apps/hangman?tutorial');
                }
            };


            # Play
            my $getFolder = sub {
                return join ('/', splice(@{[split(/\//, __FILE__)]},
                0,
                scalar @{[split(/\//, __FILE__)]} -1)) . "/";
            };

            my $filenameEasy = &$getFolder . '../lists/easyWords.txt';
            open(my $fh, '<', $filenameEasy) or die $!;
            my @linesEasy = <$fh>;
            close $fh;

            my $filenameHard = &$getFolder . '../lists/hardWords.txt';
            open(my $fh, '<', $filenameHard) or die $!;
            my @linesHard = <$fh>;
            close $fh;

            my $randNumber = int(rand(50));

            my $wordEasy = @linesEasy[$randNumber];
            my $wordHard = @linesHard[$randNumber];

            $request->{wordEasy} = uc($wordEasy);
            $request->{wordHard} = uc($wordHard);

            $request->{wordLengthEasy} = (length($wordEasy) - 1);
            $request->{wordLengthHard} = (length($wordHard) - 1);


            # Shop/Inventory
            my $isItemOwned = 0;
            my $itemId = undef;
            my $itemName = '';
            my $itemPrice = 0;
            my $itemType = '';
            my $currentItem = 0;
            my $itemRepository;
            my $itemRepositoryTest = 0;
            my $itemsPlayerCreate = {
                'user_id' => $userId,
                'hat_id' => 0,
            };
            my $shopType;

            my @cgiParam = $request->param();


            # Skins -> Shop/Inventory
            my $allSkins = $skinsRepository->selectSkins();
            foreach my $skin (@$allSkins) {
                if (@$skin[0] eq $cgiParam[0]) {
                    $itemType = 'current_skin_id';
                    $shopType = 'skins';
                    $currentItem = $skins;
                    $itemRepository = $playerSkinsRepository;
                    $itemId = $skinsRepository->findByName(@$skin[0], 'getId');
                    $itemName = $skinsRepository->findByName(@$skin[0], 'getName');
                    $itemPrice = $skinsRepository->findByName(@$skin[0], 'getPrice');
                    $isItemOwned = $playerSkinsRepository->findByUserId($userId, $itemId, 'getSkinId');
                    if ($itemId eq 0) {
                        $isItemOwned = 0;
                    }
                    $itemsPlayerCreate = {
                        'user_id' => $userId,
                        'skin_id' => $itemId,
                    };
                }
            }


            # Themes -> Shop/Inventory
            my $allThemes = $themesRepository->selectThemes();
            foreach my $theme (@$allThemes) {
                if (@$theme[0] eq $cgiParam[0]) {
                    $itemType = 'current_theme_id';
                    $shopType = 'themes';
                    $currentItem = $themes;
                    $itemRepository = $playerThemesRepository;
                    $itemId = $themesRepository->findByName(@$theme[0], 'getId');
                    $itemName = $themesRepository->findByName(@$theme[0], 'getName');
                    $itemPrice = $themesRepository->findByName(@$theme[0], 'getPrice');
                    $isItemOwned = $playerThemesRepository->findByUserId($userId, $itemId, 'getThemeId');
                    if ($itemId eq 0) {
                        $isItemOwned = 0;
                    }
                    $itemsPlayerCreate = {
                        'user_id' => $userId,
                        'theme_id' => $itemId,
                    };
                }
            }


            # Hats -> Shop/Inventory
            my $allHats = $hatsRepository->selectHats();
            foreach my $hat (@$allHats) {
                if (@$hat[0] eq $cgiParam[0]) {
                    $itemType = 'current_hat_id';
                    $shopType = 'hats';
                    $currentItem = $hats;
                    $itemRepository = $hatsPlayerRepository;
                    $itemId = $hatsRepository->findByName(@$hat[0], 'getId');
                    $itemName = $hatsRepository->findByName(@$hat[0], 'getName');
                    $itemPrice = $hatsRepository->findByName(@$hat[0], 'getPrice');
                    $isItemOwned = $hatsPlayerRepository->findByUserId($userId, $itemId, 'getHatId');
                    if ($itemId eq 0) {
                        $isItemOwned = 0;
                    }
                    $itemsPlayerCreate = {
                        'user_id' => $userId,
                        'hat_id' => $itemId,
                    };
                }
            }


            # inventory
            if ($isItemOwned eq $itemId && $request->param($itemName) eq 1) {
                if ($currentItem ne $itemId) {
                    $player->{$itemType} = $itemId;
                    $playerRepository->create($player);
                    print($request->redirect(
                        -url => "/apps/hangman/inventory/$shopType"
                    ));
                }
                else {
                    $request->{alreadyEquipped} = 1;
                }
            }


            # shop
            if ($isItemOwned ne $itemId && $request->param($itemName) eq $itemPrice) {
                if ($coins >= $itemPrice) {
                    $itemRepository->create($itemsPlayerCreate);
                    $player->{'coins'} = $coins - $itemPrice;
                    $playerRepository->create($player);
                    print($request->redirect(
                        -url => "/apps/hangman/shop/$shopType"
                    ));
                }
                else {
                    $request->{notEnoughCoins} = 1;
                }
            }


            # Finish Game
            if ($request->param('wonEasy')) {
                $player->{'wins'} = $request->{wins} + 1;
                $player->{'coins'} = $request->{coins} + 1;
                $playerRepository->create($player);
            }

            if ($request->param('wonHard')) {
                $player->{'wins'} = $request->{wins} + 1;
                $player->{'coins'} = $request->{coins} + 2;
                $playerRepository->create($player);
            }

            if ($request->param('lost')) {
                $player->{'losses'} = $request->{losses} + 1;
                $playerRepository->create($player);
            }


            # Check If first visit
            $request->{IfFirstVisit} = sub {
                unless ($username) { 
                    print $request->redirect('https://apps.test/apps/hangman');
                }
    	    };


            # Find theme URL
            if ($themes eq '0') {
                $request->{themeURL} = 'https://i.ibb.co/b2S24W7/Western2-resized-Standard.jpg';
            };

            if ($themes eq 1) {
                $request->{themeURL} = 'https://i.ibb.co/j8mCLqp/Revolution-resized-Guillotine.jpg';
            };

            if ($themes eq 2) {
                $request->{themeURL} = 'https://i.ibb.co/LRmy2gX/Pirate-Theme-night.png';
            };

            if ($themes eq 3) {
                $request->{themeURL} = 'https://i.ibb.co/FqY7X5B/Pot-Boiling.jpg';
            };

            if ($themes eq 4) {
                $request->{themeURL} = 'https://i.ibb.co/RbLnvxd/Fire-Burning.jpg';
            };

            if ($themes eq 5) {
                $request->{themeURL} = 'https://i.ibb.co/JpZvYYz/train-train.jpg';
            };

            if ($themes eq 6) {
                $request->{themeURL} = 'https://i.ibb.co/ZGzJr74/Gladiator-Colloseum.jpg';
            };


            # Create Leaderboard
            $request->{leaderboard} = sub {
                my $count = $playerRepository->count();

                $count = $count->{count};

                if ($count > 3) {
                    $count = 3;
                };

                my $userFirst = undef;

                my $winsFirst = undef;

                my $lossesFirst = undef;

                my $userSecond = undef;

                my $userThird = undef;

                if ($count > 0) {
                    $userFirst = @$highscores[0]->[0];
                }

                if ($count > 1) {
                    $userSecond = @$highscores[1]->[0];
                }

                if ($count > 2) {
                    $userThird = @$highscores[2]->[0];
                }

                $request->{count} = $count;

                $request->{userFirst} = $userFirst;

                $request->{userSecond} = $userSecond;

                $request->{userThird} = $userThird;

                # first
                $request->{winsFirst} = $playerRepository->findByUsername($userFirst, 'getWins');

                $request->{lossesFirst} = $playerRepository->findByUsername($userFirst, 'getLosses');

                my $firstUserId = $playerRepository->findByUsername($userFirst, 'getUserId');
                my $totalSkinsFirst = $playerSkinsRepository->total($firstUserId);
                my $skinsCollectionFirst = @$totalSkinsFirst;
                $request->{skinsFirst} = $skinsCollectionFirst;

                my $firstUserId = $playerRepository->findByUsername($userFirst, 'getUserId');
                my $totalHatsFirst = $hatsPlayerRepository->total($firstUserId);
                my $hatsCollectionFirst = @$totalHatsFirst;
                $request->{hatsFirst} = $hatsCollectionFirst;

                my $firstUserId = $playerRepository->findByUsername($userFirst, 'getUserId');
                my $totalThemesFirst = $playerThemesRepository->total($firstUserId);
                my $themesCollectionFirst = @$totalThemesFirst;
                $request->{themesFirst} = $themesCollectionFirst;

                # second
                $request->{winsSecond} = $playerRepository->findByUsername($userSecond, 'getWins');

                $request->{lossesSecond} = $playerRepository->findByUsername($userSecond, 'getLosses');

                my $secondUserId = $playerRepository->findByUsername($userSecond, 'getUserId');
                my $totalSkinsSecond = $playerSkinsRepository->total($secondUserId);
                my $skinsCollectionSecond = @$totalSkinsSecond;
                $request->{skinsSecond} = $skinsCollectionSecond;

                my $secondUserId = $playerRepository->findByUsername($userSecond, 'getUserId');
                my $totalHatsSecond = $hatsPlayerRepository->total($secondUserId);
                my $hatsCollectionSecond = @$totalHatsSecond;
                $request->{hatsSecond} = $hatsCollectionSecond;

                my $secondUserId = $playerRepository->findByUsername($userSecond, 'getUserId');
                my $totalThemesSecond = $playerThemesRepository->total($secondUserId);
                my $themesCollectionSecond = @$totalThemesSecond;
                $request->{themesSecond} = $themesCollectionSecond;

                # third
                $request->{winsThird} = $playerRepository->findByUsername($userThird, 'getWins');

                $request->{lossesThird} = $playerRepository->findByUsername($userThird, 'getLosses');

                my $thirdUserId = $playerRepository->findByUsername($userThird, 'getUserId');
                my $totalSkinsThird = $playerSkinsRepository->total($thirdUserId);
                my $skinsCollectionThird = @$totalSkinsThird;
                $request->{skinsThird} = $skinsCollectionThird;

                my $thirdUserId = $playerRepository->findByUsername($userThird, 'getUserId');
                my $totalHatsThird = $hatsPlayerRepository->total($thirdUserId);
                my $hatsCollectionThird = @$totalHatsThird;
                $request->{hatsThird} = $hatsCollectionThird;

                my $thirdUserId = $playerRepository->findByUsername($userThird, 'getUserId');
                my $totalThemesThird = $playerThemesRepository->total($thirdUserId);
                my $themesCollectionThird = @$totalThemesThird;
                $request->{themesThird} = $themesCollectionThird;
            };

            return &$next($request);
        },

    ],

}, sub {

    # Routes within this scope require the visitor to be signed in.

    Http::Route::group({

        # The prefix of the http route.
        prefix => '/apps/hangman',

        # The prefix of the route name.
        as => 'apps.hangman.',

    }, sub {

        Http::Route::group({

            # The prefix of the http route.
            prefix => '/shop',

            # The prefix of the route name.
            as => 'shop.',

        }, sub {

            Http::Route::get('/skins', sub {

                my $request = shift;

                # TODO: Implement default controller routing instead of creating
                # TODO: an instance of the controller class.

                return Hangman::Http::Controllers::Controller->new()->shopSkins(
                    $request,
                );

            }),

            Http::Route::post('/skins', sub {

                my $request = shift;

                # TODO: Implement default controller routing instead of creating
                # TODO: an instance of the controller class.

                return Hangman::Http::Controllers::Controller->new()->shopSkinsBought(
                    $request,
                );

            }),

            Http::Route::get('/hats', sub {

                my $request = shift;

                # TODO: Implement default controller routing instead of creating
                # TODO: an instance of the controller class.

                return Hangman::Http::Controllers::Controller->new()->shopHats(
                    $request,
                );

            }),

            Http::Route::post('/hats', sub {

                my $request = shift;

                # TODO: Implement default controller routing instead of creating
                # TODO: an instance of the controller class.

                return Hangman::Http::Controllers::Controller->new()->shopHatsBought(
                    $request,
                );

            }),

            Http::Route::get('/themes', sub {

                my $request = shift;

                # TODO: Implement default controller routing instead of creating
                # TODO: an instance of the controller class.

                return Hangman::Http::Controllers::Controller->new()->shopThemes(
                    $request,
                );

            }),

            Http::Route::post('/themes', sub {

                my $request = shift;

                # TODO: Implement default controller routing instead of creating
                # TODO: an instance of the controller class.

                return Hangman::Http::Controllers::Controller->new()->shopThemesBought(
                    $request,
                );

            }),

        });

        Http::Route::group({

            # The prefix of the http route.
            prefix => '/inventory',

            # The prefix of the route name.
            as => 'inventory.',

        }, sub {

            Http::Route::get('/skins', sub {

                my $request = shift;

                # TODO: Implement default controller routing instead of creating
                # TODO: an instance of the controller class.

                return Hangman::Http::Controllers::Controller->new()->inventorySkins(
                    $request,
                );

            }),

            Http::Route::post('/skins', sub {

                my $request = shift;

                # TODO: Implement default controller routing instead of creating
                # TODO: an instance of the controller class.

                return Hangman::Http::Controllers::Controller->new()->inventorySkinsEquipped(
                    $request,
                );

            }),

            Http::Route::get('/hats', sub {

                my $request = shift;

                # TODO: Implement default controller routing instead of creating
                # TODO: an instance of the controller class.

                return Hangman::Http::Controllers::Controller->new()->inventoryHats(
                    $request,
                );

            }),

            Http::Route::post('/hats', sub {

                my $request = shift;

                # TODO: Implement default controller routing instead of creating
                # TODO: an instance of the controller class.

                return Hangman::Http::Controllers::Controller->new()->inventoryHatsEquipped(
                    $request,
                );

            }),

            Http::Route::get('/themes', sub {

                my $request = shift;

                # TODO: Implement default controller routing instead of creating
                # TODO: an instance of the controller class.

                return Hangman::Http::Controllers::Controller->new()->inventoryThemes(
                    $request,
                );

            }),

            Http::Route::post('/themes', sub {

                my $request = shift;

                # TODO: Implement default controller routing instead of creating
                # TODO: an instance of the controller class.

                return Hangman::Http::Controllers::Controller->new()->inventoryThemesEquipped(
                    $request,
                );

            }),

        });

        Http::Route::group({

            # The prefix of the http route.
            prefix => '/play',

            # The prefix of the route name.
            as => 'play.',

        }, sub {

            Http::Route::get('/easy', sub {

                my $request = shift;

                # TODO: Implement default controller routing instead of creating
                # TODO: an instance of the controller class.

                return Hangman::Http::Controllers::Controller->new()->playEasy(
                    $request,
                );

            }),

            Http::Route::post('/easy', sub {

                my $request = shift;

                # TODO: Implement default controller routing instead of creating
                # TODO: an instance of the controller class.

                return Hangman::Http::Controllers::Controller->new()->playEasyPost(
                    $request,
                );

            }),

            Http::Route::get('/hard', sub {

                my $request = shift;

                # TODO: Implement default controller routing instead of creating
                # TODO: an instance of the controller class.

                return Hangman::Http::Controllers::Controller->new()->playHard(
                    $request,
                );

            }),

            Http::Route::post('/hard', sub {

                my $request = shift;

                # TODO: Implement default controller routing instead of creating
                # TODO: an instance of the controller class.

                return Hangman::Http::Controllers::Controller->new()->playHardPost(
                    $request,
                );

            }),

        });
        
        Http::Route::get('/', sub {

            my $request = shift;

            # TODO: Implement default controller routing instead of creating
            # TODO: an instance of the controller class.

            return Hangman::Http::Controllers::Controller->new()->welcome(
                $request,
            );

        }),

        Http::Route::post('/', sub {

            my $request = shift;

            # TODO: Implement default controller routing instead of creating
            # TODO: an instance of the controller class.

            return Hangman::Http::Controllers::Controller->new()->welcome(
                $request,
            );

        }),

        Http::Route::get('/play', sub {

            my $request = shift;

            # TODO: Implement default controller routing instead of creating
            # TODO: an instance of the controller class.

            return Hangman::Http::Controllers::Controller->new()->play(
                $request,
            );

        }),

        Http::Route::post('/play', sub {

            my $request = shift;

            # TODO: Implement default controller routing instead of creating
            # TODO: an instance of the controller class.

            return Hangman::Http::Controllers::Controller->new()->playPost(
                $request,
            );

        }),

        Http::Route::get('/inventory', sub {

            my $request = shift;

            # TODO: Implement default controller routing instead of creating
            # TODO: an instance of the controller class.

            return Hangman::Http::Controllers::Controller->new()->inventory(
                $request,
            );

        }),

        Http::Route::get('/shop', sub {

            my $request = shift;

            # TODO: Implement default controller routing instead of creating
            # TODO: an instance of the controller class.

            return Hangman::Http::Controllers::Controller->new()->shop(
                $request,
            );

        }),

        Http::Route::get('/profile', sub {

            my $request = shift;

            # TODO: Implement default controller routing instead of creating
            # TODO: an instance of the controller class.

            return Hangman::Http::Controllers::Controller->new()->profile(
                $request,
            );

        }),

        Http::Route::get('/messages/{id}', sub {

            my $request = shift;

            return Hangman::Http::Controllers::Controller->new()->showMessage(
                $request,
            );

        }),

        Http::Route::group({

            # The prefix of the http route.
            prefix => '/admin',

            # The prefix of the route name.
            as => 'admin.',

            middlewares => [

                sub {
                    my $request = shift;
                    my $next = shift;
                    
                    unless (user()->isHangmanAdmin()) {
                        abort('Unauthorized.', 403);
                    }

                    return &$next($request); 
                },

            ],

        }, sub {
            
            Http::Route::get('/', sub {

                my $request = shift;

                return Hangman::Http::Controllers::Controller->new()->dashboard(
                    $request,
                );

            }),

        });

    });

});
