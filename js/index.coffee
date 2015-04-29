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

pllalgs = {
	"T-Perm" : "R U R' U' R' F R2 U' R' U' R U R' F'",
	"J(a)-Perm" : "R' U L' U2 R U' R' U2 R L U'",
	"J(b)-Perm" : "R U R' F' R U R' U' R' F R2 U' R' U'",
	"R(a)-Perm" : "R U R' F' R U2 R' U2 R' F R U R U2 R' U'",
	"R(b)-Perm" :  "R' U2 R U2 R' F R U R' U' R' F' R2 U'",
	"F-Perm" : "R' U' F' R U R' U' R' F R2 U' R' U' R U R' U R",
	"Y-Perm" : "F R U' R' U' R U R' F' R U R' U' R' F R F'"
}

show = (n) ->
	$("#images").append("<img src=#{n} />")

generateImages = () ->
	$("#images").empty()
	notation = $("#notation").val().split " "

	for move in notation
		switch(move)
			when "B" then show b
			when "B'" then show bi
			when "D" then show d
			when "D'" then show di
			when "F" then show f
			when "F'" then show fi
			when "L" then show l
			when "L'" then show li
			when "R" then show r
			when "R'" then show ri
			when "U" then show u
			when "U'" then show ui
			when "B2" then show b; show b
			when "D2" then show d; show d
			when "F2" then show f; show f
			when "L2" then show l; show l
			when "R2" then show r; show r
			when "U2" then show u; show u

$("#generateImages").on "click", (event) ->
	generateImages()

$("#pll-algs").on "change", (event) ->
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
