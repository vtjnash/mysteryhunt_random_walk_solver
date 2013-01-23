module RW
column = [3,4,3,3,6,3,5,6] #x
row =    [4,5,4,4,6,3,3,4] #y
#column = [5,1,4,4,4,5]
#row = [1,5,4,4,5,4]


grid =  zeros(Int,length(column),length(row))

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

function recurse(x,y,g,c,r)
    if x < 1
        return false
    elseif x > length(c)
        if y == length(r)
            if all(c,0) && all(r,0)
                println(g')
                throw(Done)
            else
                return false
            end
        else
            return false
        end
    elseif y < 1
        return false
    elseif y > length(r)
        return false
    elseif c[x] == 0
        return false
    elseif r[y] == 0
        return false
    elseif g[x,y] != 0
        return false
    end
    c[x] -= 1
    r[y] -= 1
    g[x,y] = 1
    recurse(x-1,y,g,c,r)
    recurse(x+1,y,g,c,r)
    recurse(x,y-1,g,c,r)
    recurse(x,y+1,g,c,r)
    g[x,y] = 0
    c[x] += 1
    r[y] += 1
    return false
end
println( try recurse(1,1,grid,column,row) catch e if e == Done "found solution" else rethrow() end end )
end
