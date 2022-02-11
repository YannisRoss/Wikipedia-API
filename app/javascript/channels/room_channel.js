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
    console.log(data)
    let statisticsDiv = document.getElementById("statistics-div")
    let statistics = `<ul>
    <li>Entries count:  ${data['entries'].length} </li>
    <li>Search terms:  ${data['terms'].length} </li>   
    `
    console.log("let's examine data['entries']")
    console.log(data['entries'])
    console.log(`length is ${data['entries'].length}`)
    if (data['entries'].length > 0) {

      statistics = statistics + `
    
      <li>Entry with the biggest wordcount:  ${data['wordcount_max_min'][0]}</li>
      
      <li>Entry with the lowest wordcount:  ${data['wordcount_max_min'][1]}</li>
  
      
      <li>Entry with the most words in title:  ${data['biggest_title']} </li>
      <li>Entry with the lowest levenshtein distance according to its search term (levenshtein value and search term):  ${data['lowest_levenshtein']} , searched from ${data['lowest_levenshtein_term']} </li>
  
  
      </ul>
        `

    }
    else {
      statistics = statistics + ` 
      </ul>
      `
    }


    statisticsDiv.innerHTML = statistics
  
  }})
  

  
