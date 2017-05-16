subroutine introplate(track_x,track_y,ntrk,c)
use globe_data,only : lomin,lomax,glon,nodelon,nodelat,nlat,nlon,appvel,lamin,lamax
real c(ntrk)
real dx1,dx2,dy1,dy2
real v11,v12,v21,v22
real track_x(ntrk),track_y(ntrk)
integer ntrk,i,m,n
do i=1, ntrk
!           write(10,*)track_x(i),track_y(i)
           m=int((track_x(i)-lomin)/glon)+1 ! id of the grid on longitude
           n=int((track_y(i)-lamin)/glon)+1 ! id of the grid on lanitude
!           write(*,*)'   m=',m,    "    n=",n
!           write(*,*)"nlon=",nlon, " nlat=",nlat, " glon=",glon
!           write(*,*)'track_y(i)=',track_y(i),' lamax=',lamax
           dx1=track_x(i)-nodelon(m)
           dx2=nodelon(m+1)-track_x(i)
           dy1=track_y(i)-nodelat(n)
           dy2=nodelat(n+1)-track_y(i)
           v11=appvel(m,n)
           v12=appvel(m,n+1)
           v21=appvel(m+1,n)
           v22=appvel(m+1,n+1)
           c(i)=(v11*dx2*dy2+v12*dx1*dy2+v21*dx2*dy1+v22*dx1*dy1)/glon/glon
!           write(*,*)"c(i)=",c(i)
enddo
end subroutine
