module globe_data
integer grids             !
integer nlon,nlat
real*4, dimension(:,:), allocatable :: appvel
real*4, dimension(:), allocatable :: nodelat,nodelon  !(maxnodes)
real lomin,lomax,lamin,lamax,glon
real*8 dist,azi
real space
real*8 pi,radius,convdeg
parameter(pi=3.14159265,radius=6371.0,convdeg=3.14159265/180.0)
end module
