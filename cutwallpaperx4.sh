#!/bin/bash

#Version for 4 screens. 3 aligned and one on the top of the central one.
#This script requires imagemagick

image="$*"
fichier=${image##*/}
home=~

#modify the line below to set the height of your screen
hauteurmax=2160
#modify the line below to set the width of your screen
largeurmax=5760


#set the path of destination :
imagepath=$home"/Images/Triplemonitor/Coupé/"

gauche=left-
droite=right-
centre=center-
haut=top-
big=big
hauteur=$(identify -format "%h" "$image")
largeur=$(identify -format "%w" "$image")
entrop=$(($hauteur-$hauteurmax))
entropx=$(($largeur-$largeurmax))
hauteur2=$(($entrop/2))
largeur2=$(($entropx/2))
tiers=$(($largeurmax/3))
tiersx2=$(($tiers*2))
hauteurdiv2=$(($hauteurmax/2))

#copy original image in destination folder
cp "$image" "$imagepath$big$fichier"

#Global cut $hauteurmax x $largeurmax
mogrify -crop +0-$hauteur2 "$imagepath$big$fichier"
mogrify -crop +0+$hauteur2 "$imagepath$big$fichier"
mogrify -crop -$largeur2+0 "$imagepath$big$fichier"
mogrify -crop +$largeur2+0 "$imagepath$big$fichier"

#Copy for top and bottom
cp "$imagepath$big$fichier" "$imagepath$haut$fichier"
cp "$imagepath$big$fichier" "$imagepath$centre$fichier"

#Cut top and bottom in half
mogrify -crop -0-$hauteurdiv2 "$imagepath$haut$fichier"
mogrify -crop -0+$hauteurdiv2 "$imagepath$centre$fichier"

#Add copies to cut (left, right)
cp "$imagepath$centre$fichier" "$imagepath$gauche$fichier"
cp "$imagepath$centre$fichier" "$imagepath$droite$fichier"


#Horizontal cuts for central and top parts
mogrify -crop +$tiers-0 "$imagepath$centre$fichier"
mogrify -crop +$tiers-0 "$imagepath$haut$fichier"
mogrify -crop -$tiers-0 "$imagepath$centre$fichier"
mogrify -crop -$tiers-0 "$imagepath$haut$fichier"

#Vertical cuts for side parts
mogrify -crop -$tiersx2-0 "$imagepath$gauche$fichier"
mogrify -crop +$tiersx2-0 "$imagepath$droite$fichier"

#Comment the following line if you want to keep the max res file
rm "$imagepath$big$fichier"



