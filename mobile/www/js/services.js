angular.module('starter.services', [])
.constant('BaseUrl', 'http://localhost:3000/api/v1')

.factory('UserSession', function($resource) {
  return $resource("http://localhost:3000/users/sign_in.json");
})

.factory('Goals', function($resource){
  return $resource("http://localhost:3000/api/v1/goals/:id", {}, {
    query: {method: 'GET', isArray: false},
    create: {method: 'POST'},
    get: {method: 'GET', isArray: false, id: '@id'}
  })
})

.factory('friendRequests', function($resource){
  return $resource("http://localhost:3000/api/v1/friendables/:id", {id: '@id'}, {
    query: {method: 'GET', isArray: true },
  })
})

// $scope.upVote = function() {
//     $http.post('');
//   }

.factory('upVote', function($resource){
  return $resource("http://localhost:3000/api/v1/boards/:board_id/up-vote", {board_id: '@board_id'}, {
    post: {method: 'POST'},
  })
})

.factory('downVote', function($resource){
  return $resource("http://localhost:3000/api/v1/boards/:board_id/down-vote", {board_id: '@board_id'}, {
    post: {method: 'POST'},
  })
})

//  friend request accept
.factory('friendRequestAccept', function($resource){
 return $resource("http://localhost:3000/friendables/:id/friend_request_accept", {id: '@id'}, {
    put: {method: 'PUT'},
  });
 })

// friend request reject

.factory('friendRequestReject', function($resource){
  return $resource('http://localhost:3000/friendables/:id/friend_request_reject', {id: '@id'}, {
  });
})


.factory('Occurrences', function($resource){
  return $resource('http://localhost:3000/api/v1/occurrences', {}, {
    query: {method: 'GET', isArray: true}
  })
})

.factory('occurrenceComplete', function($resource){
  return $resource('http://localhost:3000/api/v1/occurrences/:occurrence_id/mark_complete', {occurrence_id: '@id'}, {
    put: {method: 'PUT', isArray: false}
  })
})

.factory('checkIn', function($resource) {
  return $resource("http://localhost:3000/api/v1/checkins", {user_id: "@user_id"}, {
    query: {method: 'GET', isArray: true},
    create: {method: 'POST'}
  })
})

.factory('userInfo', function($resource){
  return $resource("http://localhost:3000/api/v1/aboutmes", {id: '@id'}, {}, {
    
  })
})

.factory('Objectives', function($resource){
  return $resource("http://localhost:3000/api/v1/goals/:goal_id/objectives", {goal_id: '@goal_id'}, {
    query: {method: 'GET', isArray: true},
    create: {method: 'POST'}
  })
})

.factory('Events', function($resource) {
  return $resource("http://localhost:3000/api/v1/events", {}, {
    query: {method: 'GET', isArray: true},
    create: {method: 'POST'}
  })
})

.factory('friendSearch', function($resource){
  return $resource("http://localhost:3000/api/v1/users", {search: '@search'}, {
    query: {method: 'GET', isArray: true}
  })
})

.factory('userAlerts', function($resource){
  return $resource("http://localhost:3000/api/v1/notifications/:id", {id: '@id'}, {
    query: {method: 'GET', isArray: true}
  })
})

.factory('friendSearchResults', function(){
  searchResults = {}

  searchResults.users = []

  searchResults.add = function(user){
    searchResults.users.push({id: searchResults.users.length, users: user})
  };

  return searchResults;
})


.factory('friends', function($resource) {
  return $resource("http://localhost:3000/api/v1/users/:user_id/friend_list", {user_id: "@user_id"}, {
    query: {method: 'GET', isArray: true}
  })
})

.factory('friend', function($resource){
  return $resource("http://localhost:3000/api/v1/users/:id", {id: '@id'}, {
  })
})

.factory('newFriendRequest', function($resource){
  return $resource("http://localhost:3000/friendables/:id/friend_request", {id: '@id'}, {
    put: {method: 'PUT'}
  })
})


.factory('userCheckins', function($resource){
  return $resource("http://localhost:3000/api/v1/users/:user_id/checkins/", {user_id: '@user_id'}, {
    query: {method: 'GET', isArray: true}
  })
})

.factory('Board', function($resource, BaseUrl) {
  return $resource('http://localhost:3000/api/v1/boards/:id', {id: '@id'}, {
    query: {method: 'GET', isArray: true},
    create: {method: 'POST'}
  })
})




.factory('Chats', function() {
  // Might use a resource here that returns a JSON array

  // Some fake testing data
  var chats = [{
    id: 0,
    name: 'Ben Sparrow',
    lastText: 'You on your way?',
    face: 'img/ben.png'
  }, {
    id: 1,
    name: 'Max Lynx',
    lastText: 'Hey, it\'s me',
    face: 'img/max.png'
  }, {
    id: 2,
    name: 'Adam Bradleyson',
    lastText: 'I should buy a boat',
    face: 'img/adam.jpg'
  }, {
    id: 3,
    name: 'Perry Governor',
    lastText: 'Look at my mukluks!',
    face: 'img/perry.png'
  }, {
    id: 4,
    name: 'Mike Harrington',
    lastText: 'This is wicked good ice cream.',
    face: 'img/mike.png'
  }];

  return {
    all: function() {
      return chats;
    },
    remove: function(chat) {
      chats.splice(chats.indexOf(chat), 1);
    },
    get: function(chatId) {
      for (var i = 0; i < chats.length; i++) {
        if (chats[i].id === parseInt(chatId)) {
          return chats[i];
        }
      }
      return null;
    }
  };
});
