# Task 1
#install.packages("stringr")
library(stringr)

# Step 1
list.dirs("Musicr")

# Step 2
str_count("MUSICR/PeopleStuff", pattern = "/")

sub.directories = c(list.dirs("Musicr"))
album.sub = c()
for(direc in sub.directories){
  print(direc)
  if (str_count(direc, pattern = "/") == 2) {
    album.sub = append(album.sub, direc)
  }
}
print(album.sub)

# Step 3
code.to.process = c()
files = c()
for(sub in album.sub){
  sub.files = list.files(sub)
  if(sum(str_count(sub.files, pattern = "wav")) > 0) {
    files = append(files, sub.files)
  }
}
print(files)


for(album in album.sub){
  tracks = list.files(album)
  for(track in tracks){
    name = str_sub(track, start = 1, end = length(track)-6)
    location = paste('"', album, track, '"', sep = "/")
    split = str_split(name, "-")
    track.name = split[[1]][length(split[[1]])]
    artist = split[[1]][length(split[[1]])-1]
    #print(name)
    #print(location)
    #print(split)
    #print(track.name)
    #print(artist)
    album.split = str_split(album, "/")
    just.album = album.split[[1]][length(album.split[[1]])]
    output = paste(artist, just.album, track.name, ".json", sep = "-")
    print(output)
  }
}
