program fmst_model_format
character (90) paras,model,output
integer intg,imode
integer ntrk,ii
real ddeg,trt,ddist
real track_x(1000),track_y(1000)
real c(1000),vel1
real nodelon(2000),nodelat(2000),appvel(0:2000,0:2000)


if(iargc().ne.3)then
           write(*,*)'Usage: forward_modeling para.dat model output'
           write(*,*)'para.dat: lomin,lomax,lamin,lamax,glon'
           call exit(-1)
endif
call getarg(1,paras)
call getarg(2,model)
call getarg(3,output)
!******************************** read the parameter ************************
open(10,file=paras)
read(10,*)lomin,lomax,lamin,lamax,glon
close(10)
write(*,*)lomin,lomax,lamin,lamax,glon,intg,model,output
nlon=int((lomax-lomin)/glon)+2
nlat=int((lamax-lamin)/glon)+2
appvel=0
!********************************* generate the grid ************************
do i=0,nlon+2
            nodelon(i)=lomin+(i-1)*glon
enddo
do i=0,nlat+2
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
do i=0,nlon+1
            do j=0,nlat+1
                     if(appvel(i,j)==0)then
                                  appvel(i,j)=univel
                     endif
            enddo
enddo
!********************** read the measurements and begin forward calculating ***********
ii=0
open(16,file=output)
write(16,*) nlat, nlon
write(16,*) lamin,lomin
write(16,*) glon, glon
write(16,*)
do i=0,nlon+1
            do j=0,nlat+1
                      write(16,*)appvel(i,j)
            enddo
            write(16,'(1X)')
enddo
close(16)
end program
