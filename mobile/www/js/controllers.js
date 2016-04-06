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

.controller('RegisterCtrl', function($scope, RegisterSession, $location, $ionicPopup, $rootScope){
  $scope.data = {};

  $scope.register = function(){
    console.log($scope.data)
    var user_user = new RegisterSession({user: $scope.data});
    user_user.$save(
      function(data){
        $location.path('login');
      },

      function(err) {
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

.controller('panicButtonCtrl', function($scope, $ionicPopup, $state, Events){
  $scope.panic = function(){
    event = new Events({title: window.localStorage.userName + " could use some help!"})
    event.$create();
    $ionicPopup.alert({
      title: "Your network has been alerted!",
      template: "In the meantime, please checkout the following resources"
    });
    $state.go('tab.dash')
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
    name: "Journal",
    url: "http://localhost:8100/#/tab/resources/journal"
  }];

  
})
.controller('eventsPopoverCtrl', function($state, $http, $scope, $ionicPopover){
  $ionicPopover.fromTemplateUrl('templates/notifications.html', {
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
  
  $scope.$on('popover.hidden', function() {
    // Execute action on hide popover
  });
  // Execute action on remove popover
  $scope.$on('popover.removed', function() {
    // Execute action
  });
})

.controller('userEventsCtrl', function($scope, userAlerts){
  userAlerts.query().$promise.then(function(response){
    $scope.events = response
  })
})

.controller('friendsCtrl', function($scope, friends, $http, $state){
  friends.query({user_id: window.localStorage.userId}).$promise.then(function(response){
    $scope.friends = response;
    console.log($scope.friends);
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

.controller('friendChatCtrl', function($scope, friends, Chats, Messages, $http, $state, $stateParams, $interval, $timeout, $ionicScrollDelegate){
  friends.get({id: $stateParams.id}).$promise.then(function(response){
    $scope.friendship = response.friendable;
    console.log($scope.friendship);
    

    if($scope.friendship.chat_messages) {
      $scope.messages = $scope.friendship.chat_messages;
    } else {
      $scope.messages = [];
    }
    console.log($scope.messages);
  });

  $scope.userId = window.localStorage.userId

  $scope.hideTime = true;

  var alternate,
    isIOS = ionic.Platform.isWebView() && ionic.Platform.isIOS();

/*
  var scrollHax = function(){
    var element = document.getElementById("rawr2");
    element.scrollTop = element.scrollHeight;
  }

  */

  $scope.sendMessage = function() {

    var d = new Date();
    d = d.toLocaleTimeString().replace(/:\d+ /, ' ');

    $scope.messages.push({
      user_id: $scope.userId,
      content: $scope.data.message,
      time: d
    });

    if($scope.friendship.chat_id != 'nil') {
      Messages.create({chat_id: $scope.friendship.chat_id, content: $scope.data.message});
    } else {
      var content = $scope.data.message
      console.log(content);
      Chats.create({friendable_id: $scope.friendship.id}).$promise.then(function(response) {
        console.log(response.chat.id);
        console.log($scope.data.message);
        Messages.create({chat_id: response.chat.id, content: content});
      })
      //scrollHax();
    }

    delete $scope.data.message;
    $ionicScrollDelegate.scrollBottom(true);

  };


  $scope.inputUp = function() {
    if (isIOS) $scope.data.keyboardHeight = 216;
    $timeout(function() {
      $ionicScrollDelegate.scrollBottom(true);
    }, 300);

  };

  $scope.inputDown = function() {
    if (isIOS) $scope.data.keyboardHeight = 0;
    $ionicScrollDelegate.resize();
  };

  $scope.closeKeyboard = function() {
    // cordova.plugins.Keyboard.close();
  };


  $scope.data = {};
  $scope.myId = '12345';
  $scope.messages = [];




  var refreshData = function() {
    // Assign to scope within callback to avoid data flickering on screen
    friends.get({id: $stateParams.id}).$promise.then(function(response){
      $scope.messages = response.friendable.chat_messages;
      // console.log('tick');
    })
  };

  // Cancel interval on page changes
  $scope.$on('$locationChangeStart', function(){
    console.log("sould cancel");
    $interval.cancel(promise);
  });

  var promise = $interval(refreshData, 10000);

})

.controller('goalListCtrl', function($scope, Goals, $http, $state, Events){
  Goals.query().$promise.then(function(response){
    $scope.goals = response.goals 
  })

  $scope.goalData = {title: $scope.title,
                        description: $scope.description,
                        date: $scope.date
                        };

    $scope.addGoal = function() {
      var goal = new Goals($scope.goalData);
      goal.$create().then(function(response){
        console.log(response.goal.id)
        $state.go('tab.new-objective', {id: response.goal.id})
      })            

      var event = new Events({title: "Created a new goal!"});
      event.$create()

      $scope.goalData.title = '';
      $scope.goalData.description = '';
    };  
})

.controller('newObjectiveCtrl', function($scope, Goals, Objectives, SuggestedObjectives, $state, $stateParams){
  SuggestedObjectives.query().$promise.then(function(response) {
    $scope.suggested_objectives = response;
  })
  $scope.objective = new Objectives();
  $scope.objective.recurring = 'daily';
  $scope.objectiveList = [];
  
  $scope.addObjective = function() {
    $scope.objective.$save({goal_id: $stateParams.id}).then(function(response){
      $scope.objectiveList.push($scope.objective);
      console.log($scope.objectiveList)
    })
    
  }
})

.controller('goalShowCtrl', function($scope, Goals, $http, $stateParams, Events){
  Goals.get({id: $stateParams.id}).$promise.then(function(response){
    $scope.goal = response 
    
  })
})

.controller('objectivesCtrl', function($scope, Objectives, $stateParams){
  Objectives.query({goal_id: $stateParams.id}).$promise.then(function(response){
    $scope.objectives = response; 
    console.log(response)   
  })
})

.controller('occurrencesCtrl', function($scope, Occurrences, occurrenceComplete, $ionicPopup){
  Occurrences.query().$promise.then(function(response){
    $scope.occurrences = response;
  })

  $scope.delete = function (index) {
    $scope.occurrences.splice(index, 1);
}

  $scope.markComplete = function(occurrence) {
    occurrenceComplete.put({id: occurrence.id}).$promise.then(function(response){
      
    })
    $ionicPopup.alert({title: "Great Job!"})
  }
})

.controller('DashCtrl', function($scope, $http, $state) {
  //variable we pass in - we need to add attribute to user backend and use a service to grab and store it
  var soberDate = '1/1/2010';

  //when the view loads, this fires and unfucks itself
  $scope.$on('$ionicView.loaded', function(){
    upTime(soberDate)
  })


  //hell yeah ghetto function
  function upTime(soberDate) {
    now = new Date();
    countTo = new Date(soberDate);
    difference = (now - countTo);

    days = Math.floor(difference / (60 * 60 * 1000 * 24) * 1);
    hours = Math.floor((difference % (60 * 60 * 1000 * 24)) / (60 * 60 * 1000) * 1);
    mins=Math.floor(((difference%(60*60*1000*24))%(60*60*1000))/(60*1000)*1);
    secs=Math.floor((((difference%(60*60*1000*24))%(60*60*1000))%(60*1000))/1000*1);

    document.getElementById('days').firstChild.nodeValue = days;
    document.getElementById('hours').firstChild.nodeValue = hours;
    document.getElementById('minutes').firstChild.nodeValue = mins;
    document.getElementById('seconds').firstChild.nodeValue = secs;

    clearTimeout(upTime.to);
    upTime.to = setTimeout(function(){upTime(countTo); }, 1000);
  }



})

.controller('objectivePopoverCtrl', function($state, $http, $scope, $ionicPopover){
  $ionicPopover.fromTemplateUrl('templates/objective-popover.html', {
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

.controller('checkinController', function($scope, checkIn, $http, $state, $ionicPopup, Events){
    $scope.checkinData = {
      use: $scope.sober,
      mood: $scope.mood,
      remarks: $scope.remarks,
      need_support: $scope.need_support
  };

  $scope.newCheckin = function() {
    var checkin = new checkIn($scope.checkinData);
    checkin.$create();
    var event = new Events({title: window.localStorage.userName + " Checked in!"})
    event.$create();
    $ionicPopup.alert({title:"Thanks for checking in!"});
    $state.go('tab.dash');

  };
})

.controller('checkinListController', function($scope, checkIn, $http, $state, $ionicModal){
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

.controller('aboutMeCtrl', function($scope, friend){
  friend.get({id: window.localStorage.userId}).$promise.then(function(response){
    $scope.soberDate = response.sober_date;
    console.log($scope.soberDate)
  })
})

.controller('groupsCtrl', function($scope, Groups, groupInvites, $http){
  Groups.get().$promise.then(function(response){
    $scope.groups = response.groups
  })

  $scope.group = new Groups();
  $scope.newGroup = function(){
    $scope.group.$save().then(function(response){
      console.log(response)
    });
    $scope.groups.push({name: $scope.group.name, description: $scope.group.description});
    console.log($scope.group);
    console.log($scope.groups);
  }

  groupInvites.get({id: window.localStorage.userId}).$promise.then(function(response){
    $scope.invites = response.groups;
    console.log(response.groups)
  });

   $scope.acceptRequest = function(id){
    $http.put('http://localhost:3000/api/v1/groupable/'+ id +'/accept')
  };

  $scope.rejectRequest = function(id){
    $http.put('http://localhost:3000/api/v1/groupable/'+ id +'/ignore')
  };
})

.controller('invitesModalCtrl', function($scope, $ionicModal){
  $ionicModal.fromTemplateUrl('/templates/invites-modal.html', function($ionicModal) {
        $scope.modal = $ionicModal;
    }, {
        // Use our scope for the scope of the modal to keep it simple
        scope: $scope,
        // The animation we want to use for the modal entrance
        animation: 'slide-in-up'
    });  
})

.controller('groupCtrl', function($scope, $stateParams, $timeout, $interval, $ionicScrollDelegate, Groups, Messages, Chats){
  Groups.get({id: $stateParams.id}).$promise.then(function(response){
    $scope.group = response.group
    
    if($scope.group.chat_messages) {
      $scope.messages = $scope.group.chat_messages;
    } else {
      $scope.messages = [];
    }
  })

  $scope.userId = window.localStorage.userId

  $scope.hideTime = true;

  var alternate,
    isIOS = ionic.Platform.isWebView() && ionic.Platform.isIOS();

/*
  var scrollHax = function(){
    var element = document.getElementById("rawr2");
    element.scrollTop = element.scrollHeight;
  }

  */

  

  $scope.sendMessage = function() {

    var d = new Date();
    d = d.toLocaleTimeString().replace(/:\d+ /, ' ');

    $scope.messages.push({
      user_id: $scope.userId,
      content: $scope.data.message,
      time: d
    });

    if($scope.messages[0].chat_id) {
      Messages.create({chat_id: $scope.messages[0].chat_id, content: $scope.data.message});
    } else {
      var content = $scope.data.message
      console.log(content);
      Chats.create({group_id: $scope.group.id}).$promise.then(function(response) {
        console.log(response.chat.id);
        console.log($scope.data.message);
        Messages.create({chat_id: response.chat.id, content: content});
      })
      //scrollHax();
    }

    delete $scope.data.message;
    $ionicScrollDelegate.scrollBottom(true);

  };


  $scope.inputUp = function() {
    if (isIOS) $scope.data.keyboardHeight = 216;
    $timeout(function() {
      $ionicScrollDelegate.scrollBottom(true);
    }, 300);

  };

  $scope.inputDown = function() {
    if (isIOS) $scope.data.keyboardHeight = 0;
    $ionicScrollDelegate.resize();
  };

  $scope.closeKeyboard = function() {
    // cordova.plugins.Keyboard.close();
  };


  $scope.data = {};
  $scope.myId = '12345';
  $scope.messages = [];




  var refreshData = function() {
    // Assign to scope within callback to avoid data flickering on screen
    Groups.get({id: $stateParams.id}).$promise.then(function(response){
      $scope.messages = response.group.chat_messages;
      // console.log('tick');
    })
  };

  // Cancel interval on page changes
  $scope.$on('$locationChangeStart', function(){
    console.log("sould cancel");
    $interval.cancel(promise);
  });

  var promise = $interval(refreshData, 10000);

})

.controller('BoardCtrl', function($scope, $state, Board, $ionicPopup, upVote, $stateParams, downVote) {
  Board.query().$promise.then(function(response) {
    $scope.boards = response;  
  });


  $scope.topic = new Board();

  $scope.newTopic = function(){
    $scope.topic.$save();
    $scope.boards.push($scope.topic);
    $scope.$apply();
    $ionicPopup.alert({title: "Thanks! Your post is live"})
  } 

  $scope.upVote = function(board_id){
    upVote.post({board_id: board_id}).$promise.then(function(response){
      console.log(response)
    })
  }

  $scope.addPoint = function(board){
    board.points += 1;
  }

  $scope.removePoint = function(board){
    board.points -=1;
  }

  $scope.downVote = function(board_id){
    downVote.post({board_id: board_id}).$promise.then(function(repsonse){
    })
  }
})

.controller('boardModalCtrl', function($scope, $ionicModal){
  $ionicModal.fromTemplateUrl('/templates/new-board.html', function($ionicModal) {
        $scope.modal = $ionicModal;
    }, {
        // Use our scope for the scope of the modal to keep it simple
        scope: $scope,
        // The animation we want to use for the modal entrance
        animation: 'slide-in-up'
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

.controller('JournalCtrl', function($scope, $http, $timeout){


  $scope.autoExpand = function(e) {
        var element = typeof e === 'object' ? e.target : document.getElementById(e);
        var scrollHeight = element.scrollHeight -20; // replace 60 by the sum of padding-top and padding-bottom
        element.style.height =  scrollHeight + "px";    
    };
  
  function expand() {
    $scope.autoExpand('TextArea');
  }
})

.controller('PostCtrl', function($scope, $stateParams, Board, Post, $stateParams) {
  Board.get({id: $stateParams.id}).$promise.then(function(response) {
    $scope.board = response;
    $scope.posts = response.posts
    console.log($scope.board)
  });


  $scope.post = new Post({board_id: $stateParams.id, user_id: window.localStorage.userId});

  $scope.newPost = function(){
    $scope.post.$save();
    $scope.posts.push({title: $scope.post.title, content: $scope.post.content, username: window.localStorage.userName});
    console.log($scope.post);
    console.log($scope.posts);
  };
})

/*
.controller('Messages', function($scope, $timeout, $ionicScrollDelegate, Chats) {

  $scope.hideTime = true;

  var alternate,
    isIOS = ionic.Platform.isWebView() && ionic.Platform.isIOS();

  $scope.sendMessage = function() {
    alternate = !alternate;

    var d = new Date();
  d = d.toLocaleTimeString().replace(/:\d+ /, ' ');

    $scope.messages.push({
      userId: alternate ? '12345' : '54321',
      text: $scope.data.message,
      time: d
    });

    delete $scope.data.message;
    $ionicScrollDelegate.scrollBottom(true);

  };


  $scope.inputUp = function() {
    if (isIOS) $scope.data.keyboardHeight = 216;
    $timeout(function() {
      $ionicScrollDelegate.scrollBottom(true);
    }, 300);

  };

  $scope.inputDown = function() {
    if (isIOS) $scope.data.keyboardHeight = 0;
    $ionicScrollDelegate.resize();
  };

  $scope.closeKeyboard = function() {
    // cordova.plugins.Keyboard.close();
  };


  $scope.data = {};
  $scope.myId = '12345';
  $scope.messages = [];

}); */
