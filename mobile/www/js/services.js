angular.module('starter.services', [])
.constant('BaseUrl', 'http://localhost:3000/api/v1')

.factory('UserSession', function($resource) {
  return $resource("http://localhost:3000/users/sign_in.json");
})

.factory('Goals', function($resource){
  return $resource("http://localhost:3000/api/v1/goals", {}, {
    query: {method: 'GET', isArray: false},
    create: {method: 'POST'}
  })
})

.factory('friendRequests', function($resource){
  return $resource("http://localhost:3000/api/v1/friendables/:id", {id: '@id'}, {
    query: {method: 'GET', isArray: true },
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

.factory('checkIn', function($resource) {
  return $resource("http://localhost:3000/api/v1/checkins", {user_id: "@user_id"}, {
    query: {method: 'GET', isArray: true},
    create: {method: 'POST'}
  })
})

.factory('objective', function($resource){
  return $resource("http://localhost:3000/api/v1/goals/:id", {id: '@id'}, {
  })
})

.factory('friendSearch', function($resource){
  return $resource("http://localhost:3000/api/v1/users", {search: '@search'}, {
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


.factory('userCheckins', function($resource){
  return $resource("http://localhost:3000/api/v1/users/:user_id/checkins/", {user_id: '@user_id'}, {
    query: {method: 'GET', isArray: true}
  })
})

.factory('Board', function($resource, BaseUrl) {
  return $resource(BaseUrl+'/boards/:id')
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
