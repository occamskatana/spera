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

.controller('LoginCtrl', function($scope, $location, UserSession, $ionicPopup, $rootScope) {
  $scope.data = {};

  $scope.login = function(){
    var user_session = new UserSession({user: $scope.data});
    user_session.$save(
      function(data){
        console.log(data);
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



.controller('DashCtrl', function($scope, Goals, $http) {

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
    };   
})

.controller('checkinController', function($scope, checkIn, $http, $state){
    $scope.checkinData = {
      use: $scope.use,
      mood: $scope.mood,
      remarks: $scope.remarks,
      need_support: $scope.need_support
  };

  $scope.newCheckin = function() {
    var checkin = new checkIn($scope.checkinData);
    checkin.$create();
    alert("Thanks for checking in!");
    $state.go('tab.dash');
  };
})

.controller('ChatDetailCtrl', function($scope, $stateParams, Chats) {
  $scope.chat = Chats.get($stateParams.chatId);
})

.controller('AccountCtrl', function($scope) {
  $scope.settings = {
    enableFriends: true
  };
});
