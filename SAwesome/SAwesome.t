#charset "us-ascii" 
#include <adv3.h> 
#include <en_us.h> 

versionInfo: GameID 
IFID = '573a8b18-1008-ca66-9580-9a156f82eefa' 
    name = 'Hide and Seek' 
    byline = 'by Cindy' 
    htmlByline = 'by <a href="mailto:whatever@nospam.org"> 
                  CINDY</a>' 
    version = '1.0' 
    authorEmail = 'CINDY <whatever@nospam.org>' 
    desc = 'COMP1917 Something Awesome.' 
    htmlDesc = 'COMP1917 Something Awesome.' 

    showCredit() 
    { 
        /* show our credits */ 
        "The TADS 3 language and library were created by Michael J.  
Roberts.<.p>";  

       
        "\b"; 
    } 
    showAbout() 
    { 
        "<i>Hide and Seek</i><.p> 
        Something Awesome Project"; 
    } 
; 

outsideCottage: OutdoorRoom
    roomName = 'Ouside a Cottage'
    desc = "You stand just before a cottage that is nestled on the outskirts of a town to the south. To the east there is a vast forest. It looks rather foreboding.
    So, what were you doing here again? Ah, right. This is your home. You were playing hide and seek with your brother. Being the good, responsible seeker that you are, you now must embark on a journey to find your little brother.
    "
    east = forest
south: FakeConnector {"You begin heading towards the town before decide against it. The people there give you and your brother weird looks when they see you. You're not sure why, but you know that your brother doesn't like it too. You should turn back."}
    dobjFor(Enter) remapTo(In)
    in = insideCottage
    west asExit(in)
; 

insideCottage: Room 'Inside Cottage'
	"You enter the cottage, cautiously shutting the door so the squeal of the hinge could escape unnoticed. The air is cold. The door exiting is to the east. To north is the living room. To west of you is the room shared by you and your brother."
	
north: FakeConnector {"Before you can approach the living room, you can already hear your parents. Your mother's wailing fills the empty hallway. You can't hear your father yet, and you're not sure that you want to. It will be for your own good that they don't see you. You should go back."}
	west =bedroom
	out = outsideCottage
	east asExit(out)
;
+ chair: Chair 'wooden chair' 'wooden chair'
    "It's a plain wooden chair."
    initSpecialDesc = "A plain wooden chair sits in a corner"
;

bedroom: Room 'Bedroom'
	"It's a small room that you and your brother share.  It is quite crammed with the two piece of furniture. The door exiting is to the east."
	out = insideCottage
	east asExit(out)
;

+ bed: Thing'bed''single bed'
    "It's a bed. The blankets are a messy bundle on top of it. Your brother certainly isn't here."
;

+ wardrobe: Thing 'wardrobe' 'wardrobe'
	"A plain wooden wardrobe. It is quite small, but big enough to fit a child inside of it. You open it to find it to be empty."
;

forest: OutdoorRoom 'Deep in the Forest'
	"You venture into the forest. The daylight is quickly lost above the canopy of trees. You are not afraid. You come here quite often, after all. You catch a glimpse of your home to the west. The path you are on diverts, one heading northeast, and the other north, where you can hear the sound of trickling water."
	west = outsideCottage
	northeast = clearing
	north = river
;

river: OutdoorRoom 'By the River Bank'
	"You find yourself at a river, the forest south of you. You stand on the banks. The river is too thick to cross. The forest is humming with insects around you. The mud beneath you is messy with paw prints, big and small. You're no expert at animal tracking, but you wonder if you should examine the prints anyway."
	south = forest
;
+prints: Decoration 'print/prints/paw prints/paw print''paw print'
    "Well, you are no expert, but judging at how the paw prints all have claws, you think there must have been some commotion over food among pedators and scavengers. Funny enough, you don't see any hooves. What could they have been scavenging if it wasn't deers that they hunted? Ah. It doesn't matter. You're just playing a simple game of hide and seek. Maybe you and your brother can solve the mystery together when you find him.."
