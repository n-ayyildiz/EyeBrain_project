#!/bin/bash

#
#FSL

#FSL atlasq function works with coordinates with comma only!!
#to convert tab delimited text file to comma delimited text file:
sed 's/\t/,/g' coordinates_tmp.txt > coordinates.txt

for coordinate in $(cat coordinates.txt)
do 
    echo "-------------------------------" >> Global_RNFLT_FA_clusters_cog.txt
    echo "${coordinate}" >> Global_RNFLT_FA_clusters_cog.txt
    atlasq ohi -a "JHU White-Matter Tractography Atlas" -c $coordinate >> Global_RNFLT_FA_clusters_cog.txt 
    atlasq ohi -a "JHU ICBM-DTI-81 White-Matter Labels" -c $coordinate >> Global_RNFLT_FA_clusters_cog.txt
    atlasq ohi -a "Juelich Histological Atlas" -c $coordinate >> Global_RNFLT_FA_clusters_cog.txt
    echo "-------------------------------" >> Global_RNFLT_FA_clusters_cog.txt
done

echo "DONE!!"

##save as csv and open with tab delimiter option!!!

## PS.
## done for the 'Global_RNFLT_FA_clusters.txt' as well
## for reporting 'peak' (Global_RNFLT_FA_clusters.txt) and 'center of gravity' coordinates (Global_RNFLT_FA_clusters_cog.txt) were combined 
###
