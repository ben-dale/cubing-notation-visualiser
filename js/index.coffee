$ = jQuery

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

show = (n) ->
	$("#images").append("<img src=#{n} />")

handleErrors = (invalidMoves) ->
	if invalidMoves.length > 0 
		message = "Unable to parse the following moves: <ul>"
		for move in invalidMoves 
			message += "<li>#{move}</li>"
		message += "</ul>"
		showError message

generateImages = () ->
	$("#images").empty()
	notation = $("#notation").val().split " "
	invalidMoves = []

	for move in notation
		repeatingMove = false
		
		if move.indexOf("2") > -1 then repeatingMove = true; move = move.replace("2", "")
	
		image = getImageForMove(move)
		if image.length == 0 
			invalidMoves.push(move)
		else if repeatingMove
			show image
			show image
		else
			show image	
		
	handleErrors(invalidMoves)

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
