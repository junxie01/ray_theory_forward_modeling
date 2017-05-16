#!/bin/bash
evla=34.26230
stla=39.06230
evlo=-116.9207
stlo=-101.8309
psbasemap -R0/360/-90/90 -JG-100/30/6i -B30g30/15g15:."Orthographic": -P -K> ortho.ps
psxy track.dat -R -J -B -Sc0.1i -O -K -Gblack >>ortho.ps
psxy -R -O -K -St0.2i -Gred -J -B >>ortho.ps<<eof
$evlo $evla
$stlo $stla
eof
psxy -R -J -O -K -B -W1p,red>>ortho.ps<<eof
0 90
$evlo $evla
eof
