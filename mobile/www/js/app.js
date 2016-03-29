// Ionic Starter App

// angular.module is a global place for creating, registering and retrieving Angular modules
// 'starter' is the name of this angular module example (also set in a <body> attribute in index.html)
// the 2nd parameter is an array of 'requires'
// 'starter.services' is found in services.js
// 'starter.controllers' is found in controllers.js
angular.module('starter', ['ionic','ionic.service.core', 'starter.controllers', 'starter.services', 'ngResource', 'starter.directives'])

.constant('config', {
  "pubnub": {
    "publish-key": "pub-c-61756fe8-0fc3-4801-b6a9-6a07bd489103",
    "subscribe-key": "sub-c-6eabf852-e947-11e5-ab43-02ee2ddab7fe"
  }
})

.run(function($ionicPlatform) {
  $ionicPlatform.ready(function() {
    // Hide the accessory bar by default (remove this to show the accessory bar above the keyboard
    // for form inputs)
    if (window.cordova && window.cordova.plugins && window.cordova.plugins.Keyboard) {
      cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);
      cordova.plugins.Keyboard.disableScroll(true);

    }
    if (window.StatusBar) {
      // org.apache.cordova.statusbar required
      StatusBar.styleDefault();
    }
  });
})

.config(function($stateProvider, $urlRouterProvider, $httpProvider) {
  $httpProvider.defaults.withCredentials = true;
  // Ionic uses AngularUI Router which uses the concept of states
  // Learn more here: https://github.com/angular-ui/ui-router
  // Set up the various states which the app can be in.
  // Each state's controller can be found in controllers.js
  $stateProvider

  // setup an abstract state for the tabs directive
    .state('tab', {
    url: '/tab',
    abstract: true,
    templateUrl: 'templates/tabs.html'
  })

  // Each tab has its own nav history stack:

  

  .state('tab.dash', {
    cache: false,
    url: '/dash',
    views: {
      'tab-dash': {
        templateUrl: 'templates/tab-dash.html',
        controller: 'DashCtrl'
      }
    }
  })

  .state('tab.goal-list', {
    url: 'dash/goal-list',
    views: {
      'tab-dash': {
        templateUrl: 'templates/goal-list.html',
        controller: 'goalListCtrl'
      }
    }
  })

  .state('tab.goal', {
    url:'/goal/:id',
    views: {
      'tab-dash': {
        templateUrl: 'templates/goal.html',
        controller: 'goalShowCtrl'
      }
    }
  })


  .state('tab.new-objective', {
    url: 'dash/:id/new-objective',
    views: {
      'tab-dash': {
        templateUrl: 'templates/new-objective.html',
        controller: 'newObjectiveCtrl'
      }
    }
  })

  .state('tab.checkin', {
    cache: false,
    url: '/checkin',
    views: {
      'tab-checkin': {
        templateUrl: 'templates/tab-checkin.html',
        controller: 'checkinListController'
      }
    }
  })

  .state('tab.new-checkin', {
    url: '/checkin/new',
    views: {
      'tab-checkin': {
        controller: "checkinController",
        templateUrl: "templates/new-checkin.html"
      }
    }
    
  })

  .state('tab.new-goal', {
    url: '/dash/goal',
      views: {
        'tab-dash': {      
          controller: 'goalListCtrl',
          templateUrl: "templates/new-goal.html"
        }
    }
  })


  .state('tab.chats', {
      url: '/chats',
      views: {
        'tab-chats': {
          templateUrl: 'templates/friends.html',
          controller: 'friendsCtrl'
        }
      }
    })

  .state('tab.friendRequest', {
    url: '/chats/requests/:id',
      views: {
        'tab-chats': {
          templateUrl: 'templates/friendrequest.html',
          controller: 'friendRequestsCtrl'
        }
      }
  })

  .state('tab.friendSearchResults', {
    url: 'chats/results', 
      views: {
        'tab-chats': {
          templateUrl: 'templates/friendSearchResults.html',
          controller: 'friendSearchCtrl'
        }
      }
  })

  .state('tab.friend-chat', {
    url: 'chats/friend-chat/:id',
    views: {
      'tab-chats': {
        templateUrl: 'templates/friend-chat.html',
        controller: 'friendChatCtrl'
      }
    }
  })

  .state('tab.group-show', {
    url: 'chats/group/:id',
    views: {
      'tab-chats': {
        templateUrl: 'templates/group-show.html',
        controller: 'groupCtrl'
      }
    }
  })

  .state('tab.new-group', {
    url: 'chats/group/new',
    views: {
      'tab-chats': {
        templateUrl: 'templates/new-group.html',
        controller: 'groupsCtrl'
      }
    }
  })

  .state('tab.user-show', {
    url: 'chats/results/:id',
    views: {
      'tab-chats': {
        templateUrl: 'templates/user-show.html',
        controller: 'userShow'
      }
    }
  })


    .state('tab.chat-detail', {
      url: '/chats/:id',
      views: {
        'tab-chats': {
          templateUrl: 'templates/friend.html',
          controller: 'friendCtrl'
        }
      }
    })

    .state('tab.friend-checkin', {
      url: '/chats/:id/checkin',
      views: {
        'tab-chats': {
          templateUrl: 'templates/friend-checkin.html',
          controller: 'friendCtrl'
        }
      }
    })

  .state('login', {
    url: '/login',
    templateUrl: 'templates/login.html',
    controller: 'LoginCtrl'
  })

  .state('register', {
    url: '/register',
    templateUrl: 'templates/register.html',
    controller: 'RegisterCtrl'
  })

  .state('tab.account', {
    url: '/account',
    views: {
      'tab-account': {
        templateUrl: 'templates/tab-account.html',
        controller: 'AccountCtrl'
      }
    }
  })

  .state('tab.about-me', {
    url: '/account/details', 
    views: {
      'tab-account': {
        templateUrl: 'templates/tab-about-me.html',
        controller: 'aboutMeCtrl'
      }
    }
  })

  .state('tab.resources', {
    url :'/resources',
    views: {
      'tab-resources': {
        templateUrl: 'templates/tab-resources.html',
        controller: 'ResourcesCtrl'
      }
    }
  })

  .state('tab.meetings', {
    url:'/resources/meetings',
    views: {
      'tab-resources': {
        templateUrl: 'templates/meetings.html',
        controller: 'MeetingCtrl'
      }
    }
  })

  .state('tab.journal', {
    url:'/resources/journal',
    views: {
      'tab-resources': {
        templateUrl: 'templates/journal.html',
        controller: 'JournalCtrl'
      }
    }
  })

  .state('tab.boards', {
    url: '/resources/boards',
    views: {
      'tab-resources': {
        templateUrl: 'templates/boards.html',
        controller: 'BoardCtrl'
      }
    }
  })

  .state('tab.board-detail', {
    url: '/boards/:id',
    views: {
      'tab-resources': {
        templateUrl: 'templates/tab-board-detail.html',
        controller: 'PostCtrl'
      }
    }
  })
  ;

  // if none of the above states are matched, use this as the fallback
  $urlRouterProvider.otherwise('/login');

});