;

clearing: OutdoorRoom 'Clearing'
	"You come into a clearing. The path stops, the forest now southwest of you. A tall oak stands in the middle of this clearing."
    southwest = forest
up: TravelMessage
	{ -> topOfTree
		"By clinging on to the lowest branch you haul yourself onto the tree. You climb further up, up, and up."
		canTravelerPass(traveler)
			{return traveler.isIn(chair) && traveler.posture==standing;}
			explainTravelBarrier(traveler)
			{"The lowest branch is just out of reach.";}
	}
;
 
+ tree: Fixture 'tall oak tree' 'tree'
    "Standing lonesomely in the middle of the clearing is this oak tree. It's completely possible to climb it. Maybe your brother is hiding on top of it."
    dobjFor(Climb) remapTo(Up)
	/*up: OneWayRoomConnector
	{
		destination = topOfTree
		canTravelerPass(traveler) {return traveler.isIn(chair);}
		explainTravelerBarrier(traveler)
			{"The lowest branch is too high for you to reach.";}
			travelDesc = "By standing on the chair you just manage to reach the lowest branch and you manage to haul yourself up the tree. <.p>"
	}
    */
;
++ branch: OutOfReach, Fixture 'lowest branch' 'lowest branch'
	"The lowest branch is too high for you to reach from the ground. You're going to need some help."
	/*
	canObjReachContents(obj)
	{
		if(obj.posture == standing && obj.location == chair)
			return true;
		return inherited(obj);
	}
	cannotReachFromOutsideMsg(dest)
	{
		return 'The branch is too high for you to reach by yourself.';
	}
*/
;

topOfTree: OutdoorRoom 'At the top of the tree'
	"You climb to the top of the tree."
;
tinsoilder: Thing 'toy/tin soldier' 'tin soldier that belongs to your brother'
	location = topOfTree
	
actionDobjTake()
	{
		if (location != topOfTree)
			inherited;
	else
	{
	"The view up here is pretty great. You can see your cottage, and the river that winds through the forest. The sun is beginning to set, and you wonder if you should return home. Your brother had been evasive. He wasn't usually this good at hide and seek. But he has really outdone you these past few days, leaving you to walk home alone night after night without as much as a trace of him. But his tricks are at an end now, because you know just exactly where he is. You have to go get him. You're older, and have always taken care of him. He must be hungry and cold. He must be sad all alone under the tree.																													Jump. You tell yourself. He won't be lonely anymore soon.";
	
	finishGameMsg(ftDeath, [finishOptionUndo]);
	}
}
;
/*
cottage: Thing
	vocabWords = 'pretty little cottage/house/building'
	name = 'pretty little cottage'
	desc = "It's such a pretty little cottage. You can almost imagine there to be a fireplace inside. It is surrounded by a white fence and bushes of roses. The windows frames are painted in green."
	location = outsideCottage
;
*/

cottage: Thing 'pretty little cottage/house/building'
	'plain cottage that is your home' @outsideCottage
	"It's a rather plain cottage. Your family is quite poor, so it was a lot easier to live outside the town than inside it. Even though there are no other children around, you didn't mind. The grassland and the conjoined forest gave you plenty of space to play with your brother."
;    


/* HOW TO DO DECORATIONS
+ cottage: Decoration 'pretty little cottage/house/building' 'pretty little cottage'   
   "It's just the sort of pretty little cottage that townspeople dream of living in, with roses round the door and a neat little window frame freshly painted in green. "    
; 


study: Room 'a house' "A large desk stands under window";
+ desk: Heavy, Surface 'desk' 'desk' "This large desk has a drawer";
*/

me: Actor 
    /* the initial location */ 
    location = outsideCottage 
; 

gameMain: GameMainDef 
     initialPlayerChar = me 
     showIntro() 
     { 
       "Welcome to 'Hide and Seek' - Cindy's Something Awesome Project!\b"; 
     } 
     showGoodbye() 
     { 
       "<.p>Thanks for playing!\b"; 
     }     
; 
