require("database-setup")

local user1 = db.users:findOne {username = "jorge"}
print(user1)

user1 = db.users:findOne {username = "jorgesad"}
print(user1)
