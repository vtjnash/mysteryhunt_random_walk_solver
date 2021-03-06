module RW2
#const col= [3,4,3,3,6,3,5,6] #x
#const row = [4,5,4,4,6,3,3,4] #y
#const col_add = (9,9,9,9,9,9,9,9)
#const row_add = (9,9,9,9,9,9,9,9)
#const col2 = [0,0,0,0,0,0,0,0,0,0]
#const row2 = [0,0,0,0,0,0,0,0,0,0]
#const length_col = length(col)
#const length_row = length(row)
#const grid =  zeros(Int,length_col,length_row)

#const col  = [3,2,8,4,6,0,8,6,4,3]
#const col_add = (5,5,99,99,8,2,99,99,6,6) # col, row gt
#const col2 = [4,3,0,0,0,6,0,0,3,3]
#const row  = [4,4,6,6,0,6,5,8,3,2]
#const row_add = (6,6,99,99,2,8,99,99,5,5) # row, col gt
#const row2 = [2,4,0,0,6,0,0,0,3,4] 
#const length_col = length(col)
#const length_row = length(row)
#const grid =  zeros(Int,length_col,length_row)
#grid[6,1] = grid[6,2]  = grid[1,5] = grid[2,5]  = -1
#grid[5,9] = grid[5,10] = grid[9,6] = grid[10,6] = -1
#
#const col  = []
#const col_add = () # col, row gt
#const col2 = []
#const row  = []
#const row_add = () # row, col gt
#const row2 = [] 
#const length_col = length(col)
#const length_row = length(row)
#const grid =  zeros(Int,length_col,length_row)
#grid[]  = -1

const col  = [3,4,4,7,8,0,6,9,10,3,5,2]
const col_add = (6,6,6,99,99,3,10,99,99,7,7,7) # col, row gt
const col2 = [4,3,2,0,0,5,0,0,0,4,3,5]
const row  = [2,4,3,7,9,0,5,8,10,3,5,4]
const row_add = (6,6,6,99,99,3,10,99,99,7,7,7) # row, col gt
const row2 = [5,2,5,0,0,4,0,0,0,3,4,4] 
const length_col = length(col)
const length_row = length(row)
const grid =  zeros(Int,length_col,length_row)
grid[6,1] = grid[6,2] = grid[6,3] = grid[1,6] = grid[2,6] = grid[3,6] = -1
grid[7,10] = grid[7,11] = grid[7,12] = grid[10,7] = grid[11,7] = grid[12,7] = -1

type Done end
import Base.all
function all(a::Array,t)
    for i = 1:length(a)
        if a[i] != t
            return false
        end
    end
    return true
end

function recurse(x,y)
    if x < 1
        return false
    elseif x > length_col
        if y == length_row
            if all(col,0) && all(row,0) && all(row2,0) && all(col2,0)
                println(grid)
                throw(Done)
                return true
            else
                return false
            end
        else
            return false
        end
    elseif y < 1
        return false
    elseif y > length_row
        return false
    end
    if grid[x,y] != 0
        return false
    end
    if y <= col_add[x]
        if col[x] == 0
            return false
        end
        c = col
    else
        if col2[x] == 0
            return false
        end
        c = col2
    end
    if x <= row_add[y]
        if row[y] == 0
            return false
        end
        r = row
    else
        if row2[y] == 0
            return false
        end
        r = row2
    end
    ## check connected
    flag = false
    for i = 1:(x-1)
        if col[i] != 0
            if col2[i] != 0
                flag = true
            end
        elseif col2[i] == 0 && flag == true
            return false
        end
    end
    for i = (x+1):length_col
        if col[i] == 0 && col2[i] == 0
            return false
        end
    end
    flag = false
    for i = 1:(y-1)
        if row[i] != 0
            if row2[i] != 0
                flag = true
            end
        elseif row2[i] == 0 && flag == true
            return false
        end
    end
    for i = (y+1):length_row
        if row[i] == 0 && row2[i] == 0
            return false
        end
    end
    ##
    c[x] -= 1
    r[y] -= 1
    grid[x,y] = 1

    for i in randperm(4)
        if i == 1
            recurse(x+1,y)
        elseif i == 2
            recurse(x-1,y)
        elseif i == 3
            recurse(x,y+1)
        elseif i == 4
            recurse(x,y-1)
        else
            throw(i)
        end
    end

    grid[x,y] = 0
    c[x] += 1
    r[y] += 1
    return false
end
println( try recurse(1,1) catch e if e == Done "found solution" else rethrow() end end )
end

