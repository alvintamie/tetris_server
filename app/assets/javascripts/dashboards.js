var messagesRef = new Firebase('https://chat-tetris-firebase.firebaseIO.com//');
var name;

$(document).ready(function(){
    var box = null;
    box = $("#chat_div").chatbox({id:"chat_div", 
                                  user:{key : "value"},
                                  title : "test chat",
                                  messageSent : function(id, user, msg) {
                                 	  messagesRef.push({name:name,text:msg});
                                          }
                                        });

messagesRef.limit(10).on('child_added', function (snapshot) {
  var msg = snapshot.val();
  $("#chat_div").chatbox("option", "boxManager").addMsg(msg.name,msg.text);
  });
});

function initialize_name(_name){
	name = _name;
}

$(document).delegate('.modal-submit','click', function(e){
    // We don't want this to act as a link so cancel the link action
    e.preventDefault();
    // Find form and submit it
    secret_key = $("#tmp_secret_key").val();
    $("#secret_key").val(secret_key);
    $("#form").submit();
  });

$(document).delegate(".btn-to-modal",'click',function(e){
  $('#game_id').val($(this).data('id'));
});



