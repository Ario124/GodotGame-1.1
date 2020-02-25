extends TileMap

var grid = []

func _ready(): 
	grid.resize(17)
	for n in 17: 
		grid[n] = []
		grid[n].resize(17)
		for m in 17:
			grid[n][m] = randi() % 4

	for n in range(0, 16):
		for m in range(0,16):
			if grid[n][m] == 0:
				set_cell(n,m,(n+m)%2)
