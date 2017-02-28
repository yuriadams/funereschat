App = App || {};
App.lobby = (function($) {
	function _appendMessage(data) {
		$('#container').append("<p>" + data.text + "</p>");
	}

	function _subscribe(room, user) {
		var channel = App.cable.subscriptions.create({ channel: 'ChatChannel', room: room, user: user },
		{ received: _appendMessage });

		$('#form-message').on('submit', function(evt) {
			evt.preventDefault();
			channel.send({ text: this['message_text'].value })
			this.reset()
		});
	}

	return {
		subscribe: _subscribe
	};
}($));
