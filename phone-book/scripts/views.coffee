UserView = Backbone.View.extend {
  className: "users__card"
  template: _.template $("#user-template").html()

  events: {
    "click .users__button_apply": "deactivateEditMode"
    "click .users__button_edit": "activateEditMode"
    "click .users__button_delete": "clear"
  }

  initialize: () ->
    this.listenTo this.model, "change", this.render
    this.listenTo this.model, "destroy", this.remove

  render: () ->
    this.$el.html this.template {
        ...this.model.toJSON()
        error: this.model.validationError
      }
    this

  clear: () ->
    this.model.destroy()

  activateEditMode: () ->
    this.model.set { isOnEdit: true }
    # this.model.save()

  deactivateEditMode: () ->
    name = this.model.get "name"
    phone = this.model.get "phone"
    if !name or !phone
      this.clear()
    this.model.set {
      name: document.querySelector('.users__input[name="name"]').value
      phone: document.querySelector('.users__input[name="phone"]').value
    }
    if !this.model.isValid()
      this.model.set { name, phone }
    this.model.set { isOnEdit: false }
    # this.model.save()
}

AppView = Backbone.View.extend {
  el: document.getElementById "root"

  events: {
    "click .add__plus": "addNew"
  }

  initialize: () ->
    this.listenTo users, "add", this.addOne
    this.listenTo users, "reset", this.addAll

  addNew: () ->
    users.setIsEditFalse()
    user = new User {
      phone: document.querySelector('#add .add__input[name="phone"]').value
      name: document.querySelector('#add .add__input[name="name"]').value
    }
    if user.isValid()
      # .create()
      users.add user
    this.model.set { error: user.validationError }
    document.querySelector(".add__error").textContent = this.model.get "error"
    document.querySelector('.add__input[name="phone"]').value = ""
    document.querySelector('.add__input[name="name"]').value = ""

  addOne: (user) ->
    if user.isValid()
      view = new UserView { model: user }
      document.getElementById("users").append view.render().el

  addAll: () ->
    users.each this.addOne, this
}
