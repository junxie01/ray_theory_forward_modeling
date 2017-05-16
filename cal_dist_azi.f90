! calculate the azimuth in rad
subroutine cal_dist_azi(evlo,evla,stlo,stla)
use globe_data,only : convdeg,radius,dist,azi
real evla,evlo,stla,stlo
real*8 ea,sa,do
real*8 cos_ab,sin_ab
real*8 cosaz
do=dble((stlo-evlo)*convdeg)
ea=dble((90-evla)*convdeg)
sa=dble((90-stla)*convdeg)
cos_ab=dcos(ea)*dcos(sa)+dsin(ea)*dsin(sa)*dcos(do)
dist=dacos(cos_ab)*radius
sin_ab=dsqrt(1-cos_ab**2)
cosaz=(dcos(sa)-cos_ab*dcos(ea))/sin_ab/dsin(ea)
azi=dacos(cosaz)
return
end subroutine
