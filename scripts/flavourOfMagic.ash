#flavourOfScobo.ash

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
print("There are only " + hobomagic[0].count + " parts available so I'm going to cast " + hobomagic[0].flavour);
print("Just so you know, there are already " + hobomagic[1].count + " parts parts made from " + hobomagic[1].flavour);
print("Just so you know, there are already " + hobomagic[2].count + " parts parts made from " + hobomagic[2].flavour);
print("Just so you know, there are already " + hobomagic[3].count + " parts parts made from " + hobomagic[3].flavour);
print("Just so you know, there are already " + hobomagic[4].count + " parts parts made from " + hobomagic[4].flavour);
print("also, it looks like someone beat up " + skins + " hobos the old fashioned way");


if(skins < hobomagic[0].count){
use_skill($skill[spirit of nothing]);
print("Our Palette has been clensed!");
abort("Go ahead and make "+ hobomagic[0].count + " or more skins manually by beating things up.");
}
else{
use_skill(hobomagic[0].flavour);
print("We're tasting the " + hobomagic[0].flavour);
}

adventure(5, $location[Hobopolis Town Square]);
}

void main() {

if(!have_skill($skill[Flavour of Magic])){
abort("You need Flavour of Magic to use this script");
}

if(numeric_modifier("Spell Damage Percent")<2000){
if(!(user_confirm("Your spell damage is under 200% modified. Are your spells strong enough to make scobo parts?"))){
abort("Time to gear up to make super strong spells!");
}
else{makeScoboParts();}
}

}
