column = [3,4,3,3,6,3,5,6] #x
row =    [4,5,4,4,6,3,3,4] #y

grid =  [[0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0],
         [0,0,0,0,0,0,0,0]]
class Done:
    def __init__(self):
        pass
def all(a,t):
    for x in a:
        if x == t:
            return False
    return True
def recurse(x,y,g,c,r):
    if x < 0:
        return False
    elif x >= len(c):
        if y + 1 == len(r):
            if all(row,0) and all(column,0):
                print g
                raise Done()
            else:
                return False
        else:
            return False
    elif y < 0:
        return False
    elif y >= len(r):
        return False
    elif c[x] == 0:
        return False
    elif r[x] == 0:
        return False
    elif g[x][y] != 0:
        return False
    c[x] -= 1
    r[x] -= 1
    g[x][y] = 1
    recurse(x-1,y,g,c,r)
    recurse(x+1,y,g,c,r)
    recurse(x,y-1,g,c,r)
    recurse(x,y+1,g,c,r)
    g[x][y] = 0
    c[x] += 1
    r[x] += 1
    return False

try:
    recurse(0,0,grid,row,column)
except Done:
    print "found solution"
