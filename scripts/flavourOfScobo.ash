#flavourOfScobo.ash
string combat_LTS(int round, monster opp, string text){
return "skill Lunging Thrust-Smack";
}

void makeHoboSkin(){
item brimstoneBludgeon= $item[Brimstone Bludgeon];

if(!have_skill($skill[lunging thrust-smack])){
abort("Please Make some Skins yourself");
}

cli_execute("outfit Hobo-Town-Skinmaker");

adv1($location[Hobopolis Town Square], -1, "combat_LTS");

}


void makeScoboParts(){



	string richard = visit_url("clan_hobopolis.php?place=3&action=talkrichard&whichtalk=3");

	record comparison_phial {
			skill flavour; //convert to flavour of magic skill
			int count; //this is the count of parts
		};
	comparison_phial [int] hobomagic; //building array of type comparison_phial
	hobomagic[0].flavour = $skill[Spirit of Cayenne]; //hot
	hobomagic[1].flavour = $skill[Spirit of Peppermint]; //cold
	hobomagic[2].flavour = $skill[Spirit of Garlic]; //stench
	hobomagic[3].flavour = $skill[Spirit of Wormwood]; //spooky
	hobomagic[4].flavour = $skill[Spirit of Bacon Grease]; //sleaze

	//zeroing out counts of existing parts
	hobomagic[0].count = 0;
	hobomagic[1].count = 0;
	hobomagic[2].count = 0;
	hobomagic[3].count = 0;
	hobomagic[4].count = 0;

	int skins = 0;

//note: This requires 2 or more parts to be counted. 
	matcher m = create_matcher("\<b\>([0-9]?[0-9]{0,4})\</b\> (pairs of frozen hobo eyes|pairs of charred hobo boots|piles of stinking hobo guts|creepy hobo skulls|hobo crotches|hobo skins)", richard);

	while(find(m)){
		print(group(m)); // This will print out how many parts are seen currently.
		switch(m.group(2)) {
		case "pairs of charred hobo boots":
			hobomagic[0].count = to_int(m.group(1));
			break;
		case "pairs of frozen hobo eyes":
			hobomagic[1].count = to_int(m.group(1));
			break;
		case "piles of stinking hobo guts":
			hobomagic[2].count = to_int(m.group(1));
			break;
		case "creepy hobo skulls":
			hobomagic[3].count = to_int(m.group(1));
			break;
		case "hobo crotches":
			hobomagic[4].count = to_int(m.group(1));
			break;
		case "hobo skins":
			skins = to_int(m.group(1));
			break;
		}
	}
	sort hobomagic by hobomagic[index].count;
if((hobomagic[0].count >=2) && (hobomagic[1].count >=2) && (hobomagic[2].count >=2) && (hobomagic[3].count >=2) && (hobomagic[4].count >=2) && (skins >=2)){
    print("Launching a schobo!", "orange");
    visit_url("clan_hobopolis.php?place=3&action=talkrichard&whichtalk=3&preaction=simulacrum&qty=1");
}
if(skins < hobomagic[0].count){
use_skill($skill[spirit of nothing]);
print("Our Palette has been clensed!");
makeHoboSkin();
//abort("Go ahead and make "+ hobomagic[0].count + " or more skins manually by beating things up.");
}

else{
use_skill(hobomagic[0].flavour);
print("We're tasting the " + hobomagic[0].flavour);
if(my_basestat($stat[mysticality]) <250){cli_execute("outfit Hobo-Town-Flavour-baby");}
else{cli_execute("outfit Hobo-Town-Flavour");}
adventure(1, $location[Hobopolis Town Square]);
}


}

void main(int turns) {
	//this will check to make sure the outfit is named correctly. IPB can change the script if needed.
	if(!cli_execute("outfit Hobo-Town-Skinmaker")){
	print("Unable to find the right outfit. Please create a physical damage outfit to use with Lunging Thrust-Smack and name it 'Hobo-Town-Skinmaker'");
	abort("Error: unable to find the corect outfit 'Hobo-Town-Skinmaker'");
	}
	//this will check to make sure the outfit is named correctly. IPB can change the script if needed.
	if(my_basestat($stat[mysticality]) <250){
		if(!cli_execute("outfit Hobo-Town-Flavour-baby")){
		print("Error: unable to find the corect outfit. Please create a Spell damage outfit to use with Flavour of Magic and name it 'Hobo-Town-Flavour-baby'");
		abort("Error: unable to find the corect outfit 'Hobo-Town-Flavour-baby'");
		}
		}
	else{
			if(!cli_execute("outfit Hobo-Town-Flavour")){
			print("Error: unable to find the corect outfit. Please create a Spell damage outfit to use with Flavour of Magic and name it 'Hobo-Town-Flavour'");
			abort("Error: unable to find the corect outfit 'Hobo-Town-Flavour'");
			}
		}


int advBurned = 0;

if (turns <= 0){
abort("Please run FlavourOfScobo [# of turns] to instruct the Number of Adventures to use");
}

if(!have_skill($skill[Flavour of Magic])){
abort("You need Flavour of Magic to use this script");
}

//if(numeric_modifier("Spell Damage Percent")<200){
//if(!(user_confirm("Your spell damage is under 200% modified. Are your spells strong enough to make scobo parts?"))){
//abort("Time to gear up to make super strong spells!");
//}
//else{makeScoboParts();}
//}
while(advBurned < turns){

makeScoboParts();
advBurned++;
}

}
