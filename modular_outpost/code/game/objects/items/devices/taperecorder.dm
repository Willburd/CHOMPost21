/obj/item/rectape/anna_lore
	name = "old tape"

/obj/item/rectape/anna_lore/Initialize(mapload)
	. = ..()
	icon_state = "tape_[pick("white", "blue", "red", "yellow", "purple")]"
	switch(rand(1,6))
		if(1)
			storedinfo += "\[00:00\] Recording started."
			storedinfo += "\[00:54\] Anna Neso says, '...This is Anna Neso--Xenoarchaeologist--though I know not why I'm... making; a point of saying that, when nobody should be hearing this log but me.'"
			storedinfo += "\[01:53\] Anna Neso says, '...There's... something down there, in the deep caves. It keeps calling to me. Begging for me. I... don't much know what it is, but... Command have been far from forthcoming with information.'"
			storedinfo += "\[02:20\] Anna Neso says, '...I stand at the precipice, now. Jagged rocks lay below.'"
			storedinfo += "\[02:31\] Anna Neso says, '...I... don't think those will prove a good spot for landing.'"
			storedinfo += "\[02:38\] Anna Neso says, '...'"
			storedinfo += "\[02:49\] Anna Neso says, 'I'll just... see if my remaining steel is enough to build over them, I s'pose.'"
			storedinfo += "\[03:13\] Anna Neso says, 'Last I was here, things went... poorly. Died. Got held in questioning for hours.'"
			storedinfo += "\[03:35\] Anna Neso says, '...They let me keep that sleeve's memories, though, at least. Silver lining, I... s'pose.'"
			storedinfo += "\[03:58\] Anna Neso says, '...Nearly wish they hadn't. That shit... sucked.'"
			storedinfo += "\[04:09\] Anna Neso says, '...But! It means I know a little more now, at least.'"
			storedinfo += "\[04:22\] Anna Neso says, 'Enough dawdling--let's see what else I can figure out.'"
			storedinfo += "\[04:30\] Anna Neso says, 'End Log 1.'"
			storedinfo += "\[04:30\] Recording stopped."

		if(2)
			storedinfo += "\[04:31\] Recording started."
			storedinfo += "\[04:55\] Anna Neso says, '...This place feels... more open, than last time. Less claustrophobic. Maybe that's... just the mesons, though.'"
			storedinfo += "\[04:56\] Recording stopped."

		if(3)
			storedinfo += "\[04:57\] Recording started."
			storedinfo += "\[05:08\] Anna Neso says, 'Pants and groans.'"
			storedinfo += "\[05:17\] Anna Neso asks, 'Hrrfh... hah... there's... fuckin' carp down here?'"
			storedinfo += "\[05:25\] Anna Neso says, '...There's carp down here. Right.'"
			storedinfo += "\[05:43\] Anna Neso says, 'I'm... injured somethin' fierce, b-but... it's dead, now. And... I've found a structure.'"
			storedinfo += "\[06:05\] Anna Neso , 'Yells in pain!'"
			storedinfo += "\[06:37\] Anna Neso says, '...Living quarters...? Not especially, ah... impressive, though. There's a bug net on a shelf, and uncomfortable-looking bed... and, ah... also, a table with a lamp.'"
			storedinfo += "\[06:55\] Anna Neso says,'...I'll leave my translocator beacon here, I think.'"
			storedinfo += "\[06:59\] Anna Neso says, 'End Log 2.'"
			storedinfo += "\[06:59\] Recording stopped."

		if(4)
			storedinfo += "\[07:00\] Recording started."
			storedinfo += "\[07:13\] Anna Neso says, '...RIGHT. I returned home for some, ah... medical treatment. Yes. That's what it was.'"
			storedinfo += "\[07:30\] Anna Neso says, '...BUT. Expedition shall... resume, now! End Log 3.'"
			storedinfo += "\[07:30\] Recording stopped."

		if(5)
			storedinfo += "\[07:31\] Recording started."
			storedinfo += "\[08:23\] Anna Neso asks, '...I've found a medical bay. Abandoned, and destroyed--rife with the flesh that I now know to indicate this is part of The Terraformer. Just what... happened, here? Who was operating this place? Us?'"
			storedinfo += "\[08:45\] Anna Neso says, 'I... hate the sounds that those sphincter-doors make. Sets me on edge. Always think something's gonna just... j-jump out at me.'"
			storedinfo += "\[08:46\] Anna Neso , 'Sighs.'"
			storedinfo += "\[08:50\] Anna Neso says, '...End Log 4.'"
			storedinfo += "\[08:50\] Recording stopped."

		if(6)
			storedinfo += "\[08:51\] Recording started."
			storedinfo += "\[09:09\] Anna Neso says, 'Lets out a panicked pant 'n a gasp. '...I-it... s-spoke to me, again. Closer, this time.'"
			storedinfo += "\[09:17\] Anna Neso says, 'We feel you', it said. Again and again.'"
			storedinfo += "\[09:24\] Anna Neso says, 'T-the... flesh, I mean.'"
			storedinfo += "\[09:30\] Anna Neso says, 'The walls, they--'"
			storedinfo += "\[09:38\] Anna Neso says, 'More of them. They started to grow.'"
			storedinfo += "\[09:51\] Anna Neso says, '...T-towards me, they did.'"
			storedinfo += "\[09:55\] Anna Neso says, 'To close me in.'"
			storedinfo += "\[10:12\] Anna Neso says, '...'Join us', is all the deliberation it asked prior.'"
			storedinfo += "\[10:24\] Anna Neso says, 'Lets out a sharp, weary sigh.'"
			storedinfo += "\[10:33\] Anna Neso says, '...S-shit. More of it's coming-'"
			storedinfo += "\[10:35\] Anna Neso says, 'END LOG 5.'"
			storedinfo += "\[10:36\] Recording stopped."
