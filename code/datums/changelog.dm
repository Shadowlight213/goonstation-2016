/*
(t)
(u)
(*)
*/
/datum/changelog
//	var/changelog_path = "icons/changelog.txt"
	var/html = null
/*
New auto-generated changelog:
Format:
Use (t) for the timestamp, (u) for the user, and (*)for the line to add.
Be sure to add a \ before a [
Examples:
Single update for a given day:
(t)mon jan 01 12
(u)Pantaloons
(*)Did a thing.
Multiple updates in a day:
(t)mon jan 01 12
(u)Pantaloons
(*)Did a thing.
(u)Nannek
(*)Also did a thing.

WIRE NOTE: You don't need to use (-) anymore (although doing so doesn't break anything)
OTHER NOTE:
(t)mon dec 1 14
returns "Monday, December 1 th, 204"
so you'll want your single-digit days to have 0s in front
*/

	var/changes = {"
(t)sun april 10 16
(u)Shadowlight213
(*)Actually looked at the changelog. Listing some older changes.
(*)Reworked see_invisible. Ghosts should be able to toggle darkness now. This may have messed with some invisibility stuff so please report any bugs.
(*)added fixes and features from the goon patches subforum. Listing their authors here so as to give them credit
(u)Erikhanson
(*)Fixed a bug with black hole pick from an empty list
(*)Optimises get_area and get_turf
(*)Fixes observers being unable to hear sounds
(*)Fixes a potential runtime with get_edge_target_turf
(*)Fixes AI examining
(u)Isilkor
(*)Fixed AI burn damage display
(*)added relaying PDA messages to AI shells
(u)Rubidium_Bradford
(*)Added eject verb to the PDA
(-)"}

/proc/changelog_parse(var/changes, var/title)
	var/html=""
	var/text = changes
	if (!text)
		diary << "Failed to load changelog."
	else
		html += "<ul class=\"log\"><li class=\"title\"><i class=\"icon-bookmark\"></i> [title] as of [svn_revision]</li>"

		var/list/lines = splittext(text, "\n")
		for(var/line in lines)
			if (!line)
				continue

			if (copytext(line, 1, 2) == "#")
				continue

			switch(copytext(line, 1, 4))
				if("(t)")
					var/day = copytext(line, 4, 7)
					html += "<li class=\"date\">"
					switch(day)
						if("sun")
							html += "Sunday, "
						if("mon")
							html += "Monday, "
						if("tue")
							html += "Tuesday, "
						if("wed")
							html += "Wednesday, "
						if("thu")
							html += "Thursday, "
						if("fri")
							html += "Friday, "
						if("sat")
							html += "Saturday, "
						else
							html += "Whoopsday, "
					var/month = copytext(line, 8, 11)
					switch(month)
						if("jan")
							html += "January "
						if("feb")
							html += "February "
						if("mar")
							html += "March "
						if("apr")
							html += "April "
						if("may")
							html += "May "
						if("jun")
							html += "June "
						if("jul")
							html += "July "
						if("aug")
							html += "August "
						if("sep")
							html += "September "
						if("oct")
							html += "October "
						if("nov")
							html += "November "
						if("dec")
							html += "December "
						else
							html += "Whoops"
					var/date1 = copytext(line, 12, 13)
					var/date2 = copytext(line, 13, 14)
					switch(date1)
						if("0")
							html += date2
							switch(date2)
								if("1")
									html += "st, "
								if("2")
									html += "nd, "
								if("3")
									html += "rd, "
								else
									html += "th, "
						else if("1")
							html += "[date1][date2]th, "
						else
							html += date1
							html += date2
							switch(date2)
								if("1")
									html += "st, "
								if("2")
									html += "nd, "
								if("3")
									html += "rd, "
								else
									html += "th, "
					html += "20[copytext(line, 15, 17)]</li>"
				if("(u)")
					html += "<li class=\"admin\"><span><i class=\"icon-check\"></i> [copytext(line, 4, 0)]</span> updated:</li>"
				if("(*)")
					html += "<li>[copytext(line, 4, 0)]</li>"
				else continue

		html += "</ul>"
		return html

/datum/changelog/New()
//<img alt="Goon Station 13" src="[resource("images/changelog/postcardsmall.jpg")]" class="postcard" />

	html = {"
<h1>TGoon Station 13 <a href="#license"><img alt="Creative Commons License" src="[resource("images/changelog/somerights20.png")]" /></a></h1>

<ul class="links cf">
    <li>Official Wiki<br><strong>http://wiki.ss13.co</strong><span></span></li>
    <li>Official Forums<br><strong>https://tgstation13.org/phpBB</strong></li>
</ul>"}
	html += changelog_parse(changes, "Changelog")
	html += {"
<h3>GoonStation 13 Development Team</h3>
<p class="team">
    <strong>Hosts:</strong> Rick (#1, #2), Pantaloons (#3, Wiki, Forums), Tobba (#4)<br>

    <strong>Coders:</strong> stuntwaffle, Showtime, Pantaloons, Nannek, Keelin, Exadv1, hobnob, 0staf, sniperchance, AngriestIBM, BrianOBlivion, I Said No, Harmar, Dropsy, ProcitizenSA, Pacra, LLJK-Mosheninkov, JackMassacre, Jewel, Dr. Singh, Infinite Monkeys, Cogwerks, Aphtonites, Wire, BurntCornMuffin, Tobba, Haine, Marquesas, SpyGuy, Conor12, Daeren<br>

    <strong>Spriters:</strong> Supernorn, Haruhi, Stuntwaffle, Pantaloons, Rho, SynthOrange, I Said No, Cogwerks, Aphtonites, Hempuli, Gannets, Haine, SLthePyro, and a bunch of awesome people from the forums!
</p>
<h3>TGoonStation 13 Development Team</h3>
<p class="team">
    <strong>Hosts:</strong> MrStonedOne (Gloom)<br>

    <strong>Coders:</strong> Shadowlight213\
</p>

<p class="lic">
    <a href="http://creativecommons.org/licenses/by-nc-sa/3.0/" name="license"><img alt="Creative Commons License" src="[resource("images/changelog/88x31.png")]" /></a><br/>

    <em>
    	Except where otherwise noted, Goon Station 13 is licensed under a <a href="http://creativecommons.org/licenses/by-nc-sa/3.0/">Creative Commons Attribution-Noncommercial-Share Alike 3.0 License</a>.<br>
    	Rights are currently extended to SomethingAwful Goons only.
    </em>
</p>"}
