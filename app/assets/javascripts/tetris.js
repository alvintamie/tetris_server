var homeRef;
var opponentRef;
var opponent_ctx;
var opponent_id;
var ready_worker = false;
function set_worker(_home_id,_opponent_id){
  console.log('worker');
  opponent_ctx = ctx = $("#opponent_field")[0].getContext('2d');
  homeRef = new Firebase('https://battle-tetris-firebase.firebaseIO.com/'+_home_id.toString());
  opponentRef = new Firebase('https://battle-tetris-firebase.firebaseIO.com/'+_opponent_id.toString());
  homeRef.on('child_changed', function(childSnapshot, prevChildName) {
 		 draw_field(opponent_ctx,childSnapshot.val());
	});
  ready_worker = true;
}

function push_to_firebase(field,player_block){
	if(!ready_worker) return;
   	opponentRef.child('field').set(draw_player_block_to_field(field, player_block));
}

function lost(){
  console.log("you are lost"); 
}

function draw_player_block_to_field(field, player_block){

	y = player_block.y;
	x = player_block.x;
	shape = player_block.block.shape; 
	color = player_block.block.color;
	f = clone(field);

	for(var i=0;i<shape.length;i++){
		for(var j=0;j<shape.length;j++){
  			w = x+j;
  			h = y+i;
	  		if(shape[i][j] && h>0 && h<field.length && w>0 && w<field[0].length) {
	  			console.log(w+' and '+h);
	  			f[h][w].occupy = true;
	  			f[h][w].color = color;
	  		}
		}
	}
	return f;
}