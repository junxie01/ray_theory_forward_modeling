#FFLAG=-ffixed-line-length-none
FC=ifort
bin=forward_modeling
objects=globe_data.o forward_modeling.o cal_dist_azi.o introplate.o swap.o get_track.o
all: globe_data.mod $(bin)
globe_data.mod:
	$(FC) globe_data.f90 -c
%.o: %.f90
	$(FC) -c $(FFLAG) $<
$(bin):$(objects)
	$(FC) $(objects) $(FFLAG) -o $@
clean:
	rm $(objects)
