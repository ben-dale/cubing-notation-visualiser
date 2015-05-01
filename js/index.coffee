$ = jQuery

##### IMAGES #####
b = "./images/b.png"
bi = "./images/bi.png"
d = "./images/d.png"
di = "./images/di.png"
f = "./images/f.png"
fi = "./images/fi.png"
l = "./images/l.png"
li = "./images/li.png"
r = "./images/r.png"
ri = "./images/ri.png"
u = "./images/u.png"
ui = "./images/ui.png"
ei = "./images/ei.png"
e = "./images/e.png"
m = "./images/m.png"
mi = "./images/mi.png"
s = "./images/s.png"
si = "./images/si.png"

##### ALGORITHMS #####
pllalgs = {
	"T-Perm" : "R U R' U' R' F R2 U' R' U' R U R' F'",
	"J(a)-Perm" : "R' U L' U2 R U' R' U2 R L U'",
	"J(b)-Perm" : "R U R' F' R U R' U' R' F R2 U' R' U'",
	"R(a)-Perm" : "R U R' F' R U2 R' U2 R' F R U R U2 R' U'",
	"R(b)-Perm" :  "R' U2 R U2 R' F R U R' U' R' F' R2 U'",
	"F-Perm" : "R' U' F' R U R' U' R' F R2 U' R' U' R U R' U R",
	"Y-Perm" : "F R U' R' U' R U R' F' R U R' U' R' F R F'",
	"H-Perm" : "M2' U M2' U2 M2' U M2'",
	"U(a)-Perm" : "R2 U' R' U' R U R U R U' R",
	"U(b)-Perm" : "R' U R' U' R' U' R' U R U R2",
	"Z-Perm" : "M2' U M2' U M' U2 M2' U2 M' U2",
	"A(a)-Perm" : "R' F R' B2 R F' R' B2 R2",
	"A(b)-Perm" : "R B' R F2 R' B R F2 R2"
	"F-Perm" : "R' U R U' R2 F' U' F U R F R' F' R2 U'"
}

getImageForMove = (move) ->
	switch(move)
		when "B" then b
		when "B'","Bi" then bi
		when "D" then d
		when "D'", "Di" then di
		when "F" then f
		when "F'","Fi" then fi
		when "L" then l
		when "L'","Li" then li
		when "R" then r
		when "R'","Ri" then ri
		when "U" then u
		when "U'","Ui" then ui
		when "E" then e
		when "E'", "Ei" then ei
		when "M" then  m
		when "M'", "Mi" then mi
		when "S" then  s
		when "S'", "Si" then si
		else ""

showError = (message) ->
	$("#warning-message").html(message).show();

hideError = () ->
	$("#warning-message").hide();

showImage = (n) ->
	$("#images").append("<img src=#{n} />")

handleErrors = (invalidMoves) ->
	if invalidMoves.length > 0 
		message = "Unable to parse the following moves: <ul>"
		for move in invalidMoves 
			message += "<li>#{move}</li>"
		message += "</ul>"
		showError message

removeInversion = (move) ->
	move.replace("i", "").replace("'", "")

getIndexOfLastSubAlgMove = (algorithm) ->
	index = -1
	for move in algorithm
		index++
		if move.indexOf("\)") > -1 then break
	index

parseAlgorithm = (algorithm) ->
	parsedAlgorithm = []
	algorithmArr = algorithm.split " "
	noOfSkips = 0

	for move, index in algorithmArr
		# Checks if this move has to be skipped or not
		# A move is skipped if it's encapsulated in brackets
		if noOfSkips > 0
			noOfSkips--
		else 
			if move.indexOf("\(") > -1
				# Extract the sub algorithm
				subAlg = algorithmArr.slice(index, algorithmArr.length)
				subAlg = subAlg.slice(0, getIndexOfLastSubAlgMove(subAlg) + 1)
				
				# Number of times to repeat the subalgorithm
				noOfRepeats = subAlg[subAlg.length - 1].split("\)")
				noOfRepeats = noOfRepeats[noOfRepeats.length-1]

				# Remove brackets and repeating number from sub algorithm
				subAlg[0] = subAlg[0].replace("\(", "")
				subAlg[subAlg.length-1] = subAlg[subAlg.length-1].split(")")[0]

				# Store subalgorithm in object
				subAlgorithm =
					algorithm : subAlg
					repeat : noOfRepeats

				parsedAlgorithm.push(subAlgorithm)
				noOfSkips += subAlg.length - 1
			else
				subAlgorithm = 
					algorithm : [move]
					repeat : 1

				parsedAlgorithm.push(subAlgorithm)
				
	parsedAlgorithm

generateImages = () ->
	$("#images").empty()
	invalidMoves = []
	notation = $("#notation").val().trim()
	algorithm = notation.split " "

	# The parsed algorithm comes back something like this:
	# (U R)3 U => [ { [U, R], 3 }, { [U], 1} ]
	parsedAlgorithm = parseAlgorithm(notation)
	for subAlg in parsedAlgorithm
		for x in [0...subAlg.repeat] by 1
			for move in subAlg.algorithm
				if(move.length > 0)
					# A single move can be repeated e.g. U2 or S2i
					noOfRepeats = 1

					# Extracts the number of times to repeat from the number
					extractedNumber = removeInversion(move).split(move[0])[1]
					if extractedNumber?.length != 0 and isFinite(extractedNumber)
						noOfRepeats = extractedNumber
						move = move.replace(noOfRepeats, "")

					image = getImageForMove(move)
					
					if image.length == 0 
						invalidMoves.push(move)
					else 
						for x in [0...noOfRepeats] by 1
							showImage(image)

	handleErrors(invalidMoves)

##### ON SCREEN ELEMENT LISTENING #####

$("#generateImages").on "click", (event) ->
	hideError()
	generateImages()

$("#pll-algs").on "change", (event) ->
	hideError()
	selected = $("#pll-algs").find(":selected").text()
	$("#notation").val(pllalgs[selected])
	generateImages()

##### ENTRY POINT ######

# Loop through algorithms and add to on-screen list
for k,v of pllalgs
	$("#pll-algs").append("<option>#{k}</option>");

# Load T-Perm by default
$("#notation").val(pllalgs["T-Perm"])
generateImages()