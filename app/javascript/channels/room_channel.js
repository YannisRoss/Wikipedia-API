import consumer from "./consumer"

const roomChannel = consumer.subscriptions.create("RoomChannel", {
  connected() {
    console.log('connected to RoomChannel')
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log('data received:' + data)
  }
},
);

roomChannel.send({ sent_by: "Paul", body: "This is a cool chat app." })
console.log('room_channel')