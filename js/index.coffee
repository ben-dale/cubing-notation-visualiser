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

error = (message) ->
	$("#warning-message").html(message).show();

hideError = () ->
	$("#warning-message").hide();

show = (n) ->
	$("#images").append("<img src=#{n} />")

generateImages = () ->
	$("#images").empty()
	notation = $("#notation").val().split " "
	invalidMoves = []

	for move in notation
		
		switch(move)
			when "B" then show b
			when "B'","Bi" then show bi
			when "D" then show d
			when "D'", "Di" then show di
			when "F" then show f
			when "F'","Fi" then show fi
			when "L" then show l
			when "L'","Li" then show li
			when "R" then show r
			when "R'","Ri" then show ri
			when "U" then show u
			when "U'","Ui" then show ui
			when "E" then show e
			when "E'", "Ei" then show ei
			when "M" then show m
			when "M'", "Mi" then show mi
			when "S" then show s
			when "S'", "Si" then show si
			when "B2" then show b; show b
			when "B2'", "B2i" then show bi; show bi
			when "D2" then show d; show d
			when "D2'", "D2i" then show di; show di
			when "F2" then show f; show f
			when "F2'", "F2i" then show fi; show fi
			when "L2" then show l; show l
			when "L2'", "L2i" then show li; show li
			when "R2" then show r; show r
			when "R2'", "R2i" then show ri; show ri
			when "U2" then show u; show u
			when "U2'", "U2i" then show ui; show ui
			when "M2" then show m; show m
			when "M2'", "M2i" then show mi; show mi
			when "E2" then show e; show e
			when "E2'", "S2i" then show si; show si
			when "S2" then show s; show s
			when "S2'", "S2i" then show si; show si
			else invalidMoves.push move
			
	if invalidMoves.length > 0 
		message = "Unable to parse the following moves: <ul>"
		for move in invalidMoves 
			message += "<li>#{move}</li>"
		message += "</ul>"
		error(message)

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
