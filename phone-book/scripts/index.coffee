users = new Users
appState = new AppState { users }

appView = new AppView { model: appState }

users.add [
  { phone: "000-111-22-33", name: "Test" },
  { phone: "+987654321", name: "Fake" },
  { phone: "--1--2--3--", name: "Dummy" },
  { phone: "1248163264", name: "User" },
  { phone: "1123581321", name: "Nobody" },
]
