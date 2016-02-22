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
      }
      );
  }
})

.controller('friendRequestsCtrl', function($scope, $ionicPopup, friendRequests, $http, $state, $stateParams, $resource, friendRequestAccept){
  friendRequests.query().$promise.then(function(response){
    
    $scope.requests = response
    
    
  });

  $scope.acceptFriendRequest = function() {
    friendRequestAccept.put({id: $stateParams.id})
    $ionicPopup.alert({
      title: "Thanks!",
      template: "You now have a new friend!"
    })
    $state.go('tab.chats')
  }
  friendRequests.query({id: $stateParams.id}).$promise.then(function(response){
    
    
    $scope.friendRequest = response[0];
    

     

    console.log($scope.friendRequest)
  });


})



.controller('friendsCtrl', function($scope, friends, $http, $state){
  friends.query().$promise.then(function(response){
    $scope.friends = response
    
  });
})

.controller('friendCtrl', function($scope, friend, userCheckins, $http, $state, $stateParams){
  friend.get({id: $stateParams.id}).$promise.then(function(response){
    $scope.friend = response

  })

  userCheckins.query({id: $stateParams.id}).$promise.then(function(response){
    
    $scope.checkin = response[0];
  })
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
  checkIn.query().$promise.then(function(response){
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

.controller('PostCtrl', function($scope, $stateParams, Board) {
  Board.get({id: $stateParams.id}).$promise.then(function(response) {
    $scope.board = response.board;
    $scope.posts = response.board.posts
  })
});
