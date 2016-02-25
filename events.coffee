# Description:
#   <todo>
#
# Authors:
#   Created 25th of February 2016
#   By Michael Smith

module.exports = (robot) ->
  robot.enter (res) ->
    if res.message.user.id == "voidbot"
      res.send "Never fear, I is here."
