# Task 1
#install.packages("stringr")
library(stringr)

# Step 1
list.dirs("Musicr")  #lists all subdirectories of Musicr

# Step 2
str_count("MUSICR/PeopleStuff", pattern = "/")

sub.directories = c(list.dirs("Musicr")) #puts subdirectories into a vector
album.sub = c() #empty vector for the subset of album subdirectories
for(direc in sub.directories){
  if (str_count(direc, pattern = "/") == 2) {  #if there are two forward slashes in the directory, it is an album
    album.sub = append(album.sub, direc) #add the album to the new vector
  }
}
#print(album.sub)

# Step 3
files = c()  #empty vector for all .wav files
for(sub in album.sub){ #loop through albums
  sub.files = list.files(sub) #list of files for each album
  if(sum(str_count(sub.files, pattern = "wav")) > 0) { #if a .wav file, add it to files vector
    files = append(files, sub.files)
  }
}
#print(files)

code.to.process = c() #code to process vector
for(album in album.sub) { #loop through albums
  tracks = list.files(album) #list of tracks for that album
  for(track in tracks){ #loop through the tracks in this album
    name = str_sub(track, start = 1, end = length(track)-6) #tracks filename without the .wav
    location = paste('"', album, track, '"', sep = "/") #album subdirectory/trackname
    split = str_split(name, "-") #splits the name between the dashes
    track.name = split[[1]][length(split[[1]])] #takes just the track name
    artist = split[[1]][length(split[[1]])-1] #artist name for that track
    album.split = str_split(album, "/")  #splits the album subdirectory between forward slashes
    just.album = album.split[[1]][length(album.split[[1]])] #takes just the album name
    output = paste(artist, "-", just.album, "-", track.name, ".json", sep = "") #desired output
    result = paste('streaming_extractor_music.exe "', track.name, '.wav" "', output, '"', sep = "")
    code.to.process = append(code.to.process, result)
    #print(name)
    #print(location)
    #print(split)
    #print(track.name)
    #print(artist)
    #print(output)
    #print(result)
  }
}
#print(album.sub)
print(code.to.process)

#step 4
writeLines(code.to.process, "batfile.txt")

