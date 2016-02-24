angular.module('starter.controllers', [])



.controller('ChatsCtrl', function($scope, Chats) {
  // With the new view caching in Ionic, Controllers are only called
  // when they are recreated or on app start, instead of every page change.
  // To listen for when this page is active (for example, to refresh data),
  // listen for the $ionicView.enter event:
  //
  //$scope.$on('$ionicView.enter', function(e) {
  //});

  $scope.chats = Chats.all();
  $scope.remove = function(chat) {
    Chats.remove(chat);
  };
})

.controller('LoginCtrl', function($scope, $location, UserSession, $ionicPopup, $rootScope){
  $scope.data = {};

  $scope.login = function(){
    var user_session = new UserSession({user: $scope.data});
    user_session.$save(
      function(data){
        
        window.localStorage['userId'] = data.user.id;
        window.localStorage['userName'] = data.user.username;
        $location.path('tab/dash');
      },

      function(err) {
        var error = err["data"]["error"] 
        var confirmPopup = $ionicPopup.alert({
          title: 'An error occured. Please try again',
          template: 'error'
        });
      });     
  }
})

.controller('modalCtrl', function($scope, $ionicModal){
  $ionicModal.fromTemplateUrl('/templates/friend-request-modal.html', function($ionicModal) {
        $scope.modal = $ionicModal;
    }, {
        // Use our scope for the scope of the modal to keep it simple
        scope: $scope,
        // The animation we want to use for the modal entrance
        animation: 'slide-in-up'
    });  
})

.controller('friendRequestsCtrl', function($scope, $ionicPopup, $ionicModal, friendRequests, $http, $state, $stateParams, $resource, friendRequestAccept, friendRequestReject){

  $scope.getData = function() {
    friendRequests.query().$promise.then(function(response){    
      $scope.requests = response;
      $scope.friendRequestCount = response.length;
      
    })
  }
   $scope.getData();


  $scope.Accept = function() {
    friendRequestAccept.put({id: $stateParams.id})
    $ionicPopup.alert({
      title: "Thanks!",
      template: "You now have a new friend!"
    })
    $state.go('tab.chats')
  
  }

  $scope.Reject = function() {
    friendRequestReject.delete({id: $stateParams.id})
    $ionicPopup.alert({
      title: "Friend Request Rejected",
      template: "de NIED"
    })
    $state.go('tab.chats')
  }
})



.controller('userShow', function($scope, $ionicPopup, friend, $state, $http, $stateParams, newFriendRequest){
  friend.get({id: $stateParams.id}).$promise.then(function(response){
    $scope.user = response;
  })

  $scope.newFriend = function(){
    newFriendRequest.put({id: $stateParams.id})
    $ionicPopup.alert({
      title: "You have sent this user a friend request ",
      body: "They should be back to you shortly!"
    })
    $state.go('tab.dash');
  }

})


.controller('friendSearchCtrl', function($scope, $http, $state, friendSearch, friendSearchResults, $ionicPopup){
   $scope.Search = function() {
      $scope.users = null
      searchParams = $scope.searchParams

      friendSearch.query({search: searchParams }).$promise.then(function(response){
        $scope.users = response      
    });
  }
})

.controller('ResourcesCtrl', function($scope, $http, $state){ 
  $scope.resources = [{
    name: "Boards",
    url: "http://localhost:8100/#/tab/resources/boards"
  }, {
    name: "Meetings",
    url: "http://localhost:8100/#/tab/resources/meetings"
  }, {
    name: "Find Alumni"
  }, {
    name: "Education"
  }, {
    name: "Jobs and Volunteering"
  }, {
    name: "Journal"
  }];

  
})



.controller('friendsCtrl', function($scope, friends, $http, $state){
  friends.query({user_id: window.localStorage.userId}).$promise.then(function(response){
    $scope.friends = response
    console.log($scope.friends)
  });
})

.controller('friendCtrl', function($scope, friend, userCheckins, $http, $state, $stateParams){
  friend.get({id: $stateParams.id}).$promise.then(function(response){
    $scope.friend = response
    $scope.lastCheckin = response.last_checkin
  })

  // userCheckins.query({user_id: $stateParams.id}).$promise.then(function(response){
  //   $scope.checkin = response[0];
  // })
})

