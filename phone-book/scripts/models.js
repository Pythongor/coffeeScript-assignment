// Generated by CoffeeScript 2.5.1
var AppState, User, Users, generateId;

generateId = function() {
  return "_" + Math.random().toString(36).substr(2, 9);
};

User = Backbone.Model.extend({
  urlRoot: "/api/users",
  initialize: function({isOnEdit = false}) {
    return this.set({
      isOnEdit: isOnEdit,
      id: generateId()
    });
  },
  validate: function({name, phone}) {
    if (!name) {
      return "Name is empty";
    } else if (typeof name !== "string") {
      return "Name must be string";
    } else if (!phone) {
      return "Phone is empty";
    } else if (!/^\+?[\d-]+$/.test(phone)) {
      return "Invalid phone";
    }
  }
});

Users = Backbone.Collection.extend({
  urlRoot: "/api/users",
  model: User,
  editing: function() {
    return this.where({
      isOnEdit: true
    });
  },
  setIsEditFalse: function() {
    var i, len, ref, results, user;
    ref = this.editing();
    results = [];
    for (i = 0, len = ref.length; i < len; i++) {
      user = ref[i];
      results.push(user.set({
        isOnEdit: false
      }));
    }
    return results;
  }
});

AppState = Backbone.Model.extend({
  default: {
    error: ""
  }
});