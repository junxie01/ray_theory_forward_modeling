subroutine get_track(evla,evlo,stla,stlo,track_x,track_y,ddeg,ntrk,ddist)
use globe_data,only : dist, azi,convdeg,radius
integer ntrk,i
real stla,stlo,evla,evlo,tmp
real track_x(1000),track_y(1000)
real ddist,dd
real*8 deg
real*8 ea,cos_sa,sa,cos_ab,eo,so,do


ntrk=int((stlo-evlo)/ddeg)+1                         ! number of segments
!write(*,*)'Number of segments is ',ntrk
ddist=sngl(dist)/ntrk                                      ! delta of dist
!write(*,*)'Distance =',dist, ' Azimuth=',azi/convdeg, ' convdeg=',convdeg, " ddist=",ddist
if(stlo==evlo)then
           ntrk=int(abs(evla-stla)/ddeg)+1
           ddist=sngl(dist)/ntrk
           track_x=stlo
           tmp1=evla
           tmp2=stla
           if(evla.gt.stla)then
                     tmp1=stla
                     tmp2=evla
           endif
           do i=1,ntrk
                     deg=dble((ddist/2.0+(i-1)*ddist)/6371.0)
                     track_y(i)=tmp1+sngl(deg)
           enddo
else
           ea=dble(90-evla)*convdeg
           eo=dble(evlo)*convdeg
           do i=1,ntrk
                     deg=dble((ddist/2.0+(i-1)*ddist)/6371.0)
!           deg=dd/radius
!           if(i==1)write(*,*)ddist,deg
                     cos_sa=dcos(deg)*dcos(ea)+dsin(deg)*dsin(ea)*dcos(azi)
!           if(i==1)write(*,*)'cos_sa=',cos_sa
                     sa=dacos(cos_sa) 
!           if(i==1)write(*,*)'sa=',sa
                     cos_ab=(dcos(deg)-dcos(ea)*cos_sa)/dsin(sa)/dsin(ea)
!           if(i==1)write(*,*)'sin(sa)=',sin(sa)
!           if(i==1)write(*,*)'cos_ab=',cos_ab
!           if(i==1)write(*,*)'sin(ea)=',sin(ea)
                     do=dacos(cos_ab)
!           if(i==1)write(*,*)'do=acos(cos_ab)=',acos(cos_ab)
                     so=eo+do
!           if(i==1)write(*,*)'cos(deg)=',cos(deg),'cos(ea)=',cos(ea)
!           if(i==1)write(*,*)'sa=',sa,' so=',so,' eo=',eo, ' do=',do
                     track_y(i)=sngl(90-sa/convdeg)
                     track_x(i)=sngl(so/convdeg)
           enddo
endif
!open(10,file='track.dat')
!do i=1,ntrk
!           write(10,*)track_x(i),track_y(i)
!enddo
!close(10)
return
end subroutine 