.controller('DashCtrl', function($scope, Goals, $http, $state) {

   $scope.loadData = function() { 
      Goals.query().$promise.then(function(response) {
        $scope.goals = response.goals
        $scope.userName = localStorage['userName'] 
        });
    }

    $scope.loadData();

     $scope.goalData = {title: $scope.title,
                        description: $scope.description,
                        date: $scope.date
                        };

    $scope.addGoal = function() {
      var goal = new Goals($scope.goalData);
      goal.$create().then($scope.loadData());

      $scope.goalData.title = '';
      $scope.goalData.description = '';
      $state.go('tab.dash');
    };   
})

.controller('goalPopoverCtrl', function($state, objective, $http, $scope, $ionicPopover){
  $ionicPopover.fromTemplateUrl('templates/goal.html', {
    scope: $scope
  }).then(function(popover) {
    $scope.popover = popover;
  });


  $scope.openPopover = function($event) {
    $scope.popover.show($event);
  };
  $scope.closePopover = function() {
    $scope.popover.hide();
  };
  //Cleanup the popover when we're done with it!
  $scope.$on('$destroy', function() {
    $scope.popover.remove();
  });
  // Execute action on hide popover
  $scope.$on('popover.hidden', function() {
    // Execute action
  });
  // Execute action on remove popover
  $scope.$on('popover.removed', function() {
    // Execute action
  });
})

.controller('goalCtrl', function($state, $stateParams, objective, $http, $scope){
  $scope.objective = objective.get({id: $stateParams.id})
})

.controller('checkinController', function($scope, checkIn, $http, $state, $ionicPopup){
    $scope.checkinData = {
      use: $scope.sober,
      mood: $scope.mood,
      remarks: $scope.remarks,
      need_support: $scope.need_support
  };

  $scope.newCheckin = function() {
    var checkin = new checkIn($scope.checkinData);
    checkin.$create();
    $ionicPopup.alert({title:"Thanks for checking in!"});
    $state.go('tab.dash');

  };
})

.controller('checkinListController', function($scope, checkIn, $http, $state){
  checkIn.query({user_id: window.localStorage.userId}).$promise.then(function(response){
    $scope.checkIns = response;
    
  });

  $scope.redirect = function() {
    $state.go('tab.checkin')
  }
})

.controller('ChatDetailCtrl', function($scope, $stateParams, Chats) {
  $scope.chat = Chats.get($stateParams.chatId);
})

.controller('AccountCtrl', function($scope) {
  $scope.settings = {
    enableFriends: true
  };
})

.controller('BoardCtrl', function($scope, $stateParams, Board) {
  Board.query().$promise.then(function(response) {
    $scope.boards = response;   
  });
})

.controller('MeetingCtrl', function($scope, $ionicLoading, $compile){
  function initialize() {
        var myLatlng = new google.maps.LatLng(43.07493,-89.381388);
        
        var mapOptions = {
          center: myLatlng,
          zoom: 16,
          mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        var map = new google.maps.Map(document.getElementById("map"),
            mapOptions);
        
        //Marker + infowindow + angularjs compiled ng-click
        var contentString = "<div><a ng-click='clickTest()'>Click me!</a></div>";
        var compiled = $compile(contentString)($scope);

        var infowindow = new google.maps.InfoWindow({
          content: compiled[0]
        });

        var marker = new google.maps.Marker({
          position: myLatlng,
          map: map,
          title: 'Uluru (Ayers Rock)'
        });

        google.maps.event.addListener(marker, 'click', function() {
          infowindow.open(map,marker);
        });

        $scope.map = map;
      }
      google.maps.event.addDomListener(window, 'load', initialize);
      
      $scope.centerOnMe = function() {
        if(!$scope.map) {
          return;
        }

        $scope.loading = $ionicLoading.show({
          content: 'Getting current location...',
          showBackdrop: false
        });

        navigator.geolocation.getCurrentPosition(function(pos) {
          $scope.map.setCenter(new google.maps.LatLng(pos.coords.latitude, pos.coords.longitude));
          $scope.loading.hide();
        }, function(error) {
          alert('Unable to get location: ' + error.message);
        });
      };
      
      $scope.clickTest = function() {
        alert('Example of infowindow with ng-click')
      };
})

.controller('PostCtrl', function($scope, $stateParams, Board) {
  Board.get({id: $stateParams.id}).$promise.then(function(response) {
    $scope.board = response.board;
    $scope.posts = response.board.posts
  })
});
