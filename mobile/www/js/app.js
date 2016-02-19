// Ionic Starter App

// angular.module is a global place for creating, registering and retrieving Angular modules
// 'starter' is the name of this angular module example (also set in a <body> attribute in index.html)
// the 2nd parameter is an array of 'requires'
// 'starter.services' is found in services.js
// 'starter.controllers' is found in controllers.js
angular.module('starter', ['ionic', 'starter.controllers', 'starter.services', 'ngResource'])

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

  .state('tab.checkin', {
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
          controller: 'DashCtrl',
          templateUrl: 'templates/new-goal.html'
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

  .state('tab.account', {
    url: '/account',
    views: {
      'tab-account': {
        templateUrl: 'templates/tab-account.html',
        controller: 'AccountCtrl'
      }
    }
  });

  // if none of the above states are matched, use this as the fallback
  $urlRouterProvider.otherwise('/login');

});
