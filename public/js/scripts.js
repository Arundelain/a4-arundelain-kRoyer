//***** Karen Royer - https://github.com/Arundelain/a2-arundelain
//***** Assignment 2 CS4241
//***** 09/09/2019
//*****


console.log("Welcome to assignment 2!")

// initial data - declare a key counter for the data structure and
// arrays to hold a collection of verbs, prepositions and colors
var keyCounter = 0;
//story details here
var verb = ['jumped', 'hiked', 'rode', 'traipsed', 'skipped','meandered','fell','hopped','trekked', 'tramped'];
var where = ['over', 'under', 'around','through', 'beyond', 'between', 'across','past','inside', 'near'];
var color = ['red','green', 'blue', 'yellow','orange', 'purple','brown','black','white','sky blue pink'];

// data structure - key, noun, noun, adjective, adjective, verb, where
// this is the first record - key is zero
var appdata = [{ key:keyCounter, username: 'noun', password:'noun', verb:'verb', where:'preposition'}];

//increment key to prepare to receive user data
keyCounter = 1;

//submit function from submit button
const submitF = function( e ) {
    // prevent default form action from being carried out
    e.preventDefault()

// setup up initial values of data
  var nounItem_01 = document.querySelector( '#username' ),
      nounItem_02 = document.querySelector('#password'),
      fullSentence = document.querySelector('textarea'),
      list = document.querySelector('ul'),
      listString = [],
      // get a random verb, color and preposition for the sentence.
      json = { key:keyCounter, username: nounItem_01.value, password:nounItem_02.value, verb:verb[Math.floor(Math.random() * 10)], where:where[Math.floor(Math.random() * 10)]},
      body = JSON.stringify( json ),
      data = '';


    fetch( '/submit', {
      method:'POST',
      body
    })
    .then( function( response ) {
      console.log( "this is response" + response );
      //after the user clicks on the submit button, get the data in the input areas to push onto the end of
      //the data array.
  var tempObj = {};
      tempObj['key'] = keyCounter;
      tempObj['username'] = json.username;
      tempObj['password'] = json.password;
      
      tempObj['verb'] = verb[Math.floor(Math.random() * 10)];
      tempObj['where'] = where[Math.floor(Math.random() * 10)];
      appdata.push(tempObj);

      // construct the sentence for the text area then output the full sentence
        listString.push(' The '  + ' ' + color[Math.floor(Math.random() * 10)] + ' ' + appdata[keyCounter].username +' '+ appdata[keyCounter].verb +' '+ appdata[keyCounter].where +' '+ 'the '+appdata[keyCounter].password +'. '+'\n');
      fullSentence.textContent += listString;


      //create the list items for the document using the modified database
      let listItem = document.createElement('li');
      let listText = document.createElement('span');
      let listBtn = document.createElement('button');
      var myListItem = [keyCounter, listItem];
      listItem.appendChild(listText);
      listText.textContent = keyCounter + '-'+ appdata[keyCounter].username+ ', '+appdata[keyCounter].password;
      listItem.appendChild(listBtn);
      listBtn.textContent = 'Delete';
      list.appendChild(listItem);
      //increment the keycounter and wait for the next input
      keyCounter++;

      //add actions for the onclick delete button
      listBtn.onclick = function(e) {
     /// let appLength = appdata.length;
      listString = ''
      fullSentence.textContent = '';

      if(myListItem[0]>1){
            list.removeChild(listItem);
            console.log('cut off item'+ appdata[myListItem[0]].nouns_01);
            appdata.splice(myListItem[0],1);
            fullSentence.textContent = "";
          }else{
            fullSentence.textContent = "This first item on the list cannot be deleted."+ "\n";
          }
        }

      //return focus to the first input area and return response.json
      nounItem_01.focus();
      return response.json;
    })
    return false
  }

  window.onload = function() {
    const button = document.querySelector( '#submitButton' );
    button.onclick = submitF;
  }
