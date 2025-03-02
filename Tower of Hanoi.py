def towerofhanio(n, src, media, dest):
    print ("State: ",src , media , dest)
    if n > 0:
        towerofhanio(n - 1, src, dest, media)
        if src[0]:
            disk = src[0].pop()
            print ("relocating " + str(disk) + " from " + src[1] + " to " + dest[1])
            dest[0].append(disk)
        towerofhanio(n - 1, media, src, dest)
src = ([4,3,2,1], "src")
dest = ([], "dest")
media = ([], "media")
towerofhanio(len(src[0]),src,media,dest)
print ("Final State:",src, media, dest)
