program forward_modeling
use globe_data
character (90) paras,model,input,output
integer intg,imode
integer ntrk,ii
real ddeg,trt,ddist
real track_x(1000),track_y(1000)
real c(1000),vel1


if(iargc().ne.1)then
           write(*,*)'Usage: forward_modeling para.dat'
           write(*,*)'para.dat: lomin,lomax,lamin,lamax,glon,intg,model,input,output'
           call exit(-1)
endif
call getarg(1,paras)
!******************************** read the parameter ************************
open(10,file=paras)
read(10,*)lomin,lomax,lamin,lamax,glon,intg,model,input,output
close(10)
write(*,*)lomin,lomax,lamin,lamax,glon,intg,model,input,output
ddeg=glon/intg
nlon=int((lomax-lomin)/glon)+1
nlat=int((lamax-lamin)/glon)+1
write(*,*)lomin,lomax,lamin,lamax
allocate(nodelon(nlon),nodelat(nlat),appvel(nlon,nlat))
appvel=0
!********************************* generate the grid ************************
do i=1,nlon
            nodelon(i)=lomin+(i-1)*glon
enddo
do i=1,nlat
            nodelat(i)=lamin+(i-1)*glon
enddo
!******************************** read the model*****************************
univel=0
imode=0
open(11,file=model)
12 read(11,*,end=13,err=13)stlo,stla,vel
            flag1=0
            flag2=0
            do i=1,nlon
                     if(nodelon(i)==stlo)then
                                  flag1=1
                                  goto 14
                     endif
            enddo
      14    do j=1,nlat
                     if(nodelat(j)==stla)then
                                  flag2=1
                                  goto 15
                     endif
            enddo
      15    if(flag1==1.and.flag2==1)then
                     appvel(i,j)=vel
                     univel=univel+vel
                     imode=imode+1
            endif
            goto 12
13 continue
close(11)
univel=univel/imode
do i=1,nlon
            do j=1,nlat
                     if(appvel(i,j)==0)then
                                  appvel(i,j)=univel
                     endif
            enddo
enddo
!********************** read the measurements and begin forward calculating ***********
ii=0
open(16,file=output)
open(17,file=input)
18 read(17,*,end=19,err=19)evla,evlo,stla,stlo,vel
!            write(*,*)evla,evlo,stla,stlo,vel
!            write(*,*)lamin,lamax,lomin,lomax
            if(stla.le.lamax.and.stla.ge.lamin.and.stlo.le.lomax.and.stlo.ge.lomin.and.evla.le.lamax.and.evla.ge.lamin.and.evlo.le.lomax.and.evlo.ge.lomin) then
                         !write(*,*)'hello there'
                         call swap(stla,stlo,evla,evlo)
                         !write(*,*)'hello there again'
                         call cal_dist_azi(evlo,evla,stlo,stla)                               ! calculate the azimuth in rad, and dist in km
                         !write(*,*)'hello there again 1'
                         call get_track(evla,evlo,stla,stlo,track_x,track_y,ddeg,ntrk,ddist)  ! find the ray path on the great circle
                         !write(*,*)'hello there again 2, ntrk=',ntrk
                         call introplate(track_x,track_y,ntrk,c)                              ! introplate the velocity
                         !write(*,*)'hello detective ntrk=',ntrk
                         trt=0
                         do i=1,ntrk
                                     trt=trt+ddist/c(i)
                                     !write(*,*)c(i)
                         enddo
                         vel1=sngl(dist)/trt
                         write(16,'(6f15.4)')stla,stlo,evla,evlo,vel,vel1
                         ii=ii+1
            endif
            !write(*,*)'Number been calculated is ',ii
            goto 18
19 continue
close(17)
close(16)
deallocate(nodelon,nodelat,appvel)
end program
