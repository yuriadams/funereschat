App = App || {};
App.lobby = (function($) {
  function _appendMessage(data) {
    var html = [];
    html.push("<div class='message-block'>");
    html.push("<p><img src='/images/" + data.dialect + ".png' class='msg-icon' /> <b>" + data.sender + "</b> - <small>" + data.time + "</small></p>");
    html.push("<p>" + data.text + "</p>");
    html.push("</div>");
    $('#messages-container').append(html.join(''));
  }

  function _subscribe(roomId, userId) {
    var channel = App.cable.subscriptions.create(
        { channel: 'ChatChannel', room_id: roomId, user_id: userId },
        { received: _appendMessage });

    var activeConnectionsChannel = App.cable.subscriptions.create(
        { channel: 'ActiveConnectionsChannel' },
        { received: function(data){
          var html = [];
          data.forEach(function(id_email) {
            var id = id_email[0];
            var email = id_email[1];

            if (id === userId) { return; }

            html.push("<li>");
            html.push(email);
            html.push("</li>");
          });
          $('.active-users').html(html.join(''));
        }});

    $('.message-box').on('keyup', function(evt) {
      if (evt.keyCode === 13) {
          var $this = $(this);
          channel.send({ text: $this.val() });
          $this.val('');
      }
    });
  }

  return {
    subscribe: _subscribe
  };

}($));
