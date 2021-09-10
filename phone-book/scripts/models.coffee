generateId = () -> "_" + Math.random().toString(36).substr(2, 9)

User = Backbone.Model.extend {
  urlRoot: "/api/users"
  initialize: ({ isOnEdit = false }) ->
    this.set { isOnEdit: isOnEdit, id: generateId() }
  validate: ({ name, phone }) ->
    if !name
      "Name is empty"
    else if typeof name != "string"
      "Name must be string"
    else if (!phone)
      "Phone is empty"
    else if (!/^\+?[\d-]+$/.test(phone))
      "Invalid phone"
}

Users = Backbone.Collection.extend {
  urlRoot: "/api/users",
  model: User

  editing: () ->
    return this.where { isOnEdit: true }

  setIsEditFalse: () ->
    user.set { isOnEdit: false } for user in this.editing()
}

AppState = Backbone.Model.extend {
  default: {
    error: ""
  }
}
