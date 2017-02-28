App = App || {};
App.lobby = (function($) {
	function _appendMessage(data) {
		var html = [];
		html.push("<div>");
		html.push("<p>" + data.user_id + " - " + data.created_at + "</p>");
		html.push("<p>" + data.text + "</p>");
		html.push("</div>");
		$('#messages-container').append(html.join(''));
	}

	function _subscribe(room, user) {
		var channel = App.cable.subscriptions.create(
			{ channel: 'ChatChannel', room: room, user: user },
			{ received: _appendMessage });

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
