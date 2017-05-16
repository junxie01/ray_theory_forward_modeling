! make sure the evlo is smaller than stlo
subroutine swap(stla,stlo,evla,evlo)
real stla,stlo,evla,evlo
real tmp
if (evlo > stlo )then
           tmp=evlo
           evlo=stlo
           stlo=tmp
           tmp=evla
           evla=stla
           stla=tmp
endif
end subroutine
