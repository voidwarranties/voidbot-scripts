# Description:
#   Status script for voidbot, a hubot based IRC bot.
#
# Commands:
#   .status - Returns the state of the VoidWarranties space: open or closed.
#
# Authors:
#   Created 25th of February 2016
#   By Michael Smith
#   Based on original code 13th of October 2013
#   By Ward De Ridder

module.exports = (robot) ->
  robot.hear /\.status/i, (res) ->
    robot.http("http://spaceapi.voidwarranties.be/")
      .header('Accept', 'application/json')
      .get() (err, response, body) ->
        space_state = "unknown"
        if err
          console.log "status.coffee encountered an error: #{err}"
        else
          if response.statusCode isnt 200
            console.log "status.coffee encountered an error: #{response.statusMessage}"
          else
            data = null
            try
              data = JSON.parse body
              if data.state.open
                space_state = "open"
              else
                space_state = "closed"
            catch error
              console.log "status.coffee encountered an error" +
                "parsing JSON. Received body: #{body}"

        switch space_state
          when "open"
            res.send "VoidWarranties is currently open!"
          when "closed"
            res.send "VoidWarranties is currently closed!"
          else
            res.send "I was unable to retrieve the state of the space. " +
              "Please try again later."
